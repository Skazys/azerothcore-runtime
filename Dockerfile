FROM debian:bookworm-slim

RUN apt update && apt install -y \
    libssl3 \
    libboost-system1.74.0 \
    libboost-program-options1.74.0 \
    libboost-filesystem1.74.0 \
    libmariadb3 \
    zlib1g \
    libreadline8 \
    && apt clean

WORKDIR /home/container
