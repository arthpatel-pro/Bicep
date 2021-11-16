targetScope = 'subscription'
param resourceGroup string = 'ADO'
param SubscriptionID string = 'cf10f7d1-3197-497c-a41b-a2a862604862'

param vnetname string = 'Bicep-vnet'
param addressprefix string = '192.168.1.0/24'
param subnetname string = 'Bicep-vnet-sub1'
param subnwt1add string = '192.168.1.0/26'

param asname string = 'bicep-as'

param vm1publicip string = 'bicep-vm1-pip'

param vm1netinf string = 'bicep-vm-nic'
param vm1nsg string = 'bicep-vm-nic-nsg' 

param vm1name string = 'Bicep-vm1'


resource bwbRG 'Microsoft.Resources/resourceGroups@2021-04-01' =  {
  name: resourceGroup1
  location: 'East US'
}



module networkcreate 'creatvnet.bicep' = {
  name: 'Vnet-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    vnetname:vnetname
    addressprefix : addressprefix
    subnetname: subnetname
    subnwt1add: subnwt1add
    
  }
}
var vnetid = networkcreate.outputs.subnetid



module avaibilityset 'creatavset.bicep' = {
  name : 'as-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    asname:asname
  }
}
var asid2 = avaibilityset.outputs.asid


module vm1pip 'creatpip.bicep' = {
  name : 'vm1-pip-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    publicIP:vm1publicip
  }
}
var vm1pipid = vm1pip.outputs.pipid

module vm1nic 'creatnic.bicep' = {
  name : 'nic-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
     subnetname:subnetname
      vm1pipid: vm1pipid
      vnetid:vnetid
      nsg:vm1nsg
      netinf:vm1netinf
  }
}
var vm1nicid = vm1nic.outputs.nicid

module vmcreate 'creatvm.bicep' = {
  name : 'vm-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    vmname:vm1name
    asid:asid2
    nicid:vm1nicid
   // osdiskid:osdiskid
    disksku:disksku
    ostype:ostype
    diskname:vm1diskname
  }
}
