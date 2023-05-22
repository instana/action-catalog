#!/bin/bash

# Script launches an AWX or Ansible Automation Controller job template using the AWX CLI
# AWX CLI must be installed and configured on the target system

# Parameters

#Ansible automation controller job template name
template_name=scale-kubernetes-deployment
#Kubernetes Deployment name to scale TODO Dynamic?
deployment_name=@@kubernetes_deployment_name@@
#Kubernetes namespace TODO Dynamic
namespace=@@namespace@@
#Kubernetes api server TODO Dynamic
host_api_server=@@kubernetes_api_url@@
#Kubernetes user name
k8_user=@@kubernetes_user_id@@
#Kubernetes password from VAULT
k8_password=@@k8_password@@
#Kubernetes number to scale Deployment, 
replicas=@@replica_count@@

# AWX CLI authentication
export TOWER_HOST=@@ansible_server_url@@
export TOWER_TOKEN=@@ansible_token@@
export TOWER_VERIFY_SSL=false

# Run job on node
echo "Initiating AWX CLI...."

extra_vars=$(cat <<EOF
{
  "host_api_server": "$host_api_server",
  "username": "$k8_user",
  "password": "$k8_password",
  "namespace": "$namespace",
  "deployment_name": "$deployment_name",
  "replicas": "$replicas"
}
EOF
)

echo "running command: awx job_template launch $template_name -f human --monitor --extra_vars '$extra_vars'"
awx job_template launch $template_name -f human --monitor --extra_vars "$extra_vars"


echo "AWX CLI complete"
