include {
  path = find_in_parent_folders()
}

locals {
  network = yamldecode(file("${get_terragrunt_dir()}/../../../config/prod-network.yaml"))
  config  = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}


dependency "folders" {
  config_path = "${get_terragrunt_dir()}/../../common/core-folders"
}

# dependency "perimeter_network" {
#   config_path = "${get_terragrunt_dir()}/../net-perimeter-prj"
# }

terraform {
  source = "../../terraform-network-host-project"
}

inputs = {
  services                       = local.network.prodHostNet.services
  billing_account                = local.network.prodHostNet.billing_account
  parent                         = dependency.folders.outputs.folders_map_2_levels.ProdNetworking.id
  networks                       = local.network.prodHostNet.networks
  department_code                = local.config.departmentCode
  environment                    = local.config.environment
  location                       = local.config.location
  projectlabels                  = local.network.prodHostNet.labels
  owner                          = local.config.owner
  user_defined_string            = local.network.prodHostNet.userDefinedString
  additional_user_defined_string = local.network.prodHostNet.additionalUserDefinedString
}
