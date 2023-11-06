# General variables
variable "location" {
  description = "The resource group location"
  default     = "Central Us"
}
# Hub variables
variable "spoke_resource_group_name" {
  description = "The resource group name to be created"
  default     = ""
}
# Terraform State Storage Account variables
variable "backendAzureRmResourceGroupName" {
  description = "backendAzureRmResourceGroupName"
  type        = string
}
variable "backendAzureRmStorageAccountName" {
  description = "backendAzureRmStorageAccountName"
  type        = string
}
variable "backendAzureRmContainerName" {
  description = "backendAzureRmContainerName"
  type        = string
}
variable "backendAzureRmKey" {
  description = "backendAzureRmKey"
  type        = string
}
