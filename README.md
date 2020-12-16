# Execute Terraform code : GITHUB 
AWS-ELB-Autoscasling : - In this repo, we have terraform code which will be used to provision mediawiki application on AWS infra via ELB & autoscaling
Mediawiki installation steps are mentioned in mediawiki.sh script which is passed to launch configuration terraform code.
steps:- we need to have aws credentials/roles configured in our machine .
Once credentials are configured, we need to clone git where we have terraform code
Once code is clonned to our local repo, we can execute terraform code using terraform init, terraform plan, terraform apply commands

# Execute terraform code via gocd
gocd repo :- https://github.com/rajnig15/gocd-yaml.git
In this repo, we have gocd yaml code to create pipelines automatically on GoCD, which will be used to execute terraform code

# Issues faced while executing terraform code
Issue1:- if script is created in windows and later saved as .sh file , this will create issues since the script is created on windows and when you copy the script to ec2/load balancers 
script's permission will be removed and you won't be able to execute script via user_data in terraform
sol: create script on linux machine, once created , copy the script to s3 bucket and then download the script to local machine . In this way, script's permission will be preserved.
Issue2:- ELB health check was failing even though we mentioned health check target as "HTTP:80/" or "HTTP:80/mediawiki/index.php" but instances were still showing "OoutOfService" and getting terminated again & again due to unreachability.
Sol:- In health check target, provide "HTTP:80/mediawiki/" , we need to provide the relative path to the index file . After this, Instances will be shown "InService" in ELB.
Issue3:- User_data syntax is changed in terraform version 14 , we need to use userdata syntax as user_data = file("script.sh")
