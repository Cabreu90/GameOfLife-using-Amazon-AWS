FROM nginx:alpine

# Copy source code to working directory
COPY . Index.html /var/www/html/
