/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

# Base Superset of Permissions curated from the following roles:
# Compute Network Admin - Create modify and delete networking resources
# Shared VPC Admin - Administer Shared VPC Resources
# Folder Viewer - View Folders
# Compute Admin - Full Control of Compute Resources
# Compute Security Admin - Firewall Rules Administration
# Network Management Admin - Network Management Resources Administration
# DNS Admin - Cloud DNS Management
# Access Context Manager Editor - Create edit and change Access Levels and Access Zones
# Security Center Admin Viewer - Administer Read Access to Security Center
# Logs Viewer - View Logs
# Monitoring Viewer - Read Only Access to get / list information about all monitoring data and configurations
# Viewer - Read only actions on existing resources or data

# NOTE:  IAM Recommender should be used to filter these down in the future
locals {
  network_administrator_roles = {
    network_administrator = {
      title       = "Network Administrators"
      description = "Network Administrators"
      role_id     = "network_administrator"
      permissions = [
        "accesscontextmanager.accessLevels.create",
        "accesscontextmanager.accessLevels.delete",
        "accesscontextmanager.accessLevels.get",
        "accesscontextmanager.accessLevels.list",
        "accesscontextmanager.accessLevels.replaceAll",
        "accesscontextmanager.accessLevels.update",
        "accesscontextmanager.accessPolicies.create",
        "accesscontextmanager.accessPolicies.delete",
        "accesscontextmanager.accessPolicies.get",
        "accesscontextmanager.accessPolicies.getIamPolicy",
        "accesscontextmanager.accessPolicies.list",
        "accesscontextmanager.accessPolicies.update",
        "accesscontextmanager.accessZones.create",
        "accesscontextmanager.accessZones.delete",
        "accesscontextmanager.accessZones.get",
        "accesscontextmanager.accessZones.list",
        "accesscontextmanager.accessZones.update",
        "accesscontextmanager.policies.create",
        "accesscontextmanager.policies.delete",
        "accesscontextmanager.policies.get",
        "accesscontextmanager.policies.getIamPolicy",
        "accesscontextmanager.policies.list",
        "accesscontextmanager.policies.update",
        "accesscontextmanager.servicePerimeters.commit",
        "accesscontextmanager.servicePerimeters.create",
        "accesscontextmanager.servicePerimeters.delete",
        "accesscontextmanager.servicePerimeters.get",
        "accesscontextmanager.servicePerimeters.list",
        "accesscontextmanager.servicePerimeters.replaceAll",
        "accesscontextmanager.servicePerimeters.update",
        "cloudasset.assets.searchAllResources",
        "cloudnotifications.activities.list",
        "cloudsecurityscanner.crawledurls.list",
        "cloudsecurityscanner.results.get",
        "cloudsecurityscanner.results.list",
        "cloudsecurityscanner.scanruns.get",
        "cloudsecurityscanner.scanruns.getSummary",
        "cloudsecurityscanner.scanruns.list",
        "cloudsecurityscanner.scans.get",
        "cloudsecurityscanner.scans.list",
        "compute.acceleratorTypes.get",
        "compute.acceleratorTypes.list",
        "compute.addresses.create",
        "compute.addresses.delete",
        "compute.addresses.get",
        "compute.addresses.list",
        "compute.addresses.use",
        "compute.autoscalers.create",
        "compute.autoscalers.delete",
        "compute.autoscalers.get",
        "compute.autoscalers.list",
        "compute.autoscalers.update",
        "compute.backendBuckets.create",
        "compute.backendBuckets.delete",
        "compute.backendBuckets.get",
        "compute.backendBuckets.list",
        "compute.backendBuckets.update",
        "compute.backendServices.create",
        "compute.backendServices.delete",
        "compute.backendServices.get",
        "compute.backendServices.list",
        "compute.backendServices.setSecurityPolicy",
        "compute.backendServices.update",
        "compute.backendServices.use",
        "compute.commitments.create",
        "compute.commitments.get",
        "compute.commitments.list",
        "compute.commitments.updateReservations",
        "compute.disks.addResourcePolicies",
        "compute.disks.create",
        "compute.disks.createSnapshot",
        "compute.disks.delete",
        "compute.disks.get",
        "compute.disks.getIamPolicy",
        "compute.disks.list",
        "compute.disks.removeResourcePolicies",
        "compute.disks.resize",
        "compute.disks.setIamPolicy",
        "compute.disks.setLabels",
        "compute.disks.update",
        "compute.disks.use",
        "compute.disks.useReadOnly",
        "compute.diskTypes.get",
        "compute.diskTypes.list",
        "compute.externalVpnGateways.create",
        "compute.externalVpnGateways.delete",
        "compute.externalVpnGateways.get",
        "compute.externalVpnGateways.list",
        "compute.externalVpnGateways.setLabels",
        "compute.externalVpnGateways.use",
        "compute.firewallPolicies.addAssociation",
        "compute.firewallPolicies.cloneRules",
        "compute.firewallPolicies.copyRules",
        "compute.firewallPolicies.create",
        "compute.firewallPolicies.delete",
        "compute.firewallPolicies.get",
        "compute.firewallPolicies.getIamPolicy",
        "compute.firewallPolicies.list",
        "compute.firewallPolicies.move",
        "compute.firewallPolicies.removeAssociation",
        "compute.firewallPolicies.setIamPolicy",
        "compute.firewallPolicies.update",
        "compute.firewallPolicies.use",
        "compute.firewalls.create",
        "compute.firewalls.delete",
        "compute.firewalls.get",
        "compute.firewalls.list",
        "compute.firewalls.update",
        "compute.forwardingRules.create",
        "compute.forwardingRules.delete",
        "compute.forwardingRules.get",
        "compute.forwardingRules.list",
        "compute.forwardingRules.pscCreate",
        "compute.forwardingRules.pscDelete",
        "compute.forwardingRules.pscSetLabels",
        "compute.forwardingRules.pscSetTarget",
        "compute.forwardingRules.pscUpdate",
        "compute.forwardingRules.setTarget",
        "compute.forwardingRules.update",
        "compute.globalAddresses.create",
        "compute.globalAddresses.createInternal",
        "compute.globalAddresses.delete",
        "compute.globalAddresses.deleteInternal",
        "compute.globalAddresses.get",
        "compute.globalAddresses.list",
        "compute.globalAddresses.use",
        "compute.globalForwardingRules.create",
        "compute.globalForwardingRules.delete",
        "compute.globalForwardingRules.get",
        "compute.globalForwardingRules.list",
        "compute.globalForwardingRules.pscCreate",
        "compute.globalForwardingRules.pscDelete",
        "compute.globalForwardingRules.pscGet",
        "compute.globalForwardingRules.pscSetLabels",
        "compute.globalForwardingRules.pscSetTarget",
        "compute.globalForwardingRules.pscUpdate",
        "compute.globalForwardingRules.update",
        "compute.globalNetworkEndpointGroups.attachNetworkEndpoints",
        "compute.globalNetworkEndpointGroups.create",
        "compute.globalNetworkEndpointGroups.delete",
        "compute.globalNetworkEndpointGroups.detachNetworkEndpoints",
        "compute.globalNetworkEndpointGroups.get",
        "compute.globalNetworkEndpointGroups.list",
        "compute.globalNetworkEndpointGroups.use",
        "compute.globalOperations.delete",
        "compute.globalOperations.get",
        "compute.globalOperations.list",
        "compute.globalPublicDelegatedPrefixes.create",
        "compute.globalPublicDelegatedPrefixes.delete",
        "compute.globalPublicDelegatedPrefixes.get",
        "compute.globalPublicDelegatedPrefixes.list",
        "compute.globalPublicDelegatedPrefixes.update",
        "compute.globalPublicDelegatedPrefixes.updatePolicy",
        "compute.globalPublicDelegatedPrefixes.use",
        "compute.healthChecks.create",
        "compute.healthChecks.delete",
        "compute.healthChecks.get",
        "compute.healthChecks.list",
        "compute.healthChecks.update",
        "compute.healthChecks.use",
        "compute.healthChecks.useReadOnly",
        "compute.httpHealthChecks.create",
        "compute.httpHealthChecks.delete",
        "compute.httpHealthChecks.get",
        "compute.httpHealthChecks.list",
        "compute.httpHealthChecks.update",
        "compute.httpHealthChecks.useReadOnly",
        "compute.httpsHealthChecks.create",
        "compute.httpsHealthChecks.delete",
        "compute.httpsHealthChecks.get",
        "compute.httpsHealthChecks.list",
        "compute.httpsHealthChecks.update",
        "compute.httpsHealthChecks.useReadOnly",
        "compute.images.create",
        "compute.images.delete",
        "compute.images.deprecate",
        "compute.images.get",
        "compute.images.getFromFamily",
        "compute.images.getIamPolicy",
        "compute.images.list",
        "compute.images.setLabels",
        "compute.images.update",
        "compute.images.useReadOnly",
        "compute.instanceGroupManagers.create",
        "compute.instanceGroupManagers.delete",
        "compute.instanceGroupManagers.get",
        "compute.instanceGroupManagers.list",
        "compute.instanceGroupManagers.update",
        "compute.instanceGroupManagers.use",
        "compute.instanceGroups.create",
        "compute.instanceGroups.delete",
        "compute.instanceGroups.get",
        "compute.instanceGroups.list",
        "compute.instanceGroups.update",
        "compute.instanceGroups.use",
        "compute.instances.addAccessConfig",
        "compute.instances.addResourcePolicies",
        "compute.instances.attachDisk",
        "compute.instances.create",
        "compute.instances.delete",
        "compute.instances.deleteAccessConfig",
        "compute.instances.detachDisk",
        "compute.instances.get",
        "compute.instances.getEffectiveFirewalls",
        "compute.instances.getIamPolicy",
        "compute.instances.getScreenshot",
        "compute.instances.getSerialPortOutput",
        "compute.instances.getShieldedInstanceIdentity",
        "compute.instances.getShieldedVmIdentity",
        "compute.instances.list",
        "compute.instances.listReferrers",
        "compute.instances.osAdminLogin",
        "compute.instances.osLogin",
        "compute.instances.removeResourcePolicies",
        "compute.instances.reset",
        "compute.instances.resume",
        "compute.instances.sendDiagnosticInterrupt",
        "compute.instances.setDiskAutoDelete",
        "compute.instances.setIamPolicy",
        "compute.instances.setLabels",
        "compute.instances.setMachineResources",
        "compute.instances.setMachineType",
        "compute.instances.setMetadata",
        "compute.instances.setMinCpuPlatform",
        "compute.instances.setScheduling",
        "compute.instances.setServiceAccount",
        "compute.instances.setShieldedInstanceIntegrityPolicy",
        "compute.instances.setShieldedVmIntegrityPolicy",
        "compute.instances.setTags",
        "compute.instances.start",
        "compute.instances.startWithEncryptionKey",
        "compute.instances.stop",
        "compute.instances.suspend",
        "compute.instances.update",
        "compute.instances.updateAccessConfig",
        "compute.instances.updateDisplayDevice",
        "compute.instances.updateNetworkInterface",
        "compute.instances.updateSecurity",
        "compute.instances.updateShieldedInstanceConfig",
        "compute.instances.updateShieldedVmConfig",
        "compute.instances.use",
        "compute.instances.useReadOnly",
        "compute.instanceTemplates.create",
        "compute.instanceTemplates.delete",
        "compute.instanceTemplates.get",
        "compute.instanceTemplates.getIamPolicy",
        "compute.instanceTemplates.list",
        "compute.instanceTemplates.setIamPolicy",
        "compute.instanceTemplates.useReadOnly",
        "compute.licenseCodes.getIamPolicy",
        "compute.licenseCodes.setIamPolicy",
        "compute.licenses.get",
        "compute.licenses.getIamPolicy",
        "compute.licenses.setIamPolicy",
        "compute.machineImages.create",
        "compute.machineImages.delete",
        "compute.machineImages.get",
        "compute.machineImages.getIamPolicy",
        "compute.machineImages.list",
        "compute.machineImages.setIamPolicy",
        "compute.machineImages.useReadOnly",
        "compute.machineTypes.get",
        "compute.machineTypes.list",
        "compute.networkEndpointGroups.attachNetworkEndpoints",
        "compute.networkEndpointGroups.create",
        "compute.networkEndpointGroups.delete",
        "compute.networkEndpointGroups.detachNetworkEndpoints",
        "compute.networkEndpointGroups.get",
        "compute.networkEndpointGroups.getIamPolicy",
        "compute.networkEndpointGroups.list",
        "compute.networkEndpointGroups.setIamPolicy",
        "compute.networkEndpointGroups.use",
        "compute.networks.access",
        "compute.networks.create",
        "compute.networks.delete",
        "compute.networks.get",
        "compute.networks.getEffectiveFirewalls",
        "compute.networks.list",
        "compute.networks.listPeeringRoutes",
        "compute.networks.mirror",
        "compute.networks.updatePeering",
        "compute.networks.updatePolicy",
        "compute.networks.use",
        "compute.networks.useExternalIp",
        "compute.nodeGroups.addNodes",
        "compute.nodeGroups.create",
        "compute.nodeGroups.delete",
        "compute.nodeGroups.deleteNodes",
        "compute.nodeGroups.get",
        "compute.nodeGroups.getIamPolicy",
        "compute.nodeGroups.list",
        "compute.nodeGroups.setIamPolicy",
        "compute.nodeGroups.setNodeTemplate",
        "compute.nodeGroups.update",
        "compute.nodeTemplates.create",
        "compute.nodeTemplates.delete",
        "compute.nodeTemplates.get",
        "compute.nodeTemplates.getIamPolicy",
        "compute.nodeTemplates.list",
        "compute.nodeTemplates.setIamPolicy",
        "compute.nodeTypes.get",
        "compute.nodeTypes.list",
        "compute.organizations.disableXpnHost",
        "compute.organizations.disableXpnResource",
        "compute.organizations.enableXpnHost",
        "compute.organizations.enableXpnResource",
        "compute.organizations.listAssociations",
        "compute.organizations.setFirewallPolicy",
        "compute.organizations.setSecurityPolicy",
        "compute.oslogin.updateExternalUser",
        "compute.packetMirrorings.update",
        "compute.projects.get",
        "compute.projects.setCommonInstanceMetadata",
        "compute.projects.setUsageExportBucket",
        "compute.publicAdvertisedPrefixes.create",
        "compute.publicAdvertisedPrefixes.delete",
        "compute.publicAdvertisedPrefixes.get",
        "compute.publicAdvertisedPrefixes.list",
        "compute.publicAdvertisedPrefixes.update",
        "compute.publicAdvertisedPrefixes.updatePolicy",
        "compute.publicAdvertisedPrefixes.use",
        "compute.publicDelegatedPrefixes.create",
        "compute.publicDelegatedPrefixes.delete",
        "compute.publicDelegatedPrefixes.get",
        "compute.publicDelegatedPrefixes.list",
        "compute.publicDelegatedPrefixes.update",
        "compute.publicDelegatedPrefixes.updatePolicy",
        "compute.publicDelegatedPrefixes.use",
        "compute.regionBackendServices.create",
        "compute.regionBackendServices.delete",
        "compute.regionBackendServices.get",
        "compute.regionBackendServices.list",
        "compute.regionBackendServices.setSecurityPolicy",
        "compute.regionBackendServices.update",
        "compute.regionBackendServices.use",
        "compute.regionHealthChecks.create",
        "compute.regionHealthChecks.delete",
        "compute.regionHealthChecks.get",
        "compute.regionHealthChecks.list",
        "compute.regionHealthChecks.update",
        "compute.regionHealthChecks.use",
        "compute.regionHealthChecks.useReadOnly",
        "compute.regionHealthCheckServices.create",
        "compute.regionHealthCheckServices.delete",
        "compute.regionHealthCheckServices.get",
        "compute.regionHealthCheckServices.list",
        "compute.regionHealthCheckServices.update",
        "compute.regionHealthCheckServices.use",
        "compute.regionNetworkEndpointGroups.create",
        "compute.regionNetworkEndpointGroups.delete",
        "compute.regionNetworkEndpointGroups.get",
        "compute.regionNetworkEndpointGroups.list",
        "compute.regionNetworkEndpointGroups.use",
        "compute.regionNotificationEndpoints.create",
        "compute.regionNotificationEndpoints.delete",
        "compute.regionNotificationEndpoints.get",
        "compute.regionNotificationEndpoints.list",
        "compute.regionNotificationEndpoints.update",
        "compute.regionNotificationEndpoints.use",
        "compute.regionOperations.delete",
        "compute.regionOperations.get",
        "compute.regionOperations.list",
        "compute.regions.get",
        "compute.regions.list",
        "compute.regionSslCertificates.create",
        "compute.regionSslCertificates.delete",
        "compute.regionSslCertificates.get",
        "compute.regionSslCertificates.list",
        "compute.regionTargetHttpProxies.create",
        "compute.regionTargetHttpProxies.delete",
        "compute.regionTargetHttpProxies.get",
        "compute.regionTargetHttpProxies.list",
        "compute.regionTargetHttpProxies.setUrlMap",
        "compute.regionTargetHttpProxies.use",
        "compute.regionTargetHttpsProxies.create",
        "compute.regionTargetHttpsProxies.delete",
        "compute.regionTargetHttpsProxies.get",
        "compute.regionTargetHttpsProxies.list",
        "compute.regionTargetHttpsProxies.setSslCertificates",
        "compute.regionTargetHttpsProxies.setUrlMap",
        "compute.regionTargetHttpsProxies.use",
        "compute.regionUrlMaps.create",
        "compute.regionUrlMaps.delete",
        "compute.regionUrlMaps.get",
        "compute.regionUrlMaps.invalidateCache",
        "compute.regionUrlMaps.list",
        "compute.regionUrlMaps.update",
        "compute.regionUrlMaps.use",
        "compute.regionUrlMaps.validate",
        "compute.reservations.create",
        "compute.reservations.delete",
        "compute.reservations.get",
        "compute.reservations.list",
        "compute.reservations.resize",
        "compute.resourcePolicies.create",
        "compute.resourcePolicies.delete",
        "compute.resourcePolicies.get",
        "compute.resourcePolicies.list",
        "compute.resourcePolicies.use",
        "compute.routers.create",
        "compute.routers.delete",
        "compute.routers.get",
        "compute.routers.list",
        "compute.routers.update",
        "compute.routers.use",
        "compute.routes.create",
        "compute.routes.delete",
        "compute.routes.get",
        "compute.routes.list",
        "compute.securityPolicies.addAssociation",
        "compute.securityPolicies.copyRules",
        "compute.securityPolicies.move",
        "compute.securityPolicies.removeAssociation",
        "compute.serviceAttachments.create",
        "compute.serviceAttachments.delete",
        "compute.serviceAttachments.get",
        "compute.serviceAttachments.list",
        "compute.serviceAttachments.update",
        "compute.snapshots.create",
        "compute.snapshots.delete",
        "compute.snapshots.get",
        "compute.snapshots.getIamPolicy",
        "compute.snapshots.list",
        "compute.snapshots.setIamPolicy",
        "compute.snapshots.setLabels",
        "compute.snapshots.useReadOnly",
        "compute.sslCertificates.create",
        "compute.sslCertificates.delete",
        "compute.sslCertificates.get",
        "compute.sslCertificates.list",
        "compute.subnetworks.getIamPolicy",
        "compute.subnetworks.mirror",
        "compute.subnetworks.setIamPolicy",
        "compute.subnetworks.use",
        "compute.subnetworks.useExternalIp",
        "compute.targetGrpcProxies.create",
        "compute.targetGrpcProxies.delete",
        "compute.targetGrpcProxies.get",
        "compute.targetGrpcProxies.list",
        "compute.targetGrpcProxies.update",
        "compute.targetGrpcProxies.use",
        "compute.targetHttpProxies.create",
        "compute.targetHttpProxies.delete",
        "compute.targetHttpProxies.get",
        "compute.targetHttpProxies.list",
        "compute.targetHttpProxies.setUrlMap",
        "compute.targetHttpProxies.use",
        "compute.targetHttpsProxies.create",
        "compute.targetHttpsProxies.delete",
        "compute.targetHttpsProxies.get",
        "compute.targetHttpsProxies.list",
        "compute.targetHttpsProxies.setSslCertificates",
        "compute.targetHttpsProxies.setUrlMap",
        "compute.targetHttpsProxies.use",
        "compute.targetInstances.create",
        "compute.targetInstances.delete",
        "compute.targetInstances.get",
        "compute.targetInstances.list",
        "compute.targetInstances.use",
        "compute.targetPools.addHealthCheck",
        "compute.targetPools.addInstance",
        "compute.targetPools.create",
        "compute.targetPools.delete",
        "compute.targetPools.get",
        "compute.targetPools.list",
        "compute.targetPools.removeHealthCheck",
        "compute.targetPools.removeInstance",
        "compute.targetPools.update",
        "compute.targetPools.use",
        "compute.targetSslProxies.create",
        "compute.targetSslProxies.delete",
        "compute.targetSslProxies.get",
        "compute.targetSslProxies.list",
        "compute.targetSslProxies.setBackendService",
        "compute.targetSslProxies.setProxyHeader",
        "compute.targetSslProxies.setSslCertificates",
        "compute.targetSslProxies.use",
        "compute.targetTcpProxies.create",
        "compute.targetTcpProxies.delete",
        "compute.targetTcpProxies.get",
        "compute.targetTcpProxies.list",
        "compute.targetTcpProxies.update",
        "compute.targetTcpProxies.use",
        "compute.targetVpnGateways.create",
        "compute.targetVpnGateways.delete",
        "compute.targetVpnGateways.get",
        "compute.targetVpnGateways.list",
        "compute.targetVpnGateways.use",
        "compute.vpnGateways.create",
        "compute.vpnGateways.delete",
        "compute.vpnGateways.get",
        "compute.vpnGateways.list",
        "compute.vpnGateways.setLabels",
        "compute.vpnGateways.use",
        "compute.vpnTunnels.create",
        "compute.vpnTunnels.delete",
        "compute.vpnTunnels.get",
        "compute.vpnTunnels.list",
        "compute.zoneOperations.delete",
        "compute.zoneOperations.get",
        "compute.zoneOperations.list",
        "compute.zones.get",
        "compute.zones.list",
        "dns.changes.create",
        "dns.changes.get",
        "dns.changes.list",
        "dns.dnsKeys.get",
        "dns.dnsKeys.list",
        "dns.managedZoneOperations.get",
        "dns.managedZoneOperations.list",
        "dns.managedZones.create",
        "dns.managedZones.delete",
        "dns.managedZones.get",
        "dns.managedZones.list",
        "dns.managedZones.update",
        "dns.networks.bindDNSResponsePolicy",
        "dns.networks.bindPrivateDNSPolicy",
        "dns.networks.bindPrivateDNSZone",
        "dns.networks.targetWithPeeringZone",
        "dns.policies.create",
        "dns.policies.delete",
        "dns.policies.get",
        "dns.policies.list",
        "dns.policies.update",
        "dns.projects.get",
        "dns.resourceRecordSets.create",
        "dns.resourceRecordSets.delete",
        "dns.resourceRecordSets.get",
        "dns.resourceRecordSets.list",
        "dns.resourceRecordSets.update",
        "dns.responsePolicies.create",
        "dns.responsePolicies.delete",
        "dns.responsePolicies.get",
        "dns.responsePolicies.list",
        "dns.responsePolicies.update",
        "dns.responsePolicyRules.create",
        "dns.responsePolicyRules.delete",
        "dns.responsePolicyRules.get",
        "dns.responsePolicyRules.list",
        "dns.responsePolicyRules.update",
        "logging.buckets.get",
        "logging.buckets.list",
        "logging.exclusions.get",
        "logging.exclusions.list",
        "logging.locations.get",
        "logging.locations.list",
        "logging.logEntries.list",
        "logging.logMetrics.get",
        "logging.logMetrics.list",
        "logging.logs.list",
        "logging.logServiceIndexes.list",
        "logging.logServices.list",
        "logging.queries.create",
        "logging.queries.delete",
        "logging.queries.get",
        "logging.queries.list",
        "logging.queries.listShared",
        "logging.queries.update",
        "logging.sinks.get",
        "logging.sinks.list",
        "logging.usage.get",
        "logging.views.get",
        "logging.views.list",
        "monitoring.dashboards.get",
        "monitoring.dashboards.list",
        "monitoring.groups.get",
        "monitoring.groups.list",
        "monitoring.metricDescriptors.get",
        "monitoring.metricDescriptors.list",
        "monitoring.monitoredResourceDescriptors.get",
        "monitoring.monitoredResourceDescriptors.list",
        "monitoring.publicWidgets.get",
        "monitoring.publicWidgets.list",
        "monitoring.services.get",
        "monitoring.services.list",
        "monitoring.slos.get",
        "monitoring.slos.list",
        "monitoring.timeSeries.list",
        "monitoring.uptimeCheckConfigs.get",
        "monitoring.uptimeCheckConfigs.list",
        "networkmanagement.connectivitytests.create",
        "networkmanagement.connectivitytests.delete",
        "networkmanagement.connectivitytests.get",
        "networkmanagement.connectivitytests.getIamPolicy",
        "networkmanagement.connectivitytests.list",
        "networkmanagement.connectivitytests.rerun",
        "networkmanagement.connectivitytests.setIamPolicy",
        "networkmanagement.connectivitytests.update",
        "networkmanagement.locations.get",
        "networkmanagement.locations.list",
        "networkmanagement.operations.get",
        "networkmanagement.operations.list",
        "networksecurity.authorizationPolicies.create",
        "networksecurity.authorizationPolicies.delete",
        "networksecurity.authorizationPolicies.get",
        "networksecurity.authorizationPolicies.getIamPolicy",
        "networksecurity.authorizationPolicies.list",
        "networksecurity.authorizationPolicies.setIamPolicy",
        "networksecurity.authorizationPolicies.update",
        "networksecurity.authorizationPolicies.use",
        "networksecurity.clientTlsPolicies.create",
        "networksecurity.clientTlsPolicies.delete",
        "networksecurity.clientTlsPolicies.get",
        "networksecurity.clientTlsPolicies.getIamPolicy",
        "networksecurity.clientTlsPolicies.list",
        "networksecurity.clientTlsPolicies.setIamPolicy",
        "networksecurity.clientTlsPolicies.update",
        "networksecurity.clientTlsPolicies.use",
        "networksecurity.locations.get",
        "networksecurity.locations.list",
        "networksecurity.operations.cancel",
        "networksecurity.operations.delete",
        "networksecurity.operations.get",
        "networksecurity.operations.list",
        "networksecurity.serverTlsPolicies.create",
        "networksecurity.serverTlsPolicies.delete",
        "networksecurity.serverTlsPolicies.get",
        "networksecurity.serverTlsPolicies.getIamPolicy",
        "networksecurity.serverTlsPolicies.list",
        "networksecurity.serverTlsPolicies.setIamPolicy",
        "networksecurity.serverTlsPolicies.update",
        "networksecurity.serverTlsPolicies.use",
        "networkservices.endpointConfigSelectors.create",
        "networkservices.endpointConfigSelectors.delete",
        "networkservices.endpointConfigSelectors.get",
        "networkservices.endpointConfigSelectors.getIamPolicy",
        "networkservices.endpointConfigSelectors.list",
        "networkservices.endpointConfigSelectors.setIamPolicy",
        "networkservices.endpointConfigSelectors.update",
        "networkservices.endpointConfigSelectors.use",
        "networkservices.httpFilters.create",
        "networkservices.httpFilters.delete",
        "networkservices.httpFilters.get",
        "networkservices.httpFilters.getIamPolicy",
        "networkservices.httpFilters.list",
        "networkservices.httpFilters.setIamPolicy",
        "networkservices.httpFilters.update",
        "networkservices.httpFilters.use",
        "networkservices.locations.get",
        "networkservices.locations.list",
        "networkservices.operations.cancel",
        "networkservices.operations.delete",
        "networkservices.operations.get",
        "networkservices.operations.list",
        "opsconfigmonitoring.resourceMetadata.list",
        "orgpolicy.policy.get",
        "resourcemanager.folders.get",
        "resourcemanager.folders.list",
        "resourcemanager.organizations.get",
        "resourcemanager.projects.get",
        "resourcemanager.projects.getIamPolicy",
        "resourcemanager.projects.list",
        "securitycenter.assets.group",
        "securitycenter.assets.list",
        "securitycenter.assets.listAssetPropertyNames",
        "securitycenter.containerthreatdetectionsettings.calculate",
        "securitycenter.containerthreatdetectionsettings.get",
        "securitycenter.eventthreatdetectionsettings.calculate",
        "securitycenter.eventthreatdetectionsettings.get",
        "securitycenter.findings.group",
        "securitycenter.findings.list",
        "securitycenter.findings.listFindingPropertyNames",
        "securitycenter.notificationconfig.get",
        "securitycenter.notificationconfig.list",
        "securitycenter.organizationsettings.get",
        "securitycenter.securitycentersettings.get",
        "securitycenter.securityhealthanalyticssettings.calculate",
        "securitycenter.securityhealthanalyticssettings.get",
        "securitycenter.sources.get",
        "securitycenter.sources.list",
        "securitycenter.subscription.get",
        "securitycenter.userinterfacemetadata.get",
        "securitycenter.websecurityscannersettings.calculate",
        "securitycenter.websecurityscannersettings.get",
        "servicenetworking.operations.get",
        "servicenetworking.services.addPeering",
        "servicenetworking.services.get",
        "serviceusage.services.get",
        "serviceusage.services.list",
        "trafficdirector.networks.getConfigs",
        "trafficdirector.networks.reportMetrics",
      ]
    }
  }
}