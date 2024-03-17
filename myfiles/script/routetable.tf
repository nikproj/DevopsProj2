#Public Route Table VPC-1
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name        = "${var.name}-public-route-table",
    },
    var.tags
  )
}

#Private Route Table VPC-1
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name        = "${var.name}-private-route-table",
    },
    var.tags
  )
}



#Public Route Table For VPC2
resource "aws_route_table" "public2" {
  vpc_id = aws_vpc.main2.id
  tags = merge(
    {
      Name        = "${var.name2}-public-route-table",
    },
    var.tags
  )
}

#Private Route Table for VPC2
resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main2.id
  tags = merge(
    {
      Name        = "${var.name2}-private-route-table",
    },
    var.tags
  )
}