terraform {
  backend "s3" {
    bucket = "pl-terraform-backend"
    key    = "terraform"
    region = "eu-west-3"
  }
}
