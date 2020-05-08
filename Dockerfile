FROM nginx:alpine

# Create a working directory
WORKDIR /site

# Copy source code to working directory
COPY . Index.html /site/
