resource "aws_default_vpc" "default" {
cidr
  tags = {
    Name = "Default VPC"
  }
}