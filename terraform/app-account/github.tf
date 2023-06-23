module "iam_github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "~> 5.0"

  tags = var.tags
}

module "iam_github_oidc_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.0"

  name = "${var.name}-github-oidc"
  path = "/terraform/"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "ssm:*",
        "Resource" : [
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/${var.name}/*",
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : ["ssm:DescribeParameters"],
        "Resource" : [
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:*",
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : ["ecr:GetAuthorizationToken"],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })

  tags = var.tags
}

module "iam_github_oidc_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "~> 5.0"

  name = "${var.name}-github"

  max_session_duration = 3600
  path                 = "/terraform/"

  # This should be updated to suit your organization, repository, references/branches, etc: <GITHUB_ORG>/terraform-aws-iam:*
  # Example: ['my-org/my-repo:*', 'octo-org/octo-repo:ref:refs/heads/octo-branch']
  subjects = var.allowed_github_oidc_subjects

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    SSMAccess  = module.iam_github_oidc_policy.arn
  }

  depends_on = [
    module.iam_github_oidc_provider,
  ]

  tags = local.tags
}