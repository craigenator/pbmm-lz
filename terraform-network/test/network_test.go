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
	validateOutputs(t, terraformOptions)
}

func validateOutputs(t *testing.T, opts *terraform.Options) {
	tfoutput, _ := gabs.ParseJSON([]byte(terraform.OutputJson(t, opts, "")))
	projectId := terraform.Output(t, opts, "project_id")

	networkData := map[string]interface{}{
		"auto_create_subnetworks":         false,
		"delete_default_routes_on_create": true,
		"description":                     "",
		"gateway_ipv4":                    "",
		"id":                              "projects/" + projectId + "/global/networks/utdecnr-examplevpc-vpc",
		"mtu":                             0,
		"name":                            "utdecnr-examplevpc-vpc",
		"project":                         projectId,
		"routing_mode":                    "GLOBAL",
		"self_link":                       "https://www.googleapis.com/compute/v1/projects/" + projectId + "/global/networks/utdecnr-examplevpc-vpc",
		"timeouts":                        nil,
	}

	tfNetwork := terraform.OutputMapOfObjects(t, opts, "network")
	assert.Equal(t, networkData, tfNetwork)

	routes := map[string]interface{}{
		"egress-internet": map[string]interface{}{
			"description":            "route through IGW to access internet",
			"dest_range":             "0.0.0.0/0",
			"id":                     "projects/" + projectId + "/global/routes/egress-internet-route",
			"name":                   "egress-internet-route",
			"network":                "https://www.googleapis.com/compute/v1/projects/" + projectId + "/global/networks/utdecnr-examplevpc-vpc",
			"next_hop_gateway":       "https://www.googleapis.com/compute/v1/projects/" + projectId + "/global/gateways/default-internet-gateway",
			"next_hop_ilb":           "",
			"next_hop_instance":      "",
			"next_hop_instance_zone": nil,
			"next_hop_ip":            "",
			"next_hop_network":       "",
			"next_hop_vpn_tunnel":    "",
			"priority":               float64(1000),
			"project":                projectId,
			"self_link":              "https://www.googleapis.com/compute/v1/projects/" + projectId + "/global/routes/egress-internet-route",
			"tags": []interface{}{
				"egress-inet",
			},
			"timeouts": nil,
		},
	}

	tfRoutes := tfoutput.Path("routes.value").Data()
	assert.Equal(t, routes, tfRoutes)

	tfSubnets := tfoutput.Path("subnets.value").Data()
	subnetTimeStamp := tfoutput.Path("subnets.value.northamerica-northeast1/subnet01.creation_timestamp").Data()
	subnets := map[string]interface{}{
		"northamerica-northeast1/subnet01": map[string]interface{}{
			"creation_timestamp": subnetTimeStamp,
			"description":        "This subnet has a description",
			"fingerprint":        nil,
			"gateway_address":    "10.10.20.1",
			"id":                 "projects/" + projectId + "/regions/northamerica-northeast1/subnetworks/utdecnr-subnet01-ut-snet",
			"ip_cidr_range":      "10.10.20.0/24",
			"log_config": []interface{}{
				map[string]interface{}{
					"aggregation_interval": "INTERVAL_5_SEC",
					"filter_expr":          "true",
					"flow_sampling":        0.5,
					"metadata":             "INCLUDE_ALL_METADATA",
					"metadata_fields":      nil,
				},
			},
			"name":                       "utdecnr-subnet01-ut-snet",
			"network":                    "https://www.googleapis.com/compute/v1/projects/" + projectId + "/global/networks/utdecnr-examplevpc-vpc",
			"private_ip_google_access":   true,
			"private_ipv6_google_access": "DISABLE_GOOGLE_ACCESS",
			"project":                    projectId,
			"region":                     "northamerica-northeast1",
			"secondary_ip_range":         []interface{}{},
			"self_link":                  "https://www.googleapis.com/compute/v1/projects/" + projectId + "/regions/northamerica-northeast1/subnetworks/utdecnr-subnet01-ut-snet",
			"timeouts":                   nil,
		},
	}

	assert.Equal(t, subnets, tfSubnets)

	nat := map[string]interface{}{
		"drain_nat_ips":                       nil,
		"enable_endpoint_independent_mapping": true,
		"icmp_idle_timeout_sec":               float64(30),
		"id":                                  projectId + "/northamerica-northeast1/utdecnr-nat-router-router/utdecnr-natgateway01-nat",
		"log_config":                          []interface{}{},
		"min_ports_per_vm":                    float64(64),
		"name":                                "utdecnr-natgateway01-nat",
		"nat_ip_allocate_option":              "AUTO_ONLY",
		"nat_ips":                             nil,
		"project":                             projectId,
		"region":                              "northamerica-northeast1",
		"router":                              "utdecnr-nat-router-router",
		"source_subnetwork_ip_ranges_to_nat":  "ALL_SUBNETWORKS_ALL_IP_RANGES",
		"subnetwork":                          []interface{}{},
		"tcp_established_idle_timeout_sec":    float64(1200),
		"tcp_transitory_idle_timeout_sec":     float64(30),
		"timeouts":                            nil,
		"udp_idle_timeout_sec":                float64(30),
	}

	tfNat := tfoutput.Path("cloud_nat.value").Data()
	assert.Equal(t, nat, tfNat)

	tfNatRouter := tfoutput.Path("nat_router.value").Data()
	natRouterTimeStamp := tfoutput.Path("nat_router.value.creation_timestamp").Data()
	natRouter := map[string]interface{}{
		"bgp": []interface{}{
			map[string]interface{}{
				"advertise_mode":       "DEFAULT",
				"advertised_groups":    nil,
				"advertised_ip_ranges": []interface{}{},
				"asn":                  float64(64514),
			},
		},

		"creation_timestamp": natRouterTimeStamp,
		"description":        "",
		"id":                 "projects/" + projectId + "/regions/northamerica-northeast1/routers/utdecnr-nat-router-router",
		"name":               "utdecnr-nat-router-router",
		"network":            "https://www.googleapis.com/compute/v1/projects/" + projectId + "/global/networks/utdecnr-examplevpc-vpc",
		"project":            projectId,
		"region":             "northamerica-northeast1",
		"self_link":          "https://www.googleapis.com/compute/v1/projects/" + projectId + "/regions/northamerica-northeast1/routers/utdecnr-nat-router-router",
		"timeouts":           nil,
	}

	assert.Equal(t, natRouter, tfNatRouter)
}
