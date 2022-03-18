
// virtual network

resource "azurerm_virtual_network" "VirtualNetwork" {

    // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

    resource_group_name = var.resource_group_name
    location            = var.resource_group_location

    name                = var.virtual_network_name
    address_space       = [var.virtual_network_address_prefix]

    dns_servers = ["10.106.222.10","10.106.22.10"]

    tags = {

        Application       = var.tag_application
        Cost_center       = var.tag_cost_center
        Deployment_method = var.tag_deployment_method
        Entity            = var.tag_entity
        Environment       = var.tag_environment
        Location          = var.tag_location
        Msp               = var.tag_msp
        Owner             = var.tag_owner
        Role              = var.tag_role

    }
  
}



// subnets

resource "azurerm_subnet" "Subnet" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

  for_each = var.subnets

  resource_group_name  = var.resource_group_name

  virtual_network_name = azurerm_virtual_network.VirtualNetwork.name

  name                 = each.value.subnet_name
  address_prefixes     = each.value.subnet_address_prefix

}



// route tables

resource "azurerm_route_table" "RouteTableSubnet" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table

  for_each = var.subnets

  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  
  name                          = each.value.route_table_name
  disable_bgp_route_propagation = true

  tags = {

    Application       = var.tag_application
    Cost_center       = var.tag_cost_center
    Deployment_method = var.tag_deployment_method
    Entity            = var.tag_entity
    Environment       = var.tag_environment
    Location          = var.tag_location
    Msp               = var.tag_msp
    Owner             = var.tag_owner
    Role              = var.tag_role
    
  }

}



// routes for route tables

resource "azurerm_route" "RouteTableSubnetDefaultRoute" {

    // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route

  for_each = var.subnets

  resource_group_name = var.resource_group_name

  route_table_name    = azurerm_route_table.RouteTableSubnet[each.key].name
  name                = "DefaultRoute"
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address = each.value.gateway_ip_address

}



// route for route tables

resource "azurerm_route" "RouteTableSubnetLocal" {

    // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route

  for_each = var.subnets

  resource_group_name = var.resource_group_name

  route_table_name    = azurerm_route_table.RouteTableSubnet[each.key].name
  name                = "LocalSubnet"
  address_prefix      = azurerm_subnet.Subnet[each.key].address_prefix
  next_hop_type       = "VnetLocal"

}



// route for route tables

resource "azurerm_route" "RouteTableSubnetRouteToKMS" {

    // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route

  for_each = var.subnets

  resource_group_name = var.resource_group_name

  route_table_name    = azurerm_route_table.RouteTableSubnet[each.key].name
  name                = "RouteToKMS"
  address_prefix      = "23.102.135.246/32"
  next_hop_type       = "Internet"

}



// route for route tables

resource "azurerm_route" "RouteTableSubnetRouteToVNET" {

    // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route

  for_each = var.subnets

  resource_group_name = var.resource_group_name

  route_table_name    = azurerm_route_table.RouteTableSubnet[each.key].name
  name                = "RouteToVNET"
  address_prefix      = var.virtual_network_address_prefix
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address = each.value.gateway_ip_address

}



// route tables association

resource "azurerm_subnet_route_table_association" "RouteTableSubnetAssociation" {

    // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association

  for_each = var.subnets

  subnet_id      = azurerm_subnet.Subnet[each.key].id
  route_table_id = azurerm_route_table.RouteTableSubnet[each.key].id

}



// network security groups

resource "azurerm_network_security_group" "NetworkSecurityGroupSubnet" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

  for_each = var.subnets

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  name                = each.value.network_security_group_name
  
  tags = {
    
    Application       = var.tag_application
    Cost_center       = var.tag_cost_center
    Deployment_method = var.tag_deployment_method
    Entity            = var.tag_entity
    Environment       = var.tag_environment
    Location          = var.tag_location
    Msp               = var.tag_msp
    Owner             = var.tag_owner
    Role              = var.tag_role

  }

}



// rules for network security groups

resource "azurerm_network_security_rule" "NetworkSecurityGroupRuleRFC1918" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule

  for_each = var.subnets

  resource_group_name            = var.resource_group_name

  network_security_group_name    = azurerm_network_security_group.NetworkSecurityGroupSubnet[each.key].name

  name                           = "Any_RFC1918_InBound"
  priority                       = "100"
  direction                      = "Inbound"
  access                         = "Allow"
  protocol                       = "*"
  source_address_prefixes        = ["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16"]
  source_port_range              = "*"
  destination_address_prefix     = "*"
  destination_port_range         = "*"
  
}



// network security groups association

resource "azurerm_subnet_network_security_group_association" "NetworkSecurityGroupSubnetAssociation" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association

  for_each = var.subnets

  subnet_id                 = azurerm_subnet.Subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.NetworkSecurityGroupSubnet[each.key].id

}
