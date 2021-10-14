# Repository Update Procedure

## Terraform Modules
Terraform modules are all referenced in the `terragrunt.hcl` files of the
`core-infrastructure` sub-module. To use a new version of one of the Terraform
modules, both the procedure below and the sub-module update procedure must be
performed.

To update the version Terraform module that is being referenced in once of the
`terragrunt.hcl` files:
1. Clone the Terraform module locally and make the changes there
1. Create a Pull Request (PR)
1. The module will gone through the appropriate workflow and meet the criteria
   for the Pull Request to be merged merged with the main branch.
1. Tag the version with `git tag` using semantic versioning
1. Update the main repository `terragrunt.hcl` in the appropriate location to
   point to the new tag, example below
    ```
    source = "git@github.com:GovAlta/terraform-folders.git"
    ```
1. Clone or update the local version of the `core-infrastructure` sub-module
   with `git clone` or `git pull`
1. Follow the sub-module update procedure below

## Sub-Modules
To update a sub-module:
1. Clone the sub-module locally and make the changes there
1. Create a Pull Request (PR)
1. The module will gone through the appropriate workflow and meet the criteria
   for the Pull Request to be merged merged with the main branch.
1. Tag the version with `git tag` using semantic versioning
1. Update the main repository `.gitmodules` to point to the new tag using the
   example below
    ```
    url = git@github.com:GovAlta/gcp-core-infrastructure.git
    ```
1. Clone or update the local version or the main respository with `git clone` or
   `git pull`
1. Create a branch of the main repository with `git checkout -b branch-name`
1. run `bash modupdate.sh` to pull the new version of the submodules
1. Add the changes to the current branch with `git add .; git commit -m'your
   message here'; git push -u origin branch-name`
1. Create a PR on the new branch to merge it in to main
1. The module will gone through the appropriate workflow and meet the criteria
   for the Pull Request to be merged merged with the main branch, and once
   merged it will be applied to the environment