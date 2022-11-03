module "acm_minimum" {
  source            = "./../../"
  domain_name       = "exampledomain.com"
  validation_method = "DNS"
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform"
  }
}
