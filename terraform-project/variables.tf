/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

variable "auto_create_network" {
  description = "Whether to create the default network for the project"
  type        = bool
  default     = false
}

variable "billing_account" {
  description = "Billing account id."
  type        = string
  default     = null
}

variable "labels" {
  description = "Resource labels."
  type        = map(string)
  default     = {}
}

variable "oslogin" {
  description = "Enable OS Login."
  type        = bool
  default     = false
}

variable "oslogin_admins" {
  description = "List of IAM-style identities that will be granted roles necessary for OS Login administrators."
  type        = list(string)
  default     = []
}

variable "oslogin_users" {
  description = "List of IAM-style identities that will be granted roles necessary for OS Login users."
  type        = list(string)
  default     = []
}

variable "parent" {
  description = "Parent folder or organization in 'folders/folder_id' or 'organizations/org_id' format."
  type        = string
  default     = null
  validation {
    condition     = var.parent == null || can(regex("(organizations|folders)/[0-9]+", var.parent))
    error_message = "Parent must be of the form folders/folder_id or organizations/organization_id."
  }
}

variable "policy_boolean" {
  description = "Map of boolean org policies and enforcement value, set value to null for policy restore."
  type        = map(bool)
  default     = {}
}

variable "policy_list" {
  description = "Map of list org policies, status is true for allow, false for deny, null for restore. Values can only be used for allow or deny."
  type = map(object({
    inherit_from_parent = bool
    suggested_value     = string
    status              = bool
    values              = list(string)
  }))
  default = {}
}

variable "services" {
  description = "Service APIs to enable."
  type        = list(string)
  default     = []
}

variable "service_config" {
  description = "Configure service API activation."
  type = object({
    disable_on_destroy         = bool
    disable_dependent_services = bool
  })
  default = {
    disable_on_destroy         = true
    disable_dependent_services = true
  }
}

variable "shared_vpc_host_config" {
  description = "Configures this project as a Shared VPC host project (mutually exclusive with shared_vpc_service_project)."
  type        = bool
  default     = false
}

variable "shared_vpc_service_config" {
  description = "Configures this project as a Shared VPC service project (mutually exclusive with shared_vpc_host_config)."
  type = object({
    attach       = bool
    host_project = string
  })
  default = {
    attach       = false
    host_project = ""
  }
}

variable "iap_tunnel_members_list" {
  description = "list of users to grant iap.tunnelResourceAccessor role"
  type        = list(string)
  default     = []
}

# naming
variable "department_code" {
  type        = string
  description = "Code for department, part of naming module"
}

variable "environment" {
  type        = string
  description = "S-Sandbox P-Production Q-Quality D-development"
}

variable "location" {
  type        = string
  description = "location for naming and resource placement"
  default     = "northamerica-northeast1"
}

variable "owner" {
  type        = string
  description = "Division or group responsible for security and financial commitment."
}

variable "user_defined_string" {
  type        = string
  description = "User defined string."
}

variable "additional_user_defined_string" {
  type        = string
  description = "Additional user defined string."
  default     = ""
}
