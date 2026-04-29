module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
}

module "public_subnet" {
  source = "./modules/public_subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.az
}
module "private_subnet" {
  source = "./modules/private_subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az
}
module "private_subnet_2" {
  source = "./modules/private_subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1b"
}
module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
}
module "nat_gateway" {
  source = "./modules/nat_gateway"

  subnet_id = module.public_subnet.subnet_id
}
module "public_route_table" {
  source = "./modules/route_table_public"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.public_subnet.subnet_id
  igw_id    = module.internet_gateway.igw_id
}
module "private_route_table" {
  source = "./modules/route_table_private"

  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.private_subnet.subnet_id
  nat_gateway_id = module.nat_gateway.nat_gateway_id
}
module "s3_website" {
  source = "./modules/s3_website"

  bucket_name = var.bucket_name
  website_dir = "website"

  tags = {
    Project = "DevOps"
  }
}
module "rds" {
  source = "./modules/rds"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_id = module.vpc.vpc_id

  subnet_ids = [
    module.private_subnet.subnet_id, module.private_subnet_2.subnet_id
  ]
}
