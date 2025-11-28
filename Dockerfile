FROM alpine:latest

RUN apk update && apk add dropbear dropbear-scp socat bash

# Buat folder SSH
RUN mkdir -p /etc/dropbear

# Tambahkan user dan password
RUN adduser -D user && echo "user:12345" | chpasswd

# Expose port publik WebSocket
EXPOSE 80

# Jalankan Dropbear (SSH) + WebSocket tunnel (socat)
CMD dropbear -E -F -p 22 & socat TCP-LISTEN:80,fork TCP:127.0.0.1:22
