/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"gotest.tools/assert"
)

func TestModuleDeployment(t *testing.T) {
	t.Parallel()
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	compute_network_users := terraform.OutputList(t, terraformOptions, "compute_network_users")
	folder_iam_members := terraform.OutputList(t, terraformOptions, "folder_iam_members")
	organization_iam_members := terraform.OutputList(t, terraformOptions, "organization_iam_members")
	project_iam_members := terraform.OutputList(t, terraformOptions, "project_iam_members")
	service_accounts := terraform.OutputMapOfObjects(t, terraformOptions, "service_accounts")

	assert.Equal(t, 1, len(compute_network_users))
	assert.Equal(t, 1, len(folder_iam_members))
	assert.Equal(t, 1, len(organization_iam_members))
	assert.Equal(t, 2, len(project_iam_members))
	assert.Equal(t, 2, len(service_accounts))
}
