
// main

variable "availability_zone" {

  type        = string
  default     = ""
  description = ""

}



// compute

variable "admin_username" {

  type        = string
  default     = ""
  description = ""

}

variable "admin_password" {

  type        = string
  default     = ""
  description = ""

}

variable "virtual_machine_name" {

  type        = string
  default     = ""
  description = ""

}

variable "virtual_machine_size" {

  type        = string
  default     = ""
  description = ""

}

variable "os_disk_name" {

  type        = string
  default     = ""
  description = ""

}

variable "virtual_machine_nic_name" {

  type        = string
  default     = ""
  description = ""

}

variable "virtual_machine_nic_ip_address" {

  type        = string
  default     = ""
  description = ""

}

variable "virtual_machine_nic_subnet_id" {

  type        = string
  default     = ""
  description = ""

}



// resource group

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



// storage

variable "storage_account_name" {

  type        = string
  default     = ""
  description = ""

}


variable "primary_blob_endpoint" {

  type        = string
  default     = ""
  description = ""

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
