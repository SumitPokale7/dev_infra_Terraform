region = "eu-north-1"
#network
vpc_cidr              = "10.217.10.0/23"
azs                   = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
public_subnet_cidrs   = ["10.217.10.0/27", "10.217.10.64/27", "10.217.10.128/27"]
private_subnets_cidrs = ["10.217.10.192/26", "10.217.11.0/26", "10.217.11.128/26"]
enable_dns_hostnames  = true
enable_dns_support    = true
enable_nat_gateway    = true
single_nat_gateway    = false

#database
identifier_name            = "test"
engine_name                = "mysql"
engine_version             = "8.0.30"
db_name                    = "admin"
username                   = "test"
instance_class             = "db.t3.micro"
major_engine_version       = "8.0"
family                     = "mysql80"
rotation_days              = 30
skip_final_snapshot        = false
multi_az                   = false
allocated_storage          = 50
max_allocated_storage      = 1000
auto_minor_version_upgrade = false
deletion_protection        = true
maintenance_window         = "sat:12:00-sat:12:30"
db_backup_name             = "test-db-backup"
