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
  source = "../../terraform-guardrails"
}

inputs = {
  project_name        = local.config.guardrails.project_name
  billing_account     = local.config.guardrails.billing_account
  parent              = dependency.folders.outputs.folders_map_1_level.Security.id
  org_id              = local.config.orgId
  org_id_scan_list    = local.config.guardrails.orgId_scan_list
  org_client          = local.config.guardrails.org_client
  region              = local.config.defaultRegion
  user_defined_string = local.config.guardrails.user_defined_string
  department_code     = local.config.departmentCode
  environment         = local.config.environment
  owner               = local.config.owner
}