variable "env" {
  description = "Environment."
}

variable "instance_ami" {
  description = "Instance AMI."
}

variable "instance_type" {
  description = "Instance type."
}

variable "subnet_id" {
  description = "Subnet ID."
}

variable "security_group" {
  description = "EC2 security group."
}

variable "key_name" {
  description = "SSH key name."
}

variable "iam_instance_profile" {
  description = "EC2 profile role."
}