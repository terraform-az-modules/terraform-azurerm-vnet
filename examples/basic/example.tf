provider "azurerm" {
  features {}
}

module "vnet" {
  source = "../../"
}
