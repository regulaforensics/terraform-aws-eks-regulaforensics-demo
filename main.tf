module "eks_cluster" {
  source             = "./modules"
  enable_docreader   = var.enable_docreader
  enable_faceapi     = var.enable_faceapi
  cluster_version    = var.cluster_version
  instance_types     = var.instance_types
  region             = var.region
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  vpc_private_subnet = var.vpc_private_subnet
  vpc_public_subnet  = var.vpc_public_subnet
  account_id         = var.account_id
  capacity_type      = var.capacity_type
}
