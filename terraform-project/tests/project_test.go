/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

package tests

import (
	"fmt"
	"log"
	"testing"

	"github.com/Jeffail/gabs/v2"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"golang.org/x/net/context"
	"golang.org/x/oauth2/google"
	"google.golang.org/api/cloudresourcemanager/v1"
	"google.golang.org/api/compute/v1"
	"google.golang.org/api/serviceusage/v1"
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

	projectName, _ := jsonParsed.JSONPointer("/name/value")
	assert.Contains(t, projectName.Data().(string), "UtDe-unittest-")

	projectId, _ := jsonParsed.JSONPointer("/project_id/value")
	assert.Contains(t, projectId.Data().(string), "utde-unittest-uthostproj")

	// API Call tests
	projectNumber, _ := jsonParsed.JSONPointer("/number/value")

	enabledService := getServiceState(projectNumber.Data().(string), "appengine.googleapis.com")
	assert.Equal(t, enabledService, "ENABLED")

	boolConstraint := checkOrgPolicyBoolean(projectId.Data().(string), "compute.skipDefaultNetworkCreation")
	assert.True(t, boolConstraint)

	listConstraint := checkOrgPolicyList(projectId.Data().(string), "compute.trustedImageProjects")
	assert.Contains(t, listConstraint, "projects/gce-uefi-images")

	hostProjects := checkXpnHost(projectId.Data().(string))
	assert.Contains(t, hostProjects, projectId.Data().(string))

	ServiceProjects := checkXpnService(projectId.Data().(string))
	serviceProjectId, _ := jsonParsed.JSONPointer("/service_project_id/value")
	assert.Contains(t, ServiceProjects, serviceProjectId.Data().(string))
}

func getServiceState(project, service string) string {
	ctx := context.Background()

	c, err := google.DefaultClient(ctx, serviceusage.CloudPlatformScope)
	if err != nil {
		log.Fatal(err)
	}

	serviceUsageService, err := serviceusage.New(c)
	if err != nil {
		log.Fatal(err)
	}

	resp, err := serviceUsageService.Services.Get("projects/" + project + "/services/" + service).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	return resp.State
}

func checkOrgPolicyBoolean(project, constraint string) bool {
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
	resource := "projects/" + project

	rb := &cloudresourcemanager.GetOrgPolicyRequest{
		Constraint: "constraints/" + constraint,
	}
	fmt.Println(resource, constraint)
	resp, err := cloudresourcemanagerService.Projects.GetOrgPolicy(resource, rb).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	return resp.BooleanPolicy.Enforced
}

func checkOrgPolicyList(project, constraint string) []string {
	ctx := context.Background()

	c, err := google.DefaultClient(ctx, cloudresourcemanager.CloudPlatformScope)
	if err != nil {
		log.Fatal(err)
	}

	cloudresourcemanagerService, err := cloudresourcemanager.New(c)
	if err != nil {
		log.Fatal(err)
	}

	resource := "projects/" + project

	rb := &cloudresourcemanager.GetOrgPolicyRequest{
		Constraint: "constraints/" + constraint,
	}
	fmt.Println(resource, constraint)
	resp, err := cloudresourcemanagerService.Projects.GetOrgPolicy(resource, rb).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	return resp.ListPolicy.AllowedValues
}

func checkXpnHost(project string) []string {
	ctx := context.Background()
	var xpnProjects []string

	computeService, err := compute.NewService(ctx)
	if err != nil {
		log.Fatal(err)
	}

	rb := &compute.ProjectsListXpnHostsRequest{}
	resp, err := computeService.Projects.ListXpnHosts(project, rb).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	for _, pj := range resp.Items {
		xpnProjects = append(xpnProjects, pj.Name)
	}

	return xpnProjects
}

func checkXpnService(project string) []string {
	ctx := context.Background()
	var xpnProjects []string

	computeService, err := compute.NewService(ctx)
	if err != nil {
		log.Fatal(err)
	}

	resp, err := computeService.Projects.GetXpnResources(project).Context(ctx).Do()
	if err != nil {
		log.Fatal(err)
	}

	for _, pj := range resp.Resources {
		xpnProjects = append(xpnProjects, pj.Id)

	}
	return xpnProjects
}
