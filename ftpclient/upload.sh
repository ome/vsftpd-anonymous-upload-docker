#! /bin/sh

N=${N:-10000}
SERVER=${SERVER:-ftpserver}
set -eux

# Test repeated access
for i in $(seq $N); do
    echo -en '' | nc $SERVER 21;
done

# Test file transfer
lftp -f /tmp/upload.scp -d

