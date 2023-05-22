#!/bin/bash

# Verify Instana event metadata exists
if [ -z "${INSTANA_EVENT}" ]; then
  # No event data specified
  curl -H 'Content-Type: application/json' -d "{\"message\": \"No event\"}" @@eda_rulebook_server@@/instana
else
  # Action run from event
  curl -H 'Content-Type: application/json' -d "${INSTANA_EVENT}" @@eda_rulebook_server@@/instana
fi


