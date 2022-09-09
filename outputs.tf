output "subnet_ids" {
  value = local.pub_sub_ids
}

output "azs" {
  value = data.aws_availability_zones.available.names
}