###########################
# CONFIGURATION
###########################

provider "azurerm" {
      version = "~> 3.15.0"
      features {}
  }

resource "azurerm_resource_group" "tf_test" {
  name     = "tfmainrg"
  location = var.region
}

resource "azurerm_container_group" "tfcg_test" {
  name                = "weatherapi"
  location            = var.region
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label  = "andrienkomsapitf"
  os_type         = "linux"
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
