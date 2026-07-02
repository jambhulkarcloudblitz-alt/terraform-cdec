variable "image_id" {
  default = "ami-0fb110df4c5094d21"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "key_name" {
  default = "cal_aws"
}
variable "project" {
  default = "IATA"
}
variable "env" {
  default = "UAT"
}
variable "vpc_id" {
  default = "vpc-09b04be28f59fb8a9"
}
variable "availability_zones" {
  default = ["us-west-1a", "us-west-1b"]
}
variable "subnet" {
  default = ["subnet-02815e3fbcd726c47", "subnet-060e4ffd1b8303a05"]
}