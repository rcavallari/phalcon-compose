ROOT_DIR       := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
VARIABLES_FILE  = $(ROOT_DIR)/variables.env
PHALCON_VERSION = $(shell docker run -it --rm phalconphp/php-apache:ubuntu-16.04 sh -c "/usr/bin/php -r 'echo Phalcon\Version::get();'")
SHELL          := $(shell which bash)
VERSION         = 2.0.2

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
default: help-default;   # default target
Makefile: ;              # skip prerequisite discovery

.title:
	@echo -e "Phalcon Compose Builder: $(VERSION)\n"

help-default help: .title
	@echo "                          ====================================================================="
	@echo "                          Help & Check Menu"
	@echo "                          ====================================================================="
	@echo "                    help: Show Phalcon Compose Help Menu: type: make help"
	@echo "                   check: Check required files"
	@echo "                 version: Show versions"
	@echo "                          ====================================================================="
	@echo "                          Main Menu"
	@echo "                          ====================================================================="
	@echo "                   build: Build or rebuild services"
	@echo "                    pull: Pull latest dependencies"
	@echo "                      up: Create and start application in detached mode (in the background)"
	@echo "                   start: Start application"
	@echo "                    stop: Stop application"
	@echo "                  status: List containers status"
	@echo "                   reset: Reset all containers, delete all data, rebuild services and restart"
	@echo ""

build: check
	docker-compose build --no-cache

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

reset: check stop clean build up
	docker-compose up -d

check:
ifeq ($(wildcard $(VARIABLES_FILE)),)
	$(error Failed to locate the $(VARIABLES_FILE) file.)
endif
	docker-compose config -q

version:
	$(info Phalcon Compose $(VERSION))
	$(info Phalcon $(PHALCON_VERSION))
	docker-compose version

clean: stop
	docker-compose rm --force

%:
	@: