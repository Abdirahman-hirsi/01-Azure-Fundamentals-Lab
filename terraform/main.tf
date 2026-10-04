
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Azure-provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Resource Group
resource "azurerm_resource_group" "lab" {
  name     = "rg-azure-lab-01"
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "lab" {
  name                = "vnet-azure-lab-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

# Subnet
resource "azurerm_subnet" "lab" {
  name                 = "snet-lab-01"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "lab" {
  name                = "nsg-lab-01"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

# Koppel de Network Security Group aan het subnet
resource "azurerm_subnet_network_security_group_association" "lab" {
  subnet_id                 = azurerm_subnet.lab.id
  network_security_group_id = azurerm_network_security_group.lab.id
}

# Blokkeer inkomend RDP-verkeer vanaf het internet
resource "azurerm_network_security_rule" "deny_rdp" {
  name                       = "Deny-RDP-Internet"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Deny"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3389"
  source_address_prefix      = "Internet"
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.lab.name
  network_security_group_name = azurerm_network_security_group.lab.name
}

# Application Subnet
resource "azurerm_subnet" "app" {
  name                 = "snet-app-01"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Management Subnet
resource "azurerm_subnet" "management" {
  name                 = "snet-management-01"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Application Network Security Group
resource "azurerm_network_security_group" "app" {
  name                = "nsg-app-01"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

# Management Network Security Group
resource "azurerm_network_security_group" "management" {
  name                = "nsg-management-01"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

# Associate application NSG with application subnet
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}

# Associate management NSG with management subnet
resource "azurerm_subnet_network_security_group_association" "management" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.management.id
}
# Block traffic from lab subnet to application subnet
resource "azurerm_network_security_rule" "deny_lab_to_app" {
  name                       = "Deny-Lab-To-App"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Deny"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "10.0.1.0/24"
  destination_address_prefix = "10.0.2.0/24"

  resource_group_name         = azurerm_resource_group.lab.name
  network_security_group_name = azurerm_network_security_group.app.name
}