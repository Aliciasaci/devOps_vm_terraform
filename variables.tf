variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-3"
}

variable "aws_ami" {
  description = "AMI ID for the instance"
}

variable "instance_type" {
  description = "Instance type"
}

variable "vm_user" {
  description = "user of the vm"
}

variable "keypair_name" {
 description = "value of ssh key"
}

variable "instance_name" {
  description = "Name for the instance"
}

variable "network_interface_id" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "value of the secret key"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "value of the access key"
}
