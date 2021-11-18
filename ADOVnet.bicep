param vnetname string
param addressprefix string
param subnetname string
param subnwtadd string


resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name : vnetname
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressprefix
      ]
    }
      
  subnets: [
    {
      name:subnetname
      properties: {
        addressPrefix:subnwtadd
        privateEndpointNetworkPolicies: 'Enabled'
        privateLinkServiceNetworkPolicies: 'Enabled'
      }
    }
    
  ]
  }
}

output subnetid string = vnet.id
