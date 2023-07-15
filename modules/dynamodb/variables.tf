variable "dynamodb_name" {
  type=string
}
variable "billing_mode" {
  type = string
}
variable "write_capacity" {
  type = number
}
variable "read_capacity" {
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