locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = local.s3_origin_id

    custom_origin_config {
      http_port                = var.http_port
      https_port               = var.https_port
      origin_keepalive_timeout = var.origin_keepalive_timeout
      origin_protocol_policy   = var.origin_protocol_policy
      origin_read_timeout      = var.origin_read_timeout
      origin_ssl_protocols = var.origin_ssl_protocols
    }
  }

  enabled         =var.enabled_cdn
  is_ipv6_enabled = var.is_ipv6_enabled_cdn
  comment         = var.comment_cdn

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}