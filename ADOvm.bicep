param vmname string
param asid string
param nicid string
//param osdiskid string
param disksku string
param ostype string
param diskname string

param VSTSAccountUrl string = "https://dev.azure.com/Ani007"
param TeamProject string = "HTTP to Https redirection testing"
param DeploymentGroup string = "Testing"
param AgentName string = ''
param PATToken string = "ggzgth3mm7qhk3o7ypubgtqqlut5vk7xbgitqlyuzowmystimska"



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

resource vmName_TeamServicesAgent 'Microsoft.Compute/virtualMachines/extensions@2015-06-15' = {
  name: '${vmName}/TeamServicesAgent'
  location: resourceGroup().location
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

