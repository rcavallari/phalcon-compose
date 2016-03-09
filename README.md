<img align="right" width="175px" src="http://i.imgur.com/mdZ8Ktf.png" />

# Phalcon 2.1 Docker Edition [![Build Status](https://travis-ci.org/sergeyklay/phalcon-compose.svg?branch=master)](https://travis-ci.org/sergeyklay/phalcon-compose) [![phalcon-2.1.x](https://img.shields.io/badge/phalcon-2.1.x-blue.svg)](https://github.com/sergeyklay)

The *unofficial* Phalcon Docker Edition – by [@sergeyklay](https://github.com/sergeyklay)

This is an unofficial, open-source and community-driven boilerplate for Phalcon projects that run on [Docker][0].
It's an attempt of standardizing and making it easier to bootstrap Phalcon applications ready for development and production environments.
The main tools used are Phalcon, Docker and Docker Compose. Other things included are:

- Nginx 1.9.11
- MySQL 5.7.11
- Memcached 1.4
- PHP 5.6.19 + PHP-FPM
- Xdebug 2.3.3
- Opcache 7.0.6-dev
- Beanstalk 1.10
- Redis 3.0.7

## Get Started

### Dependencies

To run this stack on your machine, you need at least:

* Operating System: Windows, Linux, or OSX
* [Docker Engine][1] >= 1.7.1
* [Docker Compose][2] >= 1.4.2

### Installation

First, clone this repository:

```sh
$ git clone git@github.com:sergeyklay/phalcon-compose.git
```

Next, put your Phalcon application into `application` folder.
Then add `your_site_name.dev` in your ``/etc/hosts`` file as follows:

```
127.0.0.1	your_site_name.dev
```

## Usage

Now you are ready to build, creates, start, and attach to containers for your application, run:

```sh
docker-compose up -d
```

and you can visit your Phalcon application on the following URL: http://your_site_name.dev

### Containers Included

Here are the `docker` & `docker-compose` built images:

* `application`: Phalcon 2.1.x application code container
* `db`:          MySQL 5.7.11 database container
* `redis`:       Redis 3.0 database container
* `memcached`:   Memcached Server 1.4 container
* `queue`:       Beanstalk 1.10 queue container
* `php`:         PHP 5.6.19 + PHP-FPM container in which the application volume is mounted
* `nginx`:       Nginx 1.9.11 webserver container in which application volume is mounted too

This results in the following running containers:

```sh
$ docker-compose ps

      Name                   Command              State                        Ports
----------------------------------------------------------------------------------------------------------
beanstalkd_queue   beanstalkd -p 11300 -b /data   Up      0.0.0.0:11300->11300/tcp
core_app           bash                           Up
memcached_db       /entrypoint.sh memcached       Up      0.0.0.0:11211->11211/tcp
mysql_db           /entrypoint.sh mysqld          Up      0.0.0.0:3307->3306/tcp
nginx_web          nginx -g daemon off;           Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
php_5.6_fpm        /usr/sbin/php5-fpm -F          Up      0.0.0.0:10000->10000/tcp, 0.0.0.0:9000->9000/tcp
redis_db           /entrypoint.sh redis-server    Up      0.0.0.0:6379->6379/tcp
```

### Read logs

You can access logs by using `docker logs <container_name>` into your host machine.

[0]: https://www.docker.com/
[1]: https://docs.docker.com/installation/
[2]: https://docs.docker.com/compose/install/
