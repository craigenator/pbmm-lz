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

	// Assert forwarding zone name servers
	forwarding_zone_name_servers := terraform.Output(t, opts, "forwarding_zone_name_servers")
	assert.Equal(t, forwarding_zone_name_servers, "[ns-gcp-private.googledomains.com.]")

	// Assert private zone name servers
	private_zone_name_servers := terraform.Output(t, opts, "private_zone_name_servers")
	assert.Equal(t, private_zone_name_servers, "[ns-gcp-private.googledomains.com.]")

	// Assert public zone name servers
	public_zone_name_servers := terraform.Output(t, opts, "public_zone_name_servers")
	assert.Contains(t, public_zone_name_servers, "ns-cloud-")
	assert.Contains(t, public_zone_name_servers, "1.googledomains.com.")
	assert.Contains(t, public_zone_name_servers, "2.googledomains.com.")
	assert.Contains(t, public_zone_name_servers, "3.googledomains.com.")
	assert.Contains(t, public_zone_name_servers, "4.googledomains.com.")
}
