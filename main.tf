provider "aws" {
  region = "eu-west-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.63.0"
    }
  }
  required_version = "1.3.6"
}


module "s3_bucket" {
  source                  = "./modules/bucket"
  name_bucket             = "pioterwebsitebucket321"
  index_document          = "index.html"
  error_document          = "error.html"
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false

}

module "cdn" {
  source                         = "./modules/cdn"
  http_port                      = 80
  https_port                     = 443
  origin_keepalive_timeout       = 5
  origin_protocol_policy         = "http-only"
  origin_read_timeout            = 30
  origin_ssl_protocols     = ["TLSv1.2"]
  enabled_cdn                    = true
  is_ipv6_enabled_cdn            = false
  comment_cdn                    = "My first CDN"
  allowed_methods                = "HEAD"
  cached_methods                 = "HEAD"
  query_string                   = false
  forward_cookies_cdn            = "none"
  min_ttl                        = 0
  default_ttl                    = 3600
  max_ttl                        = 86400
  price_class                    = "PriceClass_All"
  cloudfront_default_certificate = true
  restriction_type               = "none"
  domain_name                    = module.s3_bucket.domain_name
  viewer_protocol_policy=  "https-only"
}
module "dynamodb" {

  source                  = "./modules/dynamodb"
  dynamodb_name           = "DynamoDb_Base"
  billing_mode            = "PROVISIONED"
  read_capacity           = 1
  write_capacity          = 1
  hash_key                = "waluta"
  name_attribute_dynamodb = "waluta"
  type_attribute_dynamodb = "S"
}
module "lambda" {
  source                = "./modules/lambda"
  lambda_name           = "function_lambda_terraform"
  aws_iam_role_name     = "iam_for_lambda"
  dynamo_lambda_actions = "dynamodb:getitem"
  aws_iam_dynamo_policy = "dynamodb_lambda_policy"
  runtime               = "python3.9"
  policy_dynamodb_lambda = module.dynamodb.name
}
module "restapi" {
  source                  = "./modules/restapi"
  name_api                = "api"
  authorization           = "NONE"
  integration_http_method = "POST"
  http_method           = "GET"
  type_integration        = "AWS_PROXY"
  stage_name              = "example"
  name_api_gateway        = "example-rest-api"
  lambda_name           = "function_lambda_terraform"
  integration_uri=module.lambda.integration_uri
}