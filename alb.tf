resource "aws_alb" "main" {
  name            = "${var.project_name}-load-balancer"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "app" {
  name        = "${var.project_name}-target-group"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    interval = "30"
    protocol = "HTTP"
    timeout  = "3"
    path     = var.health_check_path

    # the following expects your app to redirect 
    # to https via a 301 response, change to 200
    # if you really want your app to respond 
    # insecurely
    matcher  = "301"
  }
}

resource "aws_alb_listener" "app_lb_https" {
  load_balancer_arn = aws_alb.main.id

  certificate_arn   = aws_acm_certificate_validation.cert.certificate_arn
  port              = "443"
  protocol          = "HTTPS"
  
  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

resource "aws_alb_listener" "app_lb_http" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}