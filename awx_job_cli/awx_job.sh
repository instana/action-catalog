#!/bin/bash

# Script launches an AWX or Ansible Automation Controller job template using the AWX CLI
# AWX CLI must be installed and configured on the target system
# Requires paramters: 
# - template_name: Name of AWX job template to launch
# - host_limit: FQDN or hostname of host limit (consider a dynamic parameter)
# - test_value: Parameter value for a playbook extra named "test"

# AWX CLI authentication (if needed)
export TOWER_HOST=@@awx_server@@
export TOWER_VERIFY_SSL=false
export TOWER_TOKEN=@@awx_token@@

# Extra vars (if needed)
extra_vars=$(cat <<EOF
{
  "test": "$test_value"
}
EOF
)

# Run job on node
echo "Initiating AWX CLI...."
echo "running command: awx job_template launch $template_name -f human --monitor --limit $host_limit --extra_vars '$extra_vars'"

awx job_template launch $template_name -f human --monitor --limit $host_limit --extra_vars "$extra_vars"

echo "AWX CLI complete"