#! /bin/sh
N=${N:-10000}
THREADS=${THREADS:-10}
USER=${USER:-anonymous}
PASS=${PASS:-allowed@example.org}
SERVER=${SERVER:-ftpserver}

# Create data and checksum
mkdir -p /tmp/test && cd /tmp/test
for i in $(seq 1 $N); do
  echo $date-$i > $i
done
find * -type f -exec sha1sum {} \; |  grep -v SHASUMS > SHASUMS

# Generate upload script
echo "open -u $USER,$PASS $SERVER" > /tmp/upload.scp
echo "mkdir /incoming/parallel" >> /tmp/upload.scp
echo "set ftp:use-site-utime false" >> /tmp/upload.scp
echo "set ftp:use-site-utime2 false" >> /tmp/upload.scp
echo "mirror -p --parallel=$THREADS -R /tmp/test/ /incoming/test/" >> /tmp/upload.scp
echo "bye" >> /tmp/upload.scp

