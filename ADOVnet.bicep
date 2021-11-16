param vnetname string = 'Bicep-Testvnet'
param addressprefix string = '192.168.1.0/24'
param subnetname string = 'Bicep-Testvnet-sub1'
param subnwt1add string = '192.168.1.0/26'

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
