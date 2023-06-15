output "nlb_dns_name" {
    value = length(module.nlb) > 0 ? module.nlb[0].lb_dns_name : null
    description = "NLB for front-proxy DNS name"

}

output "task_role_arn" {
    value = module.task_role.iam_role_arn
    description = "Task role arn"
}