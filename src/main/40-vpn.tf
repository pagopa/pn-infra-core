###########################################################
# SAML provider for VPN authentication
###########################################################
resource "aws_iam_saml_provider" "vpc_pn_simulator" {
  count = var.vpc_pn_simulator_is_enabled ? 1 : 0

  name                   = format("pn-vpn-saml-%s", var.environment)
  saml_metadata_document = file(var.vpn_saml_metadata_path)
}

###########################################################
# CloudWatch Log Group for VPN
###########################################################
resource "aws_cloudwatch_log_group" "vpc_pn_simulator" {
  count = var.vpc_pn_simulator_is_enabled ? 1 : 0

  name             = format("/aws/client-vpn/pn-vpn-%s/connections", var.environment)
  retention_in_days = var.environment == "prod" ? 90 : 30
  skip_destroy      = true
}

###########################################################
# Security Group for VPN Client
###########################################################
resource "aws_security_group" "vpc_pn_simulator_vpn_clients" {
  count       = var.vpc_pn_simulator_is_enabled ? 1 : 0
  name        = format("client-vpn/pn-vpn-%s", var.environment)
  description = "SG for VPN clients"
  vpc_id      = module.vpc_pn_simulator["enabled"].vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [module.vpc_pn_simulator["enabled"].vpc_cidr_block]
    ipv6_cidr_blocks = []
    security_groups  = []
  }
}

###########################################################
# Endpoint Client VPN
###########################################################
locals {

}

resource "aws_ec2_client_vpn_endpoint" "vpn" {
  count = var.vpc_pn_simulator_is_enabled ? 1 : 0

  description            = format("pn-vpn-%s", var.environment)
  server_certificate_arn = aws_acm_certificate.vpn["enabled"].arn
  client_cidr_block      = var.vpc_pn_simulator_primary_cidr

  vpc_id             = module.vpc_pn_simulator["enabled"].vpc_id
  security_group_ids = [aws_security_group.vpc_pn_simulator_vpn_clients[0].id]

  split_tunnel = true
  dns_servers  = [local.Simulator_VPC_DNS_Server]
  session_timeout_hours = 10

  authentication_options {
    type              = "federated-authentication"
    saml_provider_arn = aws_iam_saml_provider.vpc_pn_simulator[0].arn
  }

  connection_log_options {
    enabled              = true
    cloudwatch_log_group = aws_cloudwatch_log_group.vpc_pn_simulator[0].name
  }

  tags = {
    Name = format("pn-vpn-%s", var.environment)
  }
}

###########################################################
# Client VPN - Subnet association
###########################################################
resource "aws_ec2_client_vpn_network_association" "vpn_subnet" {
  for_each = { for id in local.Simulator_VPN_SubnetsCidrs : id => id }

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn[0].id
  subnet_id              = each.value
}

###########################################################
# Authorization Rule VPN
###########################################################
resource "aws_ec2_client_vpn_authorization_rule" "vpc_only" {
  count = var.vpc_pn_simulator_is_enabled ? 1 : 0

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn[0].id
  target_network_cidr    = module.vpc_pn_simulator["enabled"].vpc_cidr_block
  authorize_all_groups   = true
}
