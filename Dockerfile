FROM alpine:latest

RUN apk update && apk add dropbear dropbear-scp socat bash

# Buat folder SSH
RUN mkdir -p /etc/dropbear

# Generate host keys
RUN dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key

# Tambahkan user dan password
RUN adduser -D user && echo "user:12345" | chpasswd

# Expose port WebSocket
EXPOSE 80

# Jalankan Dropbear + Socat WebSocket tunnel
CMD dropbear -E -F -p 22 & socat TCP-LISTEN:80,fork TCP:127.0.0.1:22
