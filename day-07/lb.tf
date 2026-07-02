resource "aws_lb_target_group" "home" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.project}-TG-HOME"
    env  = var.env
  }
}

resource "aws_lb_target_group" "mobile" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.project}-TG-mobile"
    env  = var.env
  }
  health_check {
    path = "/mobile"
  }
}

resource "aws_lb_target_group" "cloth" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.project}-TG-cloth"
    env  = var.env
  }
  health_check {
    path = "/cloth"
  }
}

resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB-sg.id]
  subnets            = var.subnet

  enable_deletion_protection = true

  tags = {
    env = var.env
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.home.arn
  }
}

resource "aws_lb_listener_rule" "mobile" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mobile.arn
  }

  condition {
    path_pattern {
      values = ["/mobile/*"]
    }
  }

}

resource "aws_lb_listener_rule" "cloth" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloth.arn
  }

  condition {
    path_pattern {
      values = ["/cloth/*"]
    }
  }

}

resource "aws_security_group" "ALB-sg" {
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
}