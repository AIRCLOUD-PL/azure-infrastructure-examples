# Variables for UAT environment configuration
# Author: Łukas Kołodziej (@lkolo-prez)
# Maximum parametrization for elegance and flexibility

# =============================================================================
# GLOBAL CONFIGURATION
# =============================================================================

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "azure-infra-examples"
}

variable "author" {
  description = "Author of the infrastructure code"
  type        = string
  default     = "Łukas Kołodziej"
}

variable "github_handle" {
  description = "GitHub handle of the author"
  type        = string
  default     = "@lkolo-prez"
}

variable "organization" {
  description = "Organization name"
  type        = string
  default     = "aircloud-pl"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  default     = ""
}

variable "location" {
  description = "Default Azure region"
  type        = string
  default     = "East US"
}

# =============================================================================
# ENVIRONMENT-SPECIFIC RESOURCE GROUPS
# =============================================================================

variable "uat_resource_group_prefix" {
  description = "Prefix for uat resource group names"
  type        = string
  default     = "rg-uat-infra"
}

variable "uat_regions" {
  description = "Map of regions and their locations for uat resources"
  type        = map(string)
  default = {
    "eastus" = "East US"
  }
}

# =============================================================================
# VIRTUAL NETWORKS & SUBNETS
# =============================================================================

variable "uat_vnet_prefix" {
  description = "Prefix for uat virtual network names"
  type        = string
  default     = "vnet-uat"
}

variable "spoke_address_spaces" {
  description = "Address spaces for spoke virtual networks per region"
  type        = map(string)
  default = {
    "eastus" = "10.20.0.0/16"
  }
}

