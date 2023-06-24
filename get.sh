#!/bin/bash

{ # Prevent the script from executing until the client downloads the full file.

# Exit on first error.
set -e

# Exit on unset variable.
set -u

# Echo commands before executing them, by default to stderr.
set -x

SCRIPT_DIR="$(dirname "$0")"
INSTALLER_DIR=bitcoin-remote-sync

mkdir $INSTALLER_DIR

readonly BUNDLE_FILE="${SCRIPT_DIR}/bundle.tgz"

LATEST_RELEASE=$(curl -L https://api.github.com/repos/bitcoin-ops/bitcoin-remote-sync/tags | grep "tarball_url" | cut -d : -f 2,3 | tr -d \" | tr -d , | tail -n 1)

HTTP_CODE="$(curl $LATEST_RELEASE \
  --location \
  --output "${BUNDLE_FILE}" \
  --write-out '%{http_code}' \
  --silent)"
readonly HTTP_CODE
if [[ "${HTTP_CODE}" != "200" ]]; then
  echo "Failed to download tarball with HTTP response status code ${HTTP_CODE}." >&2
  exit 1
fi

tar \
  --gunzip \
  --extract \
  --file "${BUNDLE_FILE}" \
  --directory "${INSTALLER_DIR}" \
  --strip 1

pushd "${INSTALLER_DIR}"
./run.sh
}
