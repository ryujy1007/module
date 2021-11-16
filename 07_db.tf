resource "aws_db_instance" "ryujy_rds" {
  allocated_storage = var.storage_size
  storage_type = var.storage_type
  engine = var.sql_engine
  engine_version = var.sql_version
  instance_class = var.db_class
  name = "test"
  identifier = "test"
  username = var.username
  password = var.password
  parameter_group_name = "default.mysql8.0"
  availability_zone = "${var.region}${var.ava[0]}"
  db_subnet_group_name = aws_db_subnet_group.ryujy_dbsb.id
  vpc_security_group_ids = [aws_security_group.ryujy_sg.id]
  skip_final_snapshot = true
  tags = {
    "Name" = "${var.name}-rds"
  }
}


resource "aws_db_subnet_group" "ryujy_dbsb" {
  name = "ryujy-dbsb-group"
  subnet_ids = aws_subnet.ryujy_pridb[*].id
  tags = {
    "Name" = "${var.name}-dbsb-gp"
  }
}