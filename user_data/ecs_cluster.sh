#!/bin/bash

echo ECS_CLUSTER=${cluster_name} > /etc/ecs/ecs.config
yum install -y aws-cli
install -d -g 1000 -o 1000 -m 755 /var/jenkins_home
aws s3 cp --recursive s3://${s3_jenkins_backup} /var/jenkins_home
chown -R 1000:1000  /var/jenkins_home
chmod 400 /var/jenkins_home/.ssh/*
groupmod -g 1000 docker
chgrp docker /var/run/docker.sock
