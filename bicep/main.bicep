@description('Name of the App Service Plan')
param appServicePlanName string = 'myAppServicePlan'

@description('Name of the Web App')
param webAppName string = 'mywebapp${uniqueString(resourceGroup().id)}'

@description('Location for all resources')
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    capacity: 1
  }
  properties: {
    reserved: false
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
