output "docker-ssh" {
	value = "ssh -i aws-key1 ubuntu@${aws_instance.docker.public_ip}"
}