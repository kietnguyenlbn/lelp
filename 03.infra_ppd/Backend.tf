
terraform {

  backend "azurerm" {

    resource_group_name  = "LEP-NETWORK-PPD-01-RGROUP"
    storage_account_name = "afrclepnetworkppdsa"
    container_name       = "statefiles"
    key                  = "01.lelp.infra.ppd.tfstate"

  }

}
