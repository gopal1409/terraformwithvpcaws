#we will create custom rtb and attach the same with publci subnet
resource "aws_route_table" "PublicRouteTable" {
 vpc_id = "${aws_vpc.mainvpc.id}"
    route {
      cidr_block = "0.0.0.0/0" 
      gateway_id = "${aws_nat_gateway.NATGW.id}"
    }
  tags = {
      Name = "publicrtbgopal"
    }
  depends_on = ["aws_vpc.mainvpc","aws_internet_gateway.IGW_TF"]
}
resource "aws_route_table_association" "publicroutable_association" {
  subnet_id      = "${aws_subnet.Public_Subnet_A.id}"
  route_table_id = "${aws_route_table.PublicRouteTable.id}"
  depends_on = ["aws_subnet.Public_Subnet_A","aws_route_table.PublicRouteTable"]
}

resource "aws_route_table" "PrivateRouteTable" {
  vpc_id     = "${aws_vpc.mainvpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_nat_gateway.NATGW.id}"
  }
  tags = {
    Name = "PrivateRouteTable-gopal"
  }
  depends_on = ["aws_vpc.mainvpc","aws_nat_gateway.NATGW"]
}

resource "aws_route_table_association" "privateroutetableassociation" {
  subnet_id      = "${aws_subnet.Private_Subnet_A.id}"
  route_table_id = "${aws_route_table.PrivateRouteTable.id}"
  depends_on = ["aws_subnet.Private_Subnet_A","aws_route_table.PrivateRouteTable"]
}