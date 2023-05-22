#!/bin/bash

# Script launches an AWX or Ansible Automation Controller job template using the AWX CLI
# AWX CLI must be installed and configured on the target system

#### Parameters ####
# AWX job template name
template_name=@@awx_template_name@@
# Host limit - optionally derive from dynamic variable or $INSTANA_EVENT
host=@@host_limit@@

# AWX CLI authentication
export TOWER_HOST=@@awx_server@@
export TOWER_VERIFY_SSL=false
export TOWER_TOKEN=@@awx_token@@

# Run job on node
echo "Initiating AWX CLI...."
echo "running command: awx job_template launch $template_name -f human --monitor --limit $host"

awx job_template launch $template_name -f human --monitor --limit $host

echo "AWX CLI complete"
