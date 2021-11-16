resource "aws_lb" "ryujy_alb" {
  name = "${var.name}-alb"
  internal = false
  load_balancer_type = var.lb_type
  security_groups = [aws_security_group.ryujy_sg.id]
  subnets = aws_subnet.ryujy_pub[*].id

  tags = {
    "Name" = "${var.name}-alb"
  }
}

resource "aws_lb_target_group" "ryujy_albtg" {
  name     = "${var.name}-albtg"
  port     = var.http
  protocol = var.pro_http
  vpc_id   = aws_vpc.ryu.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200"
    path                = "/health.html"
    port                = "traffic-port"
    protocol            = var.pro_http
    timeout             = 2
    unhealthy_threshold = 2
  }
}

output "alb_dns" {
  value = aws_lb.ryujy_alb.dns_name
}


resource "aws_lb_listener" "ryujy_albli" {
  load_balancer_arn = aws_lb.ryujy_alb.arn
  port              = var.http
  protocol          = var.pro_http



  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ryujy_albtg.arn
  }
}

resource "aws_lb_target_group_attachment" "ryujy_tgatt" {
  target_group_arn = aws_lb_target_group.ryujy_albtg.arn
  target_id = aws_instance.ryujy_weba.id
  port = var.http
}