variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to create subnets in"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}


variable "key_name" {
  description = "The name of the SSH key pair for EC2 instances"
  type        = string
}

variable "ec2_ami" {
  description = "The AMI ID to use for EC2 instances"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the ACM SSL certificate"
  type        = string
}

variable "domain_name" {
  description = "main Domain name for the application"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the application"
  type        = string
  default     = "app"
}

variable "s3_bucket_name" {
  description = "The S3 bucket name where app code is stored"
  type        = string
}
