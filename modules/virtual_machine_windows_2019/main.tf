
resource "azurerm_storage_account" "StorageAccount" {

    // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

    resource_group_name       = var.resource_group_name
    location                  = var.resource_group_location

    name                      = var.storage_account_name

    account_tier              = "Standard"
    account_kind              = "StorageV2"
    account_replication_type  = "LRS"
    access_tier               = "Cool"
    enable_https_traffic_only = true

    tags = {

        Application       = var.tag_application
        Cost_center       = var.tag_cost_center
        Deployment_method = var.tag_deployment_method
        Entity            = var.tag_entity
        Environment       = var.tag_environment
        Location          = var.tag_location
        Msp               = var.tag_msp
        Owner             = var.tag_owner
        Role              = "Storage Account for virtual machine diagnostics"

    }

}



resource "azurerm_network_interface" "VirtualMachineNic" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface 

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  name                = var.virtual_machine_nic_name

  enable_ip_forwarding = false

  dns_servers = ["10.109.108.100","10.109.108.101"]

  ip_configuration {

    name                          = "ip-configuration-01"
    subnet_id                     = var.virtual_machine_nic_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.virtual_machine_nic_ip_address

  }

  tags = {

    Application       = var.tag_application
    Cost_center       = var.tag_cost_center
    Deployment_method = var.tag_deployment_method
    Entity            = var.tag_entity
    Environment       = var.tag_environment
    Location          = var.tag_location
    Owner             = var.tag_owner
    Msp               = var.tag_msp
    Role              = "NIC for virtual machine"
    
  }

}



resource "azurerm_windows_virtual_machine" "VirtualMachine" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  name                = var.virtual_machine_name
  size                = var.virtual_machine_size
  zone                = var.availability_zone
  
  admin_username      = "adminroot"
  admin_password      = var.admin_password
  
  license_type = "Windows_Server"

  network_interface_ids = [

    azurerm_network_interface.VirtualMachineNic.id
  
  ]

  os_disk {

    name                  = var.os_disk_name
    caching               = "ReadWrite"
    storage_account_type  = "Premium_LRS"

  }

  source_image_reference {

    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"

  }

  boot_diagnostics {

    storage_account_uri = var.primary_blob_endpoint

  }

  tags = {

    Application       = var.tag_application
    Cost_center       = var.tag_cost_center
    Deployment_method = var.tag_deployment_method
    Entity            = var.tag_entity
    Environment       = var.tag_environment
    Location          = var.tag_location
    Owner             = var.tag_owner
    Msp               = var.tag_msp
    Role              = "virtual machine"

  }

}
