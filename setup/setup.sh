#!/bin/bash

echo "Starting Docker..."
nohup dockerd > /var/log/dockerd.log 2>&1 &  # Start Docker in the background

sleep 5  # Give Docker some time to initialize

echo "Starting NGINX..."
service nginx restart

# Clone the repository (replace URL later when ready)
echo "Cloning Git repository into /var/www/..."
git clone $GIT_URL/$REPO_NAME.git /var/www/

# Copy .env file to the backend directory
echo "Copying .env file to backend directory..."
cp /setup/.env /var/www/$REPO_NAME/backend/.env  # Copy the .env file to the backend

# Go into each directory and install dependencies
echo "Running npm install for backend..."
cd /var/www/$REPO_NAME/backend
npm install

echo "Running npm install for frontend..."
cd /var/www/$REPO_NAME/frontend
npm install

echo "Running npm install for admin frontend..."
cd /var/www/$REPO_NAME/admin
npm install

# Set up environment variables for backend to connect to PostgreSQL and Redis
echo "Setting up environment for backend..."

# Assuming backend service connects to the Docker containers using their service names
echo "PG_URL=postgres://$PG_USERNAME:$PG_PASSWORD@postgres:5432/$PG_DATABASE_NAME" > /var/www/$REPO_NAME/backend/.env
echo "REDIS_URL=redis://redis:$REDIS_PORT" >> /var/www/$REPO_NAME/backend/.env

# Set up PM2 for backend (Node.js app)
echo "Setting up PM2 for backend..."
pm2 startup
pm2 start /var/www/$REPO_NAME/backend/app.js --name "backend" --time
pm2 save

echo "Setup complete! Ubuntu container is ready."
tail -f /dev/null  # Keep the container running