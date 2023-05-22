#!/bin/bash

# Event metadata
instana_entity_type="Host"

if ! [ -x "$(command -v awx)" ]; then
  echo 'Error: AWX CLI (awx) is not installed.' >&2
  exit 1
fi

# Verify Instana event metadata exists
if [ -z "${INSTANA_EVENT}" ]; then
  echo 'Error: Could not find INSTANA_EVENT variable.' >&2
  exit 1
fi

# Verify entity type matches expected type for this automation
entity_name=$(jq -r '.metadata .entityName' <<< "$INSTANA_EVENT")
if [ "${entity_name}" != "${instana_entity_type}" ]; then
  echo 'Error: Entity Name' $entity_name 'does not match expected type' $instana_entity_type >&2
  exit 1
fi

# Determine Instana host from metadata
event_fqdn=$(jq -r '.metadata .fqdn' <<< "$INSTANA_EVENT")
if [[ -z "${event_fqdn}" ]]; then
  echo 'Error: Could not find fqdn in Instana event metadata.' >&2
  exit 1
fi

# Run job on node
echo "Initiating AWX CLI...."
echo "running command: awx job_template launch list-processes-cpu -f human --monitor --limit $event_fqdn"

awx job_template launch list-processes-cpu -f human --monitor \
  --limit $event_fqdn

echo "AWX CLI complete"

