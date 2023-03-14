data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}

resource "helm_release" "docreader" {
  count      = var.enable_docreader == true ? 1 : 0
  name       = "docreader"
  repository = "https://regulaforensics.github.io/helm-charts"
  chart      = "docreader"

  values = [
    var.docreader_values
  ]

}

resource "helm_release" "faceapi" {
  count      = var.enable_faceapi == true ? 1 : 0
  name       = "faceapi"
  repository = "https://regulaforensics.github.io/helm-test"
  chart      = "faceapi"

  values = [
    var.faceapi_values
  ]

}
