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

	"github.com/Jeffail/gabs"
	"github.com/gruntwork-io/terratest/modules/gcp"
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
	validateOutputs(t, terraformOptions)
}

func validateOutputs(t *testing.T, opts *terraform.Options) {
	jsonParsed, err := gabs.ParseJSON([]byte(terraform.OutputJson(t, opts, "")))

	bucket_names, _ := terraform.OutputMapE(t, opts, "tfstate_bucket_names")

	if err != nil {
		panic(err)
	}

	projectId, _ := jsonParsed.JSONPointer("/project_id/value")
	saEmail, _ := jsonParsed.JSONPointer("/service_account_email/value")
	config_bucket, _ := jsonParsed.JSONPointer("/yaml_config_bucket/value")

	assert.Equal(t, saEmail.Data().(string), "unittest-sa@"+projectId.Data().(string)+".iam.gserviceaccount.com")

	gcp.AssertStorageBucketExists(t, bucket_names["common"])
	gcp.AssertStorageBucketExists(t, bucket_names["prod"])
	gcp.AssertStorageBucketExists(t, bucket_names["nonp"])
	gcp.AssertStorageBucketExists(t, config_bucket.Data().(string))
}
