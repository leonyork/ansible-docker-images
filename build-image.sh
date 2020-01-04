#!/usr/bin/env sh
#######################################################################
# Build, test and push an image
# First argument is the alpine version to use
# Second argument is the ansible version to use
# Third argument is the image tag
#######################################################################
set -eux

if [ -z "$1" ]
then
    echo "You must specify the version of the docker image alpine to use"
    exit 1
fi

if [ -z "$2" ]
then
    echo "You must specify the tersion of ansible to use"
    exit 1
fi

if [ -z "$3" ]
then
    echo "You must specify the image tag to use"
    exit 1
fi

export ALPINE_VERSION=$1;
export ANSIBLE_VERSION=$2;
export IMAGE_TAG=$3;
docker-compose build 

# Test that it's working by making sure we can get the version
docker-compose run ansible --version

# Push to the docker registry
docker-compose push