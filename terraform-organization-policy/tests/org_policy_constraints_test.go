package tests

import (
	"context"
	"fmt"
	"log"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"golang.org/x/oauth2/google"
	"google.golang.org/api/cloudresourcemanager/v1"
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
	orgID := os.Getenv("TF_VAR_organization_id")
	boolConstraint := checkOrgPolicyBoolean(orgID, "compute.skipDefaultNetworkCreation")
	assert.True(t, boolConstraint)
	boolConstraint = checkOrgPolicyBoolean(orgID, "storage.uniformBucketLevelAccess")
	assert.True(t, boolConstraint)
	boolConstraint = checkOrgPolicyBoolean(orgID, "compute.requireOsLogin")
	assert.True(t, boolConstraint)

	// ===================== List Policy Constraint Checker
	listConstraint := checkOrgPolicyList(orgID, "gcp.resourceLocations")
	assert.Contains(t, listConstraint.DeniedValues, "in:southamerica-locations")
	assert.Contains(t, listConstraint.DeniedValues, "in:eu-locations")
	assert.Contains(t, listConstraint.DeniedValues, "in:asia-locations")
	assert.Contains(t, listConstraint.DeniedValues, "in:us-locations")

	listConstraint = checkOrgPolicyList(orgID, "iam.allowedPolicyMemberDomains")
	directoryID := os.Getenv("TF_VAR_directory_customer_id")
	directoryID = strings.ReplaceAll(directoryID, "\"", "")
	directoryID = strings.ReplaceAll(directoryID, "\\", "")
	directoryID = strings.ReplaceAll(directoryID, "[", "")
	directoryID = strings.ReplaceAll(directoryID, "]", "")
	listID := strings.Split(directoryID, ",")
	assert.Contains(t, listConstraint.AllowedValues, fmt.Sprintf("is:%s", listID[0]))

	listConstraint = checkOrgPolicyList(orgID, "compute.vmExternalIpAccess")
	assert.Equal(t, listConstraint.AllValues, "DENY")

	listConstraint = checkOrgPolicyList(orgID, "compute.vmCanIpForward")
	assert.Equal(t, listConstraint.AllValues, "DENY")

	time.Sleep(10 * time.Second)
}

func checkOrgPolicyBoolean(orgID, constraint string) bool {
	ctx := context.Background()

	c, err := google.DefaultClient(ctx, cloudresourcemanager.CloudPlatformScope)
	if err != nil {
		log.Fatal(err)
	}

	cloudresourcemanagerService, err := cloudresourcemanager.New(c)

	if err != nil {
		log.Fatal(err)
	}

	// Name of the resource the `Policy` is set on.
	resource := "organizations/" + orgID
	rb := &cloudresourcemanager.GetOrgPolicyRequest{
		Constraint: "constraints/" + constraint,
	}

	fmt.Println(resource, constraint)
	resp, err := cloudresourcemanagerService.Organizations.GetOrgPolicy(resource, rb).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	return resp.BooleanPolicy.Enforced
}

func checkOrgPolicyList(orgID, constraint string) *cloudresourcemanager.ListPolicy {
	ctx := context.Background()

	c, err := google.DefaultClient(ctx, cloudresourcemanager.CloudPlatformScope)
	if err != nil {
		log.Fatal(err)
	}

	cloudresourcemanagerService, err := cloudresourcemanager.New(c)
	if err != nil {
		log.Fatal(err)
	}

	resource := "organizations/" + orgID

	rb := &cloudresourcemanager.GetOrgPolicyRequest{
		Constraint: "constraints/" + constraint,
	}
	fmt.Println(resource, constraint)
	resp, err := cloudresourcemanagerService.Organizations.GetOrgPolicy(resource, rb).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	return resp.ListPolicy
}
