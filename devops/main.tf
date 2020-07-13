# Define Azure provider
provider "azurerm" {
    version = "2.14.0"
    features {}
}

# Create a new resource group
resource "azurerm_resource_group" "aks_rg" {
    name         = var.aks_rg
    location     = var.aks_location
    tags         = var.tags 
}

# Create a new storage account
resource "azurerm_storage_account" "aks_storage_account" {
  name                        = var.aks_storage_account_name
  location                    = var.aks_location
  resource_group_name         = azurerm_resource_group.aks_rg.name
  account_tier                = var.aks_storage_account_tier 
  account_replication_type    = var.aks_storage_replica_type 
  depends_on                  = [azurerm_resource_group.aks_rg]
  tags                        = var.tags
}

# Create a new storage container
resource "azurerm_storage_container" "aks_storage_container" {
  name                  = var.aks_storage_container_name
  storage_account_name  = azurerm_storage_account.aks_storage_account.name
  container_access_type = var.aks_storage_container_access 
  depends_on            = [azurerm_storage_account.aks_storage_account]
}

# Create azure key vault
resource "azurerm_key_vault" "azure_key_vault" {
  name                            = var.azure_key_vault
  location                        = var.aks_location
  resource_group_name             = azurerm_resource_group.aks_rg.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.azure_key_vault_sku
  soft_delete_enabled             = var.soft_delete_enabled
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  depends_on                      = [azurerm_resource_group.aks_rg]
  tags                            = var.tags

  access_policy {
    tenant_id          = data.azurerm_client_config.current.tenant_id
    object_id          = data.external.currnet_account.result.objectId
    key_permissions    = var.key_permissions
    secret_permissions = var.secret_permissions
  }

  network_acls {
    default_action = var.network_acls_action
    bypass         = var.network_acls_bypass
  }
}

# Create a workspace
resource "azurerm_log_analytics_workspace" "aks_workspace" {
    name                = var.aks_workspace
    location            = var.aks_location
    resource_group_name = azurerm_resource_group.aks_rg.name
    sku                 = var.aks_workspace_sku
    depends_on          = [azurerm_resource_group.aks_rg]
    tags                = var.tags
}

# Create a log analytics
resource "azurerm_log_analytics_solution" "aks_log_analytics" {
    solution_name         = var.aks_log_analytics
    location              = var.aks_location
    resource_group_name   = azurerm_resource_group.aks_rg.name
    workspace_resource_id = azurerm_log_analytics_workspace.aks_workspace.id
    workspace_name        = azurerm_log_analytics_workspace.aks_workspace.name
    depends_on            = [azurerm_log_analytics_workspace.aks_workspace]

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

# Create an application
resource "azuread_application" "aks_spn_app" {
 name = var.aks_spn_app
}

# Create a service principal
resource "azuread_service_principal" "aks_spn_app" {
  application_id = azuread_application.aks_spn_app.application_id
  depends_on     = [azuread_application.aks_spn_app]
}

# Grant SPN user contributor role
resource "azurerm_role_assignment" "aks_spn_role" {
  scope                = azurerm_resource_group.aks_rg.id
  role_definition_name = var.aks_snp_role 
  principal_id         = azuread_service_principal.aks_spn_app.object_id
  depends_on           = [azurerm_resource_group.aks_rg]
}

# Generate a randow password
resource "random_string" "spn_password" {
  length  = var.spn_password_length
  special = var.spn_password_special_char
}

# Create a Password for that Service Principal
resource "azuread_service_principal_password" "assign_spn_password" {
  service_principal_id = azuread_service_principal.aks_spn_app.object_id
  value                = random_string.spn_password.result
  end_date_relative    = var.spn_password_end_date 
  depends_on           = [azuread_service_principal.aks_spn_app, random_string.spn_password]
}

# Create azure key vault secret 
resource "azurerm_key_vault_secret" "key_vault_secret" {
  name            = azuread_service_principal.aks_spn_app.application_id
  value           = azuread_service_principal_password.assign_spn_password.value
  expiration_date = var.key_vault_secret_expiration_date
  key_vault_id    = azurerm_key_vault.azure_key_vault.id
  depends_on      = [azurerm_key_vault.azure_key_vault, azuread_service_principal_password.assign_spn_password]
  tags            = var.tags
}

# Create azure kubernetes cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name                = var.aks_cluster_name
    location            = var.aks_location
    resource_group_name = azurerm_resource_group.aks_rg.name
    dns_prefix          = var.aks_dns_prefix
    tags                = var.tags
    depends_on          = [azurerm_key_vault_secret.key_vault_secret]
    
    linux_profile {
        admin_username = var.admin_username

        ssh_key {
            key_data = file(var.aks_ssh_public_key)
        }
    }

    default_node_pool {
        name            = var.node_pool_name 
        node_count      = var.aks_agent_count
        vm_size         = var.node_pool_size 
    }

    service_principal {
        client_id     = azurerm_key_vault_secret.key_vault_secret.name
        client_secret = azurerm_key_vault_secret.key_vault_secret.value
    }

    addon_profile {
        oms_agent {
        enabled                    = var.oms_agent_enabled
        log_analytics_workspace_id = azurerm_log_analytics_workspace.aks_workspace.id
        }
    }
}

# Build a kubernetes environment 
resource "null_resource" "kube_cluster_build" {
  depends_on   = [azurerm_kubernetes_cluster.aks_cluster]
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
     command = "az aks get-credentials -n ${var.aks_cluster_name} -g ${var.aks_rg};kubectl create -f kubernetes_env_config/"
  }
}
