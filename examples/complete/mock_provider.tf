terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-state-01101960"
    key    = "work/demo/s3/website/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  alias                       = "main"
  region                      = "eu-west-2"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true


}

provider "aws" {
  alias                       = "acm_provider"
  region                      = "eu-west-2"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true


}
