#
# MySQL Data container
#

# Pull base image
FROM busybox

RUN adduser -H -D mysql mysql && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

# Set up the application directory
VOLUME /var/lib/mysql

CMD /bin/sh
