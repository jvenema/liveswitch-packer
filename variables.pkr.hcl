variable "azure_client_id" {
  type    = string
  default = "$${azure_client_id}"
}

variable "azure_client_secret" {
  type    = string
  default = "$${azure_client_secret}"
}

variable "azure_subscription_id" {
  type    = string
  default = "$${azure_subscription_id}"
}

variable "azure_tenant_id" {
  type    = string
  default = "$${azure_tenant_id}"
}

variable "digitalocean_token" {
  type    = string
  default = "$${digitalocean_token}"
}

variable "aws_access_key_id" {
  type    = string
  default = "$${aws_access_key_id}"
}

variable "aws_secret_access_key" {
  type    = string
  default = "$${aws_secret_access_key}"
}