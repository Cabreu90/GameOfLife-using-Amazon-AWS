## The Makefile includes instructions on environment setup
# Create and activate a virtual environment
# Install dependencies in requirements.txt

setup:
	# Create python virtual environment
	python3 -m venv ~/.devops
	# Activate environment source
	source ~/.devops/bin/activate

build:
	# Create image
	docker build --tag=site . --force-rm

push:
	# Push to docker hub
	docker push cabreu90/site

clean:
	# Remove unsused image
	#docker system prune 
	docker image rm site
	
all: setup build push
