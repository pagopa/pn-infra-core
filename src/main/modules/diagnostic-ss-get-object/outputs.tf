output "function_arn" {
  value       = aws_lambda_function.diagnostic_ss_get_object_lambda.arn
  description = "ARN of the Lambda"
}

output "role_arn" {
  value       = aws_iam_role.diagnostic_ss_get_object_role.arn
  description = "ARN of the IAM Role associated with the Lambda"
}
