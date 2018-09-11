//
// setup a jenkins build server in the default VPC
//
provider "aws" {
  region     = "us-east-2"
}

resource "aws_default_vpc" "jenkins_vpc" {

}

data "aws_subnet_ids" "jenkins_subnets" {
  vpc_id = "${aws_default_vpc.jenkins_vpc.id}"
}

variable "jenkins_ami" {
  description = "AMI for jenkins/docker hosts, defaults to AMZ linux"
  default = "ami-0b59bfac6be064b78"
}
variable "jenkins_host_keypair" {
  description = "SSH keypair to use for jenkins hosts. This must exist already."
}

variable "jenkins_instance_type" {
  description = "EC2 instance type for jenkins"
  default = "t2.micro"
}

resource "aws_security_group" "jenkins" {
  name = "jenkins-hosts"
  description = "Security group to support running jenkins master and slaves"
  vpc_id = "${aws_default_vpc.jenkins_vpc.id}"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = 50000
    protocol = "tcp"
    to_port = 50000
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 50000
    protocol = "tcp"
    to_port = 50000
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "jenkins_host" {
  ami = "${var.jenkins_ami}"
  instance_type = "${var.jenkins_instance_type}"
  key_name = "${var.jenkins_host_keypair}"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  subnet_id = "${data.aws_subnet_ids.jenkins_subnets.ids[0]}"

  tags {
    Name = "jenkins_master"
  }
}