ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
VARIABLES_FILE=$(ROOT_DIR)/variables.env
PHALCON_VERSION=$(shell docker run -it --rm phalconphp/php-apache:ubuntu-16.04 sh -c "/usr/bin/php -r 'echo Phalcon\Version::get();'")

create:
	docker-compose build --no-cache
	cp $(VARIABLES_FILE).example $(VARIABLES_FILE)

update:
	docker pull phalconphp/php-apache:ubuntu-16.04

up: check
	docker-compose up -d

start: check
	docker-compose start

stop:
	docker-compose stop

status:
	docker-compose ps

rebuild: check
	docker-compose stop
	docker-compose rm --force php
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

%:
	@:
