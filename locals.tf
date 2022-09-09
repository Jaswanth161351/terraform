locals {
  pub_sub_ids = [for s in aws_subnet.public : s.id]
  pri_sub_ids = [for s in aws_subnet.private : s.id]
}