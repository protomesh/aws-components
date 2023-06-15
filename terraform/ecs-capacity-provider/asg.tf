resource "aws_placement_group" "placement_group" {
  strategy     = "spread"
  name         = local.base_name
  spread_level = "rack"
}

data "aws_ssm_parameter" "recommended_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
}

locals {
  image_id = var.image_id == null ? jsondecode(data.aws_ssm_parameter.recommended_ami.value)["image_id"] : var.image_id
}


module "asg_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.0"

  name = "${local.base_name}-ecs"
  path = "/terraform/"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        "Resource" : [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })

  tags = local.tags
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 6.5"
  name    = local.base_name

  ignore_desired_capacity_changes = true

  key_name = var.ssh_key_name

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"

  vpc_zone_identifier = var.application_account.private_subnet_ids

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  autoscaling_group_tags = {
    AmazonECSManaged = true
  }

  launch_template_name   = local.base_name
  update_default_version = true
  user_data              = base64encode(templatefile("${path.module}/templates/user_data.sh", { cluster_name : var.cluster_name }))
  image_id               = local.image_id
  instance_type          = var.instance_type
  ebs_optimized          = true
  enable_monitoring      = true

  # IAM role & instance profile
  create_iam_instance_profile = true

  iam_role_path = "/terraform/"
  iam_role_tags = local.tags

  iam_role_policies = {
    AmazonEC2ContainerServiceforEC2Role = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    AmazonSSMManagedInstanceCore        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ECSCapacityProviderPolicy           = module.asg_policy.arn
  }

  iam_role_name = "${local.base_name}-ecs"

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.root_volume_size_gb
        volume_type           = "gp2"
      }
    },
  ]

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 32
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = concat(var.security_group_ids != null ? var.security_group_ids : [], var.create_security_group ? [module.security_group[0].security_group_id] : [])
    },
  ]

  placement_group = aws_placement_group.placement_group.name

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = merge({ resource_type = "instance" }, local.tags)
    },
    {
      resource_type = "volume"
      tags          = merge({ resource_type = "volume" }, local.tags)
    }
  ]

  tags = local.tags
}
