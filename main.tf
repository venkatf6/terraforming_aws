provider "aws" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
 region = "${var.region}"
}
resource "aws_vpc" "tata-vpc" {
 
 cidr_block = "${var.cidr_block}"
 instance_tenancy = "default"
 enable_dns_hostname = "true"
 tags{
  Name = "TATA_VPC_1"
  }
 }
resource "aws_subnet" "tata-subnet"{
 vpc_id = "${aws_vpc.tata-vpc.id}"
 cidr_block = "${var.subnet_cidr}"
 tags{
  Name = "TATA_subnet_1"
  }
 }
resource "aws_internet_gateway" "i_g_w" {
 vpc_id = "${aws_vpc.tata_vpc.id}"
 tags{
  Name = "TATA_INTERNET_GATEWAY"
  }
 }
resource "aws_instance"  "main" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
key_name = "awslabvenkat1"
tags{
 Name = "first-intsance-using-TF"
}

