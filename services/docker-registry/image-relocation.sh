#!/bin/bash

set -e

for cmd in apt-get tar; do
    echo "Checking for ${cmd}"
    command -v "${cmd}" > /dev/null
done

apt-get update -y -qq
apt-get install jq curl -y -qq

VERSION=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name')
OS=Linux
ARCH=arm64
curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" > go-containerregistry.tar.gz
tar -zxvf go-containerregistry.tar.gz -C /usr/local/bin/ crane

declare -a images=(
    "alpine:latest"
    "bitnami/git:latest"
    "bitnami/kubectl:latest"
    "gcr.io/go-containerregistry/crane:debug"
    "trufflesecurity/trufflehog:latest"
    "ubuntu:latest"
)

crane auth login -u test -p test "${DOCKER_REGISTRY_URL}"
for image in "${images[@]}"; do
    crane copy "${image}" "${DOCKER_REGISTRY_URL}/${image}" --platform linux/arm64 --insecure
done