variable "domains" {
  type        = list(string)
  description = "Lista dei domini per il certificato multidominio. Il primo è il dominio principale."
  validation {
    condition     = length(var.domains) > 0
    error_message = "Deve essere fornito almeno un dominio."
  }
  validation {
    condition = alltrue([
      for domain in var.domains :
      can(regex("^(\\*\\.)?[a-z0-9][a-z0-9-]*(\\.[a-z0-9][a-z0-9-]*)*$", domain))  #wildcard support
    ])
    error_message = "Formato dominio non valido: i domini devono essere minuscoli e contenere solo lettere, numeri, trattini e punti."
  }
}

variable "allowed_internal_zones" {
  type        = list(string)
  description = "Lista dei nomi delle zone Route53 interne consentite."
  default     = []
}

variable "allowed_external_zones" {
  type        = list(string)
  description = "Lista dei nomi delle zone cross-account (esterne). Se valorizzata, per i domini che non matchano le zone interne si tenterà il matching contro queste zone e verranno forniti in output i dettagli per la creazione manuale dei record di validazione."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags da applicare al certificato."
  default     = {}
}
