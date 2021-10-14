include {
  path = find_in_parent_folders()
}

locals {
  config = yamldecode(file("${get_terragrunt_dir()}/../../../config/organization-config.yaml"))
}

terraform {
  source = "../../terraform-folders"
}

inputs = {
  parent                  = local.config.folders.parent
  names                   = local.config.folders.names
  subfolders_first_level  = local.config.folders.subfolders_1
  subfolders_second_level = local.config.folders.subfolders_2
}
