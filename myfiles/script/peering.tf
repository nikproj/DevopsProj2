resource "aws_vpc_peering_connection" "peering" {
  vpc_id        = aws_vpc.main.id
  peer_vpc_id   = aws_vpc.main2.id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "a1" {
  route_table_id            = aws_route_table.private2.id
  destination_cidr_block    = "10.0.1.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}
resource "aws_route" "a2" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "11.0.2.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}
resource "aws_route" "a3" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "11.0.3.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}