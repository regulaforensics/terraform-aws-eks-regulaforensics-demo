data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = var.name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.vpc_private_subnet
  public_subnets       = var.vpc_public_subnet
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.name}-${random_string.suffix.result}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}-${random_string.suffix.result}" = "shared"
    "kubernetes.io/role/elb"                                           = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}-${random_string.suffix.result}" = "shared"
    "kubernetes.io/role/internal-elb"                                  = "1"
  }
}
