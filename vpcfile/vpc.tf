#Provider for authentication
provider "aws" {
    region = var.region
}


# Terraform for S3 Backend
terraform {
    backend "s3" {
    bucket = "prod-terrraform.tfstate"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    }
}

#Data block for SG
data "aws_security_group" "server" {
    name = "default"
}

# resource block for server creation
resource "aws_instance" "server_1" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = var.tags
    vpc_security_group_ids = [data.aws_security_group.server.id]
}

#variable block calling all values
variable "region" {
    default = "ap-south-1"
    description = "region calling"
}

variable "ami" {
    default = "ami-0f7197c592205b389"
    description = "calling ami"
}

variable "instance_type" {
  default = "t2.micro"
  description = "calling instance type"
}

variable "key_name" {
    default = "windows_global_key"
    description = "calling key-pair"
}

variable "tags" {
    type = map
    default = {
    Name = "Development-server"
    Enviorment = "staging"
    Owner = "jarvis"
    }
}

output "test" {
    value = data.aws_security_group.server.id
}
