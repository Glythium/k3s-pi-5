#!/bin/bash

# We cannot seal a Secret if we don't get told which Secret to seal
if [ -z $1 ]; then
    echo "Usage: ./$0 <secret filename> [sealed secret file]"
    exit 1
fi

# Check that the Secret we are trying to seal exists
if [ ! -f "$1" ]; then
    echo "ERROR: File not found '$1'"
    exit 1
fi

secret_file="$1"

# Optionally derive the SealedSecret filename from the provided command line arg
#   or just pull both the command line args straight through
if [ -z $2 ]; then
    sealed_secret_file="${1%.yaml*}-sealed.yaml"
else
    sealed_secret_file="$2"
fi

# Seal the Secret
echo "Sealing ${secret_file} > ${sealed_secret_file}"
kubeseal --controller-namespace "sealed-secrets" \
    --controller-name "sealed-secrets" \
    --secret-file "${secret_file}" \
    --sealed-secret-file "${sealed_secret_file}"