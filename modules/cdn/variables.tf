variable "http_port" {
  type = number
  description = "Number of http port"
}
variable "https_port" {
  type = number
  description = "Number of https port"
}
variable "origin_keepalive_timeout" {
  type = number
}
variable "origin_protocol_policy" {
  type = string
}
variable "origin_read_timeout" {
  type = number
}

variable "enabled_cdn" {
  type = bool
}
variable "is_ipv6_enabled_cdn" {
  type = bool
}
variable "comment_cdn" {
  type = string
}
variable "domain_name" {
  type = string
}

variable "query_string" {
  type = bool
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
}
variable "forward_cookies_cdn" {
  type = string
}
variable "viewer_protocol_policy" {
  type = string
}
variable "min_ttl" {
  type = number
}
variable "default_ttl" {
  type = number
}
variable "max_ttl" {
  type = number
}
variable "price_class" {
  type = string
  validation{
    condition = var.price_class=="PriceClass_All" ||  var.price_class=="PriceClass_200" ||   var.price_class=="PriceClass_100"
    error_message = "This is wrong mode."
  }
}
variable "cloudfront_default_certificate" {
  type = bool
}
variable "restriction_type" {
  type = string
}
variable "origin_ssl_protocols" {
  description = "SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2."
}