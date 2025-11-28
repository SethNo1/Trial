FROM alpine:latest

RUN apk update && apk add dropbear dropbear-scp socat bash

# Buat folder SSH
RUN mkdir -p /etc/dropbear

# Generate host key RSA
RUN dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key

# Tambah user + password + shell
RUN adduser -D -s /bin/sh user && echo "user:12345" | chpasswd

EXPOSE 80

# Jalankan Dropbear + Socat
CMD dropbear -E -F -p 22 & socat TCP-LISTEN:80,fork TCP:127.0.0.1:22
