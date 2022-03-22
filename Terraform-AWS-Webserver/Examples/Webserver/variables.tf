variable "key_name" {
  
}
variable "instance_type" {
  default = "t2.micro"
}
variable "instance_count" {
  default = 1
}
variable "volume_count" {
  dafault = 1
}
variable "volume_size" {
  default = "30"
}
variable "owner" {
  default = ""
}
variable "availability_zone" {
  default = "us-east-1"
}
variable "network" {
  default = "private"
}
variable "sg_name" {
    default = ""
  
}
variable "iam_instance_profile" {
  
}

