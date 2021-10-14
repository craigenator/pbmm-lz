include {
  path = find_in_parent_folders()
}

locals {
  dns      = yamldecode(file("${get_terragrunt_dir()}/../../../config/dnszone-onprem-forward.yaml"))
  config   = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../../nonp/net-host-prj"
}

terraform {
  source = "../../terraform-dns-zone"
}

inputs = {
  project_id                          = dependency.network.outputs.project_id
  domain                              = local.dns.nonprodDNS.domain
  name                                = local.dns.nonprodDNS.name
  private_visibility_config_networks  = local.dns.nonprodDNS.private_visibility_config_networks
  target_name_server_addresses        = local.dns.nonprodDNS.target_name_server_addresses
  target_network                      = local.dns.nonprodDNS.target_network
  description                         = local.dns.nonprodDNS.description
  type                                = local.dns.nonprodDNS.type
  recordsets                          = local.dns.nonprodDNS.recordsets
}
