##########################################################
# General VPC variables:
##########################################################

REGION = ""
# Region for the VSI. Supported regions: https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc
# Example: REGION = "eu-de"

ZONE = ""
# Availability zone for VSI. Supported zones: https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc
# Example: ZONE = "eu-de-2"

VPC = ""
# EXISTING VPC, previously created by the user in the same region as the VSI. The list of available VPCs: https://cloud.ibm.com/vpc-ext/network/vpcs
# Example: VPC = "ic4sap"

SECURITY_GROUP = ""
# EXISTING Security group, previously created by the user in the same VPC. The list of available Security Groups: https://cloud.ibm.com/vpc-ext/network/securityGroups
# Example: SECURITY_GROUP = "ic4sap-securitygroup"

RESOURCE_GROUP = ""
# EXISTING Resource group, previously created by the user. The list of available Resource Groups: https://cloud.ibm.com/account/resource-groups
# Example: RESOURCE_GROUP = "wes-automation"

SUBNET = ""
# EXISTING Subnet in the same region and zone as the VSI, previously created by the user. The list of available Subnets: https://cloud.ibm.com/vpc-ext/network/subnets
# Example: SUBNET = "ic4sap-subnet"

SSH_KEYS = [""]
# List of SSH Keys UUIDs that are allowed to SSH as root to the VSI. The SSH Keys should be created for the same region as the VSI. The list of available SSH Keys UUIDs: https://cloud.ibm.com/vpc-ext/compute/sshKeys
# Example: SSH_KEYS = ["r010-8f72b994-c17f-4500-af8f-d05680374t3c", "r011-8f72v884-c17f-4500-af8f-d05900374t3c"]


ID_RSA_FILE_PATH = "ansible/id_rsa"
# The id_rsa private key file path in OpenSSH format with 0600 permissions.
# This private key is used only during the terraform provisioning and it is recommended to be changed after the SAP deployment.
# It must contain the relative or absoute path from your Bastion.
# Examples: "ansible/id_rsa_abap_syb_dst" , "~/.ssh/id_rsa_abap_syb_dst" , "/root/.ssh/id_rsa".

##########################################################
# Activity Tracker variables:
##########################################################

ATR_NAME = ""
# The name of the Activity Tracker instance, in the same region chosen for the SAP system deployment.
# Example: ATR_NAME="Activity-Tracker-SAP-eu-de"

##########################################################
# VSI variables:
##########################################################


DB_HOSTNAME = ""
# The Hostname for the DB VSI. The hostname should be up to 13 characters, as required by SAP
# Example: DB_HOSTNAME = "sapnwasedb"

DB_PROFILE = "bx2-4x16"
# The DB VSI profile. Supported profiles for DB VSI: bx2-4x16. The list of available profiles: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui
# Details about all x86 instance profiles: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles).
# For more information about supported DB/OS and IBM Gen 2 Virtual Server Instances (VSI), check [SAP Note 2927211: SAP Applications on IBM Virtual Private Cloud](https://launchpad.support.sap.com/#/notes/2927211) 
# Default value: DB_PROFILE = "bx2-4x16"

DB_IMAGE = "ibm-redhat-8-6-amd64-sap-applications-4"
# OS image for DB VSI. Supported OS images for DB VSIs: ibm-sles-15-3-amd64-sap-applications-9, ibm-sles-15-4-amd64-sap-applications-6, ibm-redhat-8-4-amd64-sap-applications-7, ibm-redhat-8-6-amd64-sap-applications-4. 
# The list of available VPC Operating Systems supported by SAP: SAP note '2927211 - SAP Applications on IBM Virtual Private Cloud (VPC) Infrastructure environment' https://launchpad.support.sap.com/#/notes/2927211; The list of all available OS images: https://cloud.ibm.com/docs/vpc?topic=vpc-about-images
# Example: DB-IMAGE = "ibm-sles-15-4-amd64-sap-applications-6"

##########################################################
# SAP APP VSI variables:
##########################################################

APP_HOSTNAME = ""
# The Hostname for the SAP APP VSI. The hostname should be up to 13 characters, as required by SAP
# Example: APP_HOSTNAME = "sapnwapp"

APP_PROFILE = "bx2-4x16"
# The APP VSI profile. Supported profiles: bx2-4x16. The list of available profiles: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui

APP_IMAGE = "ibm-redhat-8-6-amd64-sap-applications-4"
# OS image for SAP APP VSI. Supported OS images for APP VSIs: ibm-sles-15-3-amd64-sap-applications-9, ibm-sles-15-4-amd64-sap-applications-6, ibm-redhat-8-4-amd64-sap-applications-7, ibm-redhat-8-6-amd64-sap-applications-4. 
# The list of available VPC Operating Systems supported by SAP: SAP note '2927211 - SAP Applications on IBM Virtual Private Cloud (VPC) Infrastructure environment' https://launchpad.support.sap.com/#/notes/2927211; The list of all available OS images: https://cloud.ibm.com/docs/vpc?topic=vpc-about-images
# Example: APP-IMAGE = "ibm-sles-15-4-amd64-sap-applications-6"

##########################################################
# SAP system configuration
##########################################################

SAP_SID = "NWD"
# The SAP system ID. Identifies the entire SAP system.
# Consists of exactly three alphanumeric characters and the first character must be a letter.
# Does not include any of the reserved IDs listed in SAP Note 1979280

SAP_ASCS_INSTANCE_NUMBER = "01"
# The central ABAP service instance number. Technical identifier for internal processes of ASCS. Must follow the SAP rules for instance number naming.
# Example: SAP_ASCS_INSTANCE_NUMBER = "01"

SAP_CI_INSTANCE_NUMBER = "00"
# The SAP central instance number. Technical identifier for internal processes of CI. Must follow the SAP rules for instance number naming.
# Example: SAP_CI_INSTANCE_NUMBER = "06"


##########################################################
# Kit Paths
##########################################################

KIT_SAPCAR_FILE = "/storage/NW75SYB/SAPCAR_1010-70006178.EXE"
KIT_SWPM_FILE =  "/storage/NW75SYB/SWPM10SP31_7-20009701.SAR"
KIT_SAPHOSTAGENT_FILE = "/storage/NW75SYB/SAPHOSTAGENT51_51-20009394.SAR"
KIT_SAPEXE_FILE = "/storage/NW75SYB/SAPEXE_900-80002573.SAR"
KIT_SAPEXEDB_FILE = "/storage/NW75SYB/SAPEXEDB_900-80002616.SAR"
KIT_IGSEXE_FILE = "/storage/NW75SYB/igsexe_13-80003187.sar"
KIT_IGSHELPER_FILE = "/storage/NW75SYB/igshelper_17-10010245.sar"
KIT_ASE_FILE = "/storage/NW75SYB/51055622_1.ZIP"
KIT_EXPORT_DIR = "/storage/NW75SYB/EXP"
