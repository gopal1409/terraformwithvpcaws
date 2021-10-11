resource "aws_instance" "PublicEC2" {
  ami =   "${var.ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id = "${aws_subnet.Public_Subnet_A.id}"
  key_name = "ec2_keypair"
  tags = {
    Name = "PublicEC2"
  }
  depends_on = ["aws_vpc.mainvpc","aws_subnet.Public_Subnet_A","aws_security_group.allow_ssh"]
}

resource "aws_instance" "PrivateEC2" {
  ami =   "${var.ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id = "${aws_subnet.Private_Subnet_A.id}"
  key_name = "ec2_keypair"
  tags = {
    Name = "PrivateEC2"
  }
  depends_on = ["aws_vpc.mainvpc","aws_subnet.Private_Subnet_A","aws_security_group.allow_ssh"]
}
