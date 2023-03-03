#!/bin/bash

# Script launches a Rundeck job via the CLI.
# Leverage $INSTANA_EVENT variable to derive host FQDN from event metadata


#### Parameters ####

# Event metadata
instana_entity_type="Host"

# Verify rundeck CLI is installed on local system
if ! [ -x "$(command -v rd)" ]; then
  echo 'Error: Rundeck CLI (rd) is not installed.' >&2
  exit 1
fi

# Verify Instana event metadata variable exists
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
echo "Initiating Rundeck CLI...."
echo "running command: rd run -p=\"$rundeck_project\" -j=\"$rundeck_jobname\" -F=$event_fqdn -f"
rd run -p="$project" -j="$jobname" -F=$event_fqdn -f

echo "Rundeck CLI complete"