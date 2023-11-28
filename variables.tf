############################################################
# General & Default VPC variables for CLI deployment
############################################################

variable "PRIVATE_SSH_KEY" {
        type            = string
        description = "The id_rsa private key content in OpenSSH format. This private key should be used only during the terraform provisioning and it is recommended to be changed after the SAP deployment."
        nullable = false
        validation {
        condition = length(var.PRIVATE_SSH_KEY) >= 64 && var.PRIVATE_SSH_KEY != null && length(var.PRIVATE_SSH_KEY) != 0 || contains(["n.a"], var.PRIVATE_SSH_KEY )
        error_message = "The content for PRIVATE_SSH_KEY variable must be completed in OpenSSH format."
     }
}

variable "ID_RSA_FILE_PATH" {
    default = "ansible/id_rsa"
    nullable = false
    description = "The file path for the private ssh key. It will be automatically generated. If it is changed, it must contain the relative path from git repo folders. Example: ansible/id_rsa_abap_ase-syb_dst"
}

variable "SSH_KEYS" {
        type            = list(string)
        description = "List of SSH Keys UUIDs that are allowed to SSH as root to the VSI. Can contain one or more IDs. The list of SSH Keys is available here: https://cloud.ibm.com/vpc-ext/compute/sshKeys."
        validation {
                condition     = var.SSH_KEYS == [] ? false : true && var.SSH_KEYS == [""] ? false : true
                error_message = "At least one SSH KEY is needed to be able to access the VSI."
        }
}

variable "BASTION_FLOATING_IP" {
        type            = string
        description = "The BASTION FLOATING IP. It can be copied from the Bastion Server Deployment \"OUTPUTS\" at the end of \"Apply plan successful\" message."
        nullable = false
        validation {
        condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",var.BASTION_FLOATING_IP)) || contains(["localhost"], var.BASTION_FLOATING_IP ) && var.BASTION_FLOATING_IP!= null
        error_message = "Incorrect format for variable: BASTION_FLOATING_IP."
      }
}

variable "RESOURCE_GROUP" {
  type        = string
  description = "The name of an EXISTING Resource Group for VSIs and Volumes resources. Default value: \"Default\". The list of Resource Groups is available here: https://cloud.ibm.com/account/resource-groups."
  default     = "Default"
}

variable "REGION" {
        type            = string
        description     = "The cloud region where to deploy the solution. The regions and zones for VPC are listed here:https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc. Review supported locations in IBM Cloud Schematics here: https://cloud.ibm.com/docs/schematics?topic=schematics-locations."
        validation {
                condition     = contains(["au-syd", "jp-osa", "jp-tok", "eu-de", "eu-gb", "ca-tor", "us-south", "us-east", "br-sao"], var.REGION )
                error_message = "For CLI deployments, the REGION must be one of: au-syd, jp-osa, jp-tok, eu-de, eu-gb, ca-tor, us-south, us-east, br-sao. \n For Schematics, the REGION must be one of: eu-de, eu-gb, us-south, us-east."
        }
}

variable "ZONE" {
        type            = string
        description     = "The cloud zone where to deploy the solution."
        validation {
                condition     = length(regexall("^(au-syd|jp-osa|jp-tok|eu-de|eu-gb|ca-tor|us-south|us-east|br-sao)-(1|2|3)$", var.ZONE)) > 0
                error_message = "The ZONE is not valid."
        }
}

variable "VPC" {
        type            = string
        description = "The name of an EXISTING VPC. The list of VPCs is available here: https://cloud.ibm.com/vpc-ext/network/vpcs."
        validation {
                condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.VPC)) > 0
                error_message = "The VPC name is not valid."
        }
}

variable "SUBNET" {
        type            = string
        description = "The name of an EXISTING Subnet. The list of Subnets is available here: https://cloud.ibm.com/vpc-ext/network/subnets."
        validation {
                condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.SUBNET)) > 0
                error_message = "The SUBNET name is not valid."
        }
}

variable "SECURITY_GROUP" {
        type            = string
        description = "The name of an EXISTING Security group. The list of Security Groups is available here: https://cloud.ibm.com/vpc-ext/network/securityGroups."
        validation {
                condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.SECURITY_GROUP)) > 0
                error_message = "The SECURITY_GROUP name is not valid."
        }
}

##############################################################
# The variables used in Activity Tracker service.
##############################################################

variable "ATR_NAME" {
  type        = string
  description = "The name of the EXISTING Activity Tracker instance, in the same region as HANA VSI. The list of available Activity Tracker is available here: https://cloud.ibm.com/observe/activitytracker"
  default = ""
}

