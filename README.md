# Ansible Docker images

[![Build Status](https://travis-ci.com/leonyork/ansible-docker-images.svg?branch=master)](https://travis-ci.com/leonyork/ansible-docker-images)

Images for running [Ansible](https://www.ansible.com/).

## Build

```docker build --build-arg ALPINE_VERSION=3.11.2 --build-arg ANSIBLE_VERSION=2.9.2 -t leonyork/ansible .```

## Test

```docker run leonyork/ansible --version```