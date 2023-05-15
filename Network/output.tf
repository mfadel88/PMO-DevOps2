output "main-vpc" {
  value =  aws_vpc.main-vpc.id
}
output "PRI-SN1" {
  value =  aws_subnet.PRI-SN1.id
}

output "PRI-SN2" {
  value =  aws_subnet.PRI-SN2.id
}
output "PUB-SN1" {
  value =  aws_subnet.PUB-SN1.id
}
output "PUB-SN2" {
  value =  aws_subnet.PUB-SN2.id
}

