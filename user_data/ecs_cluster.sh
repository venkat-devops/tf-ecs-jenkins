#!/bin/bash

echo ECS_CLUSTER=${cluster_name} > /etc/ecs/ecs.config
yum install -y aws-cli
install -d -g 1000 -o 1000 -m 755 /ecs/jenkins_home
aws s3 cp --recursive s3://${s3_jenkins_backup} /ecs/jenkins_home
chown -R 1000:1000  /ecs/jenkins_home
chmod 400 /ecs/jenkins_home/.ssh/*
chgrp docker /var/run/docker.sock
groupmod -g 1000 docker
