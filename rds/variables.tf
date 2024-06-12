variable "db_name" {
  
}
variable "db_engine" {
    default = "mysql"
  
}
variable "db_version" {
    default = "8.0"
  
}

variable "db_instance_class" {
    default = "db.t3.micro"
  
}
variable "pm-group" {
  default = "default.mysql8.0"
}

variable "passwd" {
  
}

variable "username" {
  
}