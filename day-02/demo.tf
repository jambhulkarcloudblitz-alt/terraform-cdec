provider "aws" {
 region = "us-east-2"
 secret_key = ""
 access_key = ""  
}

resource "aws_instance" "my_instance" {
    
    ami = "ami-0e5497a77ef21b5ac"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-00f2865b93a5e36b8"]
}