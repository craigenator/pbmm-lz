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

variable "project_id" {
  description = "The ID of the project where the routes will be created"
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

variable "additional_user_defined_string" {
  type        = string
  description = "Additional user defined string."
  default     = ""
}

# networks
variable "network_name" {
  type = string
}
variable "description" {
  type    = string
  default = ""
}
variable "routing_mode" {
  type    = string
  default = "GLOBAL"
}
variable "shared_vpc_host" {
  type    = bool
  default = false
}
variable "auto_create_subnetworks" {
  type    = bool
  default = false
}
variable "delete_default_internet_gateway_routes" {
  type    = bool
  default = false
}
variable "peer_project" {
  type    = string
  default = ""
}
variable "peer_network" {
  type    = string
  default = ""
}
variable "export_peer_custom_routes" {
  type    = bool
  default = false
}
variable "mtu" {
  type    = number
  default = 1460
}

# subnets
variable "subnets" {
  type = list(object({
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
}
# routes
variable "routes" {
  type = list(object({
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
  }))
  default = []
}
variable "routers" {
  type = list(object({
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
  }))
  default = []
}

#others
variable "module_depends_on" {
  description = "List of modules or resources this module depends on."
  type        = list(any)
  default     = []
}
