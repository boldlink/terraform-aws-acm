module "acm_complete" {
  source            = "./../../"
  domain_name       = "exampledomain.com"
  validation_method = "DNS"
  wait_for_issue    = true
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform"
  }
}
