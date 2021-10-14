# Bootstrap Procedure

## Overview
A script has been created that automates most of the configuration steps. The
high level steps are:
1. Create the required configuration files in the `config` directory
1. Run the [scripts\bootstrap.sh](./../scripts/bootstrap.sh)
    - Creates an initial project that contains
    - Creates the Service Account (SA) that will be used going forward to deploy
      resources via Github Actions pipeline
    - Assigns required permissions to the SA
    - Creates Environment buckets to store Terraform state files
    - Create a `bootstrap.hcl` file in the [config](./../config) directory that
      defines options for Terragrunt going forward.
1. Add the `bootstrap.hcl` file to the Git config sub-module so that it can be
   referenced while using the automated deployments.
1. Collect and store the SA JSON key file securely where it can be access by the
   pipeline to deploy resources on GCP.

## Requirements
- Deploying user must have:
    - Organization Admin
    - Permissions to set IAM on the billing account
- Terraform >= 14.10
- Terraform GCP provider >= 3.56
- Terragrunt >= 0.29.3
- GCP SDK >= 344.00
- Git client

An install script has been created that will install the above tools on Ubuntu
proper or Microsoft WSL Ubuntu. It can be executed from the main repository
using `sudo make install-tools`

## Forking Repositories
It is recommended to use the Git tool to fork the required repositories below to
a location where the department can control the updates. Forking will make it
easier to adopt enhancements and bugfixes done upstream but also keep control of
module versions and when they are adopted, allowing for integration testing
before being rolled out in the environment.


Enter the directory where the repositories will be stored locally.

Update and run the code below
```bash
export BASEDIR=/your/code/folder
```
Clone `foundations-live-infra`
```bash
cd ${BASEDIR}
git clone ../foundations-live-infra
cd foundations-live-infra
```
Create a new repository to hold the code on Github.

Either add a second upstream or remove the current origin and point to a new repository

```bash
cd ${BASEDIR}/foundations-live-infra
git remote add personal ../foundations-live-infra
git push -u personal main
```
**OR**
```bash
cd ${BASEDIR}/foundations-live-infra
git remote rm origin
git remote add origin ../foundations-live-infra
git push -u origin main
```
Repeat for `..core-infrastructure`
```bash
cd ${BASEDIR}
git clone ../..core-infrastructure
cd ..core-infrastructure
```
Create a new repository to hold the code on Github.

Either add a second upstream or remove the current origin and point to a new repository
```bash
cd ${BASEDIR}/..core-infrastructure
git remote add personal ../core-infrastructure
git push -u personal main
```
**OR**
```bash
cd ${BASEDIR}/..core-infrastructure
git remote rm origin
git remote add origin ../core-infrastructure
git push -u origin main
```


## Re-point the core-infrastructure submodule
After forking the `core-foundations` git sub-module of the
`foundations-live-infra` will need to be pointed to the newly forked
`..core-infrastructure` repository.

Inside the `..foudations-live-infra` repository edit the `modules` and
point the url of the `[core-foundations]` section to point to the repository you
created for this purpose above

```bash
[submodule "documentation"]
	path = documentation
[submodule "core-infrastructure"]
	path = core-infrastructure
	url = <CHANGE ME>
	branch = main
```

Pull the submodules locally. From the root of your clone of `foundations-live-infra`:
```bash
cd ${BASEDIR}/foundations-live-infra
make modupdate
```

Any enhancements made that could benefit everyone should be contributed to the
original repository by Pull Request (PR).

## Creating organization-config.yaml
The `config` folder in the main repository holds the environment specific
configuration details and should be considered sensitive. The contents would
give a would-be attacker a place to start a targeted attack. For this reason the
config folder is handled outside the main repository.

Clone the sample repository and copy the files to the proper location in the
`foundations-live-infra` repository.

```bash
cd ${BASEDIR}
git clone ../foundations-live-configs
mkdir foundations-live-infra/config/
cp foundations-live-configs/* foundations-live-infra/config
```

Edit the files in the `config` folder to suite the destination environment,
taking note of what needs to be unique on a global or organization level.

### Log in with to GCP
Log in to GCP with an account that has the access stated in the requirements above.

```bash
gcloud auth login
gcloud auth applicaiton-default-login
```

If using a service account:
```bash
gcloud auth activate-service-account --key-file <key-file.json>
export GOOGLE_APPLICATION_CREDENTIALS=/full/path/file.json
```

Useful commands for filling out the values are:
```bash
gcloud organizations list
gcloud alpha billing accounts list
gcloud access-context-manager policies list --organization <org-id>
gcloud resource-manager folders list --organization <org-id>
```

Repeat for all yaml files in this directory.

## Running the Bootstrap Script
Run the bootstrap process. Form this point on all commands are run from your
clone of the `foundations-live-infra` repository directory.

```bash
cd ${BASEDIR}/foundations-live-infra
make bootstrap
```

The bootstrap process will:
1. Create the bootstrap project
1. Create a GCP Service Account that will be used by the automation pipeline
1. Assign required permissions to the SA
1. Create the buckets specified in the configuration file for state and configuration
1. Assign the writer role user/group specified to the buckets so the Terraform
   state file can be uploaded
1. Create the Terragrunt configuration file at `config/bootstrap.hcl`
    - This file specifies the backend to be in the common bucket
1. Upload the files in the `config` folder to the the config bucket.

**From this point on the `config/bootstrap.hcl` must exist at that location or
it will try and fail to deploy resources every time Terraform is run because the
state will only be local.**

**All future updates to the bootstrap project need to be done via code and
applied via the Github Actions workflow.**

The output of the `make bootstrap` command will contain a variable called
`yaml_config_bucket`. Save this value for later

Verify the bootstrap environment:
```bash
cd ${BASEDIR}/foundations-live-infra
export CONFIG_BUCKET=<bucket name>
make apply-bootstrap
```

## Collect and add Service Account JSON to the Automation Environment
Follow the GCP documentation to create a Service Account JSON key for the
account created with the name in the `organization-config.yaml` file and
download it to a secure location.

```bash
gcloud iam service-accounts keys create key-file \
    --iam-account=sa-name@project-id.iam.gserviceaccount.com
```

## Github Actions
If using Github Actions:
1. Create a new Secret on the forked main repository
    - name it `GOOGLE_APPLICATION_CREDENTIALS`
    - Copy the contents of the SA JSON key and paste it in the value field
1. Create an RSA key pair with `keygen -t rsa -b 4096 -C. This key is used to
   access dependent modules. "your_email@example.com"`
    - Create a new secret called `SSH_KEY`
    - Copy the contents of the private key to the value field
    - Configure an Github account that is to be used as a Service Account with
      the public key
    - If unable to create a Service Account, add the public key to your own
      account but beware if your account is disabled the pipeline will stop
      working. **DO AT OWN RISK**
1. Create a secret called `YAML_CONFIG_BUCKET` with the value saved above.

## Push Code to Repository
Push the code for your clone of `foundations-live-infra` upstream to a
branch and create a PR. After the push upstream the Github Workflows will be
detected and will run PR and merge to main.
