## Cesarin Abreu
## This Makefile includes instructions to set up a cluster in Amazon EKS

setup: installKube installEKS installCLI ready

installKube:
# Install Kubectl 
	# Download 
	curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
	# Apply execute permissions to the binary.
	chmod +x ./kubectl
	# Copy the binary to a folder in your PATH.
	mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
	# Add the $HOME/bin path to your shell initialization file
	echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

installEKS:
# Install eksctl
	# Download and extract
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	# Move the extracted binary to /usr/local/bin
	sudo mv /tmp/eksctl /usr/local/bin

installCLI:
# Install or Upgrade awscli
	pip install awscli --upgrade --user

ready:
	# Check if kubectl is installed
	kubectl version --short --client
	# check if eksctl is installed
	eksctl version
	# Check if AWS CLI is installed
	aws --version

build:
	# Create cluster with eksctl using a configuration file
	eksctl create cluster -f clusterConf.yaml 

test:
	# check/see cluster
	kubectl get svc

deploy:
	# Deploy docker image
	kubectl apply -f docker pull cabreu90/site:latest

clean:
	# Remove cluster
	eksctl delete cluster -f clusterConf.yaml --wait

all: build test