variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {

  default = "ami-00ac45f3035ff009e"
}

variable "keyn" {
    default = "pl-keypair"


}

variable "pub-key" {

    default = "~/.ssh/id_rsa.pub"

}

variable "userdata" {

    default = "user-data.sh"

}

variable "subnet" {
  
}

variable "sg" {
  
}