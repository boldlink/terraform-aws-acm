module "route53" {
  source  = "boldlink/route53/aws"
  version = "1.0.1"
  name    = local.name
}

module "acm_complete" {
  source            = "./../../"
  domain_name       = local.name
  validation_method = "DNS"
  wait_for_issue    = false
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform"
  }
  depends_on = [
    module.route53
  ]
}
