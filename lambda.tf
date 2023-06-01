data "archive_file" "zip" {
  type        = "zip"
  source_file = "function_lambda_terraform.py"
  output_path = "function_lambda_terraform.zip"
}
resource "aws_lambda_function" "lambda" {
  function_name = "function_lambda_terraform"
  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"
  role          = aws_iam_role.iam_for_lambda.arn
  runtime          = "python3.9"
  handler          = "function_lambda_terraform.lambda_handler"
}

resource "aws_iam_role" "iam_for_lambda" {
 name = "iam_for_lambda"

 assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
data "aws_iam_policy_document" "dynamodb-lambda-policy" {
  statement {
    actions   = ["dynamodb:getitem"]
    resources = ["${aws_dynamodb_table.DynamoDb_Base.arn}",
          "${aws_dynamodb_table.DynamoDb_Base.arn}/*"]
  }
}
resource "aws_iam_policy" "dynamodb_policy" {
    name = "dynamodb_lambda_policy"
  policy = "${data.aws_iam_policy_document.dynamodb-lambda-policy.json}"
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}