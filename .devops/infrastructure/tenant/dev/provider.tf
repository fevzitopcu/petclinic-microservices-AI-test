##### Define Terraform State Backend and Must Providers
terraform {
  backend "s3" {
    bucket  = "devops-capstone-tfstate" # BUCKET_NAME
    key     = "dev/infrastructure.tfstate"
    profile = "default"
    region  = "eu-west-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

##### Give Provider Credentials
provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}
