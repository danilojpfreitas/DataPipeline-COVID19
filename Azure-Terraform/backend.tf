#Backend
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "vacinacaobackend"
      storage_account_name = "vacinacaobackend"
      container_name       = "vacinacaobackend"
      key                  = "terraform.tfstate"
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  skip_provider_registration = "true"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}