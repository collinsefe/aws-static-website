#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# Log Bucket
#------------------------------------------------------------------------------
variable "log_bucket_versioning_status" {
  description = "(Optional) The versioning state of the bucket. Valid values: Enabled or Suspended. Defaults to Enabled"
  type        = string
  default     = "Enabled"
}

variable "log_bucket_versioning_mfa_delete" {
  description = "(Optional) Specifies whether MFA delete is enabled in the bucket versioning configuration. Valid values: Enabled or Disabled. Defaults to Disabled"
  type        = string
  default     = "Disabled"
}

variable "log_bucket_force_destroy" {
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the log bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = true
}

variable "aws_accounts_with_read_view_log_bucket" {
  description = "List of AWS accounts with read permissions to log bucket"
  type        = list(string)
  default     = []
}

#------------------------------------------------------------------------------
# Website
#------------------------------------------------------------------------------
variable "website_domain_name" {
  description = "The domain name to use for the website"
  type        = string
}

variable "website_bucket_acl" {
  description = "(Optional) The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private."
  type        = string
  default     = "private"
}

variable "website_bucket_force_destroy" {
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = true
}

variable "website_index_document" {
  description = "Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders.  Defaults to index.html"
  type        = string
  default     = "index.html"
}

variable "website_error_document" {
  description = "(Optional) An absolute path to the document to return in case of a 4XX error. Defaults to 404.html"
  type        = string
  default     = "errors.html"
}

variable "website_cors_allowed_headers" {
  description = "(Optional) Specifies which headers are allowed. Defaults to Authorization and Content-Length"
  type        = list(string)
  default     = ["Authorization", "Content-Length"]
}

variable "website_cors_allowed_methods" {
  description = "(Optional) Specifies which methods are allowed. Can be GET, PUT, POST, DELETE or HEAD. Defaults to GET and POST"
  type        = list(string)
  default     = ["GET", "POST"]
}

variable "website_cors_additional_allowed_origins" {
  description = "(Optional) Specifies which origins are allowed besides the domain name specified"
  type        = list(string)
  default     = []
}

variable "website_cors_expose_headers" {
  description = "(Optional) Specifies expose header in the response."
  type        = list(string)
  default     = []
}

variable "website_cors_max_age_seconds" {
  description = "(Optional) Specifies time in seconds that browser can cache the response for a preflight request. Defaults to 3600"
  type        = number
  default     = 3600
}

variable "website_versioning_status" {
  description = "(Optional) The versioning state of the bucket. Valid values: Enabled or Suspended. Defaults to Enabled"
  type        = string
  default     = "Enabled"
}

variable "website_versioning_mfa_delete" {
  description = "(Optional) Specifies whether MFA delete is enabled in the bucket versioning configuration. Valid values: Enabled or Disabled. Defaults to Disabled"
  type        = string
  default     = "Disabled"
}

variable "website_server_side_encryption_configuration" {
  description = "(Optional) Map containing server-side encryption configuration for the website bucket. Defaults to no encryption. See examples/complete/main.tf for configuration example."
  type        = any
  default     = {}
}

#------------------------------------------------------------------------------
# WWW Website for redirection to Website
#------------------------------------------------------------------------------
variable "www_website_redirect_enabled" {
  description = "(Optional) Whether to redirect www subdomain. Defaults to true."
  type        = bool
  default     = true
}

variable "www_website_bucket_acl" {
  description = "(Optional) The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private."
  type        = string
  default     = "private"
}

variable "www_website_bucket_force_destroy" {
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = true
}

variable "www_website_versioning_enabled" {
  description = "(Optional) Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket. Defaults to true"
  type        = bool
  default     = true
}

variable "www_website_versioning_mfa_delete" {
  description = "(Optional) Enable MFA delete for either change the versioning state of your bucket or permanently delete an object version. Default is false. This cannot be used to toggle this setting but is available to allow managed buckets to reflect the state in AWS."
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Route53
#------------------------------------------------------------------------------
variable "create_route53_hosted_zone" {
  description = "Enable or disable Route 53 hosted zone creation. If set to false, the variable route53_hosted_zone_id is required. Defaults to true"
  type        = bool
  default     = true
}

variable "route53_hosted_zone_id" {
  description = "The Route 53 hosted zone ID to use if create_route53_hosted_zone is false"
  type        = string
  default     = ""
}

variable "create_route53_website_records" {
  description = "Enable or disable creation of Route 53 records in the hosted zone. Defaults to true"
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# ACM Certificate
#------------------------------------------------------------------------------
variable "create_acm_certificate" {
  description = "Enable or disable automatic ACM certificate creation. If set to false, the variable acm_certificate_arn_to_use is required. Defaults to true"
  type        = bool
  default     = true
}

variable "acm_certificate_arn_to_use" {
  description = "ACM Certificate ARN to use in case you disable automatic certificate creation. Certificate must be in us-east-1 region."
  type        = string
  default     = ""
}
