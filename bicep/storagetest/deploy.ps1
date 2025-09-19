# deploy.ps1
# PowerShell script to deploy the local Bicep file for Azure Storage Account

param(
    [string]$ResourceGroupName = "azadmin-rg",
    [string]$Location = "eastus",
    [string]$StorageAccountName = "azadminstoragetest"
)

# Login to Azure (if not already logged in)
az login

# Create resource group if it doesn't exist
az group create --name $ResourceGroupName --location $Location

# Deploy the Bicep file
az deployment group create `
    --resource-group $ResourceGroupName `
    --template-file "$(Join-Path $PSScriptRoot 'main.bicep')" `
    --parameters storageAccountName=$StorageAccountName
