resource "openstack_networking_subnet_v2" "openstack_subnet" {
  name       = var.subnet_name
  network_id = var.network_id
  cidr       = var.cidr
  ip_version = var.ip_version
}