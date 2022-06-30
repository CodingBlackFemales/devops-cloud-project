provider "aws" {
  region  = "eu-west-2"
}
resource "aws_instance" "docker" {
  ami           = "ami-0fb391cce7a602d1f"
  instance_type = "t2.micro"
  key_name = "web-server-key-pair"
  user_data = templatefile("docker_script.tpl", {
  })
  tags = {
    Name = "docker-server-tf"
  }
}

resource "aws_security_group" "docker_sg" {
  name        = "docker-sg-tf"
  description = "Allow SSH, HTTP inbound traffic"
  vpc_id = "vpc-0e85b8ba6b6fa0dc1"
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["77.96.152.181/32"]
  }
  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "HTTP for Jenkins access from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP for Docker access from VPC"
    from_port        = 2375
    to_port          = 2375
    protocol         = "tcp"
    cidr_blocks      = ["77.96.152.181/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "docker-sg-tf"
  }
}