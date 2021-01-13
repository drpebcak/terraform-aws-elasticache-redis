output "redis_security_group_id" {
  value = aws_security_group.security_group.id
}

output "parameter_group" {
  value = aws_elasticache_parameter_group.parameter_group.id
}

output "redis_subnet_group_name" {
  value     = aws_elasticache_subnet_group.subnet_group.name
  sensitive = true
}

output "id" {
  value = aws_elasticache_replication_group.redis.id
}

output "port" {
  value = var.port
}

output "endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "member_clusters" {
  value = aws_elasticache_replication_group.redis.member_clusters
}

output "configuration_endpoint_address" {
  value = aws_elasticache_replication_group.redis.configuration_endpoint_address
}
