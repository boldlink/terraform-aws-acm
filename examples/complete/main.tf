module "route53" {
  source  = "boldlink/route53/aws"
  version = "1.0.1"
  name    = local.name
}

module "acm_complete" {
  source            = "../../"
  domain_name       = local.name
  validation_method = "DNS"
  wait_for_issue    = false

  # Additional arguments from the main configuration
  subject_alternative_names = ["www.${local.name}", "app.${local.name}"]
  validation_option = [
    {
      domain_name       = "www.${local.name}"
      validation_domain = local.name
    },
    {
      domain_name       = "app.${local.name}"
      validation_domain = local.name
    }
  ]
  certificate_transparency_logging_preference = "ENABLED"
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform"
  }
  allow_overwrite = true
  ttl             = 300

  depends_on = [
    module.route53
  ]
}
