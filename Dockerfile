#
# Dockerfile for vsftpd
#

FROM alpine
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN set -xe \
    && apk add -U build-base \
                  curl \
                  tar \
                  vsftpd \
    && apk del build-base \
               curl \
               tar \
    && passwd -l root \
    && adduser -D virtual \
    && rm -rf /var/cache/apk/*

ADD vsftpd.conf /etc/vsftpd/vsftpd.conf

VOLUME /var/lib/ftp
WORKDIR /var/lib/ftp

EXPOSE 21

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
