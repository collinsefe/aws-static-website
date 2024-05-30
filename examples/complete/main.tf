module "demo_website" {
  source      = "../../"
  name_prefix = "demo"

  providers = {
    aws.main         = aws.main
    aws.acm_provider = aws.acm_provider
  }

  website_domain_name = "collinsorighose.com"

  create_acm_certificate = true

  create_route53_hosted_zone = false

  aws_accounts_with_read_view_log_bucket = ["905418009251"]

  website_server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  log_bucket_force_destroy = true
}