variable "uat_app_subnets" {
  description = "Application subnet configuration per region"
  type = map(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = {
    "eastus" = {
      name              = "snet-app"
      address_prefixes  = ["10.20.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
    }
  }
}

variable "uat_data_subnets" {
  description = "Data subnet configuration per region"
  type = map(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = {
    "eastus" = {
      name              = "snet-data"
      address_prefixes  = ["10.20.2.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
    }
  }
}

# =============================================================================
# STORAGE ACCOUNTS
# =============================================================================

variable "uat_storage_account_prefix" {
  description = "Prefix for uat storage account names"
  type        = string
  default     = "stuatuat"
}

variable "storage_account_configs" {
  description = "Storage account configurations"
  type = map(object({
    account_tier              = string
    account_replication_type  = string
    enable_https_traffic_only = bool
    min_tls_version           = string
  }))
  default = {
    "app" = {
      account_tier              = "Standard"
      account_replication_type  = "LRS"
      enable_https_traffic_only = true
      min_tls_version           = "TLS1_2"
    }
    "data" = {
      account_tier              = "Standard"
      account_replication_type  = "GRS"
      enable_https_traffic_only = true
      min_tls_version           = "TLS1_2"
    }
  }
}

# =============================================================================
# AZURE SQL DATABASE
# =============================================================================

variable "uat_sql_server_prefix" {
  description = "Prefix for uat SQL server names"
  type        = string
  default     = "sql-uat"
}

variable "sql_server_configs" {
  description = "SQL server configurations"
  type = map(object({
    version                       = string
    administrator_login           = string
    minimum_tls_version           = string
    public_network_access_enabled = bool
  }))
  default = {
    "main" = {
      version                       = "12.0"
      administrator_login           = "sqladmin"
      minimum_tls_version           = "1.2"
      public_network_access_enabled = false
    }
  }
}

variable "sql_database_configs" {
  description = "SQL database configurations"
  type = map(object({
    sku_name       = string
    max_size_gb    = number
    zone_redundant = bool
  }))
  default = {
    "appdb" = {
      sku_name       = "S0"
      max_size_gb    = 250
      zone_redundant = false
    }
    "datadb" = {
      sku_name       = "S1"
      max_size_gb    = 250
      zone_redundant = true
    }
  }
}

# =============================================================================
# AZURE CONTAINER REGISTRY
# =============================================================================

variable "uat_acr_prefix" {
  description = "Prefix for uat ACR names"
  type        = string
  default     = "acruat"
}

variable "acr_configs" {
  description = "ACR configurations"
  type = map(object({
    sku                           = string
    admin_enabled                 = bool
    public_network_access_enabled = bool
  }))
  default = {
    "main" = {
      sku                           = "Standard"
      admin_enabled                 = true
      public_network_access_enabled = false
    }
  }
}

# =============================================================================
# AZURE KUBERNETES SERVICE (AKS)
# =============================================================================

variable "uat_aks_prefix" {
  description = "Prefix for uat AKS cluster names"
  type        = string
  default     = "aks-uat"
}

variable "aks_configs" {
  description = "AKS cluster configurations"
  type = map(object({
    kubernetes_version      = string
    private_cluster_enabled = bool
    sku_tier                = string
    network_plugin          = string
    network_policy          = string
    load_balancer_sku       = string
    outbound_type           = string
    enable_auto_scaling     = bool
    min_count               = number
    max_count               = number
    max_pods                = number
    os_disk_size_gb         = number
    os_disk_type            = string
    vm_size                 = string
  }))
  default = {
    "main" = {
      kubernetes_version      = "1.28.5"
      private_cluster_enabled = true
      sku_tier                = "Standard"
      network_plugin          = "azure"
      network_policy          = "azure"
      load_balancer_sku       = "standard"
      outbound_type           = "loadBalancer"
      enable_auto_scaling     = true
      min_count               = 2
      max_count               = 5
      max_pods                = 110
      os_disk_size_gb         = 128
      os_disk_type            = "Managed"
      vm_size                 = "Standard_DS2_v2"
    }
  }
}

# =============================================================================
# AZURE APP SERVICE
# =============================================================================

variable "uat_app_service_prefix" {
  description = "Prefix for uat app service names"
  type        = string
  default     = "app-uat"
}

variable "app_service_configs" {
  description = "App service configurations"
  type = map(object({
    sku_name = string
    os_type  = string
  }))
  default = {
    "web" = {
      sku_name = "S1"
      os_type  = "Linux"
    }
    "api" = {
      sku_name = "S1"
      os_type  = "Linux"
    }
  }
}

# =============================================================================
# AZURE FUNCTIONS
# =============================================================================

variable "uat_function_app_prefix" {
  description = "Prefix for uat function app names"
  type        = string
  default     = "func-uat"
}

variable "function_app_configs" {
  description = "Function app configurations"
  type = map(object({
    sku_name          = string
    os_type           = string
    runtime           = string
    runtime_version   = string
    functions_version = string
  }))
  default = {
    "processor" = {
      sku_name          = "B1"
      os_type           = "Linux"
      runtime           = "python"
      runtime_version   = "3.9"
      functions_version = "~4"
    }
  }
}

# =============================================================================
# AZURE API MANAGEMENT
# =============================================================================

variable "uat_apim_prefix" {
  description = "Prefix for uat API Management names"
  type        = string
  default     = "apim-uat"
}

variable "apim_configs" {
  description = "API Management configurations"
  type = map(object({
    sku_name        = string
    capacity        = number
    publisher_name  = string
    publisher_email = string
  }))
  default = {
    "main" = {
      sku_name        = "Basic"
      capacity        = 1
      publisher_name  = "Łukas Kołodziej"
      publisher_email = "lukas@aircloud.pl"
    }
  }
}

# =============================================================================
# AZURE FRONT DOOR
# =============================================================================

variable "uat_frontdoor_prefix" {
  description = "Prefix for uat Front Door names"
  type        = string
  default     = "afd-uat"
}

variable "frontdoor_configs" {
  description = "Front Door configurations"
  type = map(object({
    sku_name = string
  }))
  default = {
    "main" = {
      sku_name = "Standard_AzureFrontDoor"
    }
  }
}

# =============================================================================
# MONITORING & LOGGING
# =============================================================================

variable "uat_log_analytics_prefix" {
  description = "Prefix for uat Log Analytics workspace names"
  type        = string
  default     = "law-uat"
}

variable "uat_application_insights_prefix" {
  description = "Prefix for uat Application Insights names"
  type        = string
  default     = "appi-uat"
}

# =============================================================================
# SECURITY
# =============================================================================

variable "enable_uat_resource_locks" {
  description = "Enable resource locks for uat resources"
  type        = bool
  default     = true
}

variable "uat_resource_lock_level" {
  description = "Lock level for uat resources"
  type        = string
  default     = "CanNotDelete"
}

# =============================================================================
# TAGS
# =============================================================================

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project      = "azure-infra-examples"
    Author       = "Łukas Kołodziej"
    GitHub       = "@lkolo-prez"
    Organization = "aircloud-pl"
    ManagedBy    = "terraform"
    Environment  = "uat"
    CostCenter   = "testing"
    Purpose      = "user-acceptance-testing-infrastructure"
  }
}