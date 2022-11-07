# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- feature: set creation of dns records to be optional and only be created if method of validation == DNS and create route53 record == true
- feature: Add validation example with external dns provider
- feature: Add email validation example

## [1.0.0] - 2022-11-03
### Description
- feature: create an acm certificate
- feature: validate certificate has been issued
- feature: deploy the required validation records using route53

## [0.1.0] - 2022-11-01
### Description
- feature: Initial module release

[Unreleased]: https://github.com/boldlink/terraform-aws-acm/compare/1.0.0...HEAD
[1.0.0]: https://github.com/boldlink/terraform-aws-acm/releases/tag/1.0.0
[0.1.0]: https://github.com/boldlink/terraform-aws-acm/releases/tag/0.1.0