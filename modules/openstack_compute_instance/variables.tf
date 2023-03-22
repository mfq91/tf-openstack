variable "name" {
  default = "ubuntu"
}

variable "security_groups" {
    type = list
}

variable "image_name" {
  default = "ubuntu-22.04"
}

variable "flavor_name" {
  default = "m1.small"
}

variable "network_name" {
  
}
