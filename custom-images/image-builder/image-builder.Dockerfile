FROM gcr.io/kaniko-project/executor as kaniko

FROM alpine

# kaniko runs as root, unfortunately
USER root
RUN apk update && apk upgrade --prune --force-refresh
RUN apk add crane
COPY --from=kaniko /kaniko /kaniko

ENTRYPOINT [ "sh" ]