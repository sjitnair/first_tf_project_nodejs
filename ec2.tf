resource "aws_instance" "tf_ec2_instance" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true
  key_name                    = var.ec2_key_name

  vpc_security_group_ids = [aws_security_group.tf_ec2_sg.id]
  depends_on             = [aws_s3_object.tf_s3_object]

  user_data = <<-EOF
              #!/bin/bash
              git clone https://github.com/sjitnair/nodejs-mysql.git /home/ubuntu/nodejs-mysql
              cd /home/ubuntu/nodejs-mysql

              sudo apt update -y
              sudo apt install -y nodejs npm

              echo "DB_HOST=${local.rds_endpoint}" | sudo tee .env
              echo "DB_USER=${var.rds_username}" | sudo tee -a .env
              echo "DB_PASS=${var.rds_password}" | sudo tee -a .env
              echo "DB_NAME=${var.rds_db_name}" | sudo tee -a .env
              echo "TABLE_NAME=users" | sudo tee -a .env
              echo "PORT=3000" | sudo tee -a .env

              npm install

              echo "export PATH=$PATH:/usr/bin/:/home/ubuntu/nodejs-mysql" | sudo tee /home/ubuntu/nodejs-mysql/npm_srt.sh
              echo "cd /home/ubuntu/nodejs-mysql/" | sudo tee -a /home/ubuntu/nodejs-mysql/npm_srt.sh
              echo "nohup npm start &" | sudo tee -a /home/ubuntu/nodejs-mysql/npm_srt.sh
              chmod 777 /home/ubuntu/nodejs-mysql/npm_srt.sh
              /home/ubuntu/nodejs-mysql/npm_srt.sh
              sleep 10
              chmod 400 /home/ubuntu/nodejs-mysql/npm_srt.sh
              EOF

  user_data_replace_on_change = true

  tags = merge (
    local.common_tags,
    {
      Name = "Nodejs-server"
      Usage = "User profile data collection"
    }
  )
}

resource "aws_security_group" "tf_ec2_sg" {
  name        = "nodejs-server-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge (
    local.common_tags,
    {
      Name = "SG${var.req_id}"
      Usage = "NJ Ec2 server security group"
    }
  )

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

