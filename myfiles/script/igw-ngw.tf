#Internet Gateway for VPC1
resource "aws_internet_gateway" "igw"{
   vpc_id = aws_vpc.main.id
   tags = merge(
    {
      Name        = "${var.name}-igw",
    },
    var.tags
  )
}

#Route to IGW
resource "aws_route" "igw"{
 route_table_id = aws_route_table.public.id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.igw.id
}

#Elastic IP for Nat-GW
resource "aws_eip" "eip" {
  domain = "vpc"
}
#NAT-GW
resource "aws_nat_gateway" "ngw" {
  tags = merge(
    {
      Name        = "${var.name}-ngw",
    },
    var.tags
  )
 subnet_id = aws_subnet.public[0].id
 allocation_id = aws_eip.eip.id
}
#Route to NAT-GW
resource "aws_route" "ngw"{
 route_table_id = aws_route_table.private.id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = aws_nat_gateway.ngw.id
}


#Internet Gateway for VPC2
resource "aws_internet_gateway" "igw2"{
   vpc_id = aws_vpc.main2.id
   tags = merge(
    {
      Name        = "${var.name2}-igw",
    },
    var.tags
  )
}
#Route to IGW
resource "aws_route" "igw2"{
 route_table_id = aws_route_table.public2.id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.igw2.id
}
#Elastic IP for Nat-GW VPC-2
resource "aws_eip" "eip2" {
  domain = "vpc"
}
#NAT-GW
resource "aws_nat_gateway" "ngw2" {
  tags = merge(
    {
      Name        = "${var.name2}-ngw",
    },
    var.tags
  )
 subnet_id = aws_subnet.public2[0].id
 allocation_id = aws_eip.eip2.id
}
#Route to NAT-GW
resource "aws_route" "ngw2"{
 route_table_id = aws_route_table.private2.id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = aws_nat_gateway.ngw2.id
}