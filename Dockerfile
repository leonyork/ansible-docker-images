ARG ALPINE_VERSION=3.11.2
FROM alpine:${ALPINE_VERSION}

# Install dependencies. Install these in a separate layer so that multiple ansible versions can share the layer
RUN apk add --no-cache \
    py-pip musl-dev python2-dev libffi-dev openssl-dev jq gcc

ARG ANSIBLE_VERSION=2.9.2
RUN pip install "ansible==${ANSIBLE_VERSION}"

ENTRYPOINT [ "ansible" ]
CMD [ "--help" ]