provider "aws" {
  region = us-west-1
}

module "vpc" {
  source = "./module/vpc"
  }

module "ec2" {
  source = "./module/ec2"
  ami = "ami-0fb110df4c5094d21"
  instance_type = "t3.micro"
  key_name = "cal_aws"
  subnet_id = module.vpc.public_subnet
  project = "CBZ"
  env = "staging"
  vpc_id = module.vpc.vpc_id
}