resource "aws_instance" "my_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id = var.subnet_id
  tags = {
    Name = "${var.project}-my-instance"
    env = var.env
  }
}

resource "aws_security_group" "my_sg" {
  vpc_id = var.vpc_id
  ingress {
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "TCP"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project}-SGG"
    env  = var.env
  }
}