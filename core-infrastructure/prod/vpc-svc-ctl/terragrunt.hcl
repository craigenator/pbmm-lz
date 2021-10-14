include {
  path = find_in_parent_folders()
}

locals {
  vpcSvcCtl = yamldecode(file("${get_terragrunt_dir()}/../../../config/prod-vpc-svc-ctl.yaml"))
  config    = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

dependency "access_context_manager" {
  config_path = "${get_terragrunt_dir()}/../../common/access-context-manager"
}

terraform {
  source = "../../terraform-vpc-service-controls"
}

inputs = {
  policy_id                 = dependency.access_context_manager.outputs.policy_id
  parent_id                 = dependency.access_context_manager.outputs.parent_id
  regular_service_perimeter = local.vpcSvcCtl.prodVpcSvcCtl.regular_service_perimeter
  bridge_service_perimeter  = local.vpcSvcCtl.prodVpcSvcCtl.bridge_service_perimeter
  department_code           = local.config.departmentCode
  environment               = local.config.environment
  location                  = local.config.location
  user_defined_string       = local.config.audit.userDefinedString
}
