//SubScription and RG settings
targetScope = 'subscription'
param resourceGroup1 string = 'ADO'
param SubscriptionID1 string = 'cf10f7d1-3197-497c-a41b-a2a862604862'


//General param
//Vnet param
param vnetname string = 'Bicep-vnet'
param addressprefix string = '192.168.1.0/24'
param subnet1name string = 'Bicep-vnet-sub1'
param subnwt1add string = '192.168.1.0/26'

// Avaibility Set param
param asname string = 'bicep-as'

//admin user
param adminUsername string = 'arth'
param adminPassword string = 'Arthpatel007!007'


//VM1 parameters
//Disk param
param vm1osdiskname string = 'Bicep-vm1-osdisk' 
param vm1osdisksku string = 'Standard_LRS'
param vm1ostype string = 'Windows'
param vm1osdiskpublisher string= 'MicrosoftWindowsServer'
param vm1osdiskoffer string= 'WindowsServer'
param vm1osdiskskutype string= '2019-Datacenter'
param vm1osdiskversion string= 'latest'
param vm1osdisksize int ='127'

//Public IP
param vm1publicip string = 'bicep-vm1-pip'

//Network interface
param vm1netinf string = 'bicep-vm-nic'
param vm1nsg string = 'bicep-vm-nic-nsg' 
param vm1privateipname string = 'bicep-vm-nic-privateip'
param vm1privateip string = '192.168.1.20'

//name and size
param vm1vmsize string = 'Standard_B2s'
param vm1name string = 'Bicep-vm1'

//Devops Tags
param vm1Tag1 string = 'Windows,WEB'



resource bwbRG 'Microsoft.Resources/resourceGroups@2021-04-01' =  {
  name: resourceGroup1
  location: 'East US'
}



module networkcreate 'ADOVnet.bicep' = {
  name: 'Vnet-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    vnetname:vnetname
    addressprefix : addressprefix
    subnetname: subnet1name
    subnwtadd: subnwt1add
    
  }
}
var vnetid = networkcreate.outputs.subnetid  //subnetid variable is actually containing vnet id but due to same variable name fake name has taken



module avaibilityset 'ADOas.bicep' = {
  name : 'as-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    asname:asname
  }
}
var asid2 = avaibilityset.outputs.asid


module vm1pip 'ADOpip.bicep' = {
  name : 'vm1-pip-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    publicIP:vm1publicip
  }
}
var vm1pipid = vm1pip.outputs.pipid

module vm1nic 'ADOnic.bicep' = {
  name : 'nic-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
     subnetname:subnet1name
      vmpipid: vm1pipid
      vnetid:vnetid
      nsg:vm1nsg
      netinf:vm1netinf
      privateip:vm1privateip
      privateipname:vm1privateipname
  }
}
var vm1nicid = vm1nic.outputs.nicid

module vm1create 'ADOvm.bicep' = {
  name : 'vm-create'
  scope: resourceGroup(SubscriptionID1,resourceGroup1)
  params: {
    vmname:vm1name
    asid:asid2
    nicid:vm1nicid
   // osdiskid:osdiskid
    disksku:vm1osdisksku
    ostype:vm1ostype
    diskname:vm1osdiskname
    adminUsername:adminUsername 
    adminPassword:adminPassword
    vmsize : vm1vmsize
    publisher:vm1osdiskpublisher
    offer:vm1osdiskoffer
    sku:vm1osdiskskutype
    version:vm1osdiskversion
    disksize:vm1osdisksize
    Tags:vm1Tag1
  }
}
