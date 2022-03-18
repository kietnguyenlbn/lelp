
// main

variable "naming_entity" {

  type        = string
  default     = "GRP"
  description = "define the name of the entity (LVMH trigram)"

}

variable "naming_environment" {

  type        = string
  default     = ""
  description = "define the environment"

}

variable "naming_index" {

  type        = string
  default     = ""
  description = "define the index of the resource"

}

variable "naming_region" {

  type        = string
  default     = ""
  description = "define the azure region where the resource is deployed (LVMH code)"

}

variable "naming_project" {

  type        = string
  default     = ""
  description = "define the name of the project"

}


variable "tenant_id" {

  type        = string
  default     = ""
  description = "indicate the ID of Azure tenant (Azure context)"

}

variable "subscription_id" {

  type        = string
  default     = ""
  description = "indicate the ID of subscription (Azure context)"

}

variable "azure_region" {

  type        = string
  default     = ""
  description = "define the azure region where the resource is deployed (Azure convention)"

}

variable "availability_zone" {

  type        = string
  default     = ""
  description = "define the availability zone (1,2,3)"

}





// resource group

variable "resource_group_name" {

  type        = string
  default     = ""
  description = ""

}



// tagging

variable "tag_cost_center" {

  type        = string
  default     = ""
  description = ""

}

variable "tag_deployment_method" {

  type        = string
  default     = ""
  description = ""

}

variable "tag_msp" {

  type        = string
  default     = ""
  description = ""

}

variable "tag_owner" {

  type        = string
  default     = ""
  description = ""

}


// virtual network

variable "virtual_network_address_prefix" {

  type        = string
  default     = ""
  description = ""

}




