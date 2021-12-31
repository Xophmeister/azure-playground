## Azure Databricks Workspace ##########################################

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "group" {
  name     = var.prefix
  location = var.location
}

resource "azurerm_databricks_workspace" "workspace" {
  name                = "${var.prefix}-workspace"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  sku                 = "premium"
}

## Databricks Cluster ##################################################

provider "databricks" {
  host = azurerm_databricks_workspace.workspace.workspace_url
}

# FIXME This will be the Service Principal, so we have to do some
# manual user management...
data "databricks_current_user" "me" {
  depends_on = [azurerm_databricks_workspace.workspace]
}

data "databricks_spark_version" "latest" {
  latest = true
  gpu    = false
  ml     = false

  depends_on = [azurerm_databricks_workspace.workspace]
}

data "databricks_node_type" "smallest" {
  local_disk = true

  depends_on = [azurerm_databricks_workspace.workspace]
}
