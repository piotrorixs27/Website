data "archive_file" "zip" {
  type        = "zip"
  source_file = "${var.lambda_name}.py"
  output_path = "${var.lambda_name}.zip"
}
resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_name
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role             = aws_iam_role.iam_for_lambda.arn
  runtime          = var.runtime
  handler          = "${var.lambda_name}.lambda_handler"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = var.aws_iam_role_name

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
    actions = [var.dynamo_lambda_actions]
    resources = [var.policy_dynamodb_lambda,var.policy_dynamodb_lambda]
  }
}
resource "aws_iam_policy" "dynamodb_policy" {
  name   = var.aws_iam_dynamo_policy
  policy = data.aws_iam_policy_document.dynamodb-lambda-policy.json
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}