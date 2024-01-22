resource "aws_vpc_security_group_ingress_rule" "inbound-ssh-local" {
    security_group_id = aws_security_group.allow_local_vpc.id

    cidr_ipv4      = "186.113.135.184/32"
    from_port      = "22"
    to_port        = "22"
    ip_protocol    = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "outbount-all-all" {
    security_group_id = aws_security_group.allow_local_vpc.id

    cidr_ipv4      = "0.0.0.0/0"
    ip_protocol    = "-1"
}

resource "aws_security_group" "allow_local_vpc" {
    name        = "esteban-lab-vpc"
    description = "Allow all inbound local traffic for the VPC vent-nebo"
    vpc_id      = aws_vpc.vpc_us-east-2_esteban.id
}

resource "aws_vpc" "vpc_us-east-2_esteban" {
  cidr_block    = "10.0.0.0/16"

  tags = {
        Name    = "vent-nebo"
    }
}

resource "aws_subnet" "subnet1_us-east-2_esteban" {
  vpc_id            = aws_vpc.vpc_us-east-2_esteban.id
  cidr_block        = "10.0.0.0/17"
  availability_zone = "us-east-2a"

  tags = {
    Name            = "snet-public"
  }
}

resource "aws_subnet" "subnet2_us-east-2_esteban" {
  vpc_id            = aws_vpc.vpc_us-east-2_esteban.id
  cidr_block        = "10.0.128.0/17"
  availability_zone = "us-east-2a"

  tags = {
    Name            = "snet-private"
  }
}

resource "aws_key_pair" "deployer" {
    key_name    = "PeexMain"
    public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/LEjiP13pvURUMq1w56Kkmck8bGqkTCVKafhD26LSQLBd1eeiXj7vUcjikAyqEemlUmEYkW4eRHsN0Y9Y6YOAnNX9iozSACB5Yqhd/qyx5XdN3AN12RPKCG1Plkokp+Qcny5VXYDrq9AF677+2PidCRbx/YYL1eFJr64TZxGmx/UKcfCq4I4/x+Q2JGinym5Pfohe+JL2SyyyoEk5SucMn5rTXGyp25wCq8ZqhgQxS7JK5f8BmnYDZLKCt3EjII3fZIdf7H2h8yTKBix6TPP3IfiZQO/lTeWGPJF1IVMrc9GZC2jaB7uGRK3l/4DUvKAyLJDkNPnDED6mTLU5sv4N PeexMain"
}

resource "aws_instance" "ubuntu1-ec2" {
    ami                     = var.instance_ami_ubuntu
    instance_type           = var.instance_type
    key_name                = "PeexMain"
    subnet_id               = aws_subnet.subnet1_us-east-2_esteban.id
    vpc_security_group_ids  = [aws_security_group.allow_local_vpc.id]

    tags = {
        Name    = "ubuntu-esteban"
    }
}

resource "aws_instance" "ubuntu2-ec2" {
    ami                     = var.instance_ami_windows
    instance_type           = var.instance_type
    key_name                = "PeexMain"
    subnet_id               = aws_subnet.subnet2_us-east-2_esteban.id
    vpc_security_group_ids  = [aws_security_group.allow_local_vpc.id]

    tags = {
        Name    = "windows-esteban"
    }
}