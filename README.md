
# abz-application

This is abz.agency test work for devops role.

## 1. Initiate infrastructure project
 Run script infrastructure_initialization.sh from [abz-test-work-infrastructure](https://github.com/BohdanBohatov/abz-test-work-infrastructure) repository.

## 2. Set environment variables and secrets to the project secrets
 Need to set such variables in GitHub repository, some variable may be stored in AWS Secret Manager but this takes more time. 

 #### Secrets
  + AWS_ACCESS_KEY_ID - access key ID for GitHub, role is created via infrastructure project, user and his credentials must be created manually.
  + AWS_SECRET_ACCESS_KEY - secret access key, role is created via infrastructure project, user and his credentials must be created manually.
 #### Variables - need to take from terraform output, or from AWS.
  + MYSQL_HOST - the URL for wordpress database.
  + MYSQL_PORT - the port on which mysql db runs.
  + MYSQL_SECRET_ARN - the ARN of AWS Secrets Manager where credentials for Mysql are stored 
  + REDIS_URL - the Redis url
  + S3_BUCKET - the S3 bucket to store application artifacts, to be used by CodeDeploy. 
  + WORDPRESS_CREDENTIALS_SECRET_ARN - the wordpress admin credentials secret arn.
  + WORDPRESS_DB - the database name to store wordpress data.

## 3. Configuration options for deployment script and Terraform module and how to customize them
  ### CI/CD and script customization
There is only one configuration in main.yml on line 70  **aws deploy create-deployment**  that need to be modified, exactly the environment where to deploy application, right now it is static and only for **dev** environment. Workflow need to be customized with branch dependencies.
  ### Terraform customization
To customize terraform need create another environmet folder, and create each resource separatly, for each resource there are custom module, if need something to add/remove/modify resources, need to modify module and module usage. Modifying variables can be done in module usage under in dev directory.
  ### Troubleshooting tips and common issues
  Issues:
  + Right now each module usage has providers.tf file with provider configuration, this need to be modified if multiple devops works on the same infrastructure project
  + Key pair also need to be changed if multiple DevOps works on the project.
  + EC2 AMI - I created custom amazon machine image using EC2 Image Builder, there are few reasons: 1st to use CodeDeploy ec2 must have codedeploy-agent - which is unavaliable on default ec2 image. 2nd is to stop wasting time on updating/downloading/installing required software like wordpress/redis/mariadb/. This resources I didn't do in terraform infrastructure project, I made it manually.

 ## 4 Document any external Terraform module and deployment tool used, briefly explaining why you decided to use it.
 I didn't use any external Terraform module. 
 I decided to use Github Action because I had some expirience and knowledge about some repository hosting CI/CD tools (like bitbucket/gitlab/azuredevops), it gives some free minutes which is enough for this project.
 I decided to use AWS CodeDeploy because the deployment is much easier, and can be done on EC2 which is in private VPC. The other way is to deploy via Bastion Host, which requires more setup.

 #### What was done additionaly
I added route53 with my test domaine and added tls/ssl sertificate from aws, it will look a little bit better.

  ### Infrastructure and CI/CD remarks
+ VPC has 6 subnets in total: 2 priviate, 2 private with 1 shared NAT, and 2 public - not in use. If needed bastion host, could be used or some other service in the future.
+ Trafic goes to application load balancer then to the EC2 instance with Wordpress
+ Github action: triggers on pull and push requests; github action builds artifact, building artifact is the process that copies files from application folder, these are wordpress config file and apache config file to store env variable for php server, and it grabs some env variables (mysql host, mysql port, redis host etc.) and AWS secret arn (secrets are storing credentials to create wordpress admin and credentials to connect to mysql DB) and save it in .env file - no sensetive information stored in .env file. Builded artifact uploaded to S3 bucket; Last step is to trigger AWS CodeDeploy - the reason why it used, is because EC2 situated in private subnet and it is best way to execute commands on host. appspec.yml - this file is for CodeDeploy. Script that runs on EC2 situated in scripts/configure_wp.sh.
+ CodeDeploy script (scripts/configure_wp.sh): the script exports env variables from .env file, then takes mysql credentials from AWS Secret manager and sets it in apache conf file (/etc/httpd/conf/httpd.conf). If variables changed or doesn't exist in /etc/environment sets them it it, it because php receives variables from apache, but bash CodeDeploy script receives variables from environment. Then script creates mysql database for wordpress, and installing wordpress and cache plugin, it it is not installed. 
+ application/wp-config.php - has settings for Redis plugin, so no need to configure it, plugin takes connection to DB from file. 
+ application/httpd.conf - has env variables, in the begining of the file, this variables are placeholders that changed by scripts/configure_wp.sh.


[![Infrastucture](/.images/infrastructure.png?raw=true)]
