provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "k8s_cluster" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "Kubernetes Cluster"
  }
}

resource "null_resource" "kubectl_install" {
  provisioner "local-exec" {
    command = "curl -LO https://dl.k8s.io/release/v1.23.1/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl"
  }
  depends_on = [aws_instance.k8s_cluster]
}

resource "null_resource" "helm_install" {
  provisioner "local-exec" {
    command = "curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh"
  }
  depends_on = [null_resource.kubectl_install]
}

output "public_ip" {
  value = aws_instance.k8s_cluster.public_ip
}
