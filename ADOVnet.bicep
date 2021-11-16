param vnetname string
param addressprefix string
param subnetname string
param subnwt1add string


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
        addressPrefix:subnwt1add
        privateEndpointNetworkPolicies: 'Enabled'
        privateLinkServiceNetworkPolicies: 'Enabled'
      }
    }
    
  ]
  }
}
