#!/bin/bash

set -e

for cmd in curl grep sed echo git; do
    echo "Checking for ${cmd}"
    command -v "${cmd}" > /dev/null
done

tag=$(curl --silent "https://api.github.com/repos/buildpacks-community/kpack/releases/latest" |
        grep '"tag_name":' |
        sed -E 's/.*"([^"]+)".*/\1/')

echo "Downloading kpack ${tag}"

curl --silent --location "https://github.com/buildpacks-community/kpack/releases/download/${tag}/release-${tag#v}.yaml" --output kpack.yaml

sed -i -e s/@sha256.*$//g kpack.yaml

if git status | grep modified | grep kpack.yaml; then
    if git branch -a | grep "remotes/origin/update/kpack-${tag}"; then
        echo "Branch 'update/kpack-${tag}' already exists"
    else
        git checkout -b "update/kpack-${tag}"
        git add kpack.yaml
        git config user.email "${GITLAB_USER_EMAIL}"
        git config user.name "${GITLAB_USER_NAME}"
        git remote add gitlab_origin "https://oauth2:${ACCESS_TOKEN}@gitlab.com/Glythium/k3s-pi-5.git"
        git commit -m "CI Commit: Update kpack to ${tag}"
        git push -u gitlab_origin "update/kpack-${tag}"
    fi
fi