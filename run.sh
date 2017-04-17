#!/bin/bash

if [ -z "$LDAP_SERVER" ]; then
    LDAP_SERVER="localhost"
fi

if [ -z "$LDAP_ADMIN_DN" ]; then
    LDAP_ADMIN_DN="cn=admin,dc=example,dc=org"
fi

if [ -z "$LDAP_ADMIN_PASSWORD" ]; then
    LDAP_ADMIN_PASSWORD="admin"
fi

if [ -z "$LDAP_BASE_DN" ]; then
    LDAP_BASE_DN="dc=example,dc=org"
fi

if [ -z "$LDAP_CLIENT_ADDR" ]; then
    LDAP_CLIENT_ADDR="example.org"
fi

if [ -z "$LDAP_CLIENT_SECRET" ]; then
    LDAP_CLIENT_SECRET="somesecret"
fi

/usr/bin/mo /templates/ldap > /etc/raddb/mods-enabled/ldap
/usr/bin/mo /templates/clients.conf > /etc/raddb/clients.conf
radiusd -f -X

