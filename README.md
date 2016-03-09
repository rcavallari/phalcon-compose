# Docker Phalcon 2.1

[![Build Status](https://travis-ci.org/sergeyklay/phalcon-compose.svg?branch=master)](https://travis-ci.org/sergeyklay/phalcon-compose)

Build Status

Just a little Docker POC in order to have a complete stack for running Phalcon into Docker containers using docker-compose tool.

## Get Started

### Dependencies

To run this stack on your machine, you need at least:

* [Docker Engine][1] >= 1.7.1
* [Docker Compose][2] >= 1.4.2

### Installation

First, clone this repository:

```sh
$ git clone git@github.com:sergeyklay/phalcon-compose.git
```

Next, put your Phalcon application into `application` folder.
Then add `your_site_name.dev` in your /etc/hosts file as follows:

```
127.0.0.1	your_site_name.dev
```

## Usage

Run:

```sh
docker-compose up -d
```

and you can visit your Phalcon application on the following URL: http://your_site_name.dev

### How it works

Here are the `docker` & `docker-compose` built images:

* `application`: This is the Phalcon 2.1 application code container
* `db`: This is the MySQL 5.7 database container
* `redis`: This is the Redis 3.0 database container
* `queue`: This is the Beanstalk 1.10 queue container
* `php`: This is the PHP-FPM 5.6 container in which the application volume is mounted
* `nginx`: This is the Nginx Mainline webserver container in which application volume is mounted too

This results in the following running containers:

```sh
$ docker-compose ps

      Name                   Command              State                        Ports
----------------------------------------------------------------------------------------------------------
beanstalkd_queue   beanstalkd -p 11300 -b /data   Up      0.0.0.0:11300->11300/tcp
core_app           bash                           Up
mysql_db           /entrypoint.sh mysqld          Up      0.0.0.0:3307->3306/tcp
nginx_web          nginx -g daemon off;           Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
php_5.6_fpm        /usr/sbin/php5-fpm -F          Up      0.0.0.0:10000->10000/tcp, 0.0.0.0:9000->9000/tcp
redis_db           /entrypoint.sh redis-server    Up      0.0.0.0:6379->6379/tcp
```

### Read logs

You can access logs by using `docker logs <container_name>` into your host machine.

[1]: https://docs.docker.com/installation/
[2]: https://docs.docker.com/compose/install/
