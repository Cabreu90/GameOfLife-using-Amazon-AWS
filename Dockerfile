FROM nginx:alpine
# Copy source code to working directory
COPY . /usr/share/nginx/html
