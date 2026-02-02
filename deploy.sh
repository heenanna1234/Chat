#!/usr/bin/env bash
set -euo pipefail

# Simple deploy script: build and push image to GHCR
# Requires these env vars:
#  - GHCR_USER (optional, defaults to $USER)
#  - GHCR_REPO (optional, defaults to repository name 'chat')
#  - GHCR_TOKEN (if not using `gh auth`)

IMAGE=${IMAGE:-ghcr.io/${GHCR_USER:-${USER}}/${GHCR_REPO:-chat}:latest}

echo "Building image $IMAGE"
docker build -t "$IMAGE" .

echo "Pushing image $IMAGE"

# If GHCR_TOKEN is provided, use it for login; otherwise expect `gh auth login` or `docker login` already configured.
if [ -n "${GHCR_TOKEN:-}" ]; then
  echo "Logging into ghcr.io as ${GHCR_USER:-$USER}"
  echo "$GHCR_TOKEN" | docker login ghcr.io -u "${GHCR_USER:-$USER}" --password-stdin
fi

docker push "$IMAGE"

echo "Pushed $IMAGE"
