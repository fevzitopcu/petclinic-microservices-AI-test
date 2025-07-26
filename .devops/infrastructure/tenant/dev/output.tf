output "master_ip" {
  value = module.master.public_ip
  sensitive   = false
}

output "worker_1_ip" {
  value = module.worker_1.public_ip
  sensitive   = false
}

output "worker_2_ip" {
  value = module.worker_2.public_ip
  sensitive   = false
}