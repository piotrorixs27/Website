variable "http_port" {
  type = number
}
variable "https_port" {
  type = number
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
variable "allowed_methods" {
  type = string
}
variable "cached_methods" {
  type = string
}
variable "query_string" {
  type = bool
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
}
variable "cloudfront_default_certificate" {
  type = bool
}
variable "restriction_type" {
  type = string
}
variable "origin_ssl_protocols" {
  
}