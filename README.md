[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-acm/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-acm.svg)](https://github.com/boldlink/terraform-aws-acm/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-acm/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-acm/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-acm/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-acm/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-acm/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-acm/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-acm/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-acm/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-acm/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-acm/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-acm/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-acm/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS ACM Terraform module

## Description

Terraform module which creates an acm certificate, Route53 record and acm certificate validation resource.

### Features in this module
Creates an acm certificate
deploys the required validation records using route53
validates whether certificate has been issued

### Why use this module
This module supports automatic record validation using Route53 DNS.
Additionally, this module as well as other Boldlink modules are created following AWS security best practices highlighted by checkov scans on the modules.


*NOTE*: certificate validation is only successful when the domain is registered in aws and is inside the account this stack is being deployed. To validate a certificate for a domain managed outside aws, create a record similar to the one displayed in the output section where your domain is registered, e.g Godaddy/cloudflare.

Examples available [`here`](github.com/boldlink/terraform-aws-acm/tree/main/examples)

## Usage
*NOTE*: These examples use the latest version of this module

```console
module "route53" {
  source  = "boldlink/route53/aws"
  version = "1.0.1"
  name    = local.name
}

module "acm_minimum" {
  source            = "boldlink/acm/aws"
  domain_name       = local.name
  validation_method = "DNS"
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform"
  }
  depends_on = [
    module.route53
  ]
}

locals {
  name = "minimumexampledomain.com"
}

```
## Documentation

[AWS Documentation](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)

[Terraform module documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | (Optional) Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments. | `bool` | `true` | no |
| <a name="input_certificate_transparency_logging_preference"></a> [certificate\_transparency\_logging\_preference](#input\_certificate\_transparency\_logging\_preference) | (Optional) Whether certificate details should be added to a certificate transparency log. Valid values are ENABLED or DISABLED | `string` | `"ENABLED"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | (Required) Domain name for which the certificate should be issued | `string` | n/a | yes |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | (Optional) Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The TTL of the record. | `number` | `60` | no |
| <a name="input_validation_method"></a> [validation\_method](#input\_validation\_method) | (Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform. | `string` | n/a | yes |
| <a name="input_validation_option"></a> [validation\_option](#input\_validation\_option) | (Optional) Configuration block used to specify information about the initial validation of each domain name. | `any` | `{}` | no |
| <a name="input_wait_for_issue"></a> [wait\_for\_issue](#input\_wait\_for\_issue) | Whether to wait for the certificate to be issued by ACM | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the certificate |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Domain name for which the certificate is issued |
| <a name="output_domain_validation_options"></a> [domain\_validation\_options](#output\_domain\_validation\_options) | Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g., if SANs are defined. Only set if DNS-validation was used. |
| <a name="output_id"></a> [id](#output\_id) | ARN of the certificate |
| <a name="output_not_after"></a> [not\_after](#output\_not\_after) | Expiration date and time of the certificate. |
| <a name="output_not_before"></a> [not\_before](#output\_not\_before) | Expiration date and time of the certificate. |
| <a name="output_pending_renewal"></a> [pending\_renewal](#output\_pending\_renewal) | true if a Private certificate eligible for managed renewal is within the early\_renewal\_duration period. |
| <a name="output_record_fqdn"></a> [record\_fqdn](#output\_record\_fqdn) | FQDN built using the zone domain and name. |
| <a name="output_renewal_eligibility"></a> [renewal\_eligibility](#output\_renewal\_eligibility) | Whether the certificate is eligible for managed renewal. |
| <a name="output_renewal_summary"></a> [renewal\_summary](#output\_renewal\_summary) | Contains information about the status of ACM's managed renewal for the certificate. |
| <a name="output_status"></a> [status](#output\_status) | Status of the certificate. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_type"></a> [type](#output\_type) | Source of the certificate. |
| <a name="output_validation_emails"></a> [validation\_emails](#output\_validation\_emails) | List of addresses that received a validation email. Only set if EMAIL validation was used. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Supporting resources:

The example stacks are used by BOLDLink developers to validate the modules by building an actual stack on AWS.

Some of the modules have dependencies on other modules (ex. Ec2 instance depends on the VPC module) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

Resources on the `tests/supportingResources` folder are not intended for demo or actual implementation purposes, and can be used for reference.

### Makefile
The makefile contain in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```


#### BOLDLink-SIG 2022
