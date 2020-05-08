FROM nginx:alpine
# Copy source code to working directory
COPY . Index.html /usr/share/nginx/html
