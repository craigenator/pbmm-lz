include {
  path = find_in_parent_folders()
}

locals {
  dns      = yamldecode(file("${get_terragrunt_dir()}/../../../config/dnszone-onprem-forward.yaml"))
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
  domain                              = local.dns.prodDNS.domain
  name                                = local.dns.prodDNS.name
  private_visibility_config_networks  = local.dns.prodDNS.private_visibility_config_networks
  target_name_server_addresses        = local.dns.prodDNS.target_name_server_addresses
  target_network                      = local.dns.prodDNS.target_network
  description                         = local.dns.prodDNS.description
  type                                = local.dns.prodDNS.type
  recordsets                          = local.dns.prodDNS.recordsets
}
