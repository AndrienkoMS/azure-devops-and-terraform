###########################
# CONFIGURATION #
###########################
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "L1_resource_group_task2"
        storage_account_name = "l1storageaccounttask2"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
  name     = "tfmainrg"
  location = var.region
}

resource "azurerm_container_group" "tfcg_test" {
  name                = "weatherapi"
  location            = var.region
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "Public"
  dns_name_label  = "andrienkomsapitf"
  os_type         = "Linux"


  container {
    name = "weatherapi"
      image = "andrienkoms/weatherapi"
      cpu = "1"
      memory = "1"

      ports {
        port = "80"
        protocol = "TCP"
      }
  }
}
###########################
# VARIABLES
###########################

variable "region" {
  type        = string
  description = "Region in Azure"
  default     = "eastus"
}

variable "prefix" {
  type        = string
  description = "prefix for naming"
  default     = "tacos"
}

###########################
# commands
###########################
