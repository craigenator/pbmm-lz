package tests

import (
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
	custom_egress_allow_rules := []string{
		"lzpefwl-allow-egress-backend-to-databases-fwr",
	}
	custom_egress_deny_rules := []string{
		"lzpefwl-deny-egress-fwr",
	}
	custom_ingress_allow_rules := []string{
		"lzpefwl-allow-all-admin-sa-fwr",
		"lzpefwl-allow-backend-to-databases-fwr",
	}
	custom_ingress_deny_rules := []string{
		"lzpefwl-deny-ingress-6534-6566-fwr",
	}

	customEgressAllow := terraform.OutputList(t, opts, "custom_egress_allow_rules")
	assert.Equal(t, custom_egress_allow_rules, customEgressAllow)
	customEgressDeny := terraform.OutputList(t, opts, "custom_egress_deny_rules")
	assert.Equal(t, custom_egress_deny_rules, customEgressDeny)
	customIngressAllow := terraform.OutputList(t, opts, "custom_ingress_allow_rules")
	assert.Equal(t, custom_ingress_allow_rules, customIngressAllow)
	customIngressDeny := terraform.OutputList(t, opts, "custom_ingress_deny_rules")
	assert.Equal(t, custom_ingress_deny_rules, customIngressDeny)
}
