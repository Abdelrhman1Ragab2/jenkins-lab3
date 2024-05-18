output "nginx-server" {
    value = aws_instance.nginx.public_ip
}
