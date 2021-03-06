# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.2
# creates target groups & attachments for load balancing
# ---------------------------------------------------------------------------------------------------

# req:
# 1a-vpc.tf            - module.my-vpc.vpc_id
# 2a-ec2-choose-ami.tf - aws_instance.my-server[count.index].id
# 9b-random-string.tf  - random_string.my-random-string.result
# main.tf              - local.instance-count (used by other modules)
# variables.tf         - var.my-project-name
# variables.tf         - var.my-environment


resource "aws_lb_target_group" "my-lb-target-group" {
  name                  = "my-lb-target-group"
  port                  = 8080
  protocol              = "HTTP"
  vpc_id                = module.my-vpc.vpc_id

  tags                  = {
    Name                = "my-lb-target-group-${random_string.my-random-string.result}"
    Terraform           = "true"
    Project             = var.my-project-name
    Environment         = var.my-environment
  }
}


resource "aws_lb_target_group_attachment" "my-lb-attachment" {
  count                 = local.instance-count
  target_group_arn      = aws_lb_target_group.my-lb-target-group.arn
  target_id             = aws_instance.my-server[count.index].id

# port                  = 80
}
