param vmname string
param asid string
param nicid string
//param osdiskid string
param disksku string
param ostype string
param diskname string
param vmsize string
param publisher string
param offer string
param sku string
param version string
param disksize int
param Tags string

param VSTSAccountUrl string = 'https://dev.azure.com/IAC-Bicep'
param TeamProject string = 'Deploy VM'
param DeploymentGroup string = 'Testing'
param AgentName string = vmname
param PATToken string = 'bnyxodmny7twkizwcoocrbzexpcmfkvmkl3hqissrgnie5csytnq'
 

@secure()
param adminUsername string
param adminPassword string


resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmname
  location: resourceGroup().location
  properties: {
    availabilitySet: {
     id: asid
    }
    hardwareProfile: {
     vmSize: vmsize
    }
    storageProfile: {
      imageReference: {
        publisher: publisher
        offer: offer
        sku: sku
        version: version
      }
      osDisk: {
        osType: ostype
        name: diskname
        createOption: 'FromImage'
        managedDisk: {
           storageAccountType: disksku
        }
        diskSizeGB:disksize
      }
    }
    osProfile: {
      computerName: vmname
      adminUsername: adminUsername
      adminPassword: adminPassword
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

resource vmName_TeamServicesAgent 'Microsoft.Compute/virtualMachines/extensions@2015-06-15' = {
  name: 'TeamServicesAgent'
  location: resourceGroup().location
  parent: vm
  properties: {
    publisher: 'Microsoft.VisualStudio.Services'
    type: 'TeamServicesAgent'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    settings: {
      VSTSAccountUrl: VSTSAccountUrl
      TeamProject: TeamProject
      DeploymentGroup: DeploymentGroup
      AgentName: AgentName
      Tags: Tags
    }
    protectedSettings: {
      PATToken: PATToken
    }
  }
}

