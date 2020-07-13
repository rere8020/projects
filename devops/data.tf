# Get a current user details
data "azurerm_client_config" "current" {}

# Get a current user details
data "external" "currnet_account" {
  program = ["az","ad","signed-in-user","show","--query","{displayName: displayName,userPrincipalName: userPrincipalName,objectId: objectId,objectType: objectType}"]
}
