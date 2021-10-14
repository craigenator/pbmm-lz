dependency "infra" {
  config_path = "${get_terragrunt_dir()}/../../../bootstrap"
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = dependency.infra.outputs.tfstate_bucket_names.prod
    prefix = "core-infrastructure/prod/${path_relative_to_include()}"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.56.0"
    }
  }
  required_version = ">= 0.14.4"
}

provider "google" {
  region = "northamerica-northeast1"
  # credentials = path or contents of SA JSON file
}
EOF
}