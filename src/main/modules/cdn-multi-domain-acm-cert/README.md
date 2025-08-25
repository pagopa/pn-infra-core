# Cloudfront ACM Multi Domain Certificate Module

This module helps to provision a multi-domain and multi-zone ACM certificate in **us-east-1** (CloudFront requirement) with DNS validation. It automatically create DNS validation records for domains hosted in internal zones (within the same AWS account's Route53) and provides instructions for manual validation when domains belong to external zones (not managed in the related account’s Route53).

## Features

- **Multi-Domain Support:**  
  Create a certificate that includes a primary domain plus additional Subject Alternative Names (SANs).

- **Internal & External Zone Handling:**  
  - **Internal Zones:** For domains in Route53 zones that are in the same AWS account, DNS validation records are automatically created.  
  - **External Zones:** For domains that fall under zones not managed on the current AWS account’s Route53, the module outputs the DNS record details to create manually in the external zone.

- **Domain to Zone Association:**  
  - **Normalization:**  
    Domains are cleaned up by removing any trailing dots if present.

  - **Candidate Zone Detection:**  
    The module checks both allowed internal and external zones, to find a matching zone for each domain. It looks for an exact match or whether the domain ends with the zone value.

  - **Specificity Logic for nested child-zones:**  
    If a domain matches both an internal and an external zone, the module compares the number of labels (parts of the domain). Considering theDNS hierarchical tree model: records on the delegate child zones takes precedence over any records from the parent zone,the zone with more labels (more specific) is chosen.

- **Precondition Enforcement:**  
  The module performs checks before running the plan. These conditions are in place to catch configuration errors early, if something is misconfigured, the plan will fail immediately with a clear error message. The checks include:
  1. **Internal Zone Existence:**  
     - It queries AWS Route53 for each zone specified in `allowed_internal_zones`.  
     - It confirms that all declared zones are found in the account.  
     - If any are missing, the plan fails and print exactly which zones couldn’t be found.
  2. **Non-Overlapping Zone Definitions:**  
     - It ensures that there is no overlap between `allowed_internal_zones` and `allowed_external_zones`.  
     - If the same zone appears in both lists, the plan will stop and prompt to fix the overlap, listing the overlapping domains.
  3. **Domain-Zone Association:**  
     - Each domain is normalized and then matched against allowed zones.  
     - The module checks that every domain declared can be associated with at least one allowed zone.  
     - If a domain doesn’t match any zone, the plan fails and lists the problematic domains.

- **Wildcard Support & LifeCycle Policy:**  
  - Supports wildcard domains (e.g., `*.domain.com`).  
  - Uses meta-argument `create_before_destroy` to make sure new certificate is available before destroyng the old one.


## Requirements

| Name         | Version   |
|--------------|-----------|
| Terraform    | >= 1.4.2  |
| AWS Provider | >= 4.60.0  |

## Providers

| Name | Version   |
|------|-----------|
| aws  | >= 4.60.0  |

## Inputs

| Name                     | Description                                                                                                                                                                                                          | Type           | Default | Required |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|---------|:--------:|
| `domains`                | List of domains for the certificate. The first domain is used as the primary, and the rest are added as SANs.                                                                                                         | `list(string)` | -       | yes      |
| `allowed_internal_zones` | List of allowed internal Route53 zones. These zones must exist in the current AWS account to enable automatic DNS validation.                                                                                          | `list(string)` | `[]`    | no       |
| `allowed_external_zones` | List of allowed external zones. Domains that match these zones aren’t managed in this account’s Route53, so manual DNS validation record creation is required.                                                    | `list(string)` | `[]`    | no       |
| `tags`                   | Map of tags to apply to the ACM certificate.                                                                                                                                                                       | `map(string)`  | `{}`    | no       |

## Outputs

| Name                                | Description                                                                                                                             |
|-------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| `certificate_arn`                   | The ARN of the ACM certificate. If there are no external domains, provides the validated ARN; otherwise, provides the created ARN.         |
| `certificate_domain`                | The primary domain of the ACM certificate.                                                                                              |
| `certificate_validation_records`    | Details of the DNS validation records automatically created for domains in internal zones.                                              |
| `domain_validation_options`         | ACM domain validation options (sensitive data).                                                                                         |
| `external_zones_validation_records` | DNS validation details for domains that correspond to external zones must be registered manually.                             |


## Usage Examples

### Basic Certificate Creation
```hcl
module "acm_certificate" {
  source = "./acm-certificate"

  domains = [
    "www.example.com",
    "api.example.com"
  ]
  
  allowed_internal_zones = ["example.com"]

  tags = {
    Environment = "prod"
  }
}
```
## Mixed Internal and External Domains

```hcl
module "acm_certificate" {
  source = "./acm-certificate"

  domains = [
    "app.dev.example.com",         # Matches internal zone "dev.example.com"
    "service.prod.otherdomain.com"   # Matches external zone "prod.otherdomain.com"
  ]
  
  allowed_internal_zones = ["example.com", "dev.example.com"]
  allowed_external_zones = ["otherdomain.com", "prod.otherdomain.com"]

  tags = {
    Environment = "dev"
  }
}
```
In this case, the domain "app.dev.example.com" is automatically associated with the internal zone "dev.example.com", while the domain "service.prod.otherdomain.com" is linked to the external zone "prod.otherdomain.com".  
The validation records for the external zone will be printed in the output (`external_zones_validation_records`) to allow for manual configuration.

## Nested child-zones Specificity Example

```hcl
module "acm_certificate" {
  source = "./acm-certificate"

  domains = [
    "service.dev.api.otherdomain.com"
  ]
  
  allowed_internal_zones = [
    "api.otherdomain.com"       // Internal candidate (3 labels)
  ]
  
  allowed_external_zones = [
    "dev.api.otherdomain.com"   // External candidate (4 labels, more specific)
  ]
  
  tags = {
    Environment = "dev
    "
  }
}
```

In this case, being the external zone a "nested" child-zone of the "api.otherdomain.com" father internal zone, the domain "service.dev.api.otherdomain.com" is matched to the external zone "dev.api.otherdomain.com" being more specific.

## Notes

**Region:**  
The certificate is always created in `us-east-1` as for CloudFront requirement, but this can be easily changed for other use cases.

**Validation Record Management:**  
- *Internal Zones:* DNS validation records are automatically created and managed in Route53.  
- *External Zones:* The module provides the DNS validation record details to create manually, as these zones aren’t managed in this account’s Route53.

**Lifecycle Management:**  
The module uses Terraform’s `create_before_destroy` feature to ensure that the certificate is created before the old one is destroyed.

**Validation Rules:**  
- Domains must be lowercase and follow valid domain name formats (letters, numbers, hyphens, and dots).  
- Wildcard domains (e.g., `*.domain.com`) are supported.
