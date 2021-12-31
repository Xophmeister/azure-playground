output "url" {
  value = "https://${azurerm_databricks_workspace.workspace.workspace_url}"
}

# Output data source values so we know what we're dealing with...
output "debug" {
  value = {
    me    = data.databricks_current_user.me
    spark = data.databricks_spark_version.latest
    size  = data.databricks_node_type.smallest
  }
}
