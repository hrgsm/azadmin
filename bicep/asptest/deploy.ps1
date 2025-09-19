param(
    [string]$ResourceGroupName = "rg-webapp-bicep",
    [string]$Location = "eastus",
    [string]$DeploymentName = "webappDeployment",
    [string]$BicepFile = "main.bicep",
    [switch]$CleanupAfter    # <-- pass -CleanupAfter to auto-delete RG after deployment
)

Write-Host "=== Azure Web App Deployment Script ===" -ForegroundColor Cyan

# 1. Login (if not already)
Write-Host "Logging into Azure..."
az account show 1>$null 2>&1
if ($LASTEXITCODE -ne 0) {
    az login --tenant 3fef742d-b07d-442b-b77c-49281a8c98a0
}

# 2. Create Resource Group (idempotent)
Write-Host "Creating resource group: $ResourceGroupName in $Location ..."
az group create --name $ResourceGroupName --location $Location | Out-Null

# 3. Compile Bicep -> JSON
Write-Host "Compiling Bicep to JSON..."
bicep build $BicepFile --outdir .

# 4. Deploy
Write-Host "Deploying Web App..."
az deployment group create `
  --resource-group $ResourceGroupName `
  --name $DeploymentName `
  --template-file .\main.json `
  --query "properties.outputs" -o jsonc

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Deployment completed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Deployment failed!" -ForegroundColor Red
    exit 1
}

# 5. Optional Cleanup
if ($CleanupAfter) {
    Write-Host "Cleaning up resource group: $ResourceGroupName ..." -ForegroundColor Yellow
    az group delete --name $ResourceGroupName --yes --no-wait
    Write-Host "🧹 Cleanup initiated. Resources will be deleted asynchronously." -ForegroundColor Cyan
}
