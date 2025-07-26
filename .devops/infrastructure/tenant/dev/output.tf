output "master_public_ip" {
  value = module.master.public_ip
}

output "worker1_public_ip" {
  value = module.worker_1.public_ip
}

output "worker2_public_ip" {
  value = module.worker_2.public_ip
}
