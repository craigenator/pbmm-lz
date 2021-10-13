/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

module "client_reports_bucket" {
  source = "git@github.com:GovAlta/terraform-gcp-goa-naming.git//modules/gcp/storage"

  department_code = var.department_code
  environment     = var.environment
  location        = var.region

  user_defined_string = "${var.org_id}${local.asset_inventory_reports_bucket_name_suffix}${var.user_defined_string}"
}