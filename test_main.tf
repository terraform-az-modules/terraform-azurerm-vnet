# ##-----------------------------------------------------------------------------
# ## Tagging Module – Applies standard tags to all resources
# ##-----------------------------------------------------------------------------
# module "labels" {
#   source          = "terraform-az-modules/tags/azurerm"
#   version         = "1.0.2"
#   name            = local.base_name
#   location        = var.location
#   environment     = var.environment
#   managedby       = var.managedby
#   label_order     = var.label_order
#   repository      = var.repository
#   deployment_mode = var.deployment_mode
#   extra_tags      = var.extra_tags
# }

# ##-----------------------------------------------------------------------------
# ## DDoS Plan – Creates a new plan only when enabled and no existing plan is supplied
# ##-----------------------------------------------------------------------------
# resource "azurerm_network_ddos_protection_plan" "this" {
#   count               = local.create_ddos_plan ? 1 : 0
#   name                = local.ddos_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tags                = module.labels.tags
# }

# ##-----------------------------------------------------------------------------
# ## Virtual Network – Creates VNet with optional encryption and DDoS association
# ##-----------------------------------------------------------------------------
# resource "azurerm_virtual_network" "this" {
#   count                   = local.create_vnet ? 1 : 0
#   name                    = local.vnet_name
#   resource_group_name     = var.resource_group_name
#   location                = var.location
#   address_space           = var.address_spaces
#   flow_timeout_in_minutes = var.flow_timeout_in_minutes
#   dns_servers             = var.dns_servers
#   bgp_community           = var.bgp_community
#   edge_zone               = var.edge_zone
#   tags                    = module.labels.tags

#   dynamic "encryption" {
#     for_each = local.encryption_enabled ? [var.enable_encryption_settings] : []
#     content {
#       enforcement = encryption.value
#     }
#   }

#   dynamic "ddos_protection_plan" {
#     for_each = local.ddos_plan_id != null ? [local.ddos_plan_id] : []
#     content {
#       id     = ddos_protection_plan.value
#       enable = true
#     }
#   }
# }

# ##-----------------------------------------------------------------------------
# ## Network Watcher – Optional Network Watcher for diagnostics / flow logs
# ##-----------------------------------------------------------------------------
# resource "azurerm_network_watcher" "this" {
#   count               = local.create_network_watcher ? 1 : 0
#   name                = local.nw_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tags                = module.labels.tags
# }