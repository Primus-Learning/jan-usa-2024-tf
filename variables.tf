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

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {

  default = "ami-00ac45f3035ff009e"
}

variable "keyn" {


}

variable "pub-key" {

}

variable "region" {
  default = "eu-west-3"

}

variable "destroy" {
  type    = bool
  default = false
}

variable "av-zone" {
  type    = list(any)
  default = ["eu-west-3a", "eu-west-3c"]
}

variable "region-ami" {
  type = map(any)
  default = {
    "eu-west-3" = "ami-00ac45f3035ff009e"
    "us-east-2" = "ami-09040d770ffe2224f"
  }
}

variable "userdata" {

}