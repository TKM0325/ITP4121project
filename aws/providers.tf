provider "aws"{
    version = "~> 2.0"
    alias = "networking"
    region = var.aws_region
    access_key = var.access_key
    secret_key = var.secret_key
}

provider "kubernetes"{
    host = data.aws_eks_cluster.cluster.endpoint
    version = "~>1.11"
    token = data.aws_eks_cluster_auth.cluster.token
    load_config_file = false
    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
     exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}