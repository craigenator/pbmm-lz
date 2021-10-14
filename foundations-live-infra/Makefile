.ONESHELL:

SHELL=/bin/bash

clean:
	@find . -name .terragrunt-cache -type d -exec rm -rf {} +
	@find . -name .terraform -type d -exec rm -rf {} +

push-config:
	@if (test -z ${CONFIG_BUCKET}); then
		echo "Environment variable CONFIG_BUCKET not defined"
		exit 2
	fi
	@echo "Pushing Configs to config bucket ${CONFIG_BUCKET}"
	gsutil -m cp config/* gs://${CONFIG_BUCKET}

pull-config:
	@if (test -z ${CONFIG_BUCKET}); then
		echo "Environment variable CONFIG_BUCKET not defined"
		exit 2
	fi
	[[ -d config ]] || mkdir config
	@echo "Pulling Configs from config bucket ${CONFIG_BUCKET}"
	gsutil -m cp gs://${CONFIG_BUCKET}/* config/

plan-bootstrap: pull-config
	@echo "Planning Core for bootstrap";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/bootstrap" \
	  --terragrunt-non-interactive

plan-common: pull-config
	@echo "Planning Core for common";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common" \
	  --terragrunt-non-interactive

plan-folders: pull-config
	@echo "Planning Core for common";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common/core-folders" \
	  --terragrunt-non-interactive

plan-core-guardrails: pull-config
	@echo "Planning Core for core-guardrails";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common/core-guardrails" \
	  --terragrunt-non-interactive

plan-custom-roles: pull-config

	@echo "Planning Core for custom roles";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common/core-org-custom-roles" \
	  --terragrunt-non-interactive

plan-core-iam: pull-config
	@echo "Planning Core for iam";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common/core-iam" \
	  --terragrunt-non-interactive

plan-AuditBunker: pull-config

	@echo "Planning Core for AuditBunker";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common/core-audit-bunker" \
	  --terragrunt-non-interactive

plan-nonp-all: pull-config
	echo "Planning Landing Zones for nonp";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/nonp" \
	  --terragrunt-non-interactive

plan-nonp-network: pull-config
	echo "Planning Landing Zones for nonp";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/nonp/net-host-prj" \
	  --terragrunt-non-interactive

plan-prod-all: pull-config
	echo "Planning Landing Zones for nonp";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod" \
	  --terragrunt-non-interactive

plan-prod-network: pull-config
	echo "Planning Landing Zones for prod";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/net-host-prj" \
	  --terragrunt-non-interactive

plan-prod-perimeter-network: pull-config
	echo "Planning Landing Zones for prod perimeter network";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/net-perimeter/" \
	  --terragrunt-non-interactive

plan-nonp-dnszone-forward: pull-config
	echo "Planning Landing Zones for nonp dnszone forward";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/nonp/dnszone-forward/" \
	  --terragrunt-non-interactive
	  
plan-nonp-dnszone-peer: pull-config
	echo "Planning Landing Zones for nonp dnszone peer";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/nonp/dnszone-peer/" \
	  --terragrunt-non-interactive

plan-nonp-dnszone-private: pull-config
	echo "Planning Landing Zones for nonp dnszone private";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/nonp/dnszone-private/" \
	  --terragrunt-non-interactive

plan-nonp-vpc-firewall: pull-config
	echo "Planning Landing Zones for nonp vpc-firewall";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/nonp/net-firewall/" \
	  --terragrunt-non-interactive  

plan-prod-dnszone-forward: pull-config
	echo "Planning Landing Zones for prod dnszone forward";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/dnszone-forward/" \
	  --terragrunt-non-interactive

plan-prod-dnszone-peer: pull-config
	echo "Planning Landing Zones for prod dnszone peer";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/dnszone-peer/" \
	  --terragrunt-non-interactive

plan-prod-dnszone-private: pull-config
	echo "Planning Landing Zones for prod dnszone private";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/dnszone-private/" \
	  --terragrunt-non-interactive

plan-prod-vpc-firewall: pull-config
	echo "Planning Landing Zones for prod vpc-firewall";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/net-firewall/" \
	  --terragrunt-non-interactive	  

plan-core-org-policy: pull-config
	echo "Planning Landing Zones for core-org-policy";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common/core-org-policy" \
	  --terragrunt-non-interactive

plan-access-context-manager: pull-config
	echo "Planning Landing Zones for access-context-manager";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/common/access-context-manager" \
	  --terragrunt-non-interactive

plan-nonp-vpc-svc-ctl: pull-config
	echo "Planning Landing Zones for nonp-vpc-svc-ctl";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/nonp/vpc-svc-ctl" \
	  --terragrunt-non-interactive

plan-prod-vpc-svc-ctl: pull-config
	echo "Planning Landing Zones for prod-vpc-svc-ctl";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/vpc-svc-ctl" \
	  --terragrunt-non-interactive

plan-prod-net-fortigate-firewall: pull-config
	echo "Planning Landing Zones for prod-net-fortigate-firewall";
	terragrunt run-all plan \
	  --terragrunt-working-dir "core-infrastructure/prod/net-fortigate-firewall" \
	  --terragrunt-non-interactive

apply-bootstrap: pull-config
	@echo "Applying Core for bootstrap";
	terragrunt run-all apply \
	  --terragrunt-working-dir core-infrastructure/bootstrap \
	  --terragrunt-non-interactive

apply-common: pull-config
	@echo "Applying Core for common";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common" \
	  --terragrunt-non-interactive

apply-folders: pull-config
	@echo "Applying Core for common";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common/core-folders" \
	  --terragrunt-non-interactive

apply-core-guardrails: pull-config
	@echo "Applying Core for core-guardrails";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common/core-guardrails" \
	  --terragrunt-non-interactive

apply-AuditBunker: pull-config
	@echo "Applying Core for AuditBunker";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common/core-audit-bunker" \
	  --terragrunt-non-interactive

apply-custom-roles: pull-config
	@echo "Applying Core for custom roles";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common/core-org-custom-roles" \
	  --terragrunt-non-interactive

apply-core-iam: pull-config
	@echo "Applying Core for custom roles";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common/core-iam" \
	  --terragrunt-non-interactive

apply-nonp-all: pull-config
	echo "Applying Landing Zones for nonp";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/nonp" \
	  --terragrunt-non-interactive

apply-nonp-network: pull-config
	@echo "Applying Landing Zones for nonp";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/nonp/net-host-prj" \
	  --terragrunt-non-interactive

apply-prod-all: pull-config
	echo "Applying Landing Zones for nonp";
	terragrunt run-all \
	  --terragrunt-working-dir "core-infrastructure/prod" \
	  --terragrunt-non-interactive

apply-prod-network: pull-config
	@echo "Applying Landing Zones for prod";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/prod/net-host-prj" \
	  --terragrunt-non-interactive

apply-prod-perimeter-network: pull-config
	@echo "Applying Landing Zones for prod perimeter network";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/prod/net-perimeter/" \
 	  --terragrunt-non-interactive

apply-nonp-dnszone-forward: pull-config
	@echo "Applying Landing Zones for nonp dnszone forward";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/nonp/dnszone-forward/" \
 	  --terragrunt-non-interactive

apply-nonp-dnszone-peer: pull-config
	@echo "Applying Landing Zones for nonp dnszone peer";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/nonp/dnszone-peer/" \
 	  --terragrunt-non-interactive

apply-nonp-dnszone-private: pull-config
	@echo "Applying Landing Zones for nonp dnszone private";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/nonp/dnszone-private/" \
 	  --terragrunt-non-interactive

apply-nonp-vpc-firewall: pull-config
	@echo "Applying Landing Zones for nonp vpc-firewall";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/nonp/net-firewall/" \
 	  --terragrunt-non-interactive

apply-prod-dnszone-forward: pull-config
	@echo "Applying Landing Zones for prod dnszone forward";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/prod/dnszone-forward/" \
 	  --terragrunt-non-interactive

apply-prod-dnszone-peer: pull-config
	@echo "Applying Landing Zones for prod dnszone peer";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/prod/dnszone-peer/" \
 	  --terragrunt-non-interactive

apply-prod-dnszone-private: pull-config
	@echo "Applying Landing Zones for prod dnszone private";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/prod/dnszone-private/" \
 	  --terragrunt-non-interactive

apply-prod-vpc-firewall: pull-config
	@echo "Applying Landing Zones for prod vpc-firewall";
	terragrunt run-all apply \
 	  --terragrunt-working-dir "core-infrastructure/prod/net-firewall/" \
 	  --terragrunt-non-interactive

apply-core-org-policy: pull-config
	@echo "Applying Landing Zones for core-org-policy";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common/core-org-policy" \
	  --terragrunt-non-interactive

apply-access-context-manager: pull-config
	@echo "Applying Landing Zones for access-context-manager";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/common/access-context-manager" \
	  --terragrunt-non-interactive

apply-nonp-vpc-svc-ctl: pull-config
	@echo "Applying Landing Zones for nonp-vpc-svc-ctl";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/nonp/vpc-svc-ctl" \
	  --terragrunt-non-interactive

apply-prod-vpc-svc-ctl: pull-config
	@echo "Applying Landing Zones for prod-vpc-svc-ctl";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/prod/vpc-svc-ctl" \
	  --terragrunt-non-interactive

apply-prod-net-fortigate-firewall: pull-config
	@echo "Applying Landing Zones for prod-net-fortigate-firewall";
	terragrunt run-all apply \
	  --terragrunt-working-dir "core-infrastructure/prod/net-fortigate-firewall" \
	  --terragrunt-non-interactive

destroy-bootstrap: pull-config
	@echo "Destroying Core for bootstrap";
	terragrunt run-all destroy \
	  --terragrunt-working-dir "core-infrastructure/bootstrap" \
	  --terragrunt-non-interactive
	echo "Remove config/bootstrap.hcl after a success run. It is now invalid."

destroy-common: pull-config
	@echo "Destroying Core for common";
	terragrunt run-all destroy \
	  --terragrunt-working-dir "core-infrastructure/common" \
	  --terragrunt-non-interactive \
	  --terragrunt-exclude-dir ../bootstrap

destroy-nonp-all: pull-config
	echo "Destroying Landing Zones for nonp";
	terragrunt run-all destroy \
	  --terragrunt-working-dir ./core-infrastructure/nonp \
	  --terragrunt-non-interactive \
	  --terragrunt-exclude-dir ../common/* \
	  --terragrunt-exclude-dir ../bootstrap

destroy-prod-all: pull-config
	echo "Destroying Landing Zones for nonp";
	terragrunt destroy --terragrunt-working-dir "core-infrastructure/prod" --terragrunt-non-interactive --terragrunt-ignore-external-dependencies

install-tools:
	@sudo bash core-infrastructure/scripts/desktop_setup.sh

modupdate:
	bash modupdate.sh

reset-core:
	@cd core-infrastructure
	git reset --hard

version:
	@go version
	echo ""
	@terragrunt --version
	echo ""
	terraform version
	echo ""
	az version

fmt:
	@terragrunt hclfmt
	@terraform fmt -recursive

bootstrap:
	bash core-infrastructure/scripts/bootstrap.sh
