provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = "core"
  environment = "test"
  location    = "northeurope"
  label_order = ["name", "environment", "location"]
}

##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------
module "vnet" {
  source = "../../"
  name   = "vnet"
  # custom_name            = ""  # Optional: Overrides default naming logic with a fully custom name. Cannot be used if `name` is set.
  environment            = "test"
  label_order            = ["name", "environment", "location"] #location logic is pre configured in the labels module
  resource_group_name    = module.resource_group.resource_group_name
  location               = module.resource_group.resource_group_location
  address_spaces         = ["10.0.0.0/16"]
  enable_ddos_pp         = false # Set to true to create a new DDoS protection plan.
  existing_ddos_pp       = "/subscriptions/c/ddosProtectionPlans/vnetddos"
  enable_network_watcher = false # To be set true when network security group flow logs are to be tracked and network watcher with specific name is to be deployed.
}
