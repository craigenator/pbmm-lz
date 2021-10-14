include {
  path = find_in_parent_folders()
}

locals {
  dns      = yamldecode(file("${get_terragrunt_dir()}/../../../config/dnszone-nonp-peer.yaml"))
  config   = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../../prod/net-host-prj"
}

terraform {
  source = "../../terraform-dns-zone"
}

inputs = {
  project_id                          = dependency.network.outputs.project_id
  domain                              = local.dns.nonpDNS.domain
  name                                = local.dns.nonpDNS.name
  private_visibility_config_networks  = local.dns.nonpDNS.private_visibility_config_networks
  target_name_server_addresses        = local.dns.nonpDNS.target_name_server_addresses
  target_network                      = local.dns.nonpDNS.target_network
  description                         = local.dns.nonpDNS.description
  type                                = local.dns.nonpDNS.type
  recordsets                          = local.dns.nonpDNS.recordsets
}
