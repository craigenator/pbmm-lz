include {
  path = find_in_parent_folders()
}

locals {
  dns      = yamldecode(file("${get_terragrunt_dir()}/../../../config/dnszone-nonp-private.yaml"))
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
  domain                              = local.dns.nonpDNS.domain
  name                                = local.dns.nonpDNS.name
  private_visibility_config_networks  = local.dns.nonpDNS.private_visibility_config_networks
  target_name_server_addresses        = local.dns.nonpDNS.target_name_server_addresses
  target_network                      = local.dns.nonpDNS.target_network
  description                         = local.dns.nonpDNS.description
  type                                = local.dns.nonpDNS.type
  recordsets                          = local.dns.nonpDNS.recordsets
  dns_policy_network                  = local.dns.nonpDNS.dns_policy_network
  enable_inbound_forwarding           = local.dns.nonpDNS.enable_inbound_forwarding
  enable_logging                      = local.dns.nonpDNS.enable_logging
}
