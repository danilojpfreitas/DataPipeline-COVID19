#Backend
variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "environment" {
  type = string
}

#Storage Account - Data Lake Store Gen 2
variable "containers_name" {
  type = list(string)
}

#Azute DataBricks/Key Vault
variable "object_id" {
  type = string
}

#Data Factory
variable "data_factory_linked_name" {
  type = list(string)
}

variable "data_factory_linked_url" {
  type = list(string)
}

variable "storage_account_key" {
  type = string
}

variable "storage_account_url" {
  type = string
}