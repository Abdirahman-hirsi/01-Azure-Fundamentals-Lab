# Azure Lab — Network Architecture

**Status:** Designed and locally validated. Not yet deployed to Azure.

## Infrastructure Diagram

```mermaid
flowchart TB
    RG["Resource Group<br/>rg-azure-lab-01"]
    VNET["Virtual Network<br/>vnet-azure-lab-01<br/>10.0.0.0/16"]

    LAB["Lab Subnet<br/>snet-lab-01<br/>10.0.1.0/24"]
    APP["Application Subnet<br/>snet-app-01<br/>10.0.2.0/24"]
    MGMT["Management Subnet<br/>snet-management-01<br/>10.0.3.0/24"]

    NSG_LAB["NSG: nsg-lab-01"]
    NSG_APP["NSG: nsg-app-01"]
    NSG_MGMT["NSG: nsg-management-01"]

    RDP["Deny Internet RDP<br/>TCP 3389 | Inbound | Priority 100"]
    ISOLATION["Deny Lab to Application<br/>10.0.1.0/24 → 10.0.2.0/24<br/>Inbound | Priority 100"]

    RG --> VNET
    VNET --> LAB
    VNET --> APP
    VNET --> MGMT

    NSG_LAB -. Associated with .-> LAB
    NSG_APP -. Associated with .-> APP
    NSG_MGMT -. Associated with .-> MGMT

    NSG_LAB --> RDP
    NSG_APP --> ISOLATION
```

## Architecture Decisions

- **Resource Group:** Organizes all Azure resources belonging to the lab.
- **Virtual Network:** Uses the private address space `10.0.0.0/16`.
- **Lab Subnet:** Uses `10.0.1.0/24` for general lab resources.
- **Application Subnet:** Uses `10.0.2.0/24` for future application workloads.
- **Management Subnet:** Uses `10.0.3.0/24` for future management resources.
- **Network Security Groups:** Each subnet has a dedicated NSG, allowing independent security policies.

## Security Rules

| NSG | Rule | Priority | Action |
|---|---|---|---|
| nsg-lab-01 | Deny Internet RDP (TCP 3389) | 100 | Deny inbound |
| nsg-app-01 | Deny traffic from `10.0.1.0/24` to `10.0.2.0/24` | 100 | Deny inbound |
| nsg-management-01 | Azure default rules only | — | Default behavior |

The application NSG blocks traffic originating from the lab subnet. This is a first step toward network segmentation, not complete isolation.

Azure NSGs include default rules that permit communication within the same virtual network. Additional rules are required to restrict other traffic between the subnets.

## Validation

The Terraform configuration has successfully passed:

- `terraform init`
- `terraform fmt`
- `terraform validate -no-color`

The infrastructure has not yet been deployed or tested in Azure. No live connectivity or security testing has been performed.

## Planned Improvements

- Define explicit access policies between the lab, application and management subnets.
- Review management access and apply least-privilege network rules.
- Add monitoring and logging.
- Deploy and test the infrastructure after activating an Azure subscription.
