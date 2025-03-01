#! /bin/bash

URL=api.$1

# NGINX sites-available set-up
echo  Setting up NGINX sites-available files for $URL

cd /etc/nginx/sites-available

echo "upstream $URL {
server 127.0.0.1:8050;
}
server {
    server_name $URL;
    location / {
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Host \$http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_pass http://$URL/;
        proxy_redirect off;
    }
}" > $URL

sudo ln -s /etc/nginx/sites-available/$URL /etc/nginx/sites-enabled/$URL

cd ~/cs/pi




# upstream api_backend {
#     server localhost:8050;
# }

# server {
#     listen 8050;
#     server_name api.cosmicstrains.com;

#     location / {
#         proxy_pass http://api_backend;
#         proxy_set_header Host $host;
#         proxy_set_header X-Real-IP $remote_addr;
#         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_set_header X-Forwarded-Proto $scheme;
#     }

#     access_log /var/log/nginx/api_access.log;
#     error_log /var/log/nginx/api_error.log;
# }