resource "aws_security_group" "allow_local" {
    name        = "esteban-lab-group"
    description = "Allow all inbound local traffic"

    ingress {
        description = "Inbound local ssh connection"
        from_port   = "22"
        to_port     = "22"
        protocol    = "TCP"
        cidr_blocks = ["186.113.135.184/32"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_vpc" "vpc_us-west-2_esteban" {
  cidr_block    = "192.168.0.0/16"

  tags = {
        Name    = "esteban-sandbox-vpc"
    }
}

resource "aws_key_pair" "deployer" {
    key_name    = "deployer-key"
    public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4ojoTfOUYpSgPzcC8SfTnMslu9j08CPzWpGDDz7FwcFbAALZShRnpQ6R+lDew2vqts+ipJj7MBwjwIRfPRYRQ9Gw6VCRbHRmzzUJkyiH4c9SG4AfGboRKgSAJJq3+jPqr9OMARLNhAURLygJ5UJ6m65CFjjnYy2BAylRyETzLlgPnTJM5KRz+26gswTdp3I30xcGrEj1jcFVRqR19XNXIt4UprOOgeehByPSpjdy+3KnBE6yiiKN+dbt0lUfD5x6jQwI4Df2X8HL63Lj/yePUVmwPFL0WdN2AJFjRpBMo2sVowVBmaZo10tse6sN1wsoj6b9iMWqJ154GOI7RExqNLJEaLVi1BWW34hY2YoRdGQ7QAYZ8OoQ5jwAKCJkoAKs9PRjakw7ugLNrYsbIXul33v/z8vJFkxRRgvCFqP7beM7U/WzEBkK4xG22qVzQC9xTPoU8VQeW5P53KGy6IYSx4Gutx4cShw7Vj2bn6IG5yVvpJpzCSlMBdrb1U+DMbcBPteKjZbrSxfHEd52BmamLQ1dQPBbJS2JvvZwamvVAIMzwuUhhrJ9DQurY40fd6qg+pTIAq5pjSM3qTW/V+OZaTydCrGMOYW3BHlhEav4PiPa2caUcBvYU3cQ6ojlEnNrDtrDeewDVpQF4Obvjul+rtmxCpUGYAh0PeEx5dBtR1Q== estebago@ESTEBAGO-M-X9Q9"
}

resource "aws_instance" "ubuntu-ec2" {
    ami                     = var.instance_ami_ubuntu
    instance_type           = var.instance_type
    security_groups         = ["esteban-sandbox-group"]
    key_name                = "deployer-key"
    vpc_security_group_ids  = [data.aws_vpc.vpc_us-west-2_esteban.id]

    tags = {
        Name    = "ubuntu-esteban"
    }
}