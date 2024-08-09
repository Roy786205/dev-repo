resource "aws_default_vpc" "default" {
    cidr_block = 
  tags = {
    Name = "Default VPC"
  }
}