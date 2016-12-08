#!/bin/sh
cat <<EOF
{
  "private_key": "$GCP_PRIVATE_KEY",
  "client_email": "$GCP_CLIENT_EMAIL"
}
EOF
