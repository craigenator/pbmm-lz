include {
  path = find_in_parent_folders()
}

locals {
  firewall = yamldecode(file("${get_terragrunt_dir()}/../../../config/fortigate-firewall.yaml"))
  config   = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

terraform {
  source = "../../terraform-fortigate-appliance"
}

inputs = {
  project                         = local.firewall.fortigateConfig.project
  network_tags                    = local.firewall.fortigateConfig.network_tags
  machine_type                    = local.firewall.fortigateConfig.machine_type
  network_ports                   = local.firewall.fortigateConfig.network_ports
  public_port                     = local.firewall.fortigateConfig.public_port
  internal_port                   = local.firewall.fortigateConfig.internal_port
  ha_port                         = local.firewall.fortigateConfig.ha_port
  mgmt_port                       = local.firewall.fortigateConfig.mgmt_port
  user_defined_string             = local.firewall.fortigateConfig.user_defined_string
  department_code                 = local.config.departmentCode
  environment                     = local.config.environment
  location                        = local.config.location
  owner                           = local.config.owner
}
