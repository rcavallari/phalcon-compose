#
# SQLite Dockerfile
#

# Pull base image
FROM klay/ubuntu

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Install SQLite
RUN apt-get update -qq && \
    apt-get -y install rlwrap sqlite3 socat

# Cleanup package manager
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /data

# Expose volumes
VOLUME ["/data"]

# Expose ports
EXPOSE 12345
