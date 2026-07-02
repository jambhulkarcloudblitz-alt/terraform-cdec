resource "aws_launch_template" "LT_home" {
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = base64encode(<<-EOF
  #!/bin/bash
  apt update
  apt install nginx -y
  echo "<h1> Welcome to Home Page </h1>" >/var/www/html/index.html
  systemctl start nginx
  EOF
  )
  tags = {
    Name = "${var.project}-LT-Home"
    env  = var.env
  }
}

resource "aws_launch_template" "LT_Mobile" {
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = base64encode(<<-EOF
  #!/bin/bash
  apt update
  apt install nginx -y
  mkdir -p /var/www/html/mobile
  echo "<h1> Welcome to mobile Page </h1>" >/var/www/html/mobile/index.html
  systemctl start nginx
  EOF
  )
  tags = {
    Name = "${var.project}-LT-mobile"
    env  = var.env
  }
}

resource "aws_launch_template" "LT_cloth" {
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = base64encode(<<-EOF
  #!/bin/bash
  apt update
  apt install nginx -y
  mkdir -p /var/www/html/cloth
  echo "<h1> Welcome to cloth Page </h1>" >/var/www/html/cloth/index.html
  systemctl start nginx
  EOF
  )
  tags = {
    Name = "${var.project}-LT-cloth"
    env  = var.env
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

resource "aws_autoscaling_group" "asg_home" {
  name               = "ASG-HOME"
  desired_capacity   = 2
  min_size           = 1
  max_size           = 3
  availability_zones = var.availability_zones
  launch_template {
    id = aws_launch_template.LT_home.id
  }
  target_group_arns = [aws_lb_target_group.home.arn]
}

resource "aws_autoscaling_group" "asg_mobile" {
  name               = "ASG-MOBILE"
  desired_capacity   = 2
  min_size           = 1
  max_size           = 3
  availability_zones = var.availability_zones
  launch_template {
    id = aws_launch_template.LT_Mobile.id
  }
  target_group_arns = [aws_lb_target_group.mobile.arn]

}

resource "aws_autoscaling_group" "asg_cloth" {
  name               = "ASG-CLOTH"
  desired_capacity   = 2
  min_size           = 1
  max_size           = 3
  availability_zones = var.availability_zones
  launch_template {
    id = aws_launch_template.LT_cloth.id
  }
  target_group_arns = [aws_lb_target_group.cloth.arn]

}

resource "aws_autoscaling_policy" "home" {
  name                   = "asgp-home"
  autoscaling_group_name = aws_autoscaling_group.asg_home.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}

resource "aws_autoscaling_policy" "mobile" {
  name                   = "asgp-mobile"
  autoscaling_group_name = aws_autoscaling_group.asg_mobile.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}

resource "aws_autoscaling_policy" "cloth" {
  name                   = "asgp-cloth"
  autoscaling_group_name = aws_autoscaling_group.asg_cloth.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}