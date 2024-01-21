variable "instance_ami_ubuntu" {
  type          = string
  default       = "ami-04f767d954fe2d2d1"
  description   = "This Amazon Machien Image belongs to an Ubuntu Server 22.04 LTS"
}

variable "instance_ami_windows" {
  type          = string
  default       = "ami-094aa6728b151e05a"
  description   = "This Amazon Machine Image belongs to a Windows Server 2022 Base"
}

variable "instance_type" {
  type      = string
  default   = "t2.micro"
}

variable "table_name" {
  type      = string
  default   = "terraform-sandbox-us-west-2-lock-dynamo"
}
