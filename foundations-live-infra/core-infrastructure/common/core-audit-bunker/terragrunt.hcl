include {
  path = find_in_parent_folders()
}

locals {
  config = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

dependency "folders" {
  config_path = "${get_terragrunt_dir()}/../core-folders"
}

terraform {
  source = "../../terraform-audit-bunker"
}

inputs = {
  billing_account                = local.config.audit.billing_account
  parent                         = dependency.folders.outputs.folders_map_1_level.Audit.id
  audit_streams                  = local.config.audit.audit_streams
  org_id                         = local.config.orgId
  region                         = local.config.defaultRegion
  labels                         = local.config.audit.auditlabels
  department_code                = local.config.departmentCode
  environment                    = local.config.environment
  location                       = local.config.location
  owner                          = local.config.owner
  user_defined_string            = local.config.audit.userDefinedString
  additional_user_defined_string = local.config.audit.additionalUserDefinedString
  #bucket_name                    = local.config.audit.billing_account.bucket_name
  #is_locked                      = local.config.audit.billing_account.is_locked
  #bucket_force_destroy           = local.config.audit.billing_account.bucket_force_destroy
  #bucket_storage_class           = local.config.audit.billing_account.bucket_storage_class
  #sink_name                      = local.config.audit.billing_account.sink_name
  #description                    = local.config.audit.billing_account.description
  #filter                         = local.config.audit.billing_account.filter
  #retentionperiod                = local.config.audit.billing_account.retention_period
}
