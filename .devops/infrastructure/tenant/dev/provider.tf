##### Define Terraform State Backend and Must Providers
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.5.0"
    }
  }
}

##### Give Provider Credentials
provider "aws" {
  #profile = "default"
  region  = "us-east-1"
}
