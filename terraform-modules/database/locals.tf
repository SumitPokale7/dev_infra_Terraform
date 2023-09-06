locals {
  db_users = {
    "rds" = {
      secret_name = "matomo"
      username    = "matomo"
      database    = "matomo"
    },
    "master" = {
      username    = "test"
      secret_name = "test"
      database    = "admin"
    }
  }
}
