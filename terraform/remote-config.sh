#!/bin/sh
terraform remote config -backend=gcs \
                        -backend-config="bucket=mocha-cloud-dns-tfstate" \
                        -backend-config="path=terraform.tfstate" \
                        -backend-config="project=mocha-cloud" \
                        -backend-config="credentials=$(cat account.json)"
