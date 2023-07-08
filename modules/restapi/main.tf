resource "aws_api_gateway_rest_api" "example" {
  name = "api"
}
resource "aws_api_gateway_method" "example" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_rest_api.example.root_resource_id
  rest_api_id   = aws_api_gateway_rest_api.example.id
}
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_rest_api.example.root_resource_id
  http_method             = aws_api_gateway_method.example.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}
resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = "example"
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
  name = "example-rest-api"
}

data "aws_iam_policy_document" "api_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["function_lambda_terraform:InvokeFunction"]
    resources = [aws_api_gateway_rest_api.api_gateway.execution_arn]

  }
}
resource "aws_api_gateway_rest_api_policy" "test" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  policy      = data.aws_iam_policy_document.api_policy.json
}
