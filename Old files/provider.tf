
#method 1 for declaring provider
/*
provider "azurerm" {}
features {}

/*
subscription_id = "<subscription ID>"
client_id = "<Client ID>"
client_secret = "<Client Secret>"
tenant_id = "<Tenant Id>"
}



#method 2 for declaring provider not in the code ,but can get it from secure store like Azure Vault,hashicorp vault
provider "azurerm" {}

The following script exports the four Terraform environment variables in the Linux OS:
#export ARM_SUBSCRIPTION_ID=xxxxx-xxxxx-xxxx-xxxx
#export ARM_CLIENT_ID=xxxxx-xxxxx-xxxx-xxxx
#export ARM_CLIENT_SECRET=xxxxxxxxxxxxxxxxxx
#export ARM_TENANT_ID=xxxxx-xxxxx-xxxx-xxxx */


