#!/usr/bin/env sh
#######################################################################
# Build, test and push the images
# Creates multiple versions so that there's some choice about versions
# to use
#######################################################################
set -eux

# Number of releases to go back from the latest version
number_of_ansible_releases=5
number_of_alpine_releases=5

# Creates tags of the form {ANSIBLE_VERSION}-alpine-{ALPINE_VERSION} (e.g. 2.9.2-alpine-3.11.0)
# First gets the last $number_of_alpine_releases alpine tags where the tag looks like a version number (there were some odd tags that look like dates)
# For each of those tags gets the last $number_of_ansible_releases of non-release candidate versions of Ansible and builds an image
docker run leonyork/docker-tags library/alpine \
    | grep -E '^[0-9.]\.[0-9.]+$' \
    | tail -n $number_of_alpine_releases \
    | xargs -I{ALPINE_VERSION} -n1 \
        sh -c "docker run leonyork/pypi-releases ansible \
        | grep -E '^[0-9.]\.[0-9.]+$' \
        | tail -n $number_of_ansible_releases \
        | xargs -I{ANSIBLE_VERSION} -n1 sh build-image.sh {ALPINE_VERSION} {ANSIBLE_VERSION} {ANSIBLE_VERSION}-alpine-{ALPINE_VERSION} || exit 255" || exit 255

# Creates tags of the form {ANSIBLE_VERSION}-alpine (e.g. 2.9.2-alpine)
# Gets the last $number_of_ansible_releases of non-release candidate versions of Ansible and creates an image using the latest alpine image
docker run leonyork/pypi-releases ansible \
        | tail -n $number_of_ansible_releases \
        | grep -E '^[0-9.]\.[0-9.]+$' \
        | xargs -I{ANSIBLE_VERSION} -n1 sh build-image.sh latest {ANSIBLE_VERSION} {ANSIBLE_VERSION}-alpine || exit 255

# Generates the latest tag
ansible_latest_version=`docker run leonyork/pypi-releases ansible | tail -n 1`
sh build-image.sh latest $ansible_latest_version latest