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
      origin_ssl_protocols     = var.origin_ssl_protocols
    }
  }

  enabled         = var.enabled_cdn
  is_ipv6_enabled = var.is_ipv6_enabled_cdn
  comment         = var.comment_cdn

  default_cache_behavior {
    allowed_methods  = ["GET","HEAD"]
    cached_methods   = ["GET","HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = var.query_string

      cookies {
        forward = var.forward_cookies_cdn
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  price_class = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
    }
  }
}