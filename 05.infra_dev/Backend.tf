
terraform {

  backend "azurerm" {

    resource_group_name  = "LEP-NETWORK-DEV-01-RGROUP"
    storage_account_name = "afrclepnetworkdevsa"
    container_name       = "statefiles"
    key                  = "01.lelp.infra.dev.tfstate"
  }

}
