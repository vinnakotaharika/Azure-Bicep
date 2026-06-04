@description('Name of the Key Vault')
param keyVaultName string

@description('Location for the Key Vault')
param location string 

@description('Tenant ID of the Azure Active Directory')
param tenantId string 

@description('Object ID of a user, group, or service principal to grant access')
param objectId string 

@description('SKU for the Key Vault (standard or premium)')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: tenantId
    sku: {
      name: skuName
      family: 'A'
    }
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: objectId
        permissions: {
          keys: [
            'get'
            'list'
            'create'
            'delete'
            'update'
          ]
          secrets: [
            'get'
            'list'
            'set'
            'delete'
          ]
          certificates: [
            'get'
            'list'
          ]
        }
      }
    ]
    enabledForDeployment: false
    enabledForTemplateDeployment: false
    enabledForDiskEncryption: false
  }
}
