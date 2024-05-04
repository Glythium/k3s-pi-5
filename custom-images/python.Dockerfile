FROM alpine

# We'll use root for a bit to set up the container environment
USER root
RUN apk update && apk upgrade --prune --force-refresh
RUN apk add python3
RUN adduser -HD -u 1001 1001

# Switch to the non-privileged user
USER 1001

ENTRYPOINT [ "sh" ]