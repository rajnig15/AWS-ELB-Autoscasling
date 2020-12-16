# Execute Terraform code : GITHUB 
AWS-ELB-Autoscasling : - In this repo, we have terraform code which will be used to provision mediawiki application on AWS infra via ELB & autoscaling
Mediawiki installation steps are mentioned in mediawiki.sh script which is passed to launch configuration terraform code.
steps:- we need to have aws credentials/roles configured in our machine .
Once credentials are configured, we need to clone git where we have terraform code
Once code is clonned to our local repo, we can execute terraform code using terraform init, terraform plan, terraform apply commands

# Execute terraform code via gocd
gocd repo :- https://github.com/rajnig15/gocd-yaml.git
In this repo, we have gocd yaml code to create pipelines automatically on GoCD, which will be used to execute terraform code
