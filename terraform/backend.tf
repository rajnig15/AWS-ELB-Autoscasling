terraform {
  backend "s3" {
    
    bucket         = "my-us-bucket-rajni"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"

  }
}


      