##-----------------------------------------------------------------------------
## Tagging Module – Applies standard tags to all resources
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##-----------------------------------------------------------------------------
## Virtual Network – Creates a VNet with optional DNS, BGP, and DDoS settings
##-----------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  count                   = local.create_vnet ? 1 : 0
  name                    = local.vnet_name
  resource_group_name     = var.resource_group_name
  address_space           = var.address_spaces
  flow_timeout_in_minutes = var.flow_timeout_in_minutes
  location                = var.location
  dns_servers             = var.dns_servers
  bgp_community           = var.bgp_community
  edge_zone               = var.edge_zone
  tags                    = module.labels.tags

  dynamic "encryption" {
    for_each = local.encryption_enabled ? [var.enable_encryption_settings] : []
    content {
      enforcement = var.enable_encryption_settings
    }
  }

  dynamic "ddos_protection_plan" {
    for_each = local.ddos_pp_id != null ? [local.ddos_pp_id] : []
    content {
      id     = local.ddos_pp_id
      enable = true
    }
  }
}

##-----------------------------------------------------------------------------
## DDoS Plan – Creates a new plan if one is not provided
##-----------------------------------------------------------------------------
resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  count               = local.create_ddos_plan ? 1 : 0 # Updated: Only create new DDOS Plan if existing one not provided
  name                = local.ddos_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.labels.tags

  lifecycle {
    prevent_destroy = false
  }
}

##-----------------------------------------------------------------------------
## Network Watcher – Enables Azure Network Watcher in the specified region if required.
## This is used primarily for enabling flow logs or diagnostics on NSGs.
## Azure automatically enables Network Watcher, but this allows specifying a custom name.
##-----------------------------------------------------------------------------
resource "azurerm_network_watcher" "flow_log_nw" {
  count               = local.create_network_watcher ? 1 : 0
  name                = local.nw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.labels.tags
}