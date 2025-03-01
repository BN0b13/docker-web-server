
# Ubuntu Web Server Docker Setup

## Prerequisites

Ensure you have Docker installed on your system:
- **Windows 10/11**: Install Docker Desktop (Ensure WSL 2 is enabled)
- **Mac**: Install Docker Desktop (`brew install --cask docker`)
- **Linux**: Install Docker (`sudo apt install docker.io docker-compose`)

## System Requirements

### 1️⃣ Processor (CPU)
- **Minimum:** **1.5 GHz Dual-Core Processor** (Intel or AMD)
- **Recommended:** **2.0 GHz Quad-Core Processor** or better
  - Docker works better on Linux or using **WSL 2** for Windows.
  - **Apple M1/M2 chips** work well with Docker (supports ARM64 containers natively).

### 2️⃣ Memory (RAM)
- **Minimum:** **4 GB**
- **Recommended:** **8 GB** or more
  - Running Docker-in-Docker (DinD) requires more memory due to nested containers.
  - Containers running services like **Node.js, PostgreSQL, Redis** will need sufficient RAM.

### 3️⃣ Storage (Disk Space)
- **Minimum:** **10 GB** free disk space
- **Recommended:** **20 GB** or more (especially for data persistence)
  - Allocate enough space for Docker images and data volumes (PostgreSQL, Redis, and app data).

### 4️⃣ Operating System
- **Windows:**
  - **Windows 10** or **Windows 11** (with **WSL 2** enabled).
  - Enable **Virtualization** in BIOS.
  - **Docker Desktop** version compatible with WSL 2.
- **Mac:**
  - **macOS 10.14+** (Mojave or later).
  - **Docker Desktop** for macOS.
- **Linux (Recommended):**
  - **Ubuntu 20.04/22.04** or equivalent Linux distribution (supports Docker natively).
  - Install **Docker Engine**: `sudo apt install docker.io docker-compose`.

## Installation & Setup

1. Extract this zip file.
2. Open a terminal (or PowerShell) and navigate to the extracted folder.
3. Run the following command to build and start the containers:
   ```sh
   docker-compose up -d --build
   ```
4. Verify that all containers are running:
   ```sh
   docker ps
   ```
5. To access the Ubuntu container:
   ```sh
   docker exec -it ubuntu-dind bash
   ```
6. Check if services are running inside Ubuntu:
   ```sh
   service nginx status
   pm2 list
   ```

## Stopping the Server
To stop all containers, run:
```sh
docker-compose down
```

Enjoy your Ubuntu web server setup!

