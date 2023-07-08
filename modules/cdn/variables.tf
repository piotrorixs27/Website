variable "http_port" {
  type=number
}
variable "https_port" {
  type=number
}
variable "origin_keepalive_timeout" {
  type = number
}
variable "origin_protocol_policy" {
  type = string
}
variable "origin_read_timeout" {
  type=number
}
variable "origin_ssl_protocols" {
  type=string
}
variable "enabled_cdn" {
  type=bool
}
variable "is_ipv6_enabled_cdn" {
  type=bool
}
variable "comment_cdn" {
  type=string
}
