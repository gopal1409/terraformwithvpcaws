resource "aws_subnet" "Public_Subnet_A" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "${var.availability_zone}"
  map_public_ip_on_launch = true 

  tags = {
    Name = "public_subnet_gopal"
  }
  depends_on = [
    "aws_vpc.mainvpc"
  ]
}
resource "aws_subnet" "Private_Subnet_A" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${var.availability_zone}"


  tags = {
    Name = "private_subnet_gopal"
  }
  depends_on = [
    "aws_vpc.mainvpc"
  ]
}