param vmname string
param asid string
param nicid string
//param osdiskid string
param disksku string
param ostype string
param diskname string



resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmname
  location: resourceGroup().location
  properties: {
    availabilitySet: {
     id: asid
    }
    hardwareProfile: {
     vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: ostype
        name: diskname
        createOption: 'FromImage'
        managedDisk: {
           storageAccountType: disksku
        }
        diskSizeGB:127
      }
    }
    osProfile: {
      computerName: vmname
      adminUsername: 'arth'
      adminPassword: 'Arthpatel007!007'
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    networkProfile: {
      networkInterfaces: [
       {
          id: nicid
       }
      ]
    }
  }
}



