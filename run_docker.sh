#!/bin/bash
FILE=docker-compose.yml
docker-compose -f $FILE down
docker-compose -f $FILE build
docker-compose -f $FILE up

IMAGE="$(docker ps -q -f ancestor=delivery_hospital_report_delivery_hospital)"

if [[ $IMAGE ]] ; then
	if [[ "$1" ]] ; then
		SRCDIR="$( cd $1 && pwd )"
	else
		GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
		SRCDIR="$GITDIR"
	fi

	if [[ "$2" ]]; then
		docker run --rm -ti -v "$SRCDIR":/usr/app/src --device="$2":/dev/ttyS0 delivery_hospital_report_delivery_hospital
	else
		docker run --rm -ti -v "$SRCDIR":/usr/app/src delivery_hospital_report_delivery_hospital
	fi
fi