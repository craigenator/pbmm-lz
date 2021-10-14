include {
  path = fileexists("${get_terragrunt_dir()}/../../config/bootstrap.hcl") ? "${get_terragrunt_dir()}/../../config/bootstrap.hcl" : "empty.hcl"
}

locals {
  config = yamldecode(file("${get_terragrunt_dir()}/../../config/organization-config.yaml"))
}

terraform {
  source = "../terraform-landing-zone-bootstrap"
}

inputs = {
  billing_account                = local.config.bootstrap.billingAccount
  parent                         = local.config.bootstrap.parent
  terraform_deployment_account   = local.config.bootstrap.terraformDeploymentAccount
  bootstrap_email                = local.config.bootstrap.bootstrapEmail
  tfstate_buckets                = local.config.bootstrap.tfstate_buckets
  services                       = local.config.bootstrap.projectServices
  labels                         = local.config.labels  
  org_id                         = local.config.orgId
  yaml_config_bucket             = local.config.bootstrap.yaml_config_bucket
  department_code                = local.config.departmentCode
  environment                    = local.config.environment
  location                       = local.config.location
  owner                          = local.config.owner
  user_defined_string            = local.config.bootstrap.userDefinedString
  additional_user_defined_string = local.config.bootstrap.additionalUserDefinedString
}
