include {
  path = find_in_parent_folders()
}

locals {
  firewall = yamldecode(file("${get_terragrunt_dir()}/../../../config/nonp-firewall.yaml"))
  config   = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}
dependency "network" {
  config_path = "${get_terragrunt_dir()}/../net-host-prj"
}

terraform {
  source = "../../terraform-firewall"
}

inputs = {
  project_id      = dependency.network.outputs.project_id
  network         = dependency.network.outputs.network_name.nonpvpc
  custom_rules    = local.firewall.nonpFirewall.customRules
  department_code = local.config.departmentCode
  environment     = local.config.environment
  location        = local.config.location
  owner           = local.config.owner
}
