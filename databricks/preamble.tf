terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.90.0"
    }

    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.4.3"
    }
  }
}
