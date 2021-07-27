terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0277b52859bac6f4b"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.asg_m.id]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

resource "aws_security_group" "asg_m" {
  name = "terraform-example-instance"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}