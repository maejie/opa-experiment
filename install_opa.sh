#!/bin/env bash

# This script downloads opa binary
curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.39.0/opa_linux_amd64

chmod 755 ./opa

