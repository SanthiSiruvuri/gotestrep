module "Examples" {
    source = "./modules/Examples"
    instance_type = var.instance_type
    ami = var.ami
    instance_count = var.instance_count
    security_group = var.security_group
    subnet_id = var.subnet_id
    volume_count = var.volume_count
      
}