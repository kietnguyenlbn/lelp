
terraform {

  backend "azurerm" {

    resource_group_name  = "LEP-AUTH-PRD-01-RGROUP"
    storage_account_name = "afrclepauthprdsa"
    container_name       = "statefiles"
    key                  = "01.lelp.auth.prd.tfstate"

  }

}
