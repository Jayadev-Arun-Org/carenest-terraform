# CareNest Infrastructure (carenest-terraform)

Welcome to the **CareNest Infrastructure** repository! This repository manages the cloud infrastructure for the CareNest platform using **Terraform** (Infrastructure as Code) on Microsoft Azure.

## ☁️ Infrastructure Overview

This repository provisions a highly secure, enterprise-grade architecture in the `jd-carenest-new-rg` Resource Group. The core components include:

- **Global Routing & Security:** Azure Front Door provides global load balancing and Web Application Firewall (WAF) capabilities, routing traffic via Azure Private Link to the regional origin.
- **Regional Ingress:** Azure Application Gateway sits within its own subnet to handle localized ingress routing to the cluster.
- **Compute:** Azure Kubernetes Service (AKS) (`jd-carenest-new-aks`) spanning multiple node pools (System and User workloads).
- **Secure Management:** An Azure Bastion Host provides secure, browser-based SSH access to a Linux Jumpbox VM deployed in a dedicated subnet, allowing for private `kubectl` management without exposing the cluster's API server.
- **Container Registry:** Azure Container Registry (ACR) for storing CareNest Docker images.
- **Data & Messaging:** Azure Cosmos DB (MongoDB API) for data persistence, Azure Service Bus for pub/sub messaging, and Azure Storage Accounts for Blob storage (e.g., prescriptions).
- **Generative AI:** Azure AI Foundry (East US) for handling LLM and diagnostic capabilities.
- **Secrets Management:** Azure Key Vault for securely storing all connection strings, webhooks, and JWT secrets.
- **Observability:** Azure Monitor Workspace (Prometheus), Log Analytics Workspace, and Application Insights for deep telemetry and metrics tracking.

## 🔒 Security & Private Endpoints

To ensure maximum security, none of the backend managed services are exposed to the public internet. 

We utilize a dedicated **Private Endpoint Subnet** inside the Virtual Network. Azure Private Link provides a private IP address for:
- Azure Key Vault
- Azure Container Registry
- Azure Cosmos DB
- Azure Service Bus
- Azure Storage Account
- Azure AI Foundry

The AKS cluster communicates with all these services securely over the internal VNet backbone. Authentication is handled passwordlessly via an **AKS User-Assigned Managed Identity**.

## 🚀 CI/CD & SAST Pipeline

This repository utilizes GitHub Actions (`.github/workflows/terraform.yml`) for continuous deployment. The pipeline incorporates a "Shift Left" security approach:

1. **Snyk (IaC Scanning):** Before any changes are planned, Snyk scans the Terraform configurations to block any high-severity cloud misconfigurations (e.g., exposing a storage account publicly).
2. **SonarCloud:** Analyzes the Terraform codebase for code quality, formatting, and technical debt.
3. **Terraform Plan & Apply:** If both security and quality gates pass, Terraform generates a plan and automatically applies the infrastructure changes to the Azure environment.

## 🛠️ Usage

To execute changes locally (from the Jumpbox):

1. **Login to Azure:**
   ```bash
   az login
   az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
   ```
2. **Initialize Terraform:**
   ```bash
   cd carenest-infrastructure
   terraform init
   ```
3. **Plan & Apply:**
   ```bash
   terraform plan -var-file="dev.tfvars"
   terraform apply -var-file="dev.tfvars"
   ```
