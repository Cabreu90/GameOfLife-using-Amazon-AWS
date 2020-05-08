## The Makefile includes instructions on environment setup
# Create and activate a virtual environment
# Install dependencies in requirements.txt

setup:
	#
	#

build:
	# Create image
	docker build --tag=site . --force-rm

push:
	# Push to docker hub
	docker push cabreu90/site

clean:
	# Remove unused images 
	#docker image rm site
	docker system prune
	
all: setup build push
