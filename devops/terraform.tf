terraform { 
    backend "azurerm" {
        resource_group_name    = "azure-aks-cluster"
        storage_account_name   = "aksstorageaccount01"
        container_name         = "tfstate"
        key                    = "aks_cluster.tfstate" 
    }    
}    