#!/bin/bash

set -eu

docker-compose down
docker-compose build
docker-compose up -d
# Todo: review why docker wait returns a non-zero status code
docker wait vsftpd-anonymous-upload-docker_ftpclient_1 || echo completed
docker exec vsftpd-anonymous-upload-docker_ftpserver_1 sh -c "cd incoming/test && sha1sum -c SHASUMS"

