# Minimal Debian image
FROM debian:bookworm-slim

# Force APT to use IPv4 (prevents hanging on some VPS)
RUN echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4

# Install only required runtime libraries for AzerothCore
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
        libssl3 \
        libboost-system1.74.0 \
        libboost-program-options1.74.0 \
        libboost-filesystem1.74.0 \
        libmariadb3 \
        zlib1g \
        libreadline8 \
        ca-certificates \
        tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /home/container

# Pterodactyl requires USER and HOME environment variables
ENV USER=container HOME=/home/container

# Default command (Pterodactyl overrides this)
CMD ["/bin/bash"]
