locals {
  dynamoTables = [
    "pn-Notifications",
    "pn-Timelines",
    "pn-PaperRequestError"
  ]
}

# Lambda function resource definition
resource "aws_lambda_function" "diagnostic_tools_lambda" {
  function_name = var.function_name
  filename      = var.filename != null ? var.filename : null
  s3_bucket     = var.filename == null ? var.s3_code_bucket : null
  s3_key        = var.filename == null ? var.s3_code_key : null
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  role          = aws_iam_role.diagnostic_tools_role.arn

  # Dynamically calculates source code hash based on if the code is uploaded as a file or from S3
  source_code_hash = (var.filename != null ? filebase64sha256(var.filename) : sha256(var.s3_code_key))

  # Environment variables for the Lambda function
  environment {
    variables = {
      DATA_PROXY_NAME            = var.diagnostic_data_proxy_function_name
      DATA_PROXY_REGION          = var.aws_region
      DIAGNOSTIC_ASSUME_ROLE_ARN = var.diagnostic_assumerole_arn
      DYNAMO_AWS_REGION          = var.aws_region
      PN_DATA_VAULT_BASEURL      = var.alb_confidential_base_url
    }
  }

  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = [aws_security_group.lambda_security_group.id]
  }

  # Ensures that either a direct upload filename or S3 location must be specified
  lifecycle {
    precondition {
      condition     = var.filename != null || (var.s3_code_bucket != null && var.s3_code_key != null)
      error_message = "Either filename must be specified, or both s3_bucket and s3_key must be provided."
    }
  }
}

# IAM role for the Lambda function, allowing it to assume the Lambda service role
resource "aws_iam_role" "diagnostic_tools_role" {
  name = "${var.function_name}-ExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
        Effect = "Allow"
      },
    ],
  })
}

# IAM policy attached to the role for creating and managing logs
resource "aws_iam_role_policy" "lambda_logs_policy" {
  name = "${var.function_name}-LogsPolicy"
  role = aws_iam_role.diagnostic_tools_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "logs:CreateLogGroup",
        Resource = "arn:aws:logs:${var.aws_region}:${var.pn_core_aws_account_id}:*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:${var.aws_region}:${var.pn_core_aws_account_id}:log-group:/aws/lambda/${var.function_name}:*"
        ]
      }
    ],
  })
}

# IAM policy for invoking data_proxy Lambda
resource "aws_iam_role_policy" "lambda_invoke_function_policy" {
  name = "${var.function_name}-InvokePolicy"
  role = aws_iam_role.diagnostic_tools_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = var.diagnostic_assumerole_arn
      }
    ],
  })
}

# IAM policy to query Dynamo
resource "aws_iam_role_policy" "lambda_dynamo_policy" {
  name = "${var.function_name}-DynamoDBPolicy"
  role = aws_iam_role.diagnostic_tools_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query"
        ],
        Resource = [
          for table in local.dynamoTables :
          "arn:aws:dynamodb:${var.aws_region}:${var.pn_core_aws_account_id}:table/${table}"
        ]
      }
    ],
  })
}

resource "aws_iam_role_policy_attachment" "attach-vpc" {
  role      = aws_iam_role.diagnostic_tools_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# Security group to query pn-datavault
resource "aws_security_group" "lambda_security_group" {
  name        = "${var.function_name}-sec-group"
  description = "${var.function_name}-sec-group"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
