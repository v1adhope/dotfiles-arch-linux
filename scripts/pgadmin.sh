#!/usr/bin/env bash

docker run -p 80:80 \
    --add-host host.docker.internal:host-gateway \
    -e 'PGADMIN_DEFAULT_EMAIL=vladislavgardner@gmail.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=Zrsnfv2NDvHDMQPDADNFL9AnEfV7CxrQ' \
    -v ./data:/var/lib/pgadmin \
    -v /var/lib/pgadmin/storage/vladislavgardner_gmail.com/backups:/backups \
    -d dpage/pgadmin4
