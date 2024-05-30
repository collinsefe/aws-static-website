# #------------------------------------------------------------------------------
# # CloudFront Origin Access Identity
# #------------------------------------------------------------------------------

# resource "aws_cloudfront_origin_access_identity" "cf_oai" {
#   provider = aws.main

#   comment = "OAI to restrict access to AWS S3 content"
# }


#-------------------------------------------------------------------------
# Website S3 Bucket
#------------------------------------------------------------------------------

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "website" {
  bucket        = "my-new-local-hkgdlysdclhbashj-09"
  force_destroy = true

}

