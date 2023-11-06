terraform {
  required_version = ">= 1.2.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      #version = "2.57.0"
      version = "3.44.1"
    }
  }

  backend "azurerm" {
# TEAM: Updated to use my storage for testing init & plan

    resource_group_name  = var.backendAzureRmResourceGroupName
    storage_account_name = var.backendAzureRmStorageAccountName
    container_name       = var.backendAzureRmContainerName
    key                  = var.backendAzureRmKey
  }
}

data "azurerm_subscription" "primary" {
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "spoke" {
  name     = var.spoke_resource_group_name
  location = var.location
}
