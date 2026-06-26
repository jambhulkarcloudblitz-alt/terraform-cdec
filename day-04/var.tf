variable "ami" {
  default = "ami-0e5497a77ef21b5ac"
}

variable "instance_type" {
  default = "c7i-flex.large"
}

variable "env" {
  default = "dev"
}

variable "vpc_id" {
  default = "vpc-014887fba2d157e2b"
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "arn" {
  value = aws_instance.my_instance.arn
}