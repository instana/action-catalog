# awx_job_curl.sh

Purpose: Launch an AWX job template via the AWX CLI. Script also demonstrates how parameter substitution can be used.

## Details

**Type**: Script (bash)

**Parameters**:
 - awx_server: Ansible Automation Controller URL
 - awx_token: Ansible Automation Controller authentication token
 - template_name: Ansible job template name
 - host_limit: Host to limit execution against on the Ansible inventory
 - test_value: Parameter value for a playbook extra var named `test`

**Tags**: 
- AWX
- Ansible
- Sample

**Prereqs**
 - Target system (agent) is configured with the AWX CLI