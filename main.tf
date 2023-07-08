provider "aws" {
  region = "eu-west-1"
}


module "s3_bucket"{
  source = "./modules/bucket"
  name_bucket="pioterwebsitebucket321"
  index_document="index.html"
  error_document="error.html"
  block_public_acls=true
  block_public_policy=false
  ignore_public_acls=true
   restrict_public_buckets = false
}

module "cdn" {
  source = "./modules/cdn"
  http_port                = 80
  https_port               = 443
  origin_keepalive_timeout = 5
  origin_protocol_policy   = "http-only"
  origin_read_timeout      = 30
  origin_ssl_protocols = ["TLSv1.2",]
  enabled         = true
  is_ipv6_enabled= false
  comment         = "My first CDN"
}