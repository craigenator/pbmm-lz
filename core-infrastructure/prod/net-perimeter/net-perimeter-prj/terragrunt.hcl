include {
  path = find_in_parent_folders()
}

locals {
  network = yamldecode(file("${get_terragrunt_dir()}/../../../../config/perimeter-network.yaml"))
  config  = yamldecode(file("${get_terragrunt_dir()}/../../../../config/organization-config.yaml"))
}


dependency "folders" {
  config_path = "${get_terragrunt_dir()}/../../../common/core-folders"
}

dependency "prod_network" {
  config_path = "${get_terragrunt_dir()}/../../net-host-prj"
}

terraform {
  source = "../../../terraform-network-host-project"
}

inputs = {
  services                       = local.network.publicPerimeterNet.services
  billing_account                = local.network.publicPerimeterNet.billing_account
  parent                         = dependency.folders.outputs.folders_map_2_levels.ProdNetworking.id
  networks                       = local.network.publicPerimeterNet.networks
  department_code                = local.config.departmentCode
  environment                    = local.config.environment
  location                       = local.config.location
  projectlabels                  = local.network.publicPerimeterNet.labels
  owner                          = local.config.owner
  user_defined_string            = local.network.publicPerimeterNet.userDefinedString
  additional_user_defined_string = local.network.publicPerimeterNet.additionalUserDefinedString
}
