#-------------------------------------------------------------------------
# Website S3 Bucket
#------------------------------------------------------------------------------

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "website" {
  bucket        = "ccoe-pipeline-test-start-of-project-02062024"
  force_destroy = true

}

