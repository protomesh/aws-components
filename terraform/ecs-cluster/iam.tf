
module "task_execution_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.0"

  create_policy = true

  name = "${local.base_name}-task-exec"
  path = "/terraform/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        "Resource" : "*"
      }
    ]
  })

  tags = local.tags

}


module "task_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  create_role = true

  max_session_duration = 3600
  role_path            = "/terraform/"

  custom_role_policy_arns = [module.task_execution_iam_policy.arn]

  role_name         = "${local.base_name}-task-exec"
  role_requires_mfa = false

  tags = local.tags
}