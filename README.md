<img align="right" width="175px" src="http://i.imgur.com/mdZ8Ktf.png" />

# Phalcon Compose [![Build Status](https://travis-ci.org/sergeyklay/phalcon-compose.svg?branch=master)](https://travis-ci.org/sergeyklay/phalcon-compose) [![phalcon-3.0.1](https://img.shields.io/badge/phalcon-3.0.1-blue.svg)](https://github.com/phalcon/cphalcon)

The *unofficial* Phalcon Docker Edition – by [@sergeyklay](https://github.com/sergeyklay)

This is an unofficial, open-source and community-driven boilerplate for Phalcon projects that run on [Docker][0].
It's an attempt of standardizing and making it easier to bootstrap Phalcon applications ready for development and production environments.
The main tools used are Phalcon, Docker and Docker Compose. Other things included are:

- Nginx 1.10.0
- MySQL 5.7.12
- Memcached 1.4
- PHP-FPM 7.0.10
- Xdebug 2.4.0
- Opcache 7.0.6-dev
- Beanstalk 1.10
- Redis 3.2.0
- Aerospike 3.7.4
- Mongo 3.2.7
- PostgreSQL 9.5.3

## Get Started

### Dependencies

To run this stack on your machine, you need at least:

* Operating System: Windows, Linux, or OS X
* [Docker Engine][1] >= 1.10
* [Docker Compose][2] >= 1.6.2

### Installation

First, get this project by using `composer create-project`:
```sh
$ composer create-project sergeyklay/phalcon-compose
```

Another way to fetch project by using `git clone`:

```sh
$ git clone git@github.com:sergeyklay/phalcon-compose.git
```

Next, put your Phalcon Application into `application` folder.
Add `phalcon.local` in your `/etc/hosts` file as follows:

```
127.0.0.1	phalcon.local
```

Build the containers:

```sh
$ docker-compose build
```

## Usage

Now you are ready to build, create, start, and attach to containers for your application, run:

```sh
# instead of phalcon you can use here your prefered project name
$ docker-compose -p phalconcompose up -d
```

and you can visit your Phalcon application on the following URL: [http://phalcon.local](http://phalcon.local)

**NOTE:**

If your application uses a file cache or writes logs to a file on disk open application configuration and set up cache
and log paths as shown below:

* `cache` - `/var/cache/phalcon`
* `logs` - `/var/log/phalcon`

## Containers Included

Here are the `docker-compose` services:

```
 application         Phalcon application code container
 mysql               MySQL database container
 redis               Redis database container
 memcached           Memcached server container
 queue               Beanstalk queue container
 php                 PHP-FPM container
 nginx               Nginx webserver container
 aerospike           Aerospike server container
 posgres             PostgreSQL server container
 mongo               MongoDB server container
```

This results in the following running containers:

```sh
# instead of phalcon you can use here your prefered project name
$ docker-compose -p phalconcompose ps

       Name                     Command               State                                               Ports
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
phalcon.compose.aerospike    /entrypoint.sh asd               Up      0.0.0.0:3000->3000/tcp, 0.0.0.0:3001->3001/tcp, 0.0.0.0:3002->3002/tcp, 0.0.0.0:3003->3003/tcp
phalcon.compose.beanstalkd   beanstalkd -p 11300 -b /data     Up      0.0.0.0:11300->11300/tcp
phalcon.compose.memcached    /entrypoint.sh memcached         Up      0.0.0.0:11211->11211/tcp
phalcon.compose.mongo        /entrypoint.sh mongod            Up      0.0.0.0:27017->27017/tcp
phalcon.compose.mysql        docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp
phalcon.compose.nginx        nginx -g daemon off;             Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
phalcon.compose.php          php-fpm5.6 -F                    Up      0.0.0.0:10000->10000/tcp, 0.0.0.0:9000->9000/tcp
phalcon.compose.postgres     /docker-entrypoint.sh postgres   Up      0.0.0.0:5432->5432/tcp
phalcon.compose.redis        docker-entrypoint.sh redis ...   Up      0.0.0.0:6379->6379/tcp
phalcon.compose.volume       sh                               Up                       Up
```

## Read logs

You can access logs by using `docker logs <container_name>` into your host machine.

## PHP CLI

In additional you can use [`phalconphp/php`][3] container with pre-installed required extensions. For example to run
tests:

```sh
# instead of phalcon_default you can use here your prefered <project name>_default
docker run -it --rm --net=phalcon_default -v $(pwd):/app phalconphp/php:5.6 vendor/bin/codecept run
```

## License

Phalcon Compose is open source software licensed under the MIT. See the [docs/LICENSE.md](docs/LICENSE.md) file for more

[0]: https://www.docker.com/
[1]: https://docs.docker.com/installation/
[2]: https://docs.docker.com/compose/install/
[3]: https://github.com/phalcon/dockerfiles/tree/master/php
