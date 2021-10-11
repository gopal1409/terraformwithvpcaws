#this will create my vpc
resource "aws_vpc" "mainvpc" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
      Name = "VPC_TF_Gopal"
  }
}

#create a custom security group for my vpc and attache the same with vpc
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = "${aws_vpc.mainvpc.id}" #this sag will attach with my custom vpc

  ingress = [
    {
      description      = "allow ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null
      security_groups = null
      self = null

    }
  ]

  egress = [
    {
      description      = "allow ssh"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null
      security_groups = null
      self = null
    }
  ]

  tags = {
    Name = "Security_Group_tf_gopal"
  }
  depends_on = [
    "aws_vpc.mainvpc"
  ]
}

#create an internet gw and attache the same with my vpc
resource "aws_internet_gateway" "IGW_TF" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  tags = {
    Name = "IGW_TF_Gopal"
  }
  depends_on = [
    "aws_vpc.mainvpc"
  ]
}

#we will create an ealstic ip
resource "aws_eip" "EIP" {
  vpc = true
  tags = {
    Name = "EIP_TF_Gopal"
  }
  depends_on = [
    "aws_vpc.mainvpc"
  ]
}
#create a nat gw and attache the same with my vpc

resource "aws_nat_gateway" "NATGW" {
  allocation_id = "{aws_eip.EIP.id}"
  subnet_id     = aws_subnet.Public_Subnet_A.id

  tags = {
    Name = "NAT_GW_gopal"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = ["aws_eip.EIP","aws_subnet.Public_Subnet_A"]
}
