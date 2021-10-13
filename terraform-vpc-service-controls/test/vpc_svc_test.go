package tests

import (
	"context"
	"log"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"google.golang.org/api/accesscontextmanager/v1"
)

func TestModuleDeployment(t *testing.T) {
	t.Parallel()

	regularPerimeterName := "rp" + strings.ToLower(random.UniqueId())
	bridgePerimeterName := "bp" + strings.ToLower(random.UniqueId())
	accessLevelName := "ac" + strings.ToLower(random.UniqueId())

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/",
		Vars: map[string]interface{}{
			"bridge_perimeter_name":  bridgePerimeterName,
			"regular_perimeter_name": regularPerimeterName,
			"access_level_name":      accessLevelName,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	policyId := terraform.Output(t, terraformOptions, "policy_id")
	accessLevels := "accessPolicies/" + policyId + "/accessLevels/" + "scdevsc_" + accessLevelName + "_vsc"
	regularPerimeters := "accessPolicies/" + policyId + "/servicePerimeters/" + "scdevsc_" + regularPerimeterName + "_vsc"
	bridgePerimeter := "accessPolicies/" + policyId + "/servicePerimeters/" + "scdevsc_" + bridgePerimeterName + "_vsc"
	activePerimeters := getPerimeters("accessPolicies/" + policyId)

	assert.Contains(t, getAccessLevels("accessPolicies/"+policyId), accessLevels)
	assert.Contains(t, activePerimeters, regularPerimeters)
	assert.Contains(t, activePerimeters, bridgePerimeter)
}

func getAccessLevels(parent string) []string {
	ctx := context.Background()

	accesscontextmanagerService, err := accesscontextmanager.NewService(ctx)
	if err != nil {
		log.Fatal(err)
	}

	resp, err := accesscontextmanagerService.AccessPolicies.AccessLevels.List(parent).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	var accessLevels []string
	for _, i := range resp.AccessLevels {
		accessLevels = append(accessLevels, i.Name)
	}

	return accessLevels
}

func getPerimeters(parent string) []string {
	ctx := context.Background()

	accesscontextmanagerService, err := accesscontextmanager.NewService(ctx)
	if err != nil {
		log.Fatal(err)
	}

	resp, err := accesscontextmanagerService.AccessPolicies.ServicePerimeters.List(parent).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	var servicePerimeters []string
	for _, i := range resp.ServicePerimeters {
		servicePerimeters = append(servicePerimeters, i.Name)
	}

	return servicePerimeters
}
