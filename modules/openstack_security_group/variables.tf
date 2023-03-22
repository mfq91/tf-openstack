variable "openstack_security_group_name" {
  default = "allowssh-sg"
}
variable "openstack_security_group_desc" {
  default = "allowssh-sg"
}

variable "from_port" {
    default = 22
}

variable "to_port" {
    default = 22
}

variable "ip_protocol" {
    default = "tcp"
}

variable "cidr" {
    default = "0.0.0.0/0"
}