variable "DB_HOSTNAME" {
	type		= string
        description = "The Hostname for the DB VSI. The hostname should be up to 13 characters as required by SAP. For more information on rules regarding hostnames for SAP systems, check SAP Note 611361: \"Hostnames of SAP ABAP Platform servers\"."
	validation {
		condition     = length(var.DB_HOSTNAME) <= 13 && length(regexall("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$", var.DB_HOSTNAME)) > 0
		error_message = "The DB_HOSTNAME is not valid."
	}
}

variable "DB_PROFILE" {
	type		= string
        description = "The instance profile used for the VSI. A list of profiles is available here: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles. For more information about supported DB/OS and IBM Gen 2 Virtual Server Instances (VSI), check SAP Note 2927211: \"SAP Applications on IBM Virtual Private Cloud\"."
	default		= "bx2-4x16"
}

variable "DB_IMAGE" {
	type		= string
        description = "The OS image used for SYBASE VSI. A list of images is available here: https://cloud.ibm.com/docs/vpc?topic=vpc-about-images."
	default		= "ibm-redhat-8-6-amd64-sap-applications-4"
	validation {
		condition     = length(regexall("^(ibm-redhat-8-6-amd64-sap-applications|ibm-redhat-8-4-amd64-sap-applications|ibm-sles-15-3-amd64-sap-applications|ibm-sles-15-4-amd64-sap-applications)-[0-9][0-9]*", var.DB_IMAGE)) > 0
		error_message = "The OS SAP IMAGE must be one of  \"ibm-sles-15-3-amd64-sap-applications-x\", \"ibm-sles-15-4-amd64-sap-applications-x\", \"ibm-redhat-8-4-amd64-sap-applications-x\" or \"ibm-redhat-8-6-amd64-sap-applications-x\"."
	}
}

variable "APP_HOSTNAME" {
	type		= string
        description = "The Hostname for the SAP Application VSI. The hostname should be up to 13 characters as required by SAP. For more information on rules regarding hostnames for SAP systems, check SAP Note 611361: \"Hostnames of SAP ABAP Platform servers\"."
	validation {
		condition     = length(var.APP_HOSTNAME) <= 13 && length(regexall("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$", var.APP_HOSTNAME)) > 0
		error_message = "The APP_HOSTNAME is not valid."
	}
}

variable "APP_PROFILE" {
	type		= string
        description = "The instance profile used for SAP Application VSI. A list of profiles is available here: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles. For more information about supported DB/OS and IBM Gen 2 Virtual Server Instances (VSI), check SAP Note 2927211: \"SAP Applications on IBM Virtual Private Cloud\"."
	default		= "bx2-4x16"
}

variable "APP_IMAGE" {
	type		= string
        description = "The OS image used for SAP Application VSI. A list of images is available here: https://cloud.ibm.com/docs/vpc?topic=vpc-about-images."
	default		= "ibm-redhat-8-6-amd64-sap-applications-4"
	validation {
		condition     = length(regexall("^(ibm-redhat-8-6-amd64-sap-applications|ibm-redhat-8-4-amd64-sap-applications|ibm-sles-15-3-amd64-sap-applications|ibm-sles-15-4-amd64-sap-applications)-[0-9][0-9]*", var.APP_IMAGE)) > 0
		error_message = "The OS SAP IMAGE must be one of  \"ibm-sles-15-3-amd64-sap-applications-x\", \"ibm-sles-15-4-amd64-sap-applications-x\", \"ibm-redhat-8-4-amd64-sap-applications-x\" or \"ibm-redhat-8-6-amd64-sap-applications-x\"."
	}
}


data "ibm_is_instance" "db-vsi" {
  depends_on = [module.db-vsi]
  name    =  var.DB_HOSTNAME
}

data "ibm_is_instance" "app-vsi" {
  depends_on = [module.app-vsi]
  name    =  var.APP_HOSTNAME
}

##############################################################
# The variables and data sources used in SAP Ansible Modules.
##############################################################

variable "SAP_SID" {
        type            = string
        description = "The SAP system ID. Identifies the entire SAP system. Consists of exactly three alphanumeric characters and the first character must be a letter. Does not include any of the reserved IDs listed in SAP Note 1979280"
        default         = "NWD"
        validation {
                condition     = length(regexall("^[a-zA-Z][a-zA-Z0-9][a-zA-Z0-9]$", var.SAP_SID)) > 0 && !contains(["ADD", "ALL", "AMD", "AND", "ANY", "ARE", "ASC", "AUX", "AVG", "BIT", "CDC", "COM", "CON", "DBA", "END", "EPS", "FOR", "GET", "GID", "IBM", "INT", "KEY", "LOG", "LPT", "MAP", "MAX", "MIN", "MON", "NIX", "NOT", "NUL", "OFF", "OLD", "OMS", "OUT", "PAD", "PRN", "RAW", "REF", "ROW", "SAP", "SET", "SGA", "SHG", "SID", "SQL", "SUM", "SYS", "TMP", "TOP", "UID", "USE", "USR", "VAR"], var.SAP_SID)
                error_message = "The SAP_SID is not valid."
        }
}

