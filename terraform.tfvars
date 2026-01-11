req_id             = "REQ-02468"
proj_name          = "Project_nj_deploy"
aws_region         = "us-east-1"
vpc_id             = "vpc-02a3046e80968cf34"
s3_bucket_name     = "nj-my-sree-bucket"

rds_identifier     = "nodejs-rds-mysql"
rds_db_name        = "sree_demo"
rds_storage        = 10
rds_engine         = "mysql"
rds_eng_v          = "8.0"
rds_db_par_grp     = "default.mysql8.0"
rds_username       = "admin"
rds_password       = "sree1234"

allowed_mysql_cidr = ["103.155.223.37/32"]

ec2_ami            = "ami-0ecb62995f68bb549"
ec2_key_name       = "tf-ec2"
