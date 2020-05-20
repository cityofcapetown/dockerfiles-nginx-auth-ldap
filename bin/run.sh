#!/usr/bin/env bash

set -e

echo "$(date -Iminutes) Injecting Env Variables."
./inject-env-vars.sh "$BIND_DN" "$BIND_DN_PASSWORD" "$LDAP_WELCOME_MSG" "$LDAP_URL" "$BACKEND_SERVER"

cat /nginx.conf

echo "$(date -Iminutes) Starting Nginx Proxy."
nginx -c /nginx.conf
