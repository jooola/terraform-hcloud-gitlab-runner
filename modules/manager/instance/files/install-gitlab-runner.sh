#!/usr/bin/env bash

# Warning: this file is processed by the terraform templatefile function, beware when
# wrapping variable names with curly braces.

set -eu

error() {
  echo >&2 "error: $*"
  exit 1
}

# Pass terraform template variables to bash variables
# shellcheck disable=SC2154
GITLAB_RUNNER_VERSION="${version}"

# download <filepath>
download() {
  wget \
    --no-verbose \
    --force-directories \
    --no-host-directories \
    --cut-dirs=1 \
    "https://gitlab-runner-downloads.s3.amazonaws.com/$GITLAB_RUNNER_VERSION/$1"
}

tmp="$(mktemp --directory)"
# shellcheck disable=SC2064
trap "rm -Rf $tmp" EXIT

pushd "$tmp" || error "could not cd into $tmp"

# Downloaded gitlab-runner files
download release.sha256
download binaries/gitlab-runner-linux-amd64

# Ensure downloaded files are valid
if ! sha256sum --check --ignore-missing release.sha256; then
  echo "could not verify checksum"
  exit 1
fi

install --mode=755 binaries/gitlab-runner-linux-amd64 /usr/local/bin/gitlab-runner

popd || error "could not cd out of $tmp"
