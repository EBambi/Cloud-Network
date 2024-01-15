variable "instance_ami_ubuntu" {
  type          = string
  default       = "ami-008fe2fc65df48dac"
  description   = "This Amazon Machien Image belongs to an Ubuntu Server 22.04 LTS"
}

variable "instance_ami_windows" {
  type          = string
  default       = "ami-09cd5735442e39f0d"
  description   = "This Amazon Machine Image belongs to a Windows Server 2022 Base"
}

variable "instance_type" {
  type      = string
  default   = "t2.micro"
}
