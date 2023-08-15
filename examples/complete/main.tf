module "route53" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
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
