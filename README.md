# Ansible Docker images

Images for running ansible.

## Build

```docker build --build-arg ALPINE_VERSION=3.11.2 --build-arg ANSIBLE_VERSION=2.9.2 -t ansible .```

## Test

```docker run ansible --version```