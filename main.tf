terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}


resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"

  # First Inbound rule (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH from anywhere. Use a specific IP for security.
    ipv6_cidr_blocks    = ["::/0"]
  }

  # Second Inbound rule (port 5173)
  ingress {
    from_port   = 5173
    to_port     = 5173
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP from anywhere
    ipv6_cidr_blocks    = ["::/0"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0b45ae66668865cd6"  
  instance_type = "t2.micro"
  key_name      = "newkey"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  tags = {
    Name = "frontend"
  }
}

# Output the public IP of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}
