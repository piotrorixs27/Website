resource "aws_dynamodb_table" "DynamoDb_Base" {
  name           = var.dynamodb_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  attribute {
    name = var.name_attribute_dynamodb
    type = var.type_attribute_dynamodb
  }
}
resource "aws_dynamodb_table_item" "DynamoDb_Base" {
  table_name = aws_dynamodb_table.DynamoDb_Base.name
  hash_key   = aws_dynamodb_table.DynamoDb_Base.hash_key

  item = <<ITEM
{
  "waluta": {"S": "eur"},
  "price": {"N": "13"}
}
ITEM
}