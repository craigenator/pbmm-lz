# Development environment setup
There are a few tools required to manage the GCP Environment. The following
tools are required:

| Tool  | Version  | Description  |
|---|---|---|
| GCP SDK | latest | GCP SDK is used to login to GCP and perform some administrative tasks | 
| Go | OS Default  | Golang is used to run unit and integration tests for terraform modules | 
| jq | OS Default | jq is used to parse JSON content and extract fields | 
| pre-commit | latest | Python module to automate the execution of Git commit hooks | 
| Terraform  |  0.14.4 | Declarative language for infrastructure as code  |
| Terraform Docs |  0.9.1 | Generates terraform documentation from Terraform code  |
| Terragrunt |  0.26.7 | Orchestration tool to manage the deployment of multiple Terraform modules and reduce duplication of state & provider configuration  |
| GitHub CLI |  1.4.0 | Tool to interact with GitHub  |


# Installing Development tools
Run `make install-tools`. The script will run as root and you will need to enter
your password.

# Validating Developer Environment
At the command line, run `make version`. The output should match  the versions
defined above. 