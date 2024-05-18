output "nginx-server" {
    value = aws_instance.jenkins-server.public_ip
}
