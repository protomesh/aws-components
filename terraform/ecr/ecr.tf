locals {
  repository_read_write_access_arns = [
    var.application_account.iam_github_oidc_role_arn,
    "arn:aws:iam::${local.current_account}:role/OrganizationAccountAccessRole"
  ]
}

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.0"

  count = var.use_public_repository == null && var.use_repository == null ? 1 : 0

  repository_name = local.base_name

  repository_read_write_access_arns = concat(local.repository_read_write_access_arns, var.repository_read_write_access_arns)
  repository_read_access_arns       = [var.cluster.task_execution_role]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 15 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v", "commit"],
          countType     = "imageCountMoreThan",
          countNumber   = 15
        },
        action = {
          type = "expire"
        }
      },
    ]
  })

  repository_force_delete = var.force_delete

  tags = local.tags

}


data "aws_ecr_repository" "ecr" {
  count = var.use_public_repository != null || var.use_repository == null ? 0 : 1
  name  = var.use_repository
}

locals {

  image_repository = var.use_public_repository != null ? {
    repository_url  = var.use_public_repository
    repository_arn  = null
    repository_name = null
  } : var.use_repository == null ? {
    repository_url  = module.ecr[0].repository_url
    repository_arn  = module.ecr[0].repository_arn
    repository_name = local.base_name
  } : {
    repository_url  = data.aws_ecr_repository.ecr[0].repository_url
    repository_arn  = data.aws_ecr_repository.ecr[0].arn
    repository_name = var.use_repository
  }

}
