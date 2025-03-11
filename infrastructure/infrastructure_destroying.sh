#!/bin/bash

#Destroy Redis and its security group
terraform -chdir=dev/databases/elasticache_redis destroy -auto-approve
terraform -chdir=dev/security_groups/elasticache_redis_security_group destroy -auto-approve

#Destroy mysql and its security group
terraform -chdir=dev/databases/mysql_rds destroy -auto-approve
terraform -chdir=dev/security_groups/mysql_security_group destroy -auto-approve

#Destroy application load balancer and its security group, and target group
terraform -chdir=dev/load_balancers/wp_alb destroy -auto-approve
terraform -chdir=dev/security_groups/wp_alb_security_group destroy -auto-approve
terraform -chdir=dev/target_groups/wp_tg destroy -auto-approve

#Destroy EC2 and its resources
terraform -chdir=dev/ec2 destroy -auto-approve
terraform -chdir=dev/key_pair destroy -auto-approve
terraform -chdir=dev/iam_roles/ec2_role destroy -auto-approve
terraform -chdir=dev/security_groups/ec2_security_groups destroy -auto-approve

#Destroy wordpress credential secret
terraform -chdir=dev/secrets_manager/wordpress_admin destroy -auto-approve

#Destroy codedeploy and connected resources
terraform -chdir=dev/codedeploy destroy -auto-approve
terraform -chdir=dev/iam_roles/codedeploy_role destroy -auto-approve
terraform -chdir=dev/s3_buckets/s3_codedeploy_bucket destroy -auto-approve

#Destroy github role
terraform -chdir=dev/iam_roles/github_role destroy -auto-approve

#Destroy VPC and subnets
terraform -chdir=dev/subnet destroy -auto-approve
terraform -chdir=dev/vpc destroy -auto-approve
