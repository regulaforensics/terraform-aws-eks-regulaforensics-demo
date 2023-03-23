variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "name" {
  description = "Unique AWS resources name"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnet" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnet" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "cluster_version" {
  description = "Kubernetes <major>.<minor> version to use for the EKS cluster"
  type        = string
  default     = "1.24"
}

variable "instance_types" {
  description = "Node instance type"
  type        = string
  default     = "t3.medium"
}

variable "capacity_type" {
  description = "Node capacity type"
  type        = string
  default     = "SPOT"
}

variable "enable_docreader" {
  description = "Deploy Docreader helm chart"
  type        = bool
  default     = false
}

variable "docreader_values" {
  description = "Docreader helm values"
  type        = string
  default     = ""
}

variable "enable_faceapi" {
  description = "Deploy Faceapi helm chart"
  type        = bool
  default     = false
}

variable "faceapi_values" {
  description = "Faceapi helm values"
  type        = string
  default     = ""
}
