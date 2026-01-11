resource "aws_db_instance" "tf_rds_instance" {
  allocated_storage    = var.rds_storage
  db_name              = var.rds_db_name
  identifier           = var.rds_identifier
  engine               = var.rds_engine
  engine_version       = var.rds_eng_v
  instance_class       = var.rds_instance_class
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = local.rds_parameter_group_name
  tags                 = local.common_tags

  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.tf_rds_sg.id]
}

resource "aws_security_group" "tf_rds_sg" {
  name        = "mysql_njs"
  description = "Allow MYSQL traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = var.allowed_mysql_cidr
    security_groups = [aws_security_group.tf_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge (
    local.common_tags,
    {
      Name = "SG${var.req_id}"
      Usage = "NJ rds database security group"
    }
  )
}
