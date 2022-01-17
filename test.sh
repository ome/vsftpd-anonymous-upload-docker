#!/bin/bash

set -eu

docker-compose down
docker-compose build
docker-compose up -d
docker wait vsftpd-anonymous-upload-docker_ftpclient_1
docker exec vsftpd-anonymous-upload-docker_ftpserver_1 sh -c "cd incoming/test && sha1sum -c SHASUMS"

