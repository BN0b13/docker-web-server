FROM ubuntu:22.04

# Set noninteractive mode for apt to prevent prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt update && apt install -y \
    curl gnupg ca-certificates \
    build-essential \
    nginx \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js and PM2
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt install -y nodejs && \
    npm install -g pm2 && \
    rm -rf /var/lib/apt/lists/*

# Ensure Nginx and PM2 run properly
RUN systemctl enable nginx || true

# Expose necessary ports
EXPOSE 80 443 2375
