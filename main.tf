resource "random_id" "salt" {
  byte_length = 8
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = var.name
  replication_group_description = "Terraform-managed ElastiCache replication group for ${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  node_type                     = var.node_type
  automatic_failover_enabled    = var.automatic_failover_enabled
  multi_az_enabled              = var.multi_az_enabled
  engine_version                = var.engine_version
  port                          = var.port
  auto_minor_version_upgrade    = var.auto_minor_version_upgrade
  parameter_group_name          = aws_elasticache_parameter_group.parameter_group.id
  subnet_group_name             = aws_elasticache_subnet_group.subnet_group.id
  security_group_ids            = [aws_security_group.security_group.id]
  apply_immediately             = var.apply_immediately
  maintenance_window            = var.maintenance_window
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
  tags                          = merge(tomap({ "Name" = format("tf-elasticache-%s-%s", var.name, lookup(data.aws_vpc.vpc.tags, "Name", "")) }), var.tags)
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled

  cluster_mode {
    replicas_per_node_group = var.replicas_per_node_group
    num_node_groups         = var.num_node_groups
  }
}

resource "aws_elasticache_parameter_group" "parameter_group" {
  name = replace(format("%.255s", lower(replace("tf-redis-${var.name}-${data.aws_vpc.vpc.tags["Name"]}-${random_id.salt.hex}", "_", "-"))), "/\\s/", "-")

  description = "Terraform-managed ElastiCache parameter group for ${var.name}-${data.aws_vpc.vpc.tags["Name"]}"

  # Strip the patch version from redis_version var
  family = "redis${replace(var.engine_version, "/\\.[\\d]+$/", "")}"
  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elasticache_subnet_group" "subnet_group" {
  name       = replace(format("%.255s", lower(replace("tf-redis-${var.name}-${data.aws_vpc.vpc.tags["Name"]}", "_", "-"))), "/\\s/", "-")
  subnet_ids = var.subnets
}

resource "aws_security_group" "security_group" {
  name        = format("%.255s", "tf-sg-ec-${var.name}-${data.aws_vpc.vpc.tags["Name"]}")
  description = "Terraform-managed ElastiCache security group for ${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    Name = "tf-sg-ec-${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  }
}

resource "aws_security_group_rule" "ingress" {
  count                    = length(var.allowed_security_groups)
  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  source_security_group_id = element(var.allowed_security_groups, count.index)
  security_group_id        = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "networks_ingress" {
  count             = length(var.allowed_cidr)
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr
  security_group_id = aws_security_group.security_group.id
}
