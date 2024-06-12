variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "av-zone-a" {
  type    = string
  default = "eu-west-3a"

}

variable "av-zone-c" {
  type    = string
  default = "eu-west-3c"
}


variable "default-vpc_id" {
    default = "vpc-022a0dfaaa629ccba"

}