module "account_kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "~> 1.0"

  computed_aliases = {
    env = {
      name = var.name
    }
  }


  key_statements = [
    {
      sid = "CloudWatchLogs"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = ["*"]

      principals = [
        {
          type        = "Service"
          identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
        }
      ]

      conditions = [
        {
          test     = "ArnLike"
          variable = "kms:EncryptionContext:aws:logs:arn"
          values = [
            "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*",
          ]
        }
      ]
    }
  ]

  key_usage = "ENCRYPT_DECRYPT"

  key_owners         = []
  key_administrators = []
  key_users          = [module.iam_github_oidc_role.arn]

  tags = var.tags
}