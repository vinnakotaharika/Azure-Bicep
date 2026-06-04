targetScope = 'subscription'

@description('The name of the resource group to create')
param resourceGroupName string

@description('The location of the resource group and resources')
param location string = 'eastus'

@description('The name of the storage account')
param storageAccountName string

@description('The name of the Key Vault')
param keyVaultName string

@description('The object ID to grant access in the Key Vault')
param objectId string = '243e445f-cffe-4285-a482-763cc4c07897'

@description('The tenant ID of the Azure Active Directory')
param tenantId string = '93f33571-550f-43cf-b09f-cd331338d086'

@description('The SKU of the storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
param skuName string = 'Standard_LRS'

@description('Name of the Virtual Machine')
param vmName string = 'windowsVM'

@description('Admin username for the VM')
param adminUsername string = 'adminUser'

@secure()
@description('Admin password for the VM')
param adminPassword string

// Create resource group
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
}

// Deploy Storage Account
module storage 'storage.bicep' = {
  name: 'storageDeploy'
  scope: resourceGroup(resourceGroupName)
  params: {
    storageAccountName: storageAccountName
    location: location
    skuName: skuName
  }
}

// Deploy Key Vault
module keyVault 'keyvault.bicep' = {
  name: 'keyVaultDeploy'
  scope: resourceGroup(resourceGroupName)
  params: {
    keyVaultName: keyVaultName
    location: location
    tenantId: tenantId
    objectId: objectId
    skuName: 'standard'
  }
}

// Deploy Windows VM
module vm 'vm.bicep' = {
  name: 'vmDeploy'
  scope: resourceGroup(resourceGroupName)
  params: {
    vmName: vmName
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
    storageAccountName: storageAccountName
  }
}
