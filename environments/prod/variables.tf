# Variables for PROD environment configuration
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

variable "prod_resource_group_prefix" {
  description = "Prefix for prod resource group names"
  type        = string
  default     = "rg-prod-infra"
}

variable "prod_regions" {
  description = "Map of regions and their locations for prod resources"
  type        = map(string)
  default = {
    "eastus"     = "East US"
    "westeurope" = "West Europe"
  }
}

# =============================================================================
# VIRTUAL NETWORKS & SUBNETS
# =============================================================================

variable "prod_vnet_prefix" {
  description = "Prefix for prod virtual network names"
  type        = string
  default     = "vnet-prod"
}

variable "spoke_address_spaces" {
  description = "Address spaces for spoke virtual networks per region"
  type        = map(string)
  default = {
    "eastus"     = "10.30.0.0/16"
    "westeurope" = "10.31.0.0/16"
  }
}

variable "prod_app_subnets" {
  description = "Application subnet configuration per region"
  type = map(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = {
    "eastus" = {
      name              = "snet-app"
      address_prefixes  = ["10.30.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
    }
    "westeurope" = {
      name              = "snet-app"
      address_prefixes  = ["10.31.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
    }
  }
}

variable "prod_data_subnets" {
  description = "Data subnet configuration per region"
  type = map(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = {
    "eastus" = {
      name              = "snet-data"
      address_prefixes  = ["10.30.2.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
    }
    "westeurope" = {
      name              = "snet-data"
      address_prefixes  = ["10.31.2.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
    }
  }
}

# =============================================================================
# STORAGE ACCOUNTS
# =============================================================================

variable "prod_storage_account_prefix" {
  description = "Prefix for prod storage account names"
  type        = string
  default     = "stprod"
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
      account_replication_type  = "GRS"
      enable_https_traffic_only = true
      min_tls_version           = "TLS1_2"
    }
    "data" = {
      account_tier              = "Standard"
      account_replication_type  = "GZRS"
      enable_https_traffic_only = true
      min_tls_version           = "TLS1_2"
    }
  }
}

# =============================================================================
# AZURE SQL DATABASE
# =============================================================================

variable "prod_sql_server_prefix" {
  description = "Prefix for prod SQL server names"
  type        = string
  default     = "sql-prod"
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
      sku_name       = "S2"
      max_size_gb    = 500
      zone_redundant = true
    }
    "datadb" = {
      sku_name       = "P1"
      max_size_gb    = 1024
      zone_redundant = true
    }
  }
}

# =============================================================================
# AZURE CONTAINER REGISTRY
# =============================================================================

variable "prod_acr_prefix" {
  description = "Prefix for prod ACR names"
  type        = string
  default     = "acrprod"
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
      sku                           = "Premium"
      admin_enabled                 = false
      public_network_access_enabled = false
    }
  }
}

# =============================================================================
# AZURE KUBERNETES SERVICE (AKS)
# =============================================================================

variable "prod_aks_prefix" {
  description = "Prefix for prod AKS cluster names"
  type        = string
  default     = "aks-prod"
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
      min_count               = 3
      max_count               = 10
      max_pods                = 110
      os_disk_size_gb         = 256
      os_disk_type            = "Managed"
      vm_size                 = "Standard_DS3_v2"
    }
  }
}

# =============================================================================
# AZURE APP SERVICE
# =============================================================================

variable "prod_app_service_prefix" {
  description = "Prefix for prod app service names"
  type        = string
  default     = "app-prod"
}

variable "app_service_configs" {
  description = "App service configurations"
  type = map(object({
    sku_name = string
    os_type  = string
  }))
  default = {
    "web" = {
      sku_name = "P1V2"
      os_type  = "Linux"
    }
    "api" = {
      sku_name = "P1V2"
      os_type  = "Linux"
    }
  }
}

# =============================================================================
# AZURE FUNCTIONS
# =============================================================================

variable "prod_function_app_prefix" {
  description = "Prefix for prod function app names"
  type        = string
  default     = "func-prod"
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
      sku_name          = "P1V2"
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

variable "prod_apim_prefix" {
  description = "Prefix for prod API Management names"
  type        = string
  default     = "apim-prod"
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
      sku_name        = "Standard"
      capacity        = 2
      publisher_name  = "Łukas Kołodziej"
      publisher_email = "lukas@aircloud.pl"
    }
  }
}

# =============================================================================
# AZURE FRONT DOOR
# =============================================================================

variable "prod_frontdoor_prefix" {
  description = "Prefix for prod Front Door names"
  type        = string
  default     = "afd-prod"
}

variable "frontdoor_configs" {
  description = "Front Door configurations"
  type = map(object({
    sku_name = string
  }))
  default = {
    "main" = {
      sku_name = "Premium_AzureFrontDoor"
    }
  }
}

# =============================================================================
# MONITORING & LOGGING
# =============================================================================

variable "prod_log_analytics_prefix" {
  description = "Prefix for prod Log Analytics workspace names"
  type        = string
  default     = "law-prod"
}

variable "prod_application_insights_prefix" {
  description = "Prefix for prod Application Insights names"
  type        = string
  default     = "appi-prod"
}

# =============================================================================
# SECURITY
# =============================================================================

variable "enable_prod_resource_locks" {
  description = "Enable resource locks for prod resources"
  type        = bool
  default     = true
}

variable "prod_resource_lock_level" {
  description = "Lock level for prod resources"
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
    Environment  = "prod"
    CostCenter   = "production"
    Purpose      = "production-infrastructure"
    Criticality  = "high"
  }
}