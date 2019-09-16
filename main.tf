:provider "aws" {
 access_key = "${var.access_key}"
 secret_key = "${var.decret_key}"
 region = "us-east-2"
}
terraform {
 backend "s3"{
 bucket = "terraform-storage-statefiles-f3"
 key = "myapp/dev/terrafor.tfstatefile"
 profile = "terraform-user"
 region = "us-east-2"
}
}
resource "aws_vpc" "TATA-vpc"{
 cidr_block = "10.50.0.0/16"
 instance_tenancy = "default"
 enable_dns_hostnames = true
tags {
 Name = "TATA-vpc"
}
}
resource "aws_subnet" "tata-subnet"{
 vpc_id = "${aws_vpc.TATA-vpc.id}
 cidr_block = "10.50.1.0/24"
tags{
 Name = "tata-subnet"
}
}
resource "aws_internet_gateway" "igw-tata"{
 vpc_id = "${aws_vpc.TATA-vpc.id}"
tags{
 Name = "igw-for-tata-server"
}
}
resource "aws_route_table" "route-tata-server"{
 vpc_id = "${aws_vpc.TATA-vpc.id}"
 route{
  cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw-tata.id}"
}
tags {
 Name = "tata-server-RT"
}
}
resource "aws_route_table_asoociation" "route-tata-server"{
 subnet_id = "${aws_subnet.tata-subnet.id}"
 route_id = "${aws_route_table.route-tata-server.id}"
}
resource "aws_security_group" "tata-sg" {
  Name = "security-group-tata"
  description = "allow incoming http and ssh connection"
  vpc_id = "${aws_vpc.TATA-vpc.id}"
 ingress {
  from_port = "0"
  to_port = "65535"
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "tcp"
}
 tags {
  Name = "webserver-sec-grp"
} 
}
resource "aws_instance" "main"{
 ami = "ami-0c55b159cbfafe1f0"
 instance_type = "t2.micro"
 vpc_id = "${aws_vpc.TATA-vpc.id}"
 subnet_id = "${aws_subnet.tata-subnet.id}"
 vpc_security_group_ids = ["${aws_security_group.tata-sg.id}"]
 associate_public_ip_address = true
 key = "awslabvenkatohio"
}
tags{
 Name = "webserver"
}


