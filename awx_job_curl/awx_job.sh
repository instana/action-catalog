#bin/bash

# Script launches an AWX or Ansible Automation Controller job template using curl

#### Parameters ####
# AWX server URL
awx_server=@@awx_server@@
# AWX credentials - recommend access from Vault
awx_token=@@awx_token@@
# AWX job template ID
template_id=@@awx_template_id@@
# AWX inventory ID
inventory=@@awx_inventory_id@@
# Host limit - optionally derive from dynamic variable or $INSTANA_EVENT
host="localhost"
# Extra vars - replace with relevant extra_vars for your playbook
test_var=$test_var

#### Launch AWX job template #####
curl -k -v --location POST https://$awx_server/api/v2/job_templates/$template_id/launch/ \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $awx_token" \
--data-raw '{
    "extra_vars":{
        "test": "'$test_var'"
    },
    "inventory": "'$inventory'",
    "limit": "'$host'"
}'
