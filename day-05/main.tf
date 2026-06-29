
resource "aws_launch_template" "LT_Home" {
  name = "LT-Home"
  image_id = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = base64encode(<<-EOF 
                #!/bin/bash
                apt update 
                apt install nginx -y
                echo "<h1> WElcome to Home Page </h1>" >/var/www/html/index.html
                systemctl start nginx
                EOF
                )
    tags = {
      env = var.env
    }
}

resource "aws_security_group" "my_sg" {
  vpc_id = var.vpc_id
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
    to_port = 0
    from_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_launch_template" "LT_Mobile" {
  name = "LT-Mobile"
  image_id = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = base64encode(<<-EOF 
                #!/bin/bash
                apt update 
                apt install nginx -y
                mkdir -p /var/www/html/mobile
                echo "<h1> WElcome to Mobile Page </h1>" >/var/www/html/mobile/index.html
                systemctl start nginx
                EOF
                )
    tags = {
      env = var.env
    }
}

resource "aws_launch_template" "LT_Cloth" {
  name = "LT-Cloth"
  image_id = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = base64encode(<<-EOF 
                #!/bin/bash
                apt update 
                apt install nginx -y
                mkdir -p /var/www/html/cloth
                echo "<h1> WElcome to Cloth Page </h1>" >/var/www/html/cloth/index.html
                systemctl start nginx
                EOF
                )
    tags = {
      env = var.env
    }
}

resource "aws_autoscaling_group" "home_asg" {
  name = "home-asg"
  desired_capacity = 2
  min_size = 1
  max_size = 3
  launch_template {
    id = aws_launch_template.LT_Home.id
  }
  availability_zones = var.availability_zones
}

resource "aws_autoscaling_group" "mobile_asg" {
  name = "mobile-asg"
  desired_capacity = 2
  min_size = 1
  max_size = 3
  launch_template {
    id = aws_launch_template.LT_Mobile.id
  }
  availability_zones = var.availability_zones
}

resource "aws_autoscaling_group" "cloth_asg" {
  name = "cloth-asg"
  desired_capacity = 2
  min_size = 1
  max_size = 3
  launch_template {
    id = aws_launch_template.LT_Cloth.id
  }
  availability_zones = var.availability_zones
}