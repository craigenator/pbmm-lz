include {
  path = find_in_parent_folders()
}

locals {
  config = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

terraform {
  source = "../../terraform-organization-policy"
}

inputs = {
  organization_id              = local.config.orgId
  directory_customer_id        = local.config.orgPolicies.directoryCustomerId
  vms_allowed_with_external_ip = local.config.orgPolicies.vmAllowedWithExternalIp
  vms_allowed_with_ip_forward  = local.config.orgPolicies.vmAllowedWithIpForward
  policy_boolean               = local.config.orgPolicies.policy_boolean
  policy_list                  = local.config.orgPolicies.policy_list
  set_default_policy           = local.config.orgPolicies.setDefaultPolicy
}
