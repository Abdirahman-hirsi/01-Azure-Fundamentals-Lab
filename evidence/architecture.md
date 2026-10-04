
# Azure Lab — Network Architecture

**Status:** Designed and locally validated. Not yet deployed to Azure.

## Infrastructure Diagram

```mermaid
flowchart TB
    RG["Azure Resource Group<br/>rg-azure-lab-01"]
    VNET["Virtual Network<br/>vnet-azure-lab-01<br/>10.0.0.0/16"]
    SUBNET["Subnet<br/>snet-lab-01<br/>10.0.1.0/24"]
    NSG["Network Security Group<br/>nsg-lab-01"]
    RULE["Inbound Security Rule<br/>Deny Internet RDP<br/>TCP 3389 | Priority 100"]

    RG --> VNET
    VNET --> SUBNET
    NSG -. Associated with .-> SUBNET
    NSG --> RULE
```

## Architecture Decisions

- **Resource Group:** Organizes all resources belonging to the lab.
- **Virtual Network:** Provides a private Azure network with address space `10.0.0.0/16`.
- **Subnet:** Reserves `10.0.1.0/24` for the initial lab resources.
- **Network Security Group:** Controls network traffic and is associated with the subnet.
- **RDP Security Rule:** Explicitly denies inbound TCP port 3389 traffic originating from the Internet.

## Validation

The Terraform configuration has successfully passed:

- `terraform init`
- `terraform fmt`
- `terraform validate`

The infrastructure has not yet been deployed or tested in Azure.
