include {
  path = find_in_parent_folders()
}

locals {
  iam = yamldecode(file("${get_terragrunt_dir()}/../../../config/core-iam.yaml"))
  config = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

dependency "customroles" {
  config_path = "${get_terragrunt_dir()}/../core-org-custom-roles"
}

terraform {
  source = "../../terraform-iam"
}

inputs = {
  sa_create_assign       = local.iam.config.serviceAccounts
  project_iam            = local.iam.config.projectIam
  compute_network_users  = local.iam.config.computeNetworkUsers
  folder_iam             = local.iam.config.folderIam
  organization_iam       = local.iam.config.organizationIam
  organization           = local.config.orgId
}
