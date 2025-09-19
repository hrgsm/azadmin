# azadmin

## Resource Deployment Automation

This repository contains Bicep templates and PowerShell scripts to automate Azure resource creation. Two main resource examples are provided:

### 1. asptest (Web App Example)
- **Folder:** `bicep/asptest`
- **Resources:** Azure App Service Plan and Web App
- **Bicep File:** `main.bicep` defines the infrastructure for a basic web app.
- **Deployment Script:** `deploy.ps1` automates:
	- Azure login
	- Resource group creation
	- Bicep compilation
	- Deployment of the web app

**Usage:**
```powershell
cd bicep/asptest
./deploy.ps1
```

### 2. storagetest (Storage Account Example)
- **Folder:** `bicep/storagetest`
- **Resources:** Azure Storage Account
- **Bicep File:** `main.bicep` defines a parameterized storage account.
- **Deployment Script:** `deploy.ps1` automates:
	- Azure login
	- Resource group creation
	- Deployment of the storage account

**Usage:**
```powershell
cd bicep/storagetest
./deploy.ps1
```

---
Each folder is self-contained and can be used as a reference for deploying similar Azure resources using Bicep and PowerShell.
