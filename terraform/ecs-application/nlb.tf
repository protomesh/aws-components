module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  count = var.enable_network_lb ? 1 : 0

  name = local.base_name

  load_balancer_type = "network"

  vpc_id  = var.app_account.vpc_id
  subnets = var.service.nlb_subnet_ids

  # Tem uma issue com o access log https://github.com/terraform-aws-modules/terraform-aws-alb#notes
  # access_logs = {
  #   bucket = "my-nlb-logs"
  # }

  target_groups = [
    {
      name_prefix        = "ecs-"
      backend_protocol   = "TCP"
      backend_port       = var.service.nlb_target_container_port
      target_type        = "ip"
      preserve_client_ip = true
      health_check = {
        enabled             = true
        interval            = 15
        protocol            = "HTTP"
        path                = "/healthz"
        port                = 8081
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 10
      }
    }
  ]

  target_group_tags = local.tags

  https_listeners = [
    {
      port               = 443
      protocol           = "TLS"
      certificate_arn    = var.app_account.sd_public_dns_certificate_arn
      target_group_index = 0
    }
  ]

  tags = local.tags
}
