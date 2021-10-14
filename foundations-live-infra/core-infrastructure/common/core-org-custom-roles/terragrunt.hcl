include {
  path = find_in_parent_folders()
}

locals {
  config = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

terraform {
  source = "../../terraform-org-custom-roles"
}

inputs = {
  org_id              = local.config.orgId
  custom_roles        = local.config.customRoles
  department_code     = local.config.departmentCode
  environment         = local.config.environment
  location            = local.config.location
  user_defined_string = local.config.audit.userDefinedString
}
