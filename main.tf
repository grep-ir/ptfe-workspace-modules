variable "name" {}
variable "location" {}
variable "username" {}
variable "password" {}

variable "vnet_address_spacing" {
  type = "list"
}

variable "subnet_address_prefixes" {
  type = "list"
}

module "networking" {
  source  = "cmm-training.digitalinnovation.dev/dvalentine-org/networking/azurerm"
  version = "0.12.0"

  name                    = var.name
  location                = var.location
  vnet_address_spacing    = var.vnet_address_spacing
  subnet_address_prefixes = var.subnet_address_prefixes
}

module "webserver" {
  source  = "cmm-training.digitalinnovation.dev/dvalentine-org/webserver/azurerm"
  version = "0.12.0"

  name      = var.name
  location  = var.location
  subnet_id = module.networking.subnet-ids[0]
  vm_count  = 1
  username  = var.username
  password  = var.password
}

module "appserver" {
  source  = "cmm-training.digitalinnovation.dev/dvalentine-org/appserver/azurerm"
  version = "0.12.0"

  name      = var.name
  location  = var.location
  subnet_id = module.networking.subnet-ids[1]
  vm_count  = 1
  username  = var.username
  password  = var.password
}

module "dataserver" {
  source  = "cmm-training.digitalinnovation.dev/dvalentine-org/dataserver/azurerm"
  version = "0.12.0"

  name      = var.name
  location  = var.location
  subnet_id = module.networking.subnet-ids[2]
  vm_count  = 1
  username  = var.username
  password  = var.password
}
