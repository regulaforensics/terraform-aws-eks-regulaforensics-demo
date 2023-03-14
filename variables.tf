variable "enable_docreader" {
  description = "Deploy Docreader"
  type        = bool
  default     = false
}

variable "enable_faceapi" {
  description = "Deploy Faceapi"
  type        = bool
  default     = false
}

variable "ami_type" {
  description = "AMI nodes images"
  type        = string
  default     = "AL2_x86_64"
}

variable "cluster_version" {
  description = "Version of cluster"
  type        = string
  default     = "1.24"
}

variable "instance_types" {
  description = "Node instance type"
  type        = string
  default     = "t3.medium"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "account_id" {
  description = "Account ID"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "EksVpc"
}

variable "vpc_cidr" {
  description = "CIDR of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnet" {
  description = "Private subnet of the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnet" {
  description = "Public subnet of the VPC"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "capacity_type" {
  description = "Node capacity type"
  type        = string
  default     = "SPOT"
}

variable "docreader_values_yml" {
  description = "Docreader helm values.yml"
  type        = bool
  default     = false
}

variable "faceapi_values_yml" {
  description = "Faceapi helm values.yml"
  type        = bool
  default     = false
}

