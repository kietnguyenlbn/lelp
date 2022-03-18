
// variables for resource group

variable "resource_group_name" {

  type        = string
  default     = ""
  description = ""

}

variable "resource_group_location" {

  type        = string
  default     = ""
  description = ""

}



// variables for routes

variable "gateway_ip_address" {

  type        = string
  default     = ""
  description = ""

}



// variables for route tables

variable "route_table_name" {

  type        = string
  default     = ""
  description = ""

}



// variables for subnets

variable "subnets" {

  default     = {}

}



// tagging

variable "tag_application" {

  type        = string
  default     = ""
  description = ""

}

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

variable "tag_entity" {

  type        = string
  default     = ""
  description = ""

}

variable "tag_environment" {

  type        = string
  default     = ""
  description = ""

}

variable "tag_location" {

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

variable "tag_role" {

  type        = string
  default     = ""
  description = ""

}



// variables for virtual network

variable "virtual_network_name" {

  type        = string
  default     = ""
  description = ""

}

variable "virtual_network_address_prefix" {

  type        = string
  default     = ""
  description = ""

}
