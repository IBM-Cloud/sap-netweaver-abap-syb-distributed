##########################################################
# General VPC variables:
##########################################################

REGION = "eu-de"
# Region for the VSI. Supported regions: https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc
# Example: REGION = "eu-de"

ZONE = "eu-de-2"
# Availability zone for VSI. Supported zones: https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc
# Example: ZONE = "eu-de-2"

VPC = "ic4sap"
# EXISTING VPC, previously created by the user in the same region as the VSI. The list of available VPCs: https://cloud.ibm.com/vpc-ext/network/vpcs
# Example: VPC = "ic4sap"

SECURITY_GROUP = "ic4sap-securitygroup"
# EXISTING Security group, previously created by the user in the same VPC. The list of available Security Groups: https://cloud.ibm.com/vpc-ext/network/securityGroups
# Example: SECURITY_GROUP = "ic4sap-securitygroup"

RESOURCE_GROUP = "wes-automation"
# EXISTING Resource group, previously created by the user. The list of available Resource Groups: https://cloud.ibm.com/account/resource-groups
# Example: RESOURCE_GROUP = "wes-automation"

SUBNET = "alint-de-subnet2"
# EXISTING Subnet in the same region and zone as the VSI, previously created by the user. The list of available Subnets: https://cloud.ibm.com/vpc-ext/network/subnets
# Example: SUBNET = "ic4sap-subnet"

SSH_KEYS = ["r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a", "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e"]
# List of SSH Keys UUIDs that are allowed to SSH as root to the VSI. The SSH Keys should be created for the same region as the VSI. The list of available SSH Keys UUIDs: https://cloud.ibm.com/vpc-ext/compute/sshKeys
# Example: SSH_KEYS = ["r010-8f72b994-c17f-4500-af8f-d05680374t3c", "r011-8f72v884-c17f-4500-af8f-d05900374t3c"]

##########################################################
# DB VSI variables:
##########################################################

DB-HOSTNAME = "sapnwasedb"
# The Hostname for the DB VSI. The hostname should be up to 13 characters, as required by SAP
# Example: DB-HOSTNAME = "sapnwasedb"

DB-PROFILE = "bx2-4x16"
# The DB VSI profile. Supported profiles for DB VSI: bx2-4x16. The list of available profiles: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui

DB-IMAGE = "ibm-redhat-8-4-amd64-sap-applications-4"
# OS image for DB VSI. Supported OS images for DB VSIs: ibm-sles-15-3-amd64-sap-applications-5, ibm-redhat-8-4-amd64-sap-applications-4.
# The list of available VPC Operating Systems supported by SAP: SAP note '2927211 - SAP Applications on IBM Virtual Private Cloud (VPC) Infrastructure environment' https://launchpad.support.sap.com/#/notes/2927211; The list of all available OS images: https://cloud.ibm.com/docs/vpc?topic=vpc-about-images
# Example: DB-IMAGE = "ibm-redhat-8-4-amd64-sap-applications-4" 

##########################################################
# SAP APP VSI variables:
##########################################################

APP-HOSTNAME = "sapnwapp"
# The Hostname for the SAP APP VSI. The hostname should be up to 13 characters, as required by SAP
# Example: HOSTNAME = "sapnwapp"

APP-PROFILE = "bx2-4x16"
# The APP VSI profile. Supported profiles: bx2-4x16. The list of available profiles: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui

APP-IMAGE = "ibm-redhat-8-4-amd64-sap-applications-4"
# OS image for SAP APP VSI. Supported OS images for APP VSIs: ibm-sles-15-3-amd64-sap-applications-5, ibm-redhat-8-4-amd64-sap-applications-4.
# The list of available VPC Operating Systems supported by SAP: SAP note '2927211 - SAP Applications on IBM Virtual Private Cloud (VPC) Infrastructure environment' https://launchpad.support.sap.com/#/notes/2927211; The list of all available OS images: https://cloud.ibm.com/docs/vpc?topic=vpc-about-images
# Example: APP-IMAGE = "ibm-redhat-8-4-amd64-sap-applications-4" 

##########################################################
# SAP system configuration
##########################################################

sap_sid = "NWD"
# SAP System ID

sap_ascs_instance_number = "01"
# The central ABAP service instance number. Should follow the SAP rules for instance number naming.
# Example: sap_ascs_instance_number = "01"

sap_ci_instance_number = "00"
# The SAP central instance number. Should follow the SAP rules for instance number naming.
# Example: sap_ci_instance_number = "06"

##########################################################
# Kit Paths
##########################################################

kit_sapcar_file = "/storage/NW75SYB/SAPCAR_1010-70006178.EXE"
kit_swpm_file =  "/storage/NW75SYB/SWPM10SP31_7-20009701.SAR"
kit_saphotagent_file = "/storage/NW75SYB/SAPHOSTAGENT51_51-20009394.SAR"
kit_sapexe_file = "/storage/NW75SYB/SAPEXE_900-80002573.SAR"
kit_sapexedb_file = "/storage/NW75SYB/SAPEXEDB_900-80002616.SAR"
kit_igsexe_file = "/storage/NW75SYB/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/NW75SYB/igshelper_17-10010245.sar"
kit_ase_file = "/storage/NW75SYB/51055622_1.ZIP"
kit_export_dir = "/storage/NW75SYB/EXP"
