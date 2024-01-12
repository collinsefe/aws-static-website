
#-------------------------------------------------------------------------
# Website S3 Bucket
#------------------------------------------------------------------------------

resource "aws_kms_key" "mykey" {
  provider                = aws.main
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "website" {
  provider = aws.main

  bucket        = local.website_bucket_name
  force_destroy = var.website_bucket_force_destroy

  tags = merge({
    Name = "${var.name_prefix}-website"
  }, var.tags)
}

locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".ico"  = "image/vnd.microsoft.icon"
    ".jpeg" = "image/jpeg"
    ".png"  = "image/png"
    ".svg"  = "image/svg+xml"
  }
}

resource "aws_s3_object" "website" {
  provider     = aws.main
  bucket       = aws_s3_bucket.website.id
  for_each     = fileset("..//..//s3_bucket_files/", "*")
  key          = each.value
  source       = "..//..//s3_bucket_files/${each.value}"
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null) #https://engineering.statefarm.com/blog/terraform-s3-upload-with-mime/
  source_hash  = filemd5("..//..//s3_bucket_files/${each.value}")
}



resource "aws_s3_bucket_versioning" "website" {
  provider = aws.main

  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status     = var.website_versioning_status
    mfa_delete = var.website_versioning_mfa_delete
  }
}

resource "aws_s3_bucket_logging" "website" {
  provider = aws.main

  bucket        = aws_s3_bucket.website.id
  target_bucket = module.s3_logs_bucket.s3_bucket_id
  target_prefix = "website/"
}

resource "aws_s3_bucket_acl" "website" {
  provider = aws.main

  bucket = aws_s3_bucket.website.id
  acl    = var.website_bucket_acl
}

resource "aws_s3_bucket_policy" "website" {
  provider = aws.main

  bucket = aws_s3_bucket.website.id
  policy = templatefile("${path.module}/templates/s3_website_bucket_policy.json", {
    bucket_name = local.website_bucket_name
    cf_oai_arn  = aws_cloudfront_origin_access_identity.cf_oai.iam_arn
  })
}

resource "aws_s3_bucket_public_access_block" "website_bucket_public_access_block" {
  provider = aws.main

  bucket                  = aws_s3_bucket.website.id
  ignore_public_acls      = true
  block_public_acls       = true
  restrict_public_buckets = true
  block_public_policy     = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  provider = aws.main
  bucket   = aws_s3_bucket.website.id

  rule {
    apply_server_side_encryption_by_default {

      #kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "AES256"

    }
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "website_bucket_website_server_side_encryption_configuration" {
  provider = aws.main
  count    = length(keys(var.website_server_side_encryption_configuration)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.website.id

  dynamic "rule" {
    for_each = try(flatten([var.website_server_side_encryption_configuration["rule"]]), [])

    content {
      bucket_key_enabled = try(rule.value.bucket_key_enabled, null)

      dynamic "apply_server_side_encryption_by_default" {
        for_each = try([rule.value.apply_server_side_encryption_by_default], [])

        content {
          #kms_master_key_id = aws_kms_key.mykey.arn
          #sse_algorithm     = "aws:kms"
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
          #kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
        }
      }
    } 
  }
}

