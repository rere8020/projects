# Resource Group Varilables # 
#############################

# Define a resource group name
variable "aks_rg" { 
    type = string 
}

# Define a resource group location 
variable "aks_location" { 
    type = string 
}

# Define a tag 
variable "tags" { 
    type = map(string) 
}

# Storage Account Varilables # 
##############################

# Define a storage account name 
variable "aks_storage_account_name" { 
    type = string 
}

# Define a storage account tier 
variable "aks_storage_account_tier" { 
    type = string 
}

# Define a storage account replication type 
variable "aks_storage_replica_type" { 
    type = string 
}

# Define a storage container name 
variable "aks_storage_container_name" { 
    type = string 
}

# Define a storage container access type
variable "aks_storage_container_access" { 
    type = string 
}

# Key Vault Varilables # 
########################

# Define azure key vault name
variable "azure_key_vault" { 
    type = string 
}

# Define azure key vault sku
variable "azure_key_vault_sku" { 
    type = string 
}

# Specify Azure key vault to keep after deleation 
variable "soft_delete_enabled" { 
    type = bool 
}

# Specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault
variable "enabled_for_deployment" { 
    type = bool 
}

# Specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.
variable "enabled_for_disk_encryption" { 
    type = bool 
}

# Specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault
variable "enabled_for_template_deployment" { 
    type = bool 
}

# Specify requiring permissions for key permissions
variable "key_permissions" { 
    type = list(string) 
}

# Specify requiring permissions for secret permissions
variable "secret_permissions" { 
    type = list(string) 
}

# Specify network acl action
variable "network_acls_action" { 
    type = string
}

# Specif network acl bypass service
variable "network_acls_bypass" { 
    type = string
}

# Specif azure key vault expiration date
variable "key_vault_secret_expiration_date" { 
    type = string
}

# Workspace Varilables # 
########################

# Define a log analytics workspace name
variable "aks_workspace" { 
    type = string 
}

# Define a log analytics workspace sku
variable "aks_workspace_sku" { 
    type = string 
}

# Log analytics Varilables # 
############################

# Define log analytics name
variable "aks_log_analytics" { 
    type = string 
}

# Service Principle Varilables # 
################################

# Define a service principle name
variable "aks_spn_app" { 
    type = string 
}

# Define a service principle role
variable "aks_snp_role" { 
    type = string 
}

# Define enad date of a service principle password
variable "spn_password_end_date" { 
    type = string 
}

# Random password Varilables # 
##############################

# Define a random password length
variable "spn_password_length" { 
    type = number 
}

# Define special characters  
variable "spn_password_special_char" { 
    type = bool 
}

# Azure kubernetes Varilables # 
###############################

# Define azure kubernetes service name
variable "aks_cluster_name" { 
    type = string 
}

# Define azure aks dns name
variable "aks_dns_prefix" { 
    type = string 
}

# Define azure aks dns name
variable "admin_username" { 
    type = string 
}

# Define a public key location
variable "aks_ssh_public_key" { 
    type = string 
}

# Define a node pool name
variable "node_pool_name" { 
    type = string 
}

# Define a number of cluster nodes
variable "aks_agent_count" { 
    type = number 
}

# Define a node pool size
variable "node_pool_size" { 
    type = string 
}

# Define a OMG agent 
variable "oms_agent_enabled" { 
    type = bool 
}