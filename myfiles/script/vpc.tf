#vpc
resource "aws_vpc" "main"{
 tags = merge (
      {
          Name = var.name
      },
      var.tags
  )
 cidr_block               = var.vpc_cidr_block
 enable_dns_hostnames     = true                     #For EFS Mount DNS name is required 
}

#public-subnet
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones_pub[count.index]
  tags = merge (
      {
          Name = "${var.name}-public-subnet-${count.index}"
      },
      var.tags
  )
}

#Route table associasion for public-subnet
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


#private-subnet
resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones_pri[count.index]
  tags = merge (
      {
          Name = "${var.name}-private-subnet-${count.index}"
      },
      var.tags
  )
}

#Route table associasion for private-subnet
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}



#vpc2
resource "aws_vpc" "main2"{
 tags = merge (
      {
          Name = var.name2
      },
      var.tags
  )
 cidr_block               = var.vpc_cidr_block2
 enable_dns_hostnames     = true                     #For EFS Mount DNS name is required 
}

#public-subnet
resource "aws_subnet" "public2" {
  count                   = length(var.public_subnet_cidr_blocks2)
  vpc_id                  = aws_vpc.main2.id
  cidr_block              = var.public_subnet_cidr_blocks2[count.index]
  availability_zone       = var.availability_zones2_pub[count.index]
  tags = merge (
      {
          Name = "${var.name2}-public-subnet-${count.index}"
      },
      var.tags
  )
}

#Route table associasion for public-subnet
resource "aws_route_table_association" "public2" {
  count          = length(aws_subnet.public2)
  subnet_id      = aws_subnet.public2[count.index].id
  route_table_id = aws_route_table.public2.id
}


#private-subnet
resource "aws_subnet" "private2" {
  count                   = length(var.private_subnet_cidr_blocks2)
  vpc_id                  = aws_vpc.main2.id
  cidr_block              = var.private_subnet_cidr_blocks2[count.index]
  availability_zone       = var.availability_zones2_pri[count.index]
  tags = merge (
      {
          Name = "${var.name2}-private-subnet-${count.index}"
      },
      var.tags
  )
}

#Route table associasion for private-subnet
resource "aws_route_table_association" "private2" {
  count          = length(aws_subnet.private2)
  subnet_id      = aws_subnet.private2[count.index].id
  route_table_id = aws_route_table.private2.id
}