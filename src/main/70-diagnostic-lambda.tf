locals {
  confinfo_assumerole_arn           = "arn:aws:iam::${var.pn_confinfo_aws_account_id}:role/DiagnosticAssumeRole"
  confinfo_data_proxy_function_name = "diagnostic-data-proxy"
  confinfo_data_proxy_region        = var.aws_region

  alb_confidential_base_url = "http://${aws_route53_record.dev-ns.name}:8080"

  diagnostic_tools_function_name = "diagnostic-tools"
  diagnostic_tools_filename      = "${path.root}/../../functions/diagnostic-tools/function.zip"
  diagnostic_tools_runtime       = "nodejs18.x"
}

# Configuring and deploying diagnostic_tools Lambda 
module "diagnostic_tools" {
  source = "./modules/diagnostic-tools"

  filename                            = local.diagnostic_tools_filename
  function_name                       = local.diagnostic_tools_function_name
  aws_region                          = var.aws_region
  pn_core_aws_account_id              = var.pn_core_aws_account_id
  runtime                             = local.diagnostic_tools_runtime
  diagnostic_data_proxy_lambda_region = local.confinfo_data_proxy_region
  diagnostic_assumerole_arn           = local.confinfo_assumerole_arn
  diagnostic_data_proxy_function_name = local.confinfo_data_proxy_function_name
  alb_confidential_base_url           = local.alb_confidential_base_url
  vpc_subnet_ids                      = module.vpc_pn_core.private_subnets
  vpc_id                              = module.vpc_pn_core.vpc_id
}
