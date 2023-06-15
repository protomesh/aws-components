#!/bin/bash

# change the name of the cluster to match your cluster name

sudo yum install -y amazon-cloudwatch-agent

echo "ECS_CLUSTER=${cluster_name}" >> /etc/ecs/ecs.config
