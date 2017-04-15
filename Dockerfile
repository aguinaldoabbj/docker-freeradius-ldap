FROM alpine:3.5
MAINTAINER Zhang Sihao <spirit.line.523@gmail.com>

WORKDIR /app

RUN apk update && apk upgrade && \
    apk add --update freeradius freeradius-ldap freeradius-radclient && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /var/cache/apk/*

ADD raddb/ldap /etc/raddb/mods-enabled/
ADD raddb/site /etc/raddb/sites-enabled/default

VOLUME \
    /opt/db/ \
    /etc/freeradius/certs

EXPOSE \
    1812/udp \
    1813 \
    18120

CMD ["radiusd","-xx","-f"]
