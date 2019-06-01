provider "aws" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
 region = "${var.region}"
}
resource "aws_instance"  "main" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
key_name = "awslabvenkat1"
tags{
 Name = "first-intsance-using-TF"
}
}
