
provider "azurerm" {

  // references: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  features {

  }

}
