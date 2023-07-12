resource "aws_api_gateway_rest_api" "example" {
  name = var.name_api
}
resource "aws_api_gateway_method" "example" {
  authorization = var.authorization
  http_method   = var.http_method
  resource_id   = aws_api_gateway_rest_api.example.root_resource_id
  rest_api_id   = aws_api_gateway_rest_api.example.id
}
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.example.id
  resource_id             = aws_api_gateway_rest_api.example.root_resource_id
  http_method             = aws_api_gateway_method.example.http_method
  integration_http_method = var.integration_http_method
  type                    = var.type_integration
  uri                     = aws_lambda_function.lambda.invoke_arn
}
resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = var.stage_name
}
resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.example.id,
      aws_api_gateway_integration.integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_api_gateway_rest_api" "api_gateway" {
  name = var.name_api_gateway
}

data "aws_iam_policy_document" "api_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["${var.lambda_name}:InvokeFunction"]
    resources = [aws_api_gateway_rest_api.api_gateway.execution_arn]

  }
}
resource "aws_api_gateway_rest_api_policy" "test" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  policy      = data.aws_iam_policy_document.api_policy.json
}
