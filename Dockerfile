FROM sickp/alpine-sshd:latest

RUN apk update && apk add --no-cache python2
RUN passwd -d root

COPY rsa-2048.pub /root/.ssh/authorized_keys
EXPOSE 2222
