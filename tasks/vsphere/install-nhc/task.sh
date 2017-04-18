#!/bin/bash -e

gunzip ./govc/govc_linux_amd64.gz
chmod +x ./govc/govc_linux_amd64

CMD=./govc/govc_linux_amd64

function checkEnviromentVars() {
  if [ -z "$GOVC_URL" ]; then
    echo "must specify \$GOVC_URL" >&2
    exit 1
  fi
  if [ -z "$GOVC_USERNAME" ]; then
    echo "must specify \$GOVC_USERNAME" >&2
    exit 1
  fi
  if [ -z "$GOVC_PASSWORD" ]; then
    echo "must specify \$GOVC_PASSWORD" >&2
    exit 1
  fi
  if [ -z "$GOVC_DATACENTER" ]; then
    echo "must specify \$GOVC_DATACENTER" >&2
    exit 1
  fi
# TODO more checks
}
function validateClusterName() {
  cluster_path="find . -type c -name $1"
  local ret=$($CMD  $cluster_path)
  if [ -z "$ret" ]; then
    echo "Invalid cluster name: $1" >&2
    exit 1
  fi
  echo "Cluster $1 exists"
}

function validateResourcePoolName() {
  res_path="find . -type p -name $1"
  local ret=$($CMD  $res_path)
  if [ -z "$ret" ]; then
    echo "Invalid resource pool  name: $1" >&2
    exit 1
  fi
  # TODO: Handle: Multiple clusters can have same Resource pool name
  echo "Resource Pool $1 exists"
}

checkEnviromentVars
validateClusterName  $AZ_1_CUSTER_NAME
validateResourcePoolName $AZ_1_RP_NAME

