provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""

}

resource "aws_instance" "my_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    env = var.env
  }
}

resource "aws_security_group" "my_sg" {
  name   = "my-sg"
  vpc_id = var.vpc_id
  ingress {
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    env = var.env
  }
}

