
# resource "aws_vpc" "primus-vpc" {
#   cidr_block = var.cidr_block
# }


# resource "aws_subnet" "primus-public-subnet" {
#   vpc_id            = aws_vpc.primus-vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = var.av-zone-a

#   tags = {
#     Name = "primus-public-subnet"
#   }
# }


# resource "aws_subnet" "primus-private-subnet" {
#   vpc_id            = aws_vpc.primus-vpc.id
#   cidr_block        = "10.0.0.0/24"
#   availability_zone = var.av-zone-c

#   tags = {
#     Name = "primus-private-subnet"
#   }
# }


# resource "aws_security_group" "allow_ssh" {
#   name        = "allow_ssh"
#   description = "Allow TLS inbound traffic and all outbound traffic"
#   vpc_id      = aws_vpc.primus-vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow-ssh"
#   }
# }


# resource "aws_internet_gateway" "primus-igw" {
#   vpc_id = aws_vpc.primus-vpc.id

#   tags = {
#     Name = "primus-igw"
#   }
# }

# resource "aws_route_table" "pub-rt" {
#   vpc_id = aws_vpc.primus-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.primus-igw.id
#   }


#   tags = {
#     Name = "pub-rt"
#   }
# }

# resource "aws_route_table_association" "pub-rt-assoc" {
#   subnet_id      = aws_subnet.primus-public-subnet.id
#   route_table_id = aws_route_table.pub-rt.id
# }

# # change the ami ID in the variable 
# resource "aws_instance" "primus-web" {
#   ami                         = var.ami
#   instance_type               = var.instance_type
#   associate_public_ip_address = true
#   availability_zone           = var.av-zone-a
#   key_name                    = aws_key_pair.pl-keypair.key_name
#   vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
#   subnet_id                   = aws_subnet.primus-public-subnet.id
#   user_data                   = file(var.userdata)

#   tags = {
#     name = "primus-web"
#   }

#   depends_on = [aws_security_group.allow_ssh]

# }

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


resource "aws_instance" "data-ec2" {
  ami                    = data.aws_ami.amazon-linux2.id
  key_name               = aws_key_pair.pl-keypair.key_name
  # subnet_id              = aws_subnet.primus-public-subnet.id
  # vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  instance_type          = var.instance_type

  tags = {
    Name = "data-ec2"
  }

  provisioner "file" {
    source = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = "${self.public_ip}"
    }
    
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod u+x /tmp/user-data.sh",
      "./user-data.sh",
      "mkdir Babah"
     ]
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = "${self.public_ip}"
    }

}

}


# data "aws_vpc" "default" {
#   id = var.default-vpc_id
# }


# resource "aws_subnet" "data-subnet" {
#   vpc_id            = data.aws_vpc.default.id
#   cidr_block        = "172.31.64.0/20"
#   availability_zone = var.av-zone-c

#   tags = {
#     Name = "data-subnet"
#   }
# }


output "ip" {
  value = aws_instance.data-ec2.public_ip
  
}