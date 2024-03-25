locals {
  functions_path = "${path.root}/../../functions"

  confinfo_assumerole_arn            = "arn:aws:iam::${var.pn_confinfo_aws_account_id}:role/DiagnosticAssumeRole"
  confinfo_data_proxy_function_name  = "diagnostic-data-proxy"
  confinfo_list_lambda_function_name = "diagnostic-list-lambda"
  confinfo_data_proxy_region         = var.aws_region

  alb_confidential_base_url = "http://${aws_route53_record.dev-ns.name}:8080"

  diagnostic_tools_function_name = "diagnostic-tools"
  diagnostic_tools_current_build = file("${local.functions_path}/diagnostic-tools/.current_build")
  diagnostic_tools_filename      = "${local.functions_path}/diagnostic-tools/${local.diagnostic_tools_current_build}"
  diagnostic_tools_runtime       = "nodejs18.x"

  list_lambda_function_name = "diagnostic-list-lambda"
  list_lambda_current_build = file("${local.functions_path}/diagnostic-list-lambda/.current_build")
  list_lambda_filename      = "${local.functions_path}/diagnostic-list-lambda/${local.list_lambda_current_build}"
  list_lambda_runtime       = "nodejs18.x"

  diagnostic_deanonymize_notification_function_name = "diagnostic-deanonymize-notification"
  diagnostic_deanonymize_notification_current_build = file("${local.functions_path}/diagnostic-deanonymize-notification/.current_build")
  diagnostic_deanonymize_notification_filename      = "${local.functions_path}/diagnostic-deanonymize-notification/${local.diagnostic_deanonymize_notification_current_build}"
  diagnostic_deanonymize_notification_runtime       = "nodejs18.x"

  diagnostic_ss_get_object_function_name = "diagnostic-ss-get-object"
  diagnostic_ss_get_object_current_build = file("${local.functions_path}/diagnostic-ss-get-object/.current_build")
  diagnostic_ss_get_object_filename      = "${local.functions_path}/diagnostic-ss-get-object/${local.diagnostic_ss_get_object_current_build}"
  diagnostic_ss_get_object_runtime       = "nodejs18.x"
}

# Configuring and deploying diagnostic-tools Lambda 
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
  lambda_tags = {
    OnCallExec       = "True",
    SupportoEntiExec = "True"
  }
}

# Configuring and deploying list-lambda
module "diagnostic_list_lambda" {
  source = "./modules/diagnostic-list-lambda"

  filename                 = local.list_lambda_filename
  function_name            = local.list_lambda_function_name
  aws_region               = var.aws_region
  handler                  = "index.handler"
  runtime                  = local.list_lambda_runtime
  current_aws_account_id   = var.pn_confinfo_aws_account_id
  current_aws_account_name = "core"
  confinfo_lambda_name     = local.confinfo_list_lambda_function_name
  confinfo_asuume_role_arn = local.confinfo_assumerole_arn
  lambda_tags = {
    OnCallExec = "True"
  }
}

# Configuring and deploying diagnostic-deanonymize-notification Lambda 
module "diagnostic_deanonymize_notification" {
  source = "./modules/diagnostic-deanonymize-notification"

  filename                  = local.diagnostic_deanonymize_notification_filename
  function_name             = local.diagnostic_deanonymize_notification_function_name
  runtime                   = local.diagnostic_deanonymize_notification_runtime
  aws_region                = var.aws_region
  pn_core_aws_account_id    = var.pn_core_aws_account_id
  alb_confidential_base_url = local.alb_confidential_base_url
  vpc_subnet_ids            = module.vpc_pn_core.private_subnets
  vpc_id                    = module.vpc_pn_core.vpc_id
  lambda_tags = {
    OnCallExec = "True",
    FunctionType = "Diagnostic",
    FunctionDescription = "Deanonymize a notification giving the IUN."
  }
}

# Configuring and deploying diagnostic-deanonymize-notification Lambda 
module "diagnostic_ss_get_object" {
  source = "./modules/diagnostic-ss-get-object"

  filename                            = local.diagnostic_ss_get_object_filename
  function_name                       = local.diagnostic_ss_get_object_function_name
  runtime                             = local.diagnostic_ss_get_object_runtime
  aws_region                          = var.aws_region
  pn_core_aws_account_id              = var.pn_core_aws_account_id
  diagnostic_data_proxy_lambda_region = local.confinfo_data_proxy_region
  diagnostic_assumerole_arn           = local.confinfo_assumerole_arn
  diagnostic_data_proxy_function_name = local.confinfo_data_proxy_function_name
  lambda_tags = {
    OnCallExec = "True",
    FunctionType = "Diagnostic",
    FunctionDescription = "Get an object from pn-safestorage."
  }
}
