#!/usr/bin/env bash

# Create an Azure Service Principal and dump its credentials to file

set -euo pipefail

readonly AZURERC="${AZURERC-.azurerc}"

stderr() {
  echo "$*" >&2
}

get-account() {
  # Login to an Azure account and return its details (JSON) for the
  # default or specified subscription ID
  stderr "Logging into Azure..."

  if ! (( $# )); then
    az login 2>/dev/null | jq '.[] | select(.isDefault == true)'

  else
    az login 2>/dev/null | jq --arg subscription "$1" '.[] | select(.id == $subscription)'
  fi
}

create-sp() {
  # Create an Azure Service Principal for the given subscription
  local subscription="$1"

  stderr "Creating Service Principal for subscription ${subscription}..."
  az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${subscription}" 2>/dev/null
}

main() {
  local account="$(get-account "$@")"

  local subscription_id="$(jq -r '.id' <<< "${account}")"
  local tenant_id="$(jq -r '.tenantId' <<< "${account}")"

  local sp="$(create-sp "${subscription_id}")"

  local app_id="$(jq -r '.appId' <<< "${sp}")"
  local password="$(jq -r '.password' <<< "${sp}")"

  stderr "Writing credentials to \"${AZURERC}\"..."
  cat > "${AZURERC}" <<-EOF
	export ARM_SUBSCRIPTION_ID="${subscription_id}"
	export ARM_CLIENT_ID="${app_id}"
	export ARM_CLIENT_SECRET="${password}"
	export ARM_TENANT_ID="${tenant_id}"
	export ARM_ENVIRONMENT="public"
	EOF

  az logout
}

main "$@"
