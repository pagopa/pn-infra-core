output "function_arn" {
  value       = aws_lambda_function.diagnostic_tools_lambda.arn
  description = "ARN of the Lambda"
}

output "role_arn" {
  value       = aws_iam_role.diagnostic_tools_role.arn
  description = "ARN of the IAM Role associated with the Lambda"
}
