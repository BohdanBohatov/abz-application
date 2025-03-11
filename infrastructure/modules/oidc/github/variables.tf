variable "thumbprint_list" {
  description = "Github thumbprints."
  type        = set(string)
}

variable "client_id_list" {
  description = "Client ID list."
  type        = set(string)
}

variable "url" {
  type        = string
  description = "Github OpenID URL."
}