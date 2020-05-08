#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Create dockerpath
dockerpath=cabreu90/site

# Authenticate & tag
#cat ~/mypassword.txt | docker login --username cabreu90 --password-stdin
echo "Docker ID and Image: $dockerpath"
#docker tag 923fc3bd0e37 $dockerpath

# Push image to a docker repository
docker push $dockerpath