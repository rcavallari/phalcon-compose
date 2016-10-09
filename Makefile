ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
VARIABLES_FILE=$(ROOT_DIR)/variables.env
PHALCON_VERSION=$(shell docker run -it --rm phalconphp/php-apache:ubuntu-16.04 sh -c "/usr/bin/php -r 'echo Phalcon\Version::get();'")

build: check
	docker-compose build --no-cache
	docker-compose up -d

pull:
	docker pull mongo:3.2
	docker pull postgres:9.5
	docker pull mysql:5.7
	docker pull memcached:1.4
	docker pull aerospike:latest
	docker pull redis:latest
	docker pull elasticsearch:2.3
	docker pull jeroenpeeters/docker-ssh:latest
	docker pull phalconphp/beanstalkd:1.10
	docker pull phalconphp/php-apache:ubuntu-16.04

up: check
	docker-compose up -d

start: check
	docker-compose start

stop:
	docker-compose stop

status:
	docker-compose ps

reset: check
	docker-compose stop
	docker-compose rm --force
	docker-compose build --no-cache
	docker-compose up -d

check:
ifeq ($(wildcard $(VARIABLES_FILE)),)
	$(error Failed to locate the $(VARIABLES_FILE) file.)
endif
	docker-compose config -q

version:
	$(info Phalcon $(PHALCON_VERSION))
	docker-compose version

clean: stop
	docker-compose rm -f

%:
	@:
