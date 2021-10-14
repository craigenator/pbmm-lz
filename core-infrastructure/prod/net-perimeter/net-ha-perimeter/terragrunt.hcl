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

dependency "perimeter" {
  config_path = "${get_terragrunt_dir()}/../net-perimeter-prj"
}

terraform {
  source = "../../../terraform-network"
}

inputs = {
  project_id                     = dependency.perimeter.outputs.project_id
  services                       = local.network.haPerimeterNet.services
  billing_account                = local.network.haPerimeterNet.billing_account
  parent                         = dependency.folders.outputs.folders_map_2_levels.ProdNetworking.id
  networks                       = local.network.haPerimeterNet.networks
  department_code                = local.config.departmentCode
  environment                    = local.config.environment
  location                       = local.config.location
  owner                          = local.config.owner
  user_defined_string            = local.network.haPerimeterNet.userDefinedString
  additional_user_defined_string = local.network.haPerimeterNet.additionalUserDefinedString
}
