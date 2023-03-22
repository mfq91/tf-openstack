resource "openstack_compute_secgroup_v2" "openstack_security_group" {
  name        = var.openstack_security_group_name
  description = var.openstack_security_group_desc

  rule {
    from_port   = var.from_port
    to_port     = var.to_port
    ip_protocol = var.ip_protocol
    cidr        = var.cidr
  }
}