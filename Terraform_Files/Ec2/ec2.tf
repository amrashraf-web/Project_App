data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "Project_Server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  subnet_id     = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.security_group]
  associate_public_ip_address = true
  iam_instance_profile = var.eks_profile_name
  tags = {
    Name = var.instance_name
  }
}
