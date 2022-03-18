
terraform {

  backend "azurerm" {

    resource_group_name  = "LEP-NETWORK-PRD-01-RGROUP"
    storage_account_name = "afrclepnetworkprdsa"
    container_name       = "statefiles"
    key                  = "01.lelp.network.prd.tfstate"

  }

}
