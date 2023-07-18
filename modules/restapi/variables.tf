variable "name_api" {
  type=string
  description = "Nmae of this API"
}
variable "authorization" {
  type=string
}
variable "http_method" {
  type=string
}
variable "integration_http_method" {
  type=string
}
variable "type_integration" {
  type=string
}
variable "stage_name" {
  type=string
}

variable "name_api_gateway" {
  type=string
}
variable "lambda_name" {
  type=string
}
variable "integration_uri" {
  type=string
}