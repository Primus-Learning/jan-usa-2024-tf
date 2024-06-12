
# module "webserver" {
#   source    = "./ec2"
#   sg        = module.allow-ssh.sg
#   subnet_id = module.test-vpc.pub-subnet_id

# }

# module "test-vpc" {
#   source = "./network"

# }

# module "allow-ssh" {
#   source = "./security"
#   vpc_id = module.test-vpc.vpc_id

# }

# module "test-instance" {
#   source = "./ec2"
#   sg = module.allow-ssh.sg
#   subnet_id = module.test-vpc.pvt-subnet_id
#   keyn = "pl-keypair"



# }

module "test-rds" {
  source            = "./rds"
  db_name           = "pldb"
  username          = "babah"
  passwd            = "password"
  db_instance_class = "db.t3.micro"

}

module "pl-terraform-mdvpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "pl-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Name = "pl-vpc"
    Terraform = "true"
    Environment = "dev"
  }
}