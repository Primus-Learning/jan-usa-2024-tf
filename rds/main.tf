resource "aws_db_instance" "pl-db" {
  allocated_storage    = 10
  db_name              = var.db_name #"pldb"
  engine               = var.db_engine #"mysql"
  engine_version       =  var.db_version #"8.0"
  instance_class       = var.db_instance_class
  username             = var.username #"foo"
  password             = var.passwd #"password"
  parameter_group_name =  var.pm-group #"default.mysql8.0"
  skip_final_snapshot  = true
}