include {
  path = find_in_parent_folders()
}

locals {
  network = yamldecode(file("${get_terragrunt_dir()}/../../../config/nonp-network.yaml"))
  config  = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}


dependency "folders" {
  config_path = "${get_terragrunt_dir()}/../../common/core-folders"
}

terraform {
  source = "../../terraform-network-host-project"
}

inputs = {
  services                       = local.network.nonpHostNet.services
  billing_account                = local.network.nonpHostNet.billing_account
  parent                         = dependency.folders.outputs.folders_map_2_levels.NonProdNetworking.id
  networks                       = local.network.nonpHostNet.networks
  projectlabels                  = local.network.nonpHostNet.labels
  department_code                = local.config.departmentCode
  environment                    = local.config.environment
  location                       = local.config.location
  owner                          = local.config.owner
  user_defined_string            = local.network.nonpHostNet.userDefinedString
  additional_user_defined_string = local.network.nonpHostNet.additionalUserDefinedString
}
