package tests

import (
	"testing"

	"github.com/Jeffail/gabs"
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

	if err != nil {
		panic(err)
	}

	projectId, _ := jsonParsed.JSONPointer("/project_id/value")
	vmName, _ := jsonParsed.JSONPointer("/name/value")
	domain, _ := jsonParsed.JSONPointer("/domain/value")
	hostname, _ := jsonParsed.JSONPointer("/hostname/value")

	builtHostname := vmName.Data().(string) + "." + projectId.Data().(string) + "." + domain.Data().(string)

	assert.Equal(t, hostname.Data().(string), builtHostname)

}
