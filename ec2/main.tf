resource "aws_instance" "primus-web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.pl-keypair.key_name
  vpc_security_group_ids      = [var.sg]
  subnet_id                   = var.subnet_id
  user_data                   = file(var.userdata)

  tags = {
    name = "primus-web"
  }

  depends_on = [var.sg]

}

# you need to change the path to the public

resource "aws_key_pair" "pl-keypair" {
  key_name   = var.keyn
  public_key = file(var.pub-key)
}



data "aws_ami" "amazon-linux2" {

  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# resource "aws_instance" "data-ec2" {
#   ami                    = data.aws_ami.amazon-linux2.id
#   key_name               = aws_key_pair.pl-keypair.key_name
#   subnet_id              = var.subnet_id
#   vpc_security_group_ids = [var.sg]
#   instance_type          = var.instance_type

#   tags = {
#     Name = "data-ec2"
#   }
# }