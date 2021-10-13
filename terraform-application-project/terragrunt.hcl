locals {
  config   = yamldecode(file("${get_terragrunt_dir()}/config/application-config.yaml"))
  firewall = yamldecode(file("${get_terragrunt_dir()}/config/firewall-config.yaml"))
}

inputs = {
  services                       = local.config.application.projectServices
  billing_account                = local.config.application.billingAccount
  parent                         = local.config.application.parent
  networks                       = local.config.application.networks
  department_code                = local.config.application.departmentCode
  environment                    = local.config.application.environment
  location                       = local.config.application.location
  projectlabels                  = local.config.application.labels
  owner                          = local.config.application.owner
  user_defined_string            = local.config.application.userDefinedString
  additional_user_defined_string = local.config.application.additionalUserDefinedString
  custom_rules                   = local.firewall.customfirewallrules
}