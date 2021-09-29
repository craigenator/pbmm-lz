/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

resource "google_project" "project" {
  org_id              = local.parent_type == "organizations" ? local.parent_id : null
  folder_id           = local.parent_type == "folders" ? local.parent_id : null
  project_id          = lower(module.project_name.result)
  name                = module.project_name.result
  billing_account     = var.billing_account
  auto_create_network = var.auto_create_network
  labels              = var.labels
}

resource "google_compute_project_metadata_item" "oslogin_meta" {
  count   = var.oslogin ? 1 : 0
  project = google_project.project.project_id
  key     = "enable-oslogin"
  value   = "TRUE"
  # depend on services or it will fail on destroy
  depends_on = [google_project_service.project_services]
}

resource "google_project_service" "project_services" {
  for_each                   = toset(var.services)
  project                    = google_project.project.project_id
  service                    = each.value
  disable_on_destroy         = var.service_config.disable_on_destroy
  disable_dependent_services = var.service_config.disable_dependent_services
}

resource "google_project_organization_policy" "boolean" {
  for_each   = var.policy_boolean
  project    = google_project.project.project_id
  constraint = each.key

  dynamic "boolean_policy" {
    for_each = each.value == null ? [] : [each.value]
    iterator = policy
    content {
      enforced = policy.value
    }
  }

  dynamic "restore_policy" {
    for_each = each.value == null ? [""] : []
    content {
      default = true
    }
  }
}

resource "google_project_organization_policy" "list" {
  for_each   = var.policy_list
  project    = google_project.project.project_id
  constraint = each.key

  dynamic "list_policy" {
    for_each = each.value.status == null ? [] : [each.value]
    iterator = policy
    content {
      inherit_from_parent = policy.value.inherit_from_parent
      suggested_value     = policy.value.suggested_value
      dynamic "allow" {
        for_each = policy.value.status ? [""] : []
        content {
          values = (
            try(length(policy.value.values) > 0, false)
            ? policy.value.values
            : null
          )
          all = (
            try(length(policy.value.values) > 0, false)
            ? null
            : true
          )
        }
      }
      dynamic "deny" {
        for_each = policy.value.status ? [] : [""]
        content {
          values = (
            try(length(policy.value.values) > 0, false)
            ? policy.value.values
            : null
          )
          all = (
            try(length(policy.value.values) > 0, false)
            ? null
            : true
          )
        }
      }
    }
  }

  dynamic "restore_policy" {
    for_each = each.value.status == null ? [true] : []
    content {
      default = true
    }
  }
}

resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  count   = try(var.shared_vpc_host_config, false) ? 1 : 0
  project = google_project.project.project_id
}

resource "google_compute_shared_vpc_service_project" "shared_vpc_service" {
  count           = try(var.shared_vpc_service_config.attach, false) ? 1 : 0
  host_project    = var.shared_vpc_service_config.host_project
  service_project = google_project.project.project_id
}

##### IAP
resource "google_project_iam_member" "custom_iap_member" {
  for_each = toset(var.iap_tunnel_members_list)
  project  = google_project.project.project_id
  role     = "roles/iap.tunnelResourceAccessor"
  member   = each.value
}