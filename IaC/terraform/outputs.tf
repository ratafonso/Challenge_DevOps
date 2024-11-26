output "this_password" {
  value = random_password.db-password.result
  sensitive = true
}

output "db" {
  value = aws_db_instance.db-rds
  sensitive = true
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "node_group_role_arn" {
  value = module.eks.node_groups["eks_nodes"].iam_role_arn
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}

output "nat_eip" {
  value = aws_eip.nat_eip.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.tfstate_bucket.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.tfstate_lock.name
}
