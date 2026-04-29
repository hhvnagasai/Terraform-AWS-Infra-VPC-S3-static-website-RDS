variable "vpc_id" {
  description = "VPC ID where subnet will be created"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "availability_zone" {
  description = "AZ for subnet"
  type        = string
}
