/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

resource "google_compute_router" "router" {
  project = var.project_id
  network = var.network_name

  name        = module.router_name.result
  description = var.description
  region      = var.region


  dynamic "bgp" {
    for_each = var.bgp[*]
    content {
      asn               = bgp.value.asn
      advertise_mode    = lookup(bgp.value, "advertise_mode", null)
      advertised_groups = lookup(bgp.value, "advertised_groups", null)
      dynamic "advertised_ip_ranges" {
        for_each = lookup(bgp.value, "advertised_ip_ranges", {})
        content {
          range       = advertised_ip_ranges.value.range
          description = lookup(advertised_ip_ranges.value, "description", "")
        }
      }
    }
  }
}
