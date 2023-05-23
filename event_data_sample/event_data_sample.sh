#!/bin/bash

# Leverage $INSTANA_EVENT variable to derive host FQDN from event metadata
# Associate action to a Host event 

#### Parameters #### d

# Event metadata
instana_entity_type="Host"

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

# Determine tag value from metadata
entity_data=$(jq -r '.metadata .fqdn' <<< "$INSTANA_EVENT")
if [[ -z "${entity_data}" ]]; then
  echo 'Error: Could not find fqdn in Instana event metadata.' >&2
  exit 1
fi

echo FQDN: $entity_data