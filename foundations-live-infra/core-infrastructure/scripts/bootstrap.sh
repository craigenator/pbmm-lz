set -e
export PLAN_FILE="launchpad.`date +%Y-%m-%d.%H%m`.plan"
export STATE_FILE="launchpad.tfstate"

echo "INFO - Running a plan to ensure the configuration file is correct"
terragrunt plan --terragrunt-working-dir "core-infrastructure/bootstrap"  -state=${STATE_FILE} -out=${PLAN_FILE}

{
  echo "Please confirm that you have reviewed the plan and wish to apply it. Type 'yes' to proceed";
  read ;
  echo "";
  if [ "${REPLY}" != "yes" ] ; then
    echo "INFO - User did not approve plan. Exiting"
    exit 0
  fi
}

# Apply
echo "INFO - Applying Terragrunt plan"
terragrunt apply --terragrunt-working-dir "core-infrastructure/bootstrap" -parallelism=30 -state=${STATE_FILE} ${PLAN_FILE}

COMMON_BUCKET=$(terragrunt output --terragrunt-working-dir "core-infrastructure/bootstrap" -state=${STATE_FILE} -json |jq -r '.tfstate_bucket_names.value.common')
PROJECT_ID=$(terragrunt output --terragrunt-working-dir "core-infrastructure/bootstrap" -state=${STATE_FILE} -json |jq -r '.project_id.value')
CONFIG_BUCKET=$(terragrunt output --terragrunt-working-dir "core-infrastructure/bootstrap" -state=${STATE_FILE} -json |jq -r '.yaml_config_bucket.value')

STATE_TO_UPLOAD=`find core-infrastructure/bootstrap -name ${STATE_FILE}`
STATE_FILE="core-infrastructure/bootstrap/default.tfstate"
if [ "${STATE_TO_UPLOAD}" != "" ]; then
  # Upload file to storage
  # Container - tfstate (hard code and must align to core_infrastructure/bootstrap/terraform.tfvars)
  echo "INFO - Uploading ${STATE_TO_UPLOAD} to ${COMMON_BUCKET}/${STATE_FILE} ${PROJECT_ID}"
  gsutil cp ${STATE_TO_UPLOAD} gs://${COMMON_BUCKET}/${STATE_FILE}
fi

STATE_PREFIX="core-infrastructure/bootstrap"

echo "INFO - Creating bootstrap.hcl"
cat << EOF > config/bootstrap.hcl
remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = "${COMMON_BUCKET}"
    prefix = "${STATE_PREFIX}"
  }
}
EOF

# Upload configs to config bucket
echo "INFO - Uploading yaml configurations to ${CONFIG_BUCKET} in ${PROJECT_ID}"
gsutil cp config/*.yaml  config/*.hcl gs://${CONFIG_BUCKET}
