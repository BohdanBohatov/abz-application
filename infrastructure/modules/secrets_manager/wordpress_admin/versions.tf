terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.8"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}