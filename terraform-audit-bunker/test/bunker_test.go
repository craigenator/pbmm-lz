package tests

import (
	"strings"
	"testing"

	"github.com/Jeffail/gabs/v2"
	"github.com/gruntwork-io/terratest/modules/gcp"
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
	jsonParsed, err := gabs.ParseJSON([]byte(terraform.OutputJson(t, opts, "")))

	if err != nil {
		panic(err)
	}

	random_id, _ := jsonParsed.JSONPointer("/random_id/value")
	randomId := random_id.Data().(string)
	randomIdLower := strings.ToLower(randomId)
	projectId, _ := jsonParsed.JSONPointer("/project_id/value")
	assert.Equal(t, projectId.Data().(string), "lzpe-ga-utaudit"+randomIdLower)

	logSink, _ := jsonParsed.JSONPointer("/log_sinks/value/prod")
	assert.Equal(t, logSink.Data().(string), "LzPeCLD-orgaudit"+randomId+"-sink")

	sinkBucket, _ := jsonParsed.JSONPointer("/sink_buckets/value/prod")
	assert.Equal(t, sinkBucket.Data().(string), "lzpeorgaudit"+randomIdLower)
	gcp.AssertStorageBucketExists(t, sinkBucket.Data().(string))
}
