#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

# shellcheck source=hack/common.sh
source "${SCRIPT_DIR}/../common.sh"

AWS_CPI_VERSION=$1

if [ -z "${AWS_CPI_VERSION:-}" ]; then
  echo "Missing argument: AWS_CPI_VERSION"
  exit 1
fi

ASSETS_DIR="$(mktemp -d -p "${TMPDIR:-/tmp}")"
readonly ASSETS_DIR
trap_add "rm -rf ${ASSETS_DIR}" EXIT

export CHART_VERSION=""
if [ "${AWS_CPI_VERSION}" = "1.27.1" ]; then
  CHART_VERSION="0.0.8"
fi

readonly KUSTOMIZE_BASE_DIR="${SCRIPT_DIR}/kustomize/aws-cpi/"
envsubst -no-unset <"${KUSTOMIZE_BASE_DIR}/kustomization.yaml.tmpl" >"${ASSETS_DIR}/kustomization.yaml"

readonly FILE_NAME="aws-cpi-${AWS_CPI_VERSION}.yaml"
kustomize build --enable-helm "${ASSETS_DIR}" >"${ASSETS_DIR}/${FILE_NAME}"

kubectl create configmap aws-cpi-"${AWS_CPI_VERSION}" --dry-run=client --output yaml \
  --from-file "${ASSETS_DIR}/${FILE_NAME}" \
  >"${ASSETS_DIR}/aws-ebs-cpi-${AWS_CPI_VERSION}-configmap.yaml"

# add warning not to edit file directly
cat <<EOF >"${GIT_REPO_ROOT}/charts/capi-runtime-extensions/templates/cpi/aws/manifests/aws-ebs-cpi-${AWS_CPI_VERSION}-configmap.yaml"
$(cat "${GIT_REPO_ROOT}/hack/license-header.yaml.txt")

#=================================================================
#                 DO NOT EDIT THIS FILE
#  IT HAS BEEN GENERATED BY /hack/addons/update-aws-cpi.sh
#=================================================================
$(cat "${ASSETS_DIR}/aws-ebs-cpi-${AWS_CPI_VERSION}-configmap.yaml")
EOF
