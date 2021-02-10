#!/usr/bin/env bash

set -e

BIND_DN="$1"
BIND_DN_PASSWORD="$2"
LDAP_WELCOME_MSG="$3"
LDAP_URL="$4"
BACKEND_SERVER="$5"
BACKEND_SCHEME="$6"
BACKEND_AUTH_HEADER="$7"

echo "Replac[ing] template variables..."

cp /nginx.conf /tmp/nginx.conf.template
sed -i "s#<LDAP_URL GOES HERE>#${LDAP_URL}#" /tmp/nginx.conf.template
sed -i "s/<BIND_DN GOES HERE>/${BIND_DN}/" /tmp/nginx.conf.template
sed -i "s/<BIND_DN_PASSWORD GOES HERE>/${BIND_DN_PASSWORD}/" /tmp/nginx.conf.template
sed -i "s/<LDAP_WELCOME_MSG GOES HERE>/${LDAP_WELCOME_MSG}/" /tmp/nginx.conf.template

sed -i "s/<BACKEND_SCHEME GOES HERE>/${BACKEND_SCHEME}/" /tmp/nginx.conf.template
sed -i "s#<BACKEND_SERVER GOES HERE>#${BACKEND_SERVER}#" /tmp/nginx.conf.template
if [ $BACKEND_AUTH_HEADER == "" ]; then
  sed "/<BACKEND_AUTH_HEADER GOES HERE>/d" /tmp/nginx.conf.template
else
  sed -i "s/<BACKEND_AUTH_HEADER GOES HERE>/${BACKEND_AUTH_HEADER}/" /tmp/nginx.conf.template
fi;
cp /tmp/nginx.conf.template /nginx.conf

echo "... Replac[ed] template variables."
