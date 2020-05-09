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
	dockerpath= cabreu90/site
	imageID= docker images -q site
	docker tag ${imageID} ${dockerpath}
	docker push ${dockerpath}

clean:
	# Remove unused images 
	#docker image rm site
	docker system prune

cluster:
	# Create cluster with eksctl using a configuration file
	eksctl create cluster -f clusterConf.yaml 

test:
	kubectl get svc

deploy:
	kubectl apply -f docker pull cabreu90/site:latest

destroycluster:
	eksctl delete cluster -f clusterConf.yaml --wait

all: build push
