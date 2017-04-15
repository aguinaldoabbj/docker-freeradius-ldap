FROM alpine:3.5
MAINTAINER Zhang Sihao <spirit.line.523@gmail.com>

WORKDIR /app

RUN apk update && apk upgrade && \
    apk add --update bash freeradius freeradius-ldap freeradius-radclient && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /var/cache/apk/*
RUN rm -f /etc/raddb/mods-enabled/eap

ADD mo /usr/bin/mo
ADD raddb/ldap /templates/
ADD raddb/site /etc/raddb/sites-enabled/default
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
