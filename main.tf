resource "aws_iam_role" "lambda_role" {
  name = "iam_for_lambda"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : "sts:AssumeRole",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      },
      "Effect" : "Allow"
    }]
  })
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name = "aws_iam_policy_lambda_role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "*",
          # "lambda:InvokeFunction",
          # "lambda:GetFunctionConfiguration",
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "python-lambda-function" {
  function_name = "python-lambda-function"
  description   = "lambda function from terraform"
  image_uri     = var.image_uri
  package_type  = "Image"
  architectures = ["x86_64"]
  role          = aws_iam_role.lambda_role.arn
}
