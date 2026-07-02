variable "image_id" {
  default = "ami-0fe18bc3cfa53a248"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "key_name" {
  default = "o"
}
variable "project" {
  default = "CDEC-B2"
}
variable "env" {
  default = "UAT"
}
variable "vpc_id" {
  default = "vpc-0fac7b862257899e4"
}
variable "availability_zones" {
  default = ["us-east-2a", "us-east-2b"]
}
variable "subnets" {
  default = ["subnet-0d65074609c5f6d53", "subnet-01e38b02391e62ecc"]
}