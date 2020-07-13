# Resource Group Values # 
#########################
aks_rg       = "azure-aks-cluster"
aks_location = "ukwest"
tags         = { Environment = "Development"
                 Version     = "10.0.1"
               }

# Storage Account Values # 
##########################
aks_storage_account_name      = "aksstorageaccount01"
aks_storage_account_tier      = "Standard"
aks_storage_replica_type      = "GRS"
aks_storage_container_name    = "tfstate"
aks_storage_container_access  = "private"

# Azure Key Vault Values # 
##########################
azure_key_vault                   = "azure-keys-vault"
azure_key_vault_sku               = "standard"
soft_delete_enabled               = "false"
enabled_for_deployment            = "true"
enabled_for_disk_encryption       = "true"
enabled_for_template_deployment   = "true"
key_permissions                   = [ "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey","update", "verify", "wrapKey" ]
secret_permissions                = [ "backup", "delete", "get", "list", "purge", "recover", "restore", "set" ]
network_acls_action               = "Allow"
network_acls_bypass               = "AzureServices"
key_vault_secret_expiration_date  = "2021-01-01T12:00:00Z"

# Workspace Values # 
####################
aks_workspace     = "aks-workspace-cluster2020"
aks_workspace_sku = "free"

# Log analytics Values # 
########################
aks_log_analytics = "ContainerInsights"

# Service Principle Values # 
############################
aks_spn_app             = "aks_spn_app"
aks_snp_role            = "Contributor"
spn_password_end_date   = "8760h"

# Random password Values # 
##########################
spn_password_length        = 32
spn_password_special_char  = true

# Azure kubernetes Values # 
###########################
aks_cluster_name   = "aks-cluster"
aks_dns_prefix     = "aks-cluster"
admin_username     = "admin-aks"
aks_ssh_public_key = "~/.ssh/id_rsa.pub"
node_pool_name     = "agentpool"
aks_agent_count    = 3
node_pool_size     = "Standard_B2s"
oms_agent_enabled  = true