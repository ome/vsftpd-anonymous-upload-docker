# vsftpd Anonymous Upload Docker Image

[vsftpd](https://security.appspot.com/vsftpd.html) is a GPL licensed FTP server for UNIX systems, including Linux.

This Docker image is configured to allow anonymous uploads only.

A very minimal level of access control is provided by listing allowed emails in `/etc/vsftpd.email_passwords`. `/var/lib/ftp/incoming` should be mounted as a volume, note permissions are important! xferlogs are sent to stdout.

Passive FTP ports are configured to fit with the default Kubernetes NodePort range since FTP does not support port-forwarding between different ports.

```bash
docker run -d --name vsftpd -p 32021:21 -p 32022-32041:32022-32041 -v /var/lib/ftp/incoming vsftpd-anonymous-upload
```

## Client

Login as `anonymous`, password `allowed@example.org`. You can upload files to incoming but listing is blocked.

```
$ ftp anonymous@127.0.0.1
Connected to 127.0.0.1.
220 Place files in /incoming for upload.
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.

ftp> ls
229 Entering Extended Passive Mode (|||21015|)
150 Here comes the directory listing.
d-wxrwx---    2 ftp      ftp          4096 Nov 29 17:06 incoming
226 Directory send OK.

ftp> put test.txt
local: test.txt remote: test.txt
229 Entering Extended Passive Mode (|||21052|)
553 Could not create file.

ftp> cd incoming
250 Directory successfully changed.

ftp> ls
229 Entering Extended Passive Mode (|||21018|)
150 Here comes the directory listing.
226 Transfer done (but failed to open directory).

ftp> put test.txt
local: test.txt remote: test.txt
229 Entering Extended Passive Mode (|||21017|)
150 Ok to send data.
100% |***********************************|     6       53.26 KiB/s    00:00 ETA
226 Transfer complete.
6 bytes sent in 00:00 (6.59 KiB/s)

ftp> ls
229 Entering Extended Passive Mode (|||21026|)
150 Here comes the directory listing.
226 Transfer done (but failed to open directory).

ftp> put test.txt
local: test.txt remote: test.txt
229 Entering Extended Passive Mode (|||21007|)
553 Could not create file.

ftp> rm test.txt
550 Permission denied.
```

## Maintainer

ome-devel@lists.openmicroscopy.org.uk

## Acknowledgements

This image is based on https://github.com/vimagick/dockerfiles/tree/361bbf6e46665af72910542afaece71f27e46089/vsftpd
