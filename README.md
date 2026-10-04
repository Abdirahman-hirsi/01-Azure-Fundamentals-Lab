# Azure Fundamentals Lab

**Status:** In Progress — Infrastructure Designed and Locally Validated  
**Focus:** Microsoft Azure | Infrastructure as Code | Networking | Security  
**Tools:** Terraform, Azure CLI, PowerShell, VS Code, Git and GitHub

## 1. Project Overview

This project documents my hands-on learning journey towards becoming a Cloud Engineer, with a focus on Azure infrastructure, networking, security, automation and troubleshooting.

The objective is to design, deploy and manage a secure, maintainable and cost-conscious Azure environment.

The project is being prepared locally before activating an Azure subscription.

## 2. Business Scenario

A fictional company needs a secure Azure environment to host an application.

The infrastructure should provide network isolation, controlled access, monitoring and a foundation for future expansion.

Terraform is used to define the infrastructure as code, making the configuration reproducible and version-controlled.

## 3. Current Architecture

The initial Terraform configuration contains:

| Component | Configuration |
|---|---|
| Resource Group | rg-azure-lab-01 |
| Azure Region | West Europe |
| Virtual Network | vnet-azure-lab-01 |
| VNet Address Space | 10.0.0.0/16 |
| Subnet | snet-lab-01 |
| Subnet Address Range | 10.0.1.0/24 |
| Network Security Group | nsg-lab-01 |
| Security Rule | Deny inbound RDP from the Internet on TCP port 3389 |

The Network Security Group is associated with the subnet.

**Deployment status:** These resources have been defined in Terraform but have not yet been deployed to Azure.

## 4. Implementation and Validation

The following activities have been completed:

- Installed and configured Terraform and Azure CLI.
- Created the initial Terraform project structure.
- Defined the Azure Resource Group, Virtual Network and subnet.
- Configured a Network Security Group and an inbound RDP deny rule.
- Associated the Network Security Group with the subnet.
- Successfully initialized Terraform using `terraform init`.
- Successfully validated the configuration using `terraform validate`.
- Configured Git version control and published the project to GitHub.

Terraform validation confirms that the configuration is structurally valid. Deployment and runtime functionality have not yet been verified.

## 5. Security and Cost Management

The project follows a security-first approach.

An explicit inbound security rule blocks RDP traffic originating from the Internet. Additional network segmentation and access controls will be developed in later stages.

Temporary Terraform files, state files and local variable files are excluded from Git using `.gitignore`.

The Azure subscription has not yet been activated. Infrastructure will be reviewed for potential costs before deployment.

## 6. Planned Improvements

- Create and document the network architecture diagram.
- Design separate application and management subnets.
- Configure additional Network Security Group rules.
- Prepare identity and access management using Azure RBAC.
- Introduce Azure Monitor and Log Analytics.
- Develop PowerShell automation scripts.
- Deploy and test the infrastructure after activating an Azure subscription.
- Document troubleshooting, validation results and lessons learned.

## 7. Troubleshooting and Lessons Learned

Each technical issue will be documented using the following structure:

1. Problem and expected behaviour.
2. Investigation and diagnostic commands.
3. Root cause.
4. Implemented solution.
5. Verification and lessons learned.

This documentation will provide evidence of practical troubleshooting and engineering skills.

## 8. Project Evidence

The repository will contain Terraform configuration files, architecture diagrams, PowerShell scripts and relevant validation screenshots.

Credentials, access tokens and other sensitive information will not be published.