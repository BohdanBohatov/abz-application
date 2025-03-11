#!/bin/bash
set -e

#Creating route53 records
terraform -chdir=dev/route_53/alphabetagamazeta init
terraform -chdir=dev/route_53/alphabetagamazeta apply -auto-approve

#Creating VPC
terraform -chdir=dev/vpc init
terraform -chdir=dev/vpc apply -auto-approve

#Creating subnets and rules
terraform -chdir=dev/subnet init
terraform -chdir=dev/subnet apply -auto-approve

#Creating role for github CI/CD
terraform -chdir=dev/iam_roles/github_role init
terraform -chdir=dev/iam_roles/github_role apply -auto-approve

#Creating an S3 bucket to store application artifacts, artifacts will be deployed using CodeDeploy
terraform -chdir=dev/s3_buckets/s3_codedeploy_bucket init
terraform -chdir=dev/s3_buckets/s3_codedeploy_bucket apply -auto-approve

#Creating a CodeDeploy, that will deploy artifacts to EC2
terraform -chdir=dev/iam_roles/codedeploy_role init
terraform -chdir=dev/iam_roles/codedeploy_role apply -auto-approve
terraform -chdir=dev/codedeploy init
terraform -chdir=dev/codedeploy apply -auto-approve

#Creating a secret to store wordpress admin credentials
terraform -chdir=dev/secrets_manager/wordpress_admin init
terraform -chdir=dev/secrets_manager/wordpress_admin apply -auto-approve

#Creating a Mysql database, need create DB before EC2, to give EC2 access to DB's secrets
terraform -chdir=dev/security_groups/mysql_security_group init
terraform -chdir=dev/security_groups/mysql_security_group apply -auto-approve
terraform -chdir=dev/databases/mysql_rds init
terraform -chdir=dev/databases/mysql_rds apply -auto-approve

#Creating elasticache redis
terraform -chdir=dev/security_groups/elasticache_redis_security_group init
terraform -chdir=dev/security_groups/elasticache_redis_security_group apply -auto-approve
terraform -chdir=dev/databases/elasticache_redis init
terraform -chdir=dev/databases/elasticache_redis apply -auto-approve

#Creating a role, security group, and key pair for EC2, and creating EC2 with required resources
terraform -chdir=dev/security_groups/ec2_security_groups init
terraform -chdir=dev/security_groups/ec2_security_groups apply -auto-approve
terraform -chdir=dev/iam_roles/ec2_role init
terraform -chdir=dev/iam_roles/ec2_role apply -auto-approve
terraform -chdir=dev/key_pair init
terraform -chdir=dev/key_pair apply -auto-approve
terraform -chdir=dev/ec2 init
terraform -chdir=dev/ec2 apply -auto-approve

#Creating application load balancer (security group, target group, and ALB)
terraform -chdir=dev/security_groups/wp_alb_security_group init
terraform -chdir=dev/security_groups/wp_alb_security_group apply -auto-approve
terraform -chdir=dev/target_groups/wp_tg init
terraform -chdir=dev/target_groups/wp_tg apply -auto-approve
terraform -chdir=dev/load_balancers/wp_alb init
terraform -chdir=dev/load_balancers/wp_alb apply -auto-approve