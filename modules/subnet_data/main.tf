data "azurerm_subnet" "Subnet" {
    name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    resource_group_name = var.resource_group_name
  
}