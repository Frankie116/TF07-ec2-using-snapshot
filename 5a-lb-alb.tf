# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.2
# creates an application load balancer
# ---------------------------------------------------------------------------------------------------

# req:
# 1a-vpc.tf             - module.my-vpc.public_subnets
# 3a-security-groups.tf - [module.my-lb-sg.this_security_group_id]
# 7a-s3-bucket.tf       - aws_s3_bucket.my-s3-log-bucket.bucket
# 9b-random-string.tf   - random_string.my-random-string.result
# variables.tf          - var.my-project-name
# variables.tf          - var.my-environment


resource "aws_lb" "my-alb" {
  name                   = "my-alb"
  internal               = false
  load_balancer_type     = "application"
  security_groups        = [module.my-lb-sg.this_security_group_id]
  subnets                = module.my-vpc.public_subnets
  
  access_logs {
    bucket  = aws_s3_bucket.my-s3-log-bucket.bucket
    enabled = true
  }

  tags                   = {
    Name                 = "my-alb-${random_string.my-random-string.result}"
    Terraform            = "true"
    Project              = var.my-project-name
    Environment          = var.my-environment
  }
}