variable "SAP_ASCS_INSTANCE_NUMBER" {
        type            = string
        description = "The central ABAP service instance number. Technical identifier for internal processes of ASCS. Consists of a two-digit number from 00 to 97. Must be unique on a host. Must follow the SAP rules for instance number naming"
        default         = "01"
        validation {
                condition     = var.SAP_ASCS_INSTANCE_NUMBER >= 0 && var.SAP_ASCS_INSTANCE_NUMBER <=97
                error_message = "The SAP_ASCS_INSTANCE_NUMBER is not valid."
        }
}

variable "SAP_CI_INSTANCE_NUMBER" {
        type            = string
        description = "The SAP central instance number. Technical identifier for internal processes of CI. Consists of a two-digit number from 00 to 97. Must be unique on a host. Must follow the SAP rules for instance number naming"
        default         = "00"
        validation {
                condition     = var.SAP_CI_INSTANCE_NUMBER >= 0 && var.SAP_CI_INSTANCE_NUMBER <=97
                error_message = "The SAP_CI_INSTANCE_NUMBER is not valid."
        }
}

variable "SAP_MAIN_PASSWORD" {
        type            = string
        sensitive = true
        description = "Common password for all users that are created during the installation. It must be 8 to 14 characters long, it must contain at least one digit (0-9) and one uppercase letter, it must not contain backslash and double quote."
        validation {
        condition = length(regexall("^(.{0,9}|.{15,}|[^0-9]*)$", var.SAP_MAIN_PASSWORD)) == 0 && length(regexall("^[^0-9_][0-9a-zA-Z@#$_]+$", var.SAP_MAIN_PASSWORD)) > 0 && length(regexall("[A-Z]", var.SAP_MAIN_PASSWORD)) > 0
        error_message = "The SAP_MAIN_PASSWORD is not valid."
        }
}

variable "KIT_SAPCAR_FILE" {
        type            = string
        description = "Path to sapcar binary. As downloaded from SAP Support Portal."
	default		= "SAPCAR_1010-70006178.EXE"
}

variable "KIT_SWPM_FILE" {
        type            = string
        description = "Path to SWPM archive (SAR). As downloaded from SAP Support Portal."
	default		= "SWPM20SP09_4-80003424.SAR"
}

variable "KIT_SAPEXE_FILE" {
        type            = string
        description = "Path to SAP Kernel OS archive (SAR). As downloaded from SAP Support Portal."
	default		= "SAPEXE_400-80004393.SAR"
}

variable "KIT_SAPEXEDB_FILE" {
        type            = string
        description = "Path to SAP Kernel DB archive (SAR). As downloaded from SAP Support Portal."
	default		= "SAPEXEDB_400-80004392.SAR"
}

variable "KIT_IGSEXE_FILE" {
        type            = string
        description = "Path to IGS archive (SAR). As downloaded from SAP Support Portal."
	default		= "igsexe_13-80003187.sar"
}

variable "KIT_IGSHELPER_FILE" {
        type            = string
        description = "Path to IGS Helper archive (SAR). As downloaded from SAP Support Portal."
	default		= "igshelper_17-10010245.sar"
}

variable "KIT_SAPHOSTAGENT_FILE" {
        type            = string
        description = "Path to SAP Host Agent archive (SAR). As downloaded from SAP Support Portal."
	default		= "SAPHOSTAGENT51_51-20009394.SAR"
}

variable "KIT_ASE_FILE" {
	type		= string
	description = "KIT_ASE_FILE"
	default		= "/storage/NW75SYB/51055622_1.ZIP"
}

variable "KIT_EXPORT_DIR" {
	type		= string
	description = "KIT_EXPORT_DIR"
	default		= "/storage/NW75SYB/EXP"
}

# ATR variables and conditions

locals {
	ATR_ENABLE = true
}

resource "null_resource" "check_atr_name" {
  count             = local.ATR_ENABLE == true ? 1 : 0
  lifecycle {
    precondition {
      condition     = var.ATR_NAME != "" && var.ATR_NAME != null
      error_message = "The name of an EXISTENT Activity Tracker in the same region must be specified."
    }
  }
}

data "ibm_resource_instance" "activity_tracker" {
  count             = local.ATR_ENABLE == true ? 1 : 0
  name              = var.ATR_NAME
  location          = var.REGION
  service           = "logdnaat"
}

