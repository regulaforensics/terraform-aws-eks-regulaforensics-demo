module "eks_cluster" {
  source             = "./modules"
  account_id         = var.account_id
  region             = var.region
  name               = var.name
  vpc_cidr           = var.vpc_cidr
  vpc_private_subnet = var.vpc_private_subnet
  vpc_public_subnet  = var.vpc_public_subnet
  cluster_version    = var.cluster_version
  instance_types     = var.instance_types
  capacity_type      = var.capacity_type
  enable_docreader   = var.enable_docreader
  docreader_values   = var.docreader_values
  enable_faceapi     = var.enable_faceapi
  faceapi_values     = var.faceapi_values
}
