terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "3.7"
        }
    }
}

provider "aws" {
    region = var.region
  
}
module "webserver" {
    source = "../.."
    servername = var.servername
    size = "t2.micro"
}

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