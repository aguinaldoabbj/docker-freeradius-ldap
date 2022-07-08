FROM alpine

WORKDIR /app

RUN apk update && apk upgrade && \
    apk add --update bash curl freeradius freeradius-ldap freeradius-radclient openssl samba-winbind samba-winbind-clients && \
    curl -sSL https://git.io/get-mo -o /usr/bin/mo && \
    chmod +x /usr/bin/mo && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /var/cache/apk/*
RUN rm -f /etc/raddb/mods-enabled/eap

RUN /etc/raddb/certs/bootstrap \
    #chown -R root:radius /etc/raddb/certs \
    && chmod 755 /etc/raddb/certs/server.pem \
    #&& chmod 755 /etc/raddb/certs/client.crt \
    #&& chmod 640 /etc/raddb/certs/*.pem
    && ls -la /etc/raddb/certs/

#ADD mo /usr/bin/mo
# Templates to generate conf files
ADD raddb/ldap /templates/
ADD raddb/ntlm_auth /templates/
ADD raddb/clients.conf /templates/

# Static conf files
ADD raddb/default /etc/raddb/sites-enabled/default
ADD raddb/inner-tunnel /etc/raddb/sites-enabled/inner-tunnel 
ADD raddb/authorize /etc/raddb/mods-config/files/authorize
ADD raddb/radiusd.conf /etc/raddb/radiusd.conf
ADD run.sh /run.sh

VOLUME \
    /opt/db/ \
    /etc/freeradius/certs

EXPOSE \
    1812/udp \
    1813 \
    18120

CMD ["/run.sh"]
