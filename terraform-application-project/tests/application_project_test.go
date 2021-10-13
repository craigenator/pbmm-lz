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
	tfoutput := tf.(map[string]interface{})

	// Assert Project ID
	projectId := terraform.Output(t, opts, "project_id")
	assert.NotNil(t, projectId)
	assert.Contains(t, projectId, "scde-gc-datalake")

	// Assert Service Account Email
	serviceAccountEmail := terraform.Output(t, opts, "service_account_email")
	assert.Contains(t, serviceAccountEmail, "application-deploy-sa@scde-gc-datalake")
	
	// Assert State Buckets
	tfStateBucketName := terraform.Output(t, opts, "tfstate_bucket_name")
	assert.Equal(t, "scdedatalaketfstate", tfStateBucketName)
	
	// Assert Project DNS Sub Zone
	dnsZone := tfoutput["dns_sub_zone"].(map[string]interface{})["value"].(map[string]interface{})
	dnsZoneVisibility := dnsZone["private_visibility_config"].([]interface{})[0].(map[string]interface{})
	dnsZoneVisbilityNetworks := dnsZoneVisibility["networks"].([]interface{})[0].(map[string]interface{})
	assert.Contains(t, dnsZone["description"], "Main Managed DNS Zone for Project datalake")
	assert.Contains(t, dnsZone["dns_name"], "datalake")
	assert.Contains(t, dnsZone["dns_name"], ".c3.ssc-spc-cloud-nuage.canada.ca.")
	assert.Equal(t, "private", dnsZone["visibility"])
	assert.Contains(t, dnsZoneVisbilityNetworks["network_url"], "projects/scde-gc-host")
	assert.Contains(t, dnsZoneVisbilityNetworks["network_url"], "/global/networks/default")
}
