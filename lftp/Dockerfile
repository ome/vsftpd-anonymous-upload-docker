FROM alpine:latest

RUN apk --no-cache add lftp ca-certificates openssh

COPY generate.sh /tmp/generate.sh
WORKDIR /data
RUN sh /tmp/generate.sh

ENTRYPOINT ["lftp"]
CMD ["-f", "/tmp/upload.scp", "-d"]
