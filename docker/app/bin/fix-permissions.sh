#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

if [ -n "$APPLICATION_USER" ]; then
	owner="$APPLICATION_USER"
	if [ -n "$APPLICATION_GROUP" ]; then
		owner="${owner}:$APPLICATION_GROUP"
	fi

	if [ -n "$APPLICATION_CACHE" ] && [ -d "$APPLICATION_CACHE" ]; then
		chown -R $owner ${APPLICATION_CACHE}
	fi

	if [ -n "$APPLICATION_LOGS" ] && [ -d "$APPLICATION_LOGS" ]; then
		chown -R $owner ${APPLICATION_LOGS}
	fi
fi
