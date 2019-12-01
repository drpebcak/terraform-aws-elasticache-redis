## Teraform AWS ElastiCache Redis Cluster

This module creates a cluster mode enabled redis elasticache cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_cidr | A list of IP address CIDR's to allow access to. | list(string) | `[]` | no |
| allowed\_security\_groups | A list of Security Group ID's to allow access to. | list(string) | `[]` | no |
| apply\_immediately | Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false. | bool | `"false"` | no |
| auto\_minor\_version\_upgrade | Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. | bool | `"true"` | no |
| automatic\_failover\_enabled |  | bool | `"true"` | no |
| engine\_version | Redis version to use | string | `"5.0.5"` | no |
| maintenance\_window | Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period | string | `"fri:08:00-fri:09:00"` | no |
| name | Name for the Redis replication group. | string | n/a | yes |
| node\_type | Instance type to use for creating the Redis cache clusters | string | `"cache.m5.large"` | no |
| num\_node\_groups | Specify the number of node groups (shards) for this Redis replication group. | number | `"1"` | no |
| parameters | additional parameters modified in parameter group | list(map(any)) | `[]` | no |
| port |  | number | `"6379"` | no |
| replicas\_per\_node\_group | Specify the number of replica nodes in each node group. | number | `"2"` | no |
| snapshot\_retention\_limit | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. | number | `"0"` | no |
| snapshot\_window | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period | string | `"06:30-07:30"` | no |
| subnets | List of VPC Subnet IDs for the cache subnet group | list(string) | n/a | yes |
| tags | Tags for redis nodes | map(string) | `{}` | no |
| vpc\_id | ID of the VPC to deploy elasticache cluster in. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| configuration\_endpoint\_address |  |
| endpoint |  |
| id |  |
| member\_clusters |  |
| parameter\_group |  |
| port |  |
| redis\_security\_group\_id |  |
| redis\_subnet\_group\_name |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
