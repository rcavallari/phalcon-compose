# Pull base image
FROM phalconphp/php-apache:ubuntu-16.04

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

ENV PROVISION_CONTEXT "development"

# Deploy scripts/configurations
COPY bin/*.sh /opt/docker/provision/entrypoint.d/

RUN mkdir -p /vendor \
    && composer init --working-dir=/vendor \
    && composer --working-dir=/vendor config repo.packagist composer https://packagist.phpcomposer.com\
    && composer --working-dir=/vendor require phalcon/devtools \
    && ln -s /vendor/vendor/phalcon/devtools/phalcon.php /usr/local/bin/phalcon \
    && chmod ugo+x /usr/local/bin/phalcon \
    # Custom provisions
    && chmod +x /opt/docker/provision/entrypoint.d/*.sh \
