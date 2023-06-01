provider "aws" {
  region = "eu-west-1"
}
resource "aws_s3_bucket" "pioterwebsitebucket123" {
  bucket = "pioterwebsitebucket321"
  
 website {
    index_document = "index.html"
    error_document = "error.html"
 }

}
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.pioterwebsitebucket123.id

  block_public_acls       = true
  block_public_policy     =false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "my_origin_access_identity" {
  statement {
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.pioterwebsitebucket123.arn}/*"      
    ]
  }
}

resource "aws_s3_bucket_policy" "my_origin_access_identity" {
  bucket = aws_s3_bucket.pioterwebsitebucket123.id
  policy = data.aws_iam_policy_document.my_origin_access_identity.json
}
locals {
  types_metadata =jsondecode(file("${path.module}/types_metadata.json"))
}
resource "aws_s3_object" "pioterwebsitebucket123" {
  bucket   = aws_s3_bucket.pioterwebsitebucket123.id
  for_each = fileset("${path.module}/Websitepiotrwiton/", "**")
  key      = each.value
  source   = "${path.module}/Websitepiotrwiton/${each.value}"
  etag     = filemd5("${path.module}/Websitepiotrwiton/${each.value}")  
  content_type = lookup(local.types_metadata, regex("\\.[^.]+$", each.value), null)
}


