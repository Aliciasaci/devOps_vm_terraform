#!/bin/bash

# Update package list
sudo apt-get update

# Install Git
sudo apt-get install -y git

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Clone an open-source project
git clone https://github.com/goby-lang/sample-web-app.git

# Change into the project directory 
cd sample-web-app

# Build and run the Docker container 
sudo docker build -t my-project .
sudo docker run -d --name my-project-container my-project

# Print the running container
sudo docker ps