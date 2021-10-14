# Landing Zone Bootstrap Project

This modules is designed to work with the requirements for the GCP Landing Zone.

This module provides:
- Application Project
- VPC, Subnet, Routes and Firewalls
- Labels

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source |
|------|--------|
| <a name="module_project"></a> [project](#module\_project) | ../terraform-project |
| <a name="module_resource_policy_names"></a> [resource\_policy\_names](#module\_resource\_policy\_names) | ../terraform-firewall |

## Outputs

| Name | Description |
|------|-------------|
| network_name | n/a |
| project_id | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->