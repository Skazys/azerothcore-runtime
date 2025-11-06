FROM debian:bookworm-slim

# Force APT to use IPv4 only (prevents infinite hangs)
RUN echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4

# Use faster and more reliable Debian mirrors
RUN sed -i 's|deb.debian.org|deb.debian.org|g' /etc/apt/sources.list \
    && sed -i 's|security.debian.org|deb.debian.org|g' /etc/apt/sources.list

# Install only required runtime libraries for AzerothCore
RUN apt update && apt install -y --no-install-recommends \
        libssl3 \
        libboost-system1.74.0 \
        libboost-program-options1.74.0 \
        libboost-filesystem1.74.0 \
        libmariadb3 \
        zlib1g \
        libreadline8 \
        ca-certificates \
        tzdata \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /home/container

# Pterodactyl requires this environment variable
ENV USER=container HOME=/home/container

# Entry point — Pterodactyl replaces this
CMD ["/bin/bash"]
