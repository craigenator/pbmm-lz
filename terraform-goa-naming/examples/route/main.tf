/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

module "example_route" {
  source = "../../modules/gcp/route"

  user_defined_string = var.user_defined_string
}