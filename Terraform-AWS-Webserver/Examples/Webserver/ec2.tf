data "aws_ami" "test-ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "name"
      values = ["amzn-ami-hvm"]
    }
}

data "aws_vpc" "test-vpc" {
    tags = {
        owner = var.owner
    }
}

data "aws_subnet" "test-subnet" {
    vpc_id = data.aws_vpc.test-vpc.id
    availability_zone =  var.availability_zone
    tags = {
      network = var.network
    }
    depends_on = [data.aws_vpc.test-vpc]
}
data "aws_security_group" "test-sg" {
    name = var.sg_name
    vpc_id = data.aws_vpc.test-vpc.id
}

resource "aws_instance" "test-ec2" {
    count = var.instance_count
    ami   = data.aws_ami.test-ami.id
    instance_type = var.instance_type
    associate_public_ip_address = true
    iam_instance_profile = var.iam_instance_profile
    key_name = var.key_name
    vpc_security_group_ids = ["${data.aws_security_group.test-sg.id}"]
    subnet_id = data.aws_subnet.test-subnet.id
    depends_on = [data.ami.test-ami]
    user_data = <<EOF
    #!/bin/bash -xe
    mkdir test
    cd test
    EOF

    metadata_options {
      http_tokens = "required"
      http_endpoint = "enabled"
    }

    root_block_device {
      volume_size = var.volume.size
      volume_type = "gp2"
      delete_on_termination = "true"
    }
}








# terraform {
#     required_providers{
#         aws = {
#             source = "hashicorp/aws"
#             version = "3.7"
#         }
#     }
# }

# provider "aws" {
#     region = var.region
  
# }
# module "webserver" {
#     source = "../Examples/Webserver"
#     servername = var.servername
#     size = "t2.micro"
# }

# resource "aws_instance" "example" {
#   ami           = var.AMIS[var.AWS_REGION]
#   instance_type = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.instance.id]

#   # When the instance boots, start a web server on port 8080 that responds with "Hello, World!".
#   user_data = <<EOF
# #!/bin/bash
# echo "Hello, World!" > index.html
# nohup busybox httpd -f -p 8080 &
# EOF
# }