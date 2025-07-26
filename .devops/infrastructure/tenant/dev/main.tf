

#------------------------------------------------------

# module "vpc" {
#   source              = "../../modules/vpc"
#   name                = "capstone"
#   vpc_cidr            = "10.0.0.0/16"
#   public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
# }

module "master" {
  source        = "../../modules/ec2"
  name          = "k8s-master-node"
  ami           = "ami-020cba7c55df1f615" # us-east-1 Canonical, Ubuntu, 24.04, amd64 noble image
  instance_type = "t3a.medium"
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  key_name      = "devops-keypem-va"
  user_data     = file("${path.module}/scripts/user_data.sh")
  ports = [
    22,     # SSH
    6443,   # Kubernetes API server
    2379,   # etcd client communication
    2380,   # etcd peer communication
    10250,  # Kubelet API
    10251,  # kube-scheduler
    10252   # kube-controller-manager
  ]

      tags = {
        NodeName = "kube-master"
        Project = "tera-kube-ans"
        NodeRole = "master"
        NodeId = "1"
        environment = "dev"
    }
}

module "worker_1" {
  source        = "../../modules/ec2"
  name          = "k8s-worker1-node"
  ami           = "ami-020cba7c55df1f615" # us-east-1 Canonical, Ubuntu, 24.04, amd64 noble image
  instance_type = "t3a.medium"
  subnet_id     = module.vpc.public_subnet_ids[1]
  vpc_id        = module.vpc.vpc_id
  key_name      = "devops-keypem-va"
  user_data     = file("${path.module}/scripts/user_data.sh")
  # Worker node için gerekli portlar
  ports = [
    22,     # SSH
    10250,  # Kubelet API
    30000,  # NodePort servisleri (aralık olarak açılabilir)
    32767,  # Son nodePort
    8472    # Calico VXLAN (opsiyonel, network plugin'e bağlı)
  ]
      tags = {
        NodeName = "worker-1"
        Project = "tera-kube-ans"
        NodeRole = "worker"
        NodeId = "1"
        environment = "dev"
    }

}

module "worker_2" {
  source        = "../../modules/ec2"
  name          = "k8s-worker2-node"
  ami           = "ami-020cba7c55df1f615" # us-east-1 Canonical, Ubuntu, 24.04, amd64 noble image
  instance_type = "t3a.medium"
  subnet_id     = module.vpc.public_subnet_ids[2]
  vpc_id        = module.vpc.vpc_id
  key_name      = "devops-keypem-va"
  user_data     = file("${path.module}/scripts/user_data.sh")
  # Worker node için gerekli portlar
  ports = [
    22,     # SSH
    10250,  # Kubelet API
    30000,  # NodePort servisleri (aralık olarak açılabilir)
    32767,  # Son nodePort
    8472    # Calico VXLAN (opsiyonel, network plugin'e bağlı)
  ]
      tags = {
        NodeName = "worker-2"
        Project = "tera-kube-ans"
        NodeRole = "worker"
        NodeId = "2"
        environment = "dev"
    }
}
