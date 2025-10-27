# Azure Infrastructure Examples

**Author: Łukas Kołodziej (@lkolo-prez)**

A comprehensive collection of Azure infrastructure examples demonstrating maximum parametrization, elegant configuration management, and production-ready Terraform code using the latest Azure provider (v4.50.0).

## 🚀 Features

- **Latest Azure Provider**: Updated to azurerm v4.50.0 for cutting-edge Azure features
- **Maximum Parametrization**: Elegant `.tfvars` files for flexible, maintainable infrastructure
- **Multi-Environment Architecture**: Shared resources with DEV, UAT, and PROD environments
- **Production-Ready**: Security best practices, monitoring, and high availability
- **Modular Design**: Reusable components with clear separation of concerns

## 📁 Project Structure

```
azure-infra-examples/
├── shared/                          # Shared infrastructure resources
│   ├── main.tf                     # Shared resources configuration
│   ├── variables.tf                # Shared variables with maximum parametrization
│   ├── terraform.tfvars           # Elegant shared configuration
│   ├── outputs.tf                  # Shared resource outputs
│   └── versions.tf                 # Azure provider v4.50.0
├── environments/                   # Environment-specific configurations
│   ├── dev/                        # Development environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars       # DEV-specific elegant parametrization
│   │   ├── outputs.tf
│   │   └── versions.tf
│   ├── uat/                        # User Acceptance Testing environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars       # UAT-specific elegant parametrization
│   │   ├── outputs.tf
│   │   └── versions.tf
│   └── prod/                       # Production environment
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars       # PROD-specific elegant parametrization
│       ├── outputs.tf
│       └── versions.tf
└── README.md                       # This documentation
```

## 🏗️ Infrastructure Components

### Shared Resources
- **Resource Groups**: Multi-region resource group management
- **Log Analytics**: Centralized monitoring and logging
- **Key Vault**: Secure secrets management with network restrictions
- **Virtual Networks**: Hub-and-spoke network architecture

### Environment-Specific Resources
- **Storage Accounts**: Application and data storage with appropriate redundancy
- **Azure SQL Database**: Managed database services with high availability
- **Azure Container Registry**: Container image management
- **Azure Kubernetes Service (AKS)**: Container orchestration with auto-scaling
- **Azure App Service**: Web applications and APIs
- **Azure Functions**: Serverless compute
- **Azure API Management**: API gateway and management
- **Azure Front Door**: Global load balancing and CDN

## 🔧 Configuration Philosophy

### Maximum Parametrization
All configurations use centralized `.tfvars` files for maximum elegance and flexibility:

```hcl
# Example from terraform.tfvars
project_name = "azure-infra-examples"
author = "Łukas Kołodziej"
github_handle = "@lkolo-prez"
organization = "aircloud-pl"

# Environment-specific configurations
aks_configs = {
  "main" = {
    kubernetes_version         = "1.28.5"
    private_cluster_enabled    = true
    sku_tier                   = "Standard"
    # ... additional configuration
  }
}
```

### Environment Progression
- **DEV**: Basic configurations for development and testing
- **UAT**: Enhanced configurations with resource locks and monitoring
- **PROD**: Production-grade configurations with high availability and premium SKUs

## 🚀 Quick Start

### Prerequisites
- Terraform >= 1.5.0
- Azure CLI or Azure PowerShell
- Azure subscription with appropriate permissions

### Deployment Steps

1. **Configure Azure Authentication**
   ```bash
   az login
   az account set --subscription "your-subscription-id"
   ```

2. **Initialize Shared Resources**
   ```bash
   cd shared
   terraform init
   terraform plan -var-file="terraform.tfvars"
   terraform apply -var-file="terraform.tfvars"
   ```

3. **Deploy Environment-Specific Resources**
   ```bash
   cd ../environments/dev
   terraform init
   terraform plan -var-file="terraform.tfvars"
   terraform apply -var-file="terraform.tfvars"
   ```

## 📊 Environment Specifications

### Development (DEV)
- **Purpose**: Development and feature testing
- **Resource Locks**: Disabled
- **Redundancy**: Basic (LRS)
- **Monitoring**: Essential logging
- **Cost Optimization**: Minimal SKUs

### User Acceptance Testing (UAT)
- **Purpose**: Pre-production validation
- **Resource Locks**: CanNotDelete
- **Redundancy**: Standard (GRS)
- **Monitoring**: Enhanced logging and metrics
- **Cost Optimization**: Balanced performance/cost

### Production (PROD)
- **Purpose**: Live production workloads
- **Resource Locks**: CanNotDelete
- **Redundancy**: Premium (GZRS)
- **Monitoring**: Comprehensive observability
- **Cost Optimization**: High availability and performance

## 🔒 Security Features

- **Network Security**: Private endpoints and network restrictions
- **Access Control**: Role-based access control (RBAC)
- **Encryption**: Data at rest and in transit
- **Compliance**: Security best practices and configurations
- **Monitoring**: Security event logging and alerting

## 📈 Monitoring & Observability

- **Log Analytics**: Centralized log collection and analysis
- **Application Insights**: Application performance monitoring
- **Azure Monitor**: Infrastructure and service monitoring
- **Diagnostic Settings**: Comprehensive resource diagnostics

## 🏷️ Tagging Strategy

All resources are tagged with consistent metadata:

```hcl
tags = {
  Project      = "azure-infra-examples"
  Author       = "Łukas Kołodziej"
  GitHub       = "@lkolo-prez"
  Organization = "aircloud-pl"
  ManagedBy    = "terraform"
  Environment  = "dev|uat|prod"
  CostCenter   = "development|testing|production"
  Purpose      = "infrastructure"
}
```

## 🔄 CI/CD Integration

The infrastructure is designed for automated deployment:

- **State Management**: Remote state with locking
- **Module Dependencies**: Clear dependency management
- **Parameter Overrides**: Environment-specific configurations
- **Validation**: Automated testing and validation

## 🤝 Contributing

**Author: Łukas Kołodziej (@lkolo-prez)**

1. Fork the repository
2. Create a feature branch
3. Make your changes with proper parametrization
4. Update documentation
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Azure Terraform provider team for excellent documentation
- HashiCorp Terraform for infrastructure as code excellence
- Microsoft Azure for comprehensive cloud services

---

**Author: Łukas Kołodziej (@lkolo-prez)**  
*Maximum parametrization, elegant infrastructure, production-ready Azure deployments*
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
