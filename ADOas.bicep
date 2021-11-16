param asname string


resource avaibilityset 'Microsoft.Compute/availabilitySets@2021-03-01' = {
  name:asname
  location:resourceGroup().location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount:3
    platformUpdateDomainCount:5
  }
}
output asid string = avaibilityset.id
