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
  validation {
  condition = var.block_public_acls==true || var.block_public_acls==false
  error_message = "This is wrong mode. S3 will block public access permissions applied to newly added buckets or objects, and prevent the creation of new public access ACLs for existing buckets and objects. "
}
}
variable "block_public_policy" {
  type = bool
    validation {
  condition = var.block_public_policy==true || var.block_public_policy==false
  error_message = "This is wrong mode. S3 will block new bucket and access point policies that grant public access to buckets and objects. This setting doesn't change any existing policies that allow public access to S3 resources."
}
    }
variable "ignore_public_acls" {
  type = bool
  validation {
  condition = var.ignore_public_acls==true || var.ignore_public_acls==false
  error_message = "This is wrong mode. S3 will ignore all ACLs that grant public access to buckets and objects."
}
}
variable "restrict_public_buckets" {
  type = bool
  validation {
  condition = var.restrict_public_buckets==true || var.restrict_public_buckets==false
  error_message = "This is wrong mode. ."
}
}
