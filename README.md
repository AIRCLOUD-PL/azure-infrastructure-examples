<p align="center">
  <a href="https://aircloud.com.pl"><img src=".github/assets/banner.png" alt="AIRCLOUD: DevOps, cloud and AI engineering" width="100%"></a>
</p>

# azure-infrastructure-examples

**Azure Infrastructure Examples — multi-environment Terraform configurations built from AIRCLOUD modules.**

[![CI](https://github.com/AIRCLOUD-PL/azure-infrastructure-examples/actions/workflows/ci.yml/badge.svg)](https://github.com/AIRCLOUD-PL/azure-infrastructure-examples/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/AIRCLOUD-PL/azure-infrastructure-examples?sort=semver)](https://github.com/AIRCLOUD-PL/azure-infrastructure-examples/releases)

Parameter sets and scaffolding for running the AIRCLOUD Azure modules across several
environments. This repository is **not a module** and has no root configuration.

> **Status:** the repository currently holds the variable definitions for the UAT and PROD
> environments and two example stubs. For working, module-level examples see the
> `examples/` directory of each module repository (listed in the
> [module catalog](https://aircloud-pl.github.io/)).

## What's inside

```
azure-infrastructure-examples/
├── environments/
│   ├── uat/variables.tf     # UAT parameter set (naming prefixes, per-service config maps, locks, tags)
│   └── prod/variables.tf    # PROD parameter set (same shape, production defaults)
├── examples/
│   ├── simple/main.tf       # stub: module call skeleton
│   └── complete/main.tf     # stub: module call skeleton
└── test/examples_test.go    # Go test skeleton: checks that directories and docs exist
```

The environment variable files are organised by service: resource groups, virtual networks
and subnets, storage accounts, Azure SQL, Container Registry, AKS, App Service, Functions,
API Management, Front Door, monitoring (Log Analytics, Application Insights), resource locks
and tags. Each service is configured through a map of objects (for example
`aks_configs`, `sql_database_configs`), so an environment is described by data rather than code.

### Environment progression (design intent)

| | UAT | PROD |
| --- | --- | --- |
| Purpose | Pre-production validation | Live workloads |
| Resource locks | `CanNotDelete` | `CanNotDelete` |
| Storage redundancy | GRS | GZRS |
| Monitoring | Enhanced logging and metrics | Full observability |

## Usage

Consume the modules from your own root configuration with a pinned tag and feed them the
maps from an environment's variables:

```hcl
module "key_vault" {
  source = "git::https://github.com/AIRCLOUD-PL/azure-key-vault-module.git?ref=v1.0.0"
  # ...
}

module "aks" {
  source = "git::https://github.com/AIRCLOUD-PL/azure-aks-module.git?ref=v1.0.0"
  # ...
}
```

Check the repository locally the same way CI does:

```bash
git clone https://github.com/AIRCLOUD-PL/azure-infrastructure-examples.git
cd azure-infrastructure-examples
terraform fmt -check -recursive
```

### Tagging convention

All environments share one tag set:

```hcl
tags = {
  Project      = "azure-infra-examples"
  Organization = "aircloud-pl"
  ManagedBy    = "terraform"
  Environment  = "uat|prod"
  CostCenter   = "testing|production"
  Purpose      = "infrastructure"
}
```

## Contributing

1. Fork the repository and create a feature branch.
2. Keep configuration in variables/maps, not hard-coded values.
3. Run `terraform fmt -recursive` and update this README.
4. Open a pull request.

## License

MIT, see [LICENSE](LICENSE).

## Reference

<!-- BEGIN_TF_DOCS -->
This repository has no root module, so there are no generated inputs or outputs here.
See the module repositories for their generated reference.
<!-- END_TF_DOCS -->

---

## Part of the AIRCLOUD Azure module catalog

Browse all modules with usage snippets in the [module catalog](https://aircloud-pl.github.io/) or on [github.com/AIRCLOUD-PL](https://github.com/AIRCLOUD-PL). Built and maintained by [AIRCLOUD](https://aircloud.com.pl): DevOps, cloud and AI engineering. Need a hand with Azure landing zones or platform engineering? See [aircloud.com.pl/consulting](https://aircloud.com.pl/consulting).
