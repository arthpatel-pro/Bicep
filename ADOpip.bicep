param publicIP string

resource pip 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name:publicIP
  location:resourceGroup().location
  sku: {
    name:'Basic'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  
  }
}
 output pipid string = pip.id
