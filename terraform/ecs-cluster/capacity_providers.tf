module "capacity_providers" {
  source = "../ecs-capacity-provider"

  for_each = var.capacity_providers

  name = each.key

  cluster_name = var.name
  tags         = local.tags

  create_security_group   = lookup(each.value["autoscaling_group"], "create_security_group", [])
  security_group_ids      = lookup(each.value["autoscaling_group"], "security_group_ids", [])
  instance_type           = lookup(each.value["autoscaling_group"], "instance_type", "t3.micro")
  image_id                = lookup(each.value["autoscaling_group"], "image_id", null)
  root_volume_size_gb     = lookup(each.value["autoscaling_group"], "root_volume_size_gb", 30)
  min_size                = lookup(each.value["autoscaling_group"], "min_size", 1)
  max_size                = lookup(each.value["autoscaling_group"], "max_size", 2)
  desired_capacity        = lookup(each.value["autoscaling_group"], "desired_capacity", 1)
  ssh_key_name            = lookup(each.value["autoscaling_group"], "ssh_key_name", null)
  egress_with_cidr_blocks = lookup(each.value["autoscaling_group"], "egress_with_cidr_blocks", [])

  app_account = var.app_account

}
