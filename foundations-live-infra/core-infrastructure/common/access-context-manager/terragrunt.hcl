include {
  path = find_in_parent_folders()
}

locals {
  config = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

terraform {
  source = "../../terraform-vpc-service-controls"
}

inputs = {
  parent_id           = local.config.orgId
  policy_name         = local.config.accessContextManager.policy_name
  policy_id           = local.config.accessContextManager.policy_id
  access_level        = local.config.accessContextManager.access_level
  department_code     = local.config.departmentCode
  environment         = local.config.environment
  location            = local.config.location
  user_defined_string = local.config.accessContextManager.userDefinedString
}
