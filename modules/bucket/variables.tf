variable "name_bucket" {
  type = string
}
variable "index_document" {
  type = string
}
variable "error_document" {

}
variable "block_public_acls" {
  type = bool
}
variable "block_public_policy" {
  type = bool
}
variable "ignore_public_acls" {
  type = bool
}
variable "restrict_public_buckets" {
  type = bool
}
