<img align="right" width="175px" src="http://i.imgur.com/mdZ8Ktf.png" />

# Phalcon Compose
[![Build Status](https://travis-ci.org/sergeyklay/phalcon-compose.svg?branch=master)][:bs:]
[![phalcon-3.0.1](https://img.shields.io/badge/phalcon-3.0.1-blue.svg)][:phalcon:]

The *unofficial* Phalcon Docker Edition – by [@sergeyklay][:me:]

This is an unofficial, open-source and community-driven boilerplate for Phalcon projects that run on [Docker][docker].
It's an attempt of standardizing and making it easier to bootstrap Phalcon applications ready for development and production environments.
The main tools used are Phalcon, Docker and Docker Compose. Other things included are:

- Apache 2.4.18
- MySQL 5.7.12
- Memcached 1.4.25
- PHP-FPM 7.0.11
- Xdebug 2.4.1
- Beanstalk 1.10
- Redis 3.2.0
- Aerospike 3.9.1
- Mongo 3.2.7
- PostgreSQL 9.5.3

## Get Started

### Dependencies

To run this stack on your machine, you need at least:

* Operating System: Windows, Linux, or OS X
* [Docker Engine][engine] >= 1.10
* [Docker Compose][compose] >= 1.6.2

### Installation

First, get this project by using `composer create-project`:
```sh
$ composer create-project sergeyklay/phalcon-compose
```

Another way to fetch project by using `git clone`:

```sh
$ git clone git@github.com:sergeyklay/phalcon-compose.git
```

and copy `variables.env.example` to the `variables.env`.

---------------------------------------------------------

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
# You can use here your prefered project name instead of "my-app"
$ docker-compose -p my-app up -d
```

and you can visit your Phalcon application on the following URL: http://phalcon.local

**NOTE:**

If your application uses a file cache or writes logs to a file on disk then open application configuration and set up
cache and log paths as shown below:

* `cache` - `/project/cache`
* `logs` - `/project/log`

## Setting environment variables

You can pass multiple environment variables from an external file through to a service’s containers by editing
`variables.env` file.

For information about the environment variables refer to: [Environment variables in Compose][env-config].

## Containers Included

Here are the `docker-compose` services:

```
 mongo               MongoDB server container
 posgres             PostgreSQL server container
 mysql               MySQL database container
 memcached           Memcached server container
 queue               Beanstalk queue container
 aerospike           Aerospike server container
 redis               Redis database container
 php                 PHP 7 + Apache + Composer container
 ssh                 SSH acces to the PHP-FPM container
```

This results in the following running containers:

```sh
# You can use here your prefered project name instead of "my-app"
$ docker-compose -p my-app ps

           Name                         Command               State                                               Ports
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
phalcon.compose.aerospike    /entrypoint.sh asd               Up      0.0.0.0:3000->3000/tcp, 0.0.0.0:3001->3001/tcp, 0.0.0.0:3002->3002/tcp, 0.0.0.0:3003->3003/tcp
phalcon.compose.beanstalkd   beanstalkd -p 11300 -b /data     Up      0.0.0.0:11300->11300/tcp
phalcon.compose.memcached    docker-entrypoint.sh memcached   Up      0.0.0.0:11211->11211/tcp
phalcon.compose.mongo        /entrypoint.sh mongod            Up      0.0.0.0:27017->27017/tcp
phalcon.compose.mysql        docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp
phalcon.compose.php          /opt/docker/bin/entrypoint ...   Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp, 0.0.0.0:9000->9000/tcp
phalcon.compose.postgres     /docker-entrypoint.sh postgres   Up      0.0.0.0:5432->5432/tcp
phalcon.compose.redis        docker-entrypoint.sh redis ...   Up      0.0.0.0:6379->6379/tcp
phalcon.compose.ssh          npm start                        Up      0.0.0.0:2222->22/tcp, 0.0.0.0:8022->8022/tcp
```

## Read logs

You can access logs by using `docker logs <container_name>` into your host machine.

## License

Phalcon Compose is open source software licensed under the MIT. See the [LICENSE.txt][license] file for more.<br>
© Serghei Iakovlev

[:bs:]: https://travis-ci.org/sergeyklay/phalcon-compose
[:phalcon:]: https://github.com/phalcon/cphalcon
[:me:]: https://github.com/sergeyklay
[docker]: https://www.docker.com/
[engine]: https://docs.docker.com/installation/
[compose]: https://docs.docker.com/compose/install/
[license]: https://github.com/sergeyklay/phalcon-compose/blob/master/LICENSE.txt
[env-config]: https://docs.docker.com/compose/environment-variables/
