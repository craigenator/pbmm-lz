/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

terraform {
  # Optional attributes and the defaults function are
  # both experimental, so we must opt in to the experiment.
  experiments = [module_variable_optional_attrs]
}

variable "parent" {
  description = "folder/#### or organizations/#### to place the project into"
  type        = string
}

variable "billing_account" {
  description = "billing account ID"
  type        = string
}

variable "services" {
  type        = list(string)
  description = "List of services to enable on the bootstrap project required for using their APIs"
}

variable projectlabels {
  type = object({
      creator                = optional(string),
      date_created           = optional(string),
      date_modified          = optional(string),
      title                  = optional(string),
      department             = optional(string),
      imt_sector             = optional(string),
      environment            = optional(string),
      service_id             = optional(string),
      application_name       = optional(string),
      business_contact       = optional(string),
      technical_contact      = optional(string),
      general_ledger_account = optional(string),
      cost_center            = optional(string),
      internal_order         = optional(string),
      sos_id                 = optional(string),
      stra_id                = optional(string),
      security_classification= optional(string),
      criticality            = optional(string),
      hours_of_operation     = optional(string),
      project_code           = optional(string)
  })
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

## network ##
variable "networks" {
  type = list(object({
    network_name                           = string
    description                            = optional(string)
    routing_mode                           = optional(string)
    shared_vpc_host                        = optional(bool)
    auto_create_subnetworks                = optional(bool)
    delete_default_internet_gateway_routes = optional(bool)
    peer_project                           = optional(string)
    peer_network                           = optional(string)
    export_peer_custom_routes              = optional(bool)
    mtu                                    = optional(number)
    subnets = list(object({
      subnet_name           = string
      description           = optional(string)
      subnet_private_access = optional(bool)
      subnet_region         = optional(string)
      subnet_ip             = string
      secondary_ranges = optional(list(object({
        range_name    = string
        ip_cidr_range = string
      })))
      log_config = optional(object({
        aggregation_interval = optional(string)
        flow_sampling        = optional(number)
        metadata             = optional(string)
      }))
    }))
    routes = optional(list(object({
      route_name                        = string
      description                       = optional(string)
      destination_range                 = string
      next_hop_default_internet_gateway = optional(bool)
      next_hop_gateway                  = optional(string)
      next_hop_ip                       = optional(string)
      next_hop_instance                 = optional(string)
      next_hop_instance_zone            = optional(string)
      next_hop_vpn_tunnel               = optional(string)
      priority                          = optional(number)
      tags                              = optional(list(string))
    })))
    routers = optional(list(object({
      router_name = string
      description = optional(string)
      region      = optional(string)
      bgp = optional(object({
        asn               = number
        advertise_mode    = optional(string)
        advertised_groups = optional(list(string))
        advertised_ip_ranges = optional(list(object({
          range       = string
          description = optional(string)
        })))
      }))
    })))
  }))
}



## firewall rules ##

variable "custom_rules" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = {}
  type = map(object({
    description          = string
    direction            = string
    action               = string # (allow|deny)
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
}

variable "enable_bastion_ports" {
  description = "enable IAP via ports 22 and 3389"
  type        = bool
  default     = true
}

variable "custom_iap_rules" {
  description = "Object of rules to add to the firewall for IAP access to custom ports"
  type = map(object({
    rule_name = string
    protocol  = string
    ports     = list(string)
    })
  )
  default = {}
}

variable "zone_list" {
  description = "List of all zone where all communicaiton within the zone itself is allow, traffic to other zones still requires other rules"
  type        = list(any)
  default = [
    "public-access-zone",
    "operations-zone",
    "restricted-zone",
    "management-restricted-zone"
  ]
}

variable "internal_ranges_enabled" {
  description = "Create rules for intra-VPC ranges."
  type        = bool
  default     = false
}

variable "internal_ranges" {
  description = "IP CIDR ranges for intra-VPC rules."
  type        = list(string)
  default     = []
}

variable "internal_target_tags" {
  description = "List of target tags for intra-VPC rules."
  type        = list(string)
  default     = []
}

variable "internal_allow" {
  description = "Allow rules for internal ranges."
  default = [
    {
      protocol = "icmp"
    },
  ]
}

variable "admin_ranges_enabled" {
  description = "Enable admin ranges-based rules."
  type        = bool
  default     = false
}

variable "admin_ranges" {
  description = "IP CIDR ranges that have complete access to all subnets."
  type        = list(string)
  default     = []
}