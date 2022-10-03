#Creating Resource Group in Azure

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
    name = "bookRg"
    location = "West Europe"
    }

#Creating VNet in Azure
resource "azurerm_virtual_network" "vnet" {
    name = "book-vnet"
    location = "West Europe"
    address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "book-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = ["10.0.1.0/24"]
}

#Defining Network Interface Card
resource "azurerm_network_interface" "nic" {
    name = "book-nic"
    location = "West Europe"
    resource_group_name = azurerm_resource_group.rg.name
ip_configuration {
    name = "bookipconfig"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
    }
}
#Creating Public IP for NIC
resource "azurerm_public_ip" "pip" {
    name = "book-ip"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    allocation_method   = "Static"
    domain_name_label = "bookdevops"
}

#Creating Storage Account for the boot diagnostic logs
resource "azurerm_storage_account" "stor" {
    name = "bookstor"
    location = "West Europe"
    resource_group_name = azurerm_resource_group.rg.name
    account_tier = "Standard"
    account_replication_type = "LRS"
}


#Creating virtual machine
    resource "azurerm_virtual_machine" "vm" {
    name = "bookvm"
    location = "West Europe"
    resource_group_name = azurerm_resource_group.rg.name
    vm_size = "Standard_DS1_v2"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    
   storage_image_reference {
       publisher = "Canonical"
       offer = "UbuntuServer"
       sku = "16.04-LTS"
       version = "latest"
   }
   storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
    
  }
  tags = {
    environment = "staging"
  }


}