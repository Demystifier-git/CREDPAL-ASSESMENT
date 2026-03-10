# VPC
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
}

# Subnets
module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones
}


# Internet Gateway
module "igw" {
  source = "./modules/internet-gateway"
  vpc_id = module.vpc.vpc_id
}

# NAT Gateway
module "nat" {
  source            = "./modules/nat-gateway"
  public_subnet_id  = module.subnets.public_subnet_ids[0]   
  depends_on        = [module.igw]
}

# Route Tables
module "routes" {
  source             = "./modules/route-tables"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.igw.igw_id
  nat_id             = module.nat.nat_id
  public_subnet_id   = module.subnets.public_subnet_ids[0]   
  private_subnet_id  = module.subnets.private_subnet_ids[0]  
}

# Security Groups
module "web_sg" {
  source  = "./modules/security-group-ec2"
  vpc_id  = module.vpc.vpc_id
  sg_name = "ec2-sg"
  lb_security_group_id = module.lb_ssl.lb_sg_id
}


module "vpc_sg" {
  source  = "./modules/security-group-VPC"
  vpc_id  = module.vpc.vpc_id
  sg_name = "vpc-sg"
}

# EC2
module "ec2" {
  source             = "./modules/ec2"
  name               = "web-server"
  instance_type      = "t3.micro"
  subnet_id          = module.subnets.private_subnet_ids[0]
  security_group_ids = [module.web_sg.sg_id]
  key_name           = var.key_name
  ami                = var.ec2_ami
  s3_bucket_name     = var.s3_bucket_name
}

module "lb_ssl" {
  source = "./modules/lb_ssl"

  vpc_id          = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  target_instance_id = module.ec2.instance_id
  domain_name        = var.domain_name
  certificate_arn    = var.certificate_arn
}


module "route53" {
  source = "./modules/route53"

  hosted_zone_id = var.hosted_zone_id
  domain_name    = var.domain_name
  subdomain      = var.subdomain

  lb_dns_name = module.lb_ssl.lb_dns_name
  lb_zone_id  = module.lb_ssl.lb_zone_id
}
