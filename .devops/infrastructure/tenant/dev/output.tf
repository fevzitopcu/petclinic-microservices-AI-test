output "ec2_public_dns" {
  value = module.ec2.public_DNSName
}

output "ssh_to_ec2" {
  value = "ssh -i devops-keypem-ft.pem ec2-user@${module.ec2.public_DNSName}"
}

output "jenkins_password_command" {
  value = "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
}
