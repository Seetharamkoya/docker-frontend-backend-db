provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  key_name      = "Docker-aws"
  vpc_security_group_ids = [
    aws_security_group.FE-BE.id
  ]

  tags = {
    Name = "FE-BE-instance"
  }
}

# Create a security group 
resource "aws_security_group" "FE-BE" {
  name = "FE-BE"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

