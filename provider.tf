terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.0"
    }
  }

####### INTENTIONALLY COMMENTING IT SO IT WILL NOT FAIL BECAUSE OF ACCESS ISSUES YO BUCKET *******

#   backend "s3" {
#     bucket = "tes44433355"
#     key    = var.key
#     region = var.region
#     profile = var.profile
#   }

}

provider "aws" {
  region = "us-east-1"
}