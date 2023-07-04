provider "aws" {
  region = "eu-west-1"
}


module "s3_bucket"{
  name_bucket="pioterwebsitebucket321"
  index_document="index.html"
  error_document="error.html"
  block_public_acls=true
  block_public_policy=false
  ignore_public_acls=true
   restrict_public_buckets = false
}

