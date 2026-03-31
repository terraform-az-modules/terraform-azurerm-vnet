##-----------------------------------------------------------------------------
## Locals declaration for determining the id of ddos protection plan.
##-----------------------------------------------------------------------------

locals {
  # If DDOS protection is enabled, check:
  # - If existing DDOS plan is provided, use it
  # - Otherwise, use the ID from the newly created DDOS protection plan
  # Else (if not enabled), it should be null
  ddos_pp_id = var.enable_ddos_pp ? (
    var.existing_ddos_pp != null ? var.existing_ddos_pp : azurerm_network_ddos_protection_plan.ddos_protection_plan[0].id
  ) : null

  create_ddos_plan = var.enable_ddos_pp && var.enable && var.existing_ddos_pp == null
  name             = var.custom_name != null ? var.custom_name : module.labels.id
  vnet_name = var.resource_position_prefix  ? "vnet-${local.name}" : "${local.name}-vnet"
  ddos_name = var.resource_position_prefix ? "ddospp-${local.name}" : "${local.name}-ddospp"
}
