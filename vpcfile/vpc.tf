resource "aws_default_vpc" "default" {
  # #cidr_block = "10.0.0.0/16"  
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_internet_gateway" "gw" {
  ##vpc_id = aws_default_vpc.default.id

  tags = {
    Name = "main"
  }
}
resource "aws_default_subnet" "default_az1" {
  availability_zone = "ap-south-1a"
  #vpc_id = aws_default_vpc.default.id
  ##cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Default subnet for ap-south-1a"
  }
}
resource "aws_default_route_table" "example" {
  default_route_table_id = aws_default_vpc.default.id

  route {
    #cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}
resource "aws_route_table_association" "name" {
  subnet_id = aws_default_subnet.default_az1.id
  route_table_id = aws_default_route_table.example.id
  
}