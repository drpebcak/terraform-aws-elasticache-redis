variable "vpc_id" {
  type        = string
  description = "ID of the VPC to deploy elasticache cluster in."
}

variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  default     = true
  type        = bool
  description = "Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window."
}

variable "allowed_cidr" {
  description = "A list of IP address CIDR's to allow access to."
  type        = list(string)
  default     = []
}

variable "allowed_security_groups" {
  description = "A list of Security Group ID's to allow access to."
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name for the Redis replication group."
  type        = string
}

variable "replicas_per_node_group" {
  default     = 1
  type        = number
  description = "Specify the number of replica nodes in each node group."
}

variable "num_node_groups" {
  description = "Specify the number of node groups (shards) for this Redis replication group."
  type        = number
  default     = 2
}

variable "automatic_failover_enabled" {
  type    = bool
  default = true
}

variable "node_type" {
  description = "Instance type to use for creating the Redis cache clusters"
  type        = string
  default     = "cache.m5.large"
}

variable "port" {
  type    = number
  default = 6379
}

variable "subnets" {
  type        = list(string)
  description = "List of VPC Subnet IDs for the cache subnet group"
}

# might want a map
variable "engine_version" {
  description = "Redis version to use"
  type        = string
  default     = "5.0.5"
}

variable "parameters" {
  description = "additional parameters modified in parameter group"
  type        = list(map(any))
  default     = []
}

variable "maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period"
  type        = string
  default     = "fri:08:00-fri:09:00"
}

variable "snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period"
  type        = string
  default     = "06:30-07:30"
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them."
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags for redis nodes"
  type        = map(string)
  default     = {}
}

variable "at_rest_encryption_enabled" {
  default     = true
  type        = bool
  description = "Whether to enable encryption at rest."
}
