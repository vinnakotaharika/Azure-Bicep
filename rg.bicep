resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'harisa'
  location: 'eastus'
  kind: 'StorageV2'
  sku: {
    name: 'standard_LRS'
  }
}
