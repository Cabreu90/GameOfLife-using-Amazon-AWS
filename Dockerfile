FROM nginx:alpine
# Copy source code to working directory
COPY site /usr/share/nginx/html
