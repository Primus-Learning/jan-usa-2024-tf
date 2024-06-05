resource "aws_instance" "primus-web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.pl-keypair.key_name
  vpc_security_group_ids      = [var.sg]
  subnet_id                   = var.subnet
  user_data                   = file(var.userdata)

  tags = {
    name = "primus-web"
  }

  depends_on = [aws_security_group.allow_ssh]

}


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
