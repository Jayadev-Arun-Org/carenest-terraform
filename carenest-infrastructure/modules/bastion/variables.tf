variable "project_name" {
  type        = string
  description = "The prefix for all resources"
}

variable "location" {
  type        = string
  description = "The Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "bastion_subnet_id" {
  type        = string
  description = "The ID of the AzureBastionSubnet"
}

variable "jumpbox_subnet_id" {
  type        = string
  description = "The ID of the jumpbox subnet"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
