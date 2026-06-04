resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'windowsVM'
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_A2_v2'
    }
    osProfile: {
      computerName: 'windowsVM'
      adminUsername: 'adminUser'
      adminPassword: 'P@ssw0rd1234!'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'osDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: 'networkInterface.id'
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri:  'https://harisa.blob.${environment().suffixes.storage}/vm-boot-diagnostics'
      }
    }
  }
}
