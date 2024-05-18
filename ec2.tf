
resource "aws_instance" "nginx" {
  ami = var.ec2_ami
  instance_type = var.ec2_type
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  key_name = var.ec2_key
  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]

  tags = {
    Name = "nginx server "
  }
}

resource "local_file" "inventory" {
  filename = "./inventory.ini"
  content = <<-EOT
  [nginx]
  ${aws_instance.nginx.public_ip}
  EOT
}
  
