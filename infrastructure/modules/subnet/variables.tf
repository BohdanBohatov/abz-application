variable "env" {
  description = "The infrastructure environment."
  type        = string
}

variable "vpc_id" {
  description = "VPC id."
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC cidr block."
  type        = string
}

variable "availability_zone_1" {
  description = "Avaliability zone for first subnet."
  type        = string
}

variable "availability_zone_2" {
  description = "Avaliability zone for second subnet."
  type        = string
}

variable "cidr_block_private_subnet_1" {
  description = "CIDR block for first private subnet."
  type        = string
}

variable "cidr_block_private_subnet_2" {
  description = "CIDR block for second private subnet."
  type        = string
}

variable "cidr_block_public_subnet_1" {
  description = "CIDR block for first public subnet."
  type        = string
}

variable "cidr_block_public_subnet_2" {
  description = "CIDR block for second public subnet."
  type        = string
}

variable "cidr_block_private_nat_subnet_1" {
  description = "CIDR block for first private subnet."
  type        = string
}

variable "cidr_block_private_nat_subnet_2" {
  description = "CIDR block for second private subnet."
  type        = string
}


