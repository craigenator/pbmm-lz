/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

module "project_name" {
  source = "../terraform-gcp-goa-naming//modules/gcp/project"

  department_code                = var.department_code
  environment                    = var.environment
  location                       = var.location
  owner                          = var.owner
  user_defined_string            = var.user_defined_string
  additional_user_defined_string = var.additional_user_defined_string
}

module "state_bucket_names" {
  source = "../terraform-gcp-goa-naming//modules/gcp/storage"

  for_each        = var.tfstate_buckets
  department_code = var.department_code
  environment     = var.environment
  location        = var.location

  user_defined_string = lower(each.value.name)
}

module "yaml_config_bucket_name" {
  source = "../terraform-gcp-goa-naming//modules/gcp/storage"

  department_code = var.department_code
  environment     = var.environment
  location        = var.location

  user_defined_string = lower(var.yaml_config_bucket.name)
}