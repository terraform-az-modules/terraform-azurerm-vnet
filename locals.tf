##-----------------------------------------------------------------------------
## Locals declaration for determining the id of ddos protection plan.
##-----------------------------------------------------------------------------

locals {
  create_vnet            = var.enable
  vnet_name              = var.resource_position_prefix ? "vnet-${local.base_name}" : "${local.base_name}-vnet"
  base_name              = var.custom_name != null ? var.custom_name : var.name
  encryption_enabled     = var.enable_encryption_settings != null
  ddos_name              = var.resource_position_prefix ? "ddospp-${local.base_name}" : "${local.base_name}-ddospp"
  nw_name                = var.resource_position_prefix ? "nw-${local.base_name}" : "${local.base_name}-nw"
  create_network_watcher = var.enable && var.enable_network_watcher
  # If DDOS protection is enabled, check:
  # - If existing DDOS plan is provided, use it
  # - Otherwise, use the ID from the newly created DDOS protection plan
  # Else (if not enabled), it should be null
  create_ddos_plan = var.enable_ddos_pp && var.enable && var.existing_ddos_pp == null
  ddos_pp_id = var.enable_ddos_pp ? (
    var.existing_ddos_pp != null ? var.existing_ddos_pp : azurerm_network_ddos_protection_plan.ddos_protection_plan[0].id
  ) : null
}

