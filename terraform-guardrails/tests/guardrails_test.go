package tests

import (
	"encoding/json"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
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
	var tf interface{}
	json.Unmarshal([]byte(terraform.OutputJson(t, opts, "")), &tf)

	projectId := terraform.Output(t, opts, "project_id")
	assetInventoryBucket := terraform.Output(t, opts, "asset_inventory_bucket")
	reportsBucket := terraform.Output(t, opts, "reports_bucket")
	reportGenerationSchedule := terraform.Output(t, opts, "report_generation_schedule")
	guardrailsPoliciesRepoName := terraform.Output(t, opts, "guardrails_policies_repo_name")
	guardrailsValidationContainerLocation := terraform.Output(t, opts, "guardrails_validation_container_location")
	cloudbuildContainerPipelineTrigger := terraform.OutputMapOfObjects(t, opts, "cloudbuild_container_pipeline_trigger")

	cloudbuildContainerPipelineTriggerData := map[string]interface{}{
		"branch_name":  "main",
		"commit_sha":   "",
		"dir":          "guardrails-validation",
		"invert_regex": false,
		"project_id":   projectId,
		"repo_name":    guardrailsPoliciesRepoName,
		"tag_name":     "",
	}

	assert.NotNil(t, projectId)
	assert.Equal(t, reportGenerationSchedule, "0 8 * * *")
	assert.Contains(t, reportsBucket, "scde")
	assert.Contains(t, reportsBucket, "reports")
	assert.Contains(t, assetInventoryBucket, "scde")
	assert.Contains(t, assetInventoryBucket, "assets")
	assert.Contains(t, projectId, "scde-ga-guardrails")
	assert.Equal(t, guardrailsValidationContainerLocation, "gcr.io/"+projectId+"/scdeccr-guardrails-policies-cntr:latest")
	assert.Equal(t, guardrailsPoliciesRepoName, "ScDeCLD-guardrails-policies-csr")
	assert.Equal(t, cloudbuildContainerPipelineTrigger, cloudbuildContainerPipelineTriggerData)
}
