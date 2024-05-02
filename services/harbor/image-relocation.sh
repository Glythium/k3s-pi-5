#! /bin/sh

apk add skopeo

skopeo copy docker://gcr.io/kaniko-project/executor:latest "docker://${HARBOR_FQDN}/gcr/kaniko-project/executor:latest" \
    --dest-username "${HARBOR_USERNAME}" \
    --dest-password "${HARBOR_PASSWORD}"