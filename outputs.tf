output "rds_db_connect" {
  value = "mysql -u ${var.rds_username} -p -h ${local.rds_endpoint} ${var.rds_db_name} "
}

output "ec2_ssh_command" {
  value = "ssh -i ~/.ssh/${var.ec2_key_name}.pem ubuntu@${aws_instance.tf_ec2_instance.public_ip}"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.tf_s3_bucket.bucket
}

output "application_link" {
  value = "http://${aws_instance.tf_ec2_instance.public_ip}:3000"
}
