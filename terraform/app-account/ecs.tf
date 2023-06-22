resource "aws_ecs_account_setting_default" "vpc_trunking" {
   name = "awsvpcTrunking" 
   value = "enabled"
}
