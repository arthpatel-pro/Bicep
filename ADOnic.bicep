param vm1pipid string
param subnetname string
param vnetid string
param netinf string 
param nsg string 

resource nicnsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: nsg
  location:resourceGroup().location
  properties: {
    securityRules: [
      
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: netinf
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
       {
         name: 'bicep-vm-private-ip'
          properties: {
            privateIPAddress: '192.168.1.20'
           privateIPAllocationMethod: 'Static'
           publicIPAddress: {
             id : vm1pipid
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
