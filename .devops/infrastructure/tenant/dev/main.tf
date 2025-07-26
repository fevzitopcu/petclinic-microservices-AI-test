
module "master" {
  source        = "../../modules/ec2"
  name          = "capstone-k8s-master"
  ami           = "ami-0ca351c241d836d3b"    #"ami-03d8b47244d950bbb"
  instance_type = "t3a.medium"
  vpc_id     = data.aws_vpc.default.id
  subnet_id  = data.aws_subnet_ids.default_subnets.ids[0]
  key_name      = "devops-keypem-ft"
  user_data     = null # file("${path.module}/scripts/jenkins_user_data.sh")
  # Master node için gerekli portlar
  ports = [
    22,     # SSH
    6443,   # Kubernetes API server
    2379,   # etcd client communication
    2380,   # etcd peer communication
    10250,  # Kubelet API
    10251,  # kube-scheduler
    10252   # kube-controller-manager
  ]
}

module "worker_1" {
  source        = "../../modules/ec2"
  name          = "capstone-k8s-worker-1"
  ami           = "ami-0ca351c241d836d3b"    #"ami-03d8b47244d950bbb"
  vpc_id     = data.aws_vpc.default.id
  subnet_id  = data.aws_subnet_ids.default_subnets.ids[0]
  instance_type = "t3a.medium"
  key_name      = "devops-keypem-ft"
  user_data     = null # file("${path.module}/scripts/jenkins_user_data.sh")
  # Worker node için gerekli portlar
  ports = [
    22,     # SSH
    10250,  # Kubelet API
    30000,  # NodePort servisleri (aralık olarak açılabilir)
    32767,  # Son nodePort
    8472    # Calico VXLAN (opsiyonel, network plugin'e bağlı)
  ]
}

module "worker_2" {
  source        = "../../modules/ec2"
  name          = "capstone-k8s-worker-2"
  vpc_id     = data.aws_vpc.default.id
  subnet_id  = data.aws_subnet_ids.default_subnets.ids[0]
  ami           = "ami-0ca351c241d836d3b"    #"ami-03d8b47244d950bbb"
  instance_type = "t3a.medium"
  key_name      = "devops-keypem-ft"
  user_data     = null # file("${path.module}/scripts/jenkins_user_data.sh")
  # Worker node için gerekli portlar
  ports = [
    22,     # SSH
    10250,  # Kubelet API
    30000,  # NodePort servisleri (aralık olarak açılabilir)
    32767,  # Son nodePort
    8472    # Calico VXLAN (opsiyonel, network plugin'e bağlı)
  ]
}