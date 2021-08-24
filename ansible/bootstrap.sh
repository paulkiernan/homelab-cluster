#!/bin/bash

set -eu

ansible-playbook \
    -i inventory/hosts.ini \
    --extra-vars @vars.yaml \
    bootstrap.yaml \
    -K
