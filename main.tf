module "pre-init-schematics" {
  source  = "./modules/pre-init"
  count = (var.private_ssh_key == "n.a" && var.BASTION_FLOATING_IP == "localhost" ? 0 : 1)
  ID_RSA_FILE_PATH = var.ID_RSA_FILE_PATH
  private_ssh_key = var.private_ssh_key
}

module "pre-init-cli" {
  source  = "./modules/pre-init/cli"
  count = (var.private_ssh_key == "n.a" && var.BASTION_FLOATING_IP == "localhost" ? 1 : 0)
  ID_RSA_FILE_PATH = var.ID_RSA_FILE_PATH
  kit_sapcar_file=var.kit_sapcar_file
  kit_swpm_file=var.kit_swpm_file
  kit_saphotagent_file=var.kit_saphotagent_file
  kit_sapexe_file=var.kit_sapexe_file
  kit_sapexedb_file=var.kit_sapexedb_file
  kit_igsexe_file=var.kit_igsexe_file
  kit_igshelper_file=var.kit_igshelper_file
  kit_export_dir=var.kit_export_dir
  kit_ase_file = var.kit_ase_file
}

module "precheck-ssh-exec" {
  source  = "./modules/precheck-ssh-exec"
  count = (var.private_ssh_key == "n.a" && var.BASTION_FLOATING_IP == "localhost" ? 0 : 1)
  depends_on	= [ module.pre-init-schematics ]
  BASTION_FLOATING_IP = var.BASTION_FLOATING_IP
  ID_RSA_FILE_PATH = var.ID_RSA_FILE_PATH
  private_ssh_key = var.private_ssh_key
  HOSTNAME  = var.DB-HOSTNAME
  SECURITY_GROUP = var.SECURITY_GROUP
}

module "vpc-subnet" {
  source  = "./modules/vpc/subnet"
  depends_on	= [ module.precheck-ssh-exec ]
  ZONE  = var.ZONE
  VPC = var.VPC
  SECURITY_GROUP = var.SECURITY_GROUP
  SUBNET  = var.SUBNET
}

module "db-vsi" {
  source		= "./modules/db-vsi"
  depends_on	= [ module.precheck-ssh-exec ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITY_GROUP = var.SECURITY_GROUP
  SUBNET		= var.SUBNET
  RESOURCE_GROUP = var.RESOURCE_GROUP
  HOSTNAME		= var.DB-HOSTNAME
  PROFILE		= var.DB-PROFILE
  IMAGE			= var.DB-IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUME_SIZES	= [ "40" , "32", "64", "256" ]
  VOL_PROFILE		= "10iops-tier"
}

module "app-vsi" {
  source		= "./modules/app-vsi"
  depends_on	= [ module.db-vsi ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITY_GROUP = var.SECURITY_GROUP
  SUBNET		= var.SUBNET
  RESOURCE_GROUP = var.RESOURCE_GROUP
  HOSTNAME		= var.APP-HOSTNAME
  PROFILE		= var.APP-PROFILE
  IMAGE			= var.APP-IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUME_SIZES	= [ "40" , "128" ]
  VOL_PROFILE	= "10iops-tier"
}


module "app-ansible-exec-schematics" {
  source  = "./modules/ansible-exec"
  depends_on	= [ module.app-vsi, local_file.ansible_inventory, local_file.app_ansible_sapnwascs-vars, local_file.db_ansible_sapnwdb-vars, local_file.app_ansible_sapnwapp-vars ]
  count = (var.private_ssh_key == "n.a" && var.BASTION_FLOATING_IP == "localhost" ? 0 : 1)
  IP  = data.ibm_is_instance.db-vsi.primary_network_interface[0].primary_ip[0].address
  PLAYBOOK = "sap-abap-ase-syb-distributed.yml"
  BASTION_FLOATING_IP = var.BASTION_FLOATING_IP
  ID_RSA_FILE_PATH = var.ID_RSA_FILE_PATH
  private_ssh_key = var.private_ssh_key
  
}

module "ansible-exec-cli" {
  source  = "./modules/ansible-exec/cli"
  depends_on	= [ module.app-vsi , local_file.ansible_inventory, local_file.app_ansible_sapnwascs-vars, local_file.db_ansible_sapnwdb-vars, local_file.app_ansible_sapnwapp-vars ]
  count = (var.private_ssh_key == "n.a" && var.BASTION_FLOATING_IP == "localhost" ? 1 : 0)
  IP  = data.ibm_is_instance.db-vsi.primary_network_interface[0].primary_ip[0].address
  ID_RSA_FILE_PATH = var.ID_RSA_FILE_PATH
  sap_main_password = var.sap_main_password
  PLAYBOOK = "sap-abap-ase-syb-distributed.yml"
}


