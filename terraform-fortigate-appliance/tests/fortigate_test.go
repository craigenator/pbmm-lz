package tests

import (
	"testing"

	"github.com/Jeffail/gabs"
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

	jsonParsed, err := gabs.ParseJSON([]byte(terraform.OutputJson(t, terraformOptions, "")))

	if err != nil {
		panic(err)
	}

	Terraform_RW_User_API_key, _ := jsonParsed.JSONPointer("/Terraform_RW_User_API_key/value")
	internal_route, _ := jsonParsed.JSONPointer("/internal_route/value")
	mirror_lb_address, _ := jsonParsed.JSONPointer("/mirror_lb_address/value")

	assert.Regexp(t, "^[a-zA-Z0-9]{30}$", Terraform_RW_User_API_key.Data().(string))
	assert.Equal(t, "internal-route", internal_route.Data().(string))
	assert.Regexp(t, "^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", mirror_lb_address.Data().(string))
}
