resource "aws_ecs_task_definition" "main" {
  family                   = local.base_name
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"

  task_role_arn      = module.task_role.iam_role_arn
  execution_role_arn = var.cluster.task_execution_role

  runtime_platform {
    cpu_architecture = "X86_64"
  }

  container_definitions = jsonencode([for k, v in var.container_definitions : merge(v, {
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
        "awslogs-region"        = data.aws_region.current.name
        "awslogs-stream-prefix" = "ecs"
        "mode"                  = "non-blocking"
      }
    }
  })])

  volume {
    name = "container-shared"
  }

  tags = local.tags
}
