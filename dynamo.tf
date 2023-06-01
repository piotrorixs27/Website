resource "aws_dynamodb_table" "DynamoDb_Base" {
  name         = "DynamoDb_Base"
  billing_mode = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key     = "waluta"
  attribute {
    name = "waluta"
    type = "S"
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