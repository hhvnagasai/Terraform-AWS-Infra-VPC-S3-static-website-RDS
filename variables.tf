variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "az" {
  default = "ap-south-1a"
}
variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}
variable "bucket_name" {
  default = "my-static-site-hari-website"
}
variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}



