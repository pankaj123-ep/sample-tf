/*terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}*/


terraform {
  cloud {
    organization = "voda12334"

    workspaces {
      name = "sample-tf"
    }
  }
}



# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
  #shared_credentials_files = "C:/Users/KumarP74/.aws/credentials"
  #profile ="terraform-training"
}
resource "aws_vpc" "pankaj-vpc" {
  cidr_block = "10.0.0.0/16"
}

module "s3-module" {
    source = "./S2-CREATE"
    bucket-name =var.bucket-name
    env = var.env


    
  }
  




resource "aws_subnet" "pankaj-subnet" {
  vpc_id     = aws_vpc.pankaj-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "pankaj-subnet"
  }
}



resource "aws_key_pair" "pankaj-21sep" {
  key_name   = "pankaj-21sepp"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCGzCc4nxT6vVWLqdaYcsAx3ii+v9Cd0Y9MhVW8N071rwP1w/FMCK3HGlMWxfC3aKpxiP3iMaMPHPH0RokjJ5+mhbofjxxshoHOFlwVlCTnHe9+fuGLHXVmK1hHwKLO3Kes/bF34r4+rYsylHkRcxnIVlqzn/ufD9iZV19siO2OAudm8uCvQZAF4TdWowtiTEOBnpA8CK0BO0OmTNEqIyvOrPuVEBqYXj9j2+p1vk2s/GiRquFRTm76zNqgBHcYC8b6repV3abaRWRHIT1vt46bb1DBmpM8+Zp9I54okdecs97hOCXThxMufRR7TsiY/grAHmUehKexkl8pMb+i7AGn rsa-key-20220921"
}
resource "aws_instance" "PankajDEMO" {
  ami           = var.amiid
  subnet_id = aws_subnet.pankaj-subnet.id
  instance_type = var.instance_type
  key_name = aws_key_pair.pankaj-21sep.id
  associate_public_ip_address =true
  tags = {
    Name = var.server_name
  }
}

output "IP" {
  value =aws_instance.PankajDEMO.public_ip
}

