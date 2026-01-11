# -----------------
# General
# -----------------
variable "req_id" {
  description = "Request id for this deployment"
  type        = string
}

variable "proj_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Dev"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-02a3046e80968cf34"
}



# -----------------
# S3
# -----------------
variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "s3_source_path" {
  description = "Local path for S3 uploads"
  type        = string
  default     = "./images"
}

# -----------------
# RDS
# -----------------
variable "rds_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "rds_storage" {
  description = "RDS instance storage"
  type        = number
  default     = 10
}

variable "rds_engine" {
  description = "RDS engine"
  type        = string
  default     = "mysql"
}

variable "rds_eng_v" {
  description = "RDS engine version"
  type        = string
  default     = "8.0"

  validation {
    condition = contains(
      keys(local.rds_parameter_groups[var.rds_engine]),
      var.rds_eng_v
    )
    error_message = "Unsupported engine version for selected RDS engine."
  }
}

variable "rds_db_name" {
  description = "Database name"
  type        = string
}

variable "rds_db_par_grp" {
  description = "Database parameter group"
  type        = string
  default     = "default.mysql8.0"
}

variable "rds_username" {
  description = "RDS master username"
  type        = string
}

variable "rds_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "allowed_mysql_cidr" {
  description = "CIDR blocks allowed to access MySQL"
  type        = list(string)
}

# -----------------
# EC2
# -----------------
variable "ec2_ami" {
  description = "AMI ID for EC2"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ec2_key_name" {
  description = "EC2 key pair name"
  type        = string
}

