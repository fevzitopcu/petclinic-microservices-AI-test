
module "vpc" {
  source              = "../../modules/vpc"
  name                = "capstone"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs                 = ["eu-west-1a", "eu-west-1b"]
}

module "ec2" {
  source        = "../../modules/ec2"
  name          = "capstone-development-server"
  ami           = "ami-0ca351c241d836d3b"    #"ami-03d8b47244d950bbb"
  instance_type = "t3a.medium"
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  key_name      = "devops-keypem-ft"
  user_data     = file("${path.module}/scripts/jenkins_user_data.sh")
  ports = [22, 80, 8080, 9090, 8081, 8082, 8083, 8888, 9411, 7979, 3000, 9091, 8761, 8060]
}
