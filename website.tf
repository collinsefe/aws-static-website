#-------------------------------------------------------------------------
# Website S3 Bucket
#------------------------------------------------------------------------------

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "website" {
  bucket        = "${var.project_name}-ccoe-09-"
  force_destroy = true

}

