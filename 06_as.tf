resource "aws_ami_from_instance" "ryujy_ami" {
  name               = "${var.name}-aws-ami"
  source_instance_id = aws_instance.ryujy_weba.id

  depends_on = [
    aws_instance.ryujy_weba
  ]

  tags = {
    "Name" = "${var.name}-ami"
  }
}

resource "aws_launch_configuration" "ryujy_aslc" {
  name_prefix = "${var.name}-web-"
  image_id = aws_ami_from_instance.ryujy_ami.id
  instance_type = var.instance
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.ryujy_sg.id]
  key_name = var.key
#   user_data = file("./install.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_placement_group" "ryujy_place" {
  name = "${var.name}-place"
  strategy = var.strategy
}

resource "aws_autoscaling_group" "ryujy_asg" {
  name = "${var.name}-asg"
  min_size = 2
  max_size = 10
  health_check_grace_period = 10
  health_check_type = "EC2"
  desired_capacity = 2
  force_delete = true
  launch_configuration = aws_launch_configuration.ryujy_aslc.name
  vpc_zone_identifier = aws_subnet.ryujy_pub[*].id
  
}

resource "aws_autoscaling_attachment" "ryujy_asgalbatt" {
  autoscaling_group_name = aws_autoscaling_group.ryujy_asg.id
  alb_target_group_arn = aws_lb_target_group.ryujy_albtg.arn
}