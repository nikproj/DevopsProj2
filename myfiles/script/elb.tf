resource "aws_lb_target_group" "targetgroup" {
  name        = "devopsproj2-tg"
  port        = 30023
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main2.id
  health_check {
      healthy_threshold   = var.health_check["healthy_threshold"]
      interval            = var.health_check["interval"]
      unhealthy_threshold = var.health_check["unhealthy_threshold"]
      timeout             = var.health_check["timeout"]
      path                = var.health_check["path"]
      port                = var.health_check["port"]
  }
}

resource "aws_lb_target_group_attachment" "tg-attach-1" {
  target_group_arn = aws_lb_target_group.targetgroup.arn
  target_id        = aws_instance.server1.id 
  port             = 30023
}

resource "aws_lb_target_group_attachment" "tg-attach-2" {
  target_group_arn = aws_lb_target_group.targetgroup.arn
  target_id        = aws_instance.server2.id 
  port             = 30023
}

resource "aws_lb" "loadbalancer" {
  name               = "devopsproj3-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.kube_sg.id]
  subnets            = [aws_subnet.public2[0].id, aws_subnet.public2[1].id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "30023"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgroup.arn
  }
}