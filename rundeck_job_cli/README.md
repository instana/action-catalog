# rundeck_cli_job.sh

Purpose: Launch a Rundeck (or PagerDuty Process Automation) job via the Rundeck CLI.

Script also leverages `$INSTANA_EVENT` variable to derive the host FQDN from event metadata.


## Details

**Type**: Script (bash)

**Parameters**:
 - rundeck_project
 - rundeck_jobname

**Tags**: 
- Rundeck
- PagerDuty
- Sample

**Prereqs**
 - Target system (agent) is configured with Rundeck CLI
 - Target system (agent) is authenticated to Rundeck CLI via rd.conf or other mechanism
 - Target system (agent) is configured with jq