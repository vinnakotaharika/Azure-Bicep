@description('The name of the storage account')
param storageAccountName string

@description('The location of the storage account')
param location string

@description('The SKU of the storage account')
param skuName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
