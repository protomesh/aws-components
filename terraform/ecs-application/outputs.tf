output "nlb_dns_name" {
    value = length(module.nlb) > 0 ? module.nlb[0].lb_dns_name : null
    description = "NLB for DNS name"
}

output "task_role_arn" {
    value = module.task_role.iam_role_arn
    description = "Task role arn"
}

output "application_private_domain" {
    value = "${var.name}.${var.app_account.private_dns_zone}"
    description = "Domain for this service"
}
