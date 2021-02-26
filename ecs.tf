resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

data "template_file" "container_defintions_json" {
  template = file("./container_defintions.json.tpl")

  vars = {
    project_name          = var.project_name
    app_image             = var.app_image
    app_port              = var.app_port
    container_port        = var.container_port
    fargate_cpu           = var.fargate_cpu
    fargate_memory        = var.fargate_memory
    aws_region            = var.aws_region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.container_defintions_json.rendered
}

resource "aws_ecs_service" "main" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "${var.project_name}-app"
    container_port   = var.container_port
  }

  depends_on = [aws_alb_listener.app_lb_http, aws_alb_listener.app_lb_https, aws_iam_role_policy_attachment.ecs_task_execution_role]
}