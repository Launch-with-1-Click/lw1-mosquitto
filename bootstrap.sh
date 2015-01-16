#!/usr/bin/env bash
set -ex

curl https://packagecloud.io/install/repositories/chef/stable/script.rpm | sudo bash

sudo yum update -y
sudo yum install git -y
sudo yum install expect -y

## Setup hint for ec2
sudo mkdir -p /etc/chef/ohai/hints
sudo touch /etc/chef/ohai/hints/ec2.json
echo '{}' > ./ec2.json
sudo mv ./ec2.json /etc/chef/ohai/hints/ec2.json
sudo chown root.root /etc/chef/ohai/hints/ec2.json

## install mosquitto

sudo install -o root -g root mosquitto.repo /etc/yum.repos.d/
sudo yum install -y mosquitto libmosquitto-devel
