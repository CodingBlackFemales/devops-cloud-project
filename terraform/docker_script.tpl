#!/bin/bash
apt get update
apt get upgrade -y
# Install Java
sudo apt install openjdk-11-jre-headless -y
wget https://get.jenkins.io/war-stable/2.346.1/jenkins.war
java -jar jenkins.war
rm -rf jenkins.war

# Install Docker as its needed by jenkins to build and push containers to either DockerHub or AWS ECR
 sudo apt-get update
 sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin  

# Start Jenkins and Docker
sudo usermod -a -G docker jenkins
sudo service jenkins restart
sudo systemctl daemon-reload
sudo service docker stop
sudo service docker start