variable "lambda_name" {
  type=string
}
variable "aws_iam_role_name" {
  type=string
}
variable "dynamo_lambda_actions" {
  type=string
}
variable "runtime" {
  type=string
}
variable "aws_iam_dynamo_policy" {
  type=string
}
variable "policy_dynamodb_lambda" {
  type = string
}