provider "aws" {
  region = "us-east-2"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "my_instanc" {
  ami = "ami-0e5497a77ef21b5ac"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    env = "dev"
  }
}

resource "aws_security_group" "my_sg" {
  name = "my-sg"
  vpc_id = "vpc-096675e275f26d967"
  ingress {
    protocol = "TCP"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol = "TCP"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    env = "dev"
  }
}

