param vmpipid string
param subnetname string
param vnetid string
param privateip string
param netinf string 
param nsg string 
param privateipname string

resource nicnsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: nsg
  location:resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: [
            '122.182.14.98'
            '111.93.95.94'
            '115.119.250.30'
          ]
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: netinf
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
       {
         name: privateipname
          properties: {
            privateIPAddress: privateip
           privateIPAllocationMethod: 'Static'
           publicIPAddress: {
             id : vmpipid
           }
           subnet: {
             id : '${vnetid}/subnets/${subnetname}'
           }
           primary: true
           
           privateIPAddressVersion: 'IPv4'
           
          }
       }
    ]
    networkSecurityGroup: {
      id: nicnsg.id
    }
  }
  
}

output nicid string = nic.id
