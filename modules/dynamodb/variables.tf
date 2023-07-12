variable "dynamodb" {
  type=string
}
variable "billing_mode" {
  type = number
}
variable "write_capacity" {
    type = number
}
variable "hash_key" {
  type = string
}
variable "name_attribute_dynamodb" {
  type = string
}
variable "type_attribute_dynamodb" {
  type = string
}