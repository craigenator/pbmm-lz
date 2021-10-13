/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

module "route_name" {
  source = "git@github.com:GovAlta/terraform-gcp-goa-naming.git//modules/gcp/route"

  user_defined_string = var.route_name
}