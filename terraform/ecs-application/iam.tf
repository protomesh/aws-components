data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:ecs:*:${data.aws_caller_identity.current.account_id}:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }

}

module "task_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.0"

  create_policy = true

  name = "${local.base_name}-ecs-task"
  path = "/terraform/"
  policy = jsonencode(var.task_iam_policy)

  tags = local.tags

}

module "task_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.0"

  create_role = true

  custom_role_trust_policy = data.aws_iam_policy_document.trust_policy.json

  max_session_duration = 3600
  role_path            = "/terraform/"

  custom_role_policy_arns = [module.task_iam_policy.arn]

  role_name         = "${local.base_name}-ecs-task"
  role_requires_mfa = false

  tags = local.tags
}
