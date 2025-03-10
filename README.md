
# abz-application

This is abz test application, to deploy this app need

## 1. Initiate infrastructure project
 Run script infrastructure_initialization.sh from [abz-test-work-infrastructure](https://github.com/BohdanBohatov/abz-test-work-infrastructure) repository.

## 2. Set environment variables and secrets to the project secrets
 Need to set such variables as:

 #### Secrets
  + AWS_ACCESS_KEY_ID - access key ID for GitHub, role is created via infrastructure project, but credentials must be generated manually
  + AWS_SECRET_ACCESS_KEY - secret access key, role is created via infrastructure project, but credentials must be generated manually
 #### Variables - need to take from terraform output, or from AWS.
  + MYSQL_HOST - the URL for wordpress database.
  + MYSQL_PORT - the port on which mysql db runs.
  + MYSQL_SECRET_ARN - the ARN of AWS Secrets Manager where credentials for Mysql are stored 
  + REDIS_URL - the Redis url
  + S3_BUCKET - the S3 bucket to store application artifacts, to be used by CodeDeploy. 
  + WORDPRESS_CREDENTIALS_SECRET_ARN - the wordpress admin credentials.
  + WORDPRESS_DB - the database name to store wordpress data.

## 3. The CI/CD workflow