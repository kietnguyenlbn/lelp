
// deployment based on code version 5 

// resource group

module "ResourceGroup" {

  source = "../modules/resource_group_data"

  resource_group_name = "${var.naming_entity}-${var.naming_project}-${var.naming_environment}-${var.naming_index}-RGROUP"

}



// virtual network 

module "VirtualNetwork" {

  source = "../modules/virtual_network_spoke"

  resource_group_name     = module.ResourceGroup.resource_group_name
  resource_group_location = module.ResourceGroup.resource_group_location

  virtual_network_name           = "${var.naming_region}-${var.naming_entity}-${var.naming_project}-${var.naming_environment}-${var.naming_index}-VNET"
  virtual_network_address_prefix = var.virtual_network_address_prefix

  subnets = {

    intranet_subnet = {

      subnet_name           = "INTRANET-01-SUBNET"
      subnet_address_prefix = ["10.70.217.0/25"]

      route_table_name   = "${var.naming_region}-INTRANET_01_SUBNET-01-RT"
      gateway_ip_address = "10.109.120.84"

      network_security_group_name = "${var.naming_region}-INTRANET_01_SUBNET-01-RT"

    }

  }

  tag_application       = var.naming_project
  tag_cost_center       = var.tag_cost_center
  tag_deployment_method = var.tag_deployment_method
  tag_entity            = var.naming_entity
  tag_environment       = var.naming_environment
  tag_location          = var.naming_region
  tag_msp               = var.tag_msp
  tag_owner             = var.tag_owner
  tag_role              = "Virtual Network"

}
/*
module "Subnet" {
  source = "../modules/subnet_data"
  subnet_name = "lelp-em-snet-01-prd"
  virtual_network_name = ""
  resource_group_name = ""



  
}
// Virtual machine windows

module "VirtualMachineWindows" {

  source = "../modules/virtual_machine_windows_2019"

// resource group
  resource_group_name     = module.ResourceGroup.resource_group_name
  resource_group_location = module.ResourceGroup.resource_group_location


// compute
  admin_username = "admin-lbn"
  admin_password = random_password.password.result
  virtual_machine_name = ""
  virtual_machine_size = ""
  os_disk_name = ""
  virtual_machine_nic_name = ""
  virtual_machine_nic_ip_address = ""
  virtual_machine_nic_subnet_id = module.Subnet.id
  availability_zone = ""

// storagea account
  storage_account_name = ""
  primary_blob_endpoint = ""

// tag
  tag_application       = var.naming_project
  tag_cost_center       = var.tag_cost_center
  tag_deployment_method = var.tag_deployment_method
  tag_entity            = var.naming_entity
  tag_environment       = var.naming_environment
  tag_location          = var.naming_region
  tag_msp               = var.tag_msp
  tag_owner             = var.tag_owner
  tag_role              = "Virtual Machine Windows"

  depends_on = [
    module.ResourceGroup,
    module.VirtualNetwork
  ]
  
}
*/