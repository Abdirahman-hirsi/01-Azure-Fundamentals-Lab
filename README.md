# Azure Fundamentals Lab

**Status:** In Progress — Infrastructure Designed and Locally Validated  
**Focus:** Microsoft Azure | Infrastructure as Code | Networking | Security  
**Tools:** Terraform, Azure CLI, PowerShell, VS Code, Git and GitHub

## 1. Project Overview

This project documents my practical learning journey towards becoming a Cloud Engineer, focusing on Azure infrastructure, networking, security, automation and troubleshooting.

The objective is to design, deploy and manage a secure, maintainable and cost-conscious Azure environment using Infrastructure as Code (IaC).

The infrastructure is currently being developed and validated locally before activating an Azure subscription.

## 2. Business Scenario

A fictional company requires a secure Azure environment to host an application and support its IT operations.

The environment needs separate networks for general lab resources, application workloads and management activities. Network Security Groups provide a foundation for controlling communication between these environments.

Terraform is used to define the infrastructure, making the configuration reproducible, maintainable and version-controlled.

## 3. Current Architecture

The following infrastructure has been defined in Terraform:

| Component | Configuration |
|---|---|
| Resource Group | `rg-azure-lab-01` |
| Azure Region | West Europe |
| Virtual Network | `vnet-azure-lab-01` |
| VNet Address Space | `10.0.0.0/16` |
| Lab Subnet | `snet-lab-01` — `10.0.1.0/24` |
| Application Subnet | `snet-app-01` — `10.0.2.0/24` |
| Management Subnet | `snet-management-01` — `10.0.3.0/24` |
| Lab NSG | `nsg-lab-01` |
| Application NSG | `nsg-app-01` |
| Management NSG | `nsg-management-01` |

Each subnet has its own associated Network Security Group.

### Network Architecture Diagram

[View the network architecture diagram](evidence/architecture.md)

### Security Rules

| NSG | Security Rule | Priority | Action |
|---|---|---|---|
| `nsg-lab-01` | Deny inbound Internet RDP traffic on TCP port 3389 | 100 | Deny |
| `nsg-app-01` | Deny inbound traffic from `10.0.1.0/24` to `10.0.2.0/24` | 100 | Deny |
| `nsg-management-01` | Azure default security rules | — | Default |

The application subnet is protected against incoming traffic from the lab subnet.

This is an initial network segmentation measure. Additional rules are required to implement a comprehensive isolation policy between the three subnets.

**Deployment status:** All resources are currently defined in Terraform. They have not yet been deployed to Azure.

## 4. Implementation and Validation

The following activities have been completed:

- Installed Terraform and Azure CLI.
- Configured VS Code, PowerShell, Git and GitHub.
- Created the Terraform project structure.
- Defined an Azure Resource Group and Virtual Network.
- Created separate lab, application and management subnets.
- Configured and associated a dedicated NSG with each subnet.
- Defined an explicit inbound RDP deny rule.
- Added a rule blocking traffic from the lab subnet to the application subnet.
- Created and documented the network architecture diagram.
- Initialized Terraform and successfully validated the configuration.
- Published the project and its development history to GitHub.

### Local Validation

The following commands have been executed successfully:

```powershell
terraform init
terraform fmt
terraform validate -no-color
```

Terraform validation confirms that the configuration is structurally valid. It does not verify whether the infrastructure can be successfully deployed or whether the security rules behave as intended in Azure.

## 5. Security and Cost Management

Security and cost awareness are central to this project.

Each subnet has a dedicated NSG to support independently managed network policies. Explicit deny rules have been introduced for Internet-originated RDP traffic to the lab subnet and lab-to-application traffic.

Terraform working directories, state files and local variable files are excluded from Git using `.gitignore`. The Terraform provider lock file is retained for reproducibility.

No Azure subscription has been activated for this project. Deployment costs will be reviewed before creating cloud resources.

## 6. Planned Improvements

- Design and implement additional network segmentation rules.
- Define controlled access to the management subnet.
- Prepare identity and access management using Microsoft Entra ID and Azure RBAC.
- Introduce Azure Monitor and Log Analytics.
- Develop PowerShell automation scripts.
- Review Azure resource costs and deployment requirements.
- Deploy and test the infrastructure after activating an Azure subscription.
- Document troubleshooting, validation results and lessons learned.

## 7. Troubleshooting and Lessons Learned

Technical issues will be documented using the following structure:

1. Problem and expected behaviour.
2. Investigation and diagnostic commands.
3. Root cause.
4. Implemented solution.
5. Verification and lessons learned.

This documentation will demonstrate the development of practical troubleshooting and engineering skills.

## 8. Project Evidence

The repository contains:

- [Terraform infrastructure configuration](terraform/)
- [Network architecture diagram](evidence/architecture.md)
- Git commit history documenting the development process

Future evidence will include deployment results, relevant validation screenshots, PowerShell scripts and troubleshooting documentation.

Credentials, access tokens and other sensitive information will not be published.