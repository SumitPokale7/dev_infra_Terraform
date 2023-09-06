# locals {
#     secret_template = {
#         "dbInstanceIdentifier": "${var.mysql_dbInstanceIdentifier}"
#         "password"            : "${var.mysql_password}",
#         "username"            : "${each.value.username}",
#         "database"            : "${var.mysql_dbname}",
#         "host"                : "${var.mysql_host}",
#         "port"                : "${var.mysql_port}",
#         "engine"              : "mysql",
#     }
# }