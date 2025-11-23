# Instance creation
resource "aws_instance" "docker" {
  ami           = local.ami_id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-Docker-instance"
  }
  vpc_security_group_ids = [aws_security_group.allow_all.id]
   # adding memory
  root_block_device {
    volume_size = 50
    volume_type = "gp3" # or gp2 depending on performance
  }
  user_data = file("user-data.sh")
}


# security group creation to allow all ports 
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbould traffic and all outbound traffic"
  #   vpc_id      = aws_vpc.main.id    as we are not created vpc i am commenting it to take default vpc

  tags = {
    Name = "allow_all"
  }
  ingress {
    description = "Allow all inbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
