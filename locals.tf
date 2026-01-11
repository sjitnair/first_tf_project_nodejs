locals {

  # -----------------
  # Common Tags
  # -----------------
  common_tags = {
    Request_id  = var.req_id
    Environment = var.environment
    Project     = var.proj_name
    ManagedBy   = "Sreejith"
  }

  # -----------------
  # RDS Parameter Groups Mapping
  # -----------------
  rds_parameter_groups = {
    mysql = {
      "5.7" = "default.mysql5.7"
      "8.0" = "default.mysql8.0"
    }
    postgres = {
      "13" = "default.postgres13"
      "14" = "default.postgres14"
      "15" = "default.postgres15"
    }
  }

  # -----------------
  # Derived RDS Parameter Group
  # -----------------
  rds_parameter_group_name = try(
    local.rds_parameter_groups[var.rds_engine][var.rds_eng_v],
    null
  )

  # -----------------
  # RDS Endpoint (hostname only)
  # -----------------
  rds_endpoint = element(
    split(":", aws_db_instance.tf_rds_instance.endpoint),
    0
  )
}
