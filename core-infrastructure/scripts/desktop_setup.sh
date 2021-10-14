#!/bin/bash
# Installs required developer and admin tools to deploy the landing zone.
# Expects the use of Ubuntu / WSL running Ubuntu

set -e

# Edit the following variables as tool versions are updated
TF_VERSION=0.14.10
TG_VERSION=0.29.3
TFDOCS_VERSION=0.9.1

add-apt-repository ppa:longsleep/golang-backports -y

echo "Installing OS Packages"
apt-get -qq update
apt-get -qq install -y jq golang-go git ca-certificates curl apt-transport-https lsb-release gnupg unzip python3 python3-pip

# add install gcloud sdk
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && apt-get install -y google-cloud-sdk

echo "Installing Terraform"
wget -q https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
unzip terraform_${TF_VERSION}_linux_amd64.zip
chmod 755 terraform
sudo mv terraform /usr/local/bin/
rm terraform_${TF_VERSION}_linux_amd64.zip

echo "Installing terraform-docs"
curl -Lo ./terraform-docs https://github.com/terraform-docs/terraform-docs/releases/download/v${TFDOCS_VERSION}/terraform-docs-v${TFDOCS_VERSION}-$(uname | tr '[:upper:]' '[:lower:]')-amd64
chmod +x ./terraform-docs
mv ./terraform-docs /usr/local/bin/terraform-docs

echo "Installing Terragrunt"
wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/terragrunt_linux_amd64
chmod 755 terragrunt_linux_amd64
sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

echo "Installing GH Client"
GH_VERSION=1.4.0
wget -q https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.deb
sudo dpkg -i gh_${GH_VERSION}_linux_amd64.deb && rm gh_${GH_VERSION}_linux_amd64.deb 

echo "Installing pre-commit"
pip3 install pre-commit -q

echo "Desktop configuration complete"
