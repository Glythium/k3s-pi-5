#!/bin/bash

kubectl apply -f https://github.com/fluxcd/flux2/releases/latest/download/install.yaml

kubectl apply -f initial-git-secret-template.yaml -f ../common/initial-git-source.yaml -f ../common/common-kustomize.yaml