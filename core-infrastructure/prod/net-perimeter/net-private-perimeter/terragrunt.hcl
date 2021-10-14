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
  services                       = local.network.privatePerimeterNet.services
  billing_account                = local.network.privatePerimeterNet.billing_account
  parent                         = dependency.folders.outputs.folders_map_2_levels.ProdNetworking.id
  networks                       = local.network.privatePerimeterNet.networks
  department_code                = local.config.departmentCode
  environment                    = local.config.environment
  location                       = local.config.location
  owner                          = local.config.owner
  user_defined_string            = local.network.privatePerimeterNet.userDefinedString
  additional_user_defined_string = local.network.privatePerimeterNet.additionalUserDefinedString
}
