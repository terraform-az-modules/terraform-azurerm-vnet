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
  environment = "dev"
  location    = "centralus"
  label_order = ["name", "environment", "location"]
}

##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------
module "vnet" {
  source = "../../"
  # name   = "core"
  # # custom_name            = ""  # Optional: Overrides default naming logic with a fully custom name. Cannot be used if `name` is set.
  # environment         = "dev"
  # label_order         = ["name", "environment", "location"] # locations logic are pre configured in the labels module
  # resource_group_name = module.resource_group.resource_group_name
  # location            = module.resource_group.resource_group_location
  # address_spaces      = ["10.0.0.0/16"]
  enable      = true
  name        = "core"
  environment = "dev"
  vnets = {
    core = {
      name                    = "core"
      resource_group_name     = module.resource_group.resource_group_name
      location                = module.resource_group.resource_group_location
      address_space           = ["10.0.0.0/16"]
      flow_timeout_in_minutes = "30"
      dns_servers             = ["8.8.8.8", "8.8.4.4"]
      bgp_community           = "65000:1"
      edge_zone               = "centralus"
      environment             = "dev"
      project                 = "core"
      tags = {
        environment = "dev"
        project     = "core-infrastructure"
      }
    }
  }

}
