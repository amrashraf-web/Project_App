resource "aws_subnet" "public" {
  for_each = var.cidr_blocks
  vpc_id     = var.vpc_id
  cidr_block      = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = each.value.name
  }
}
