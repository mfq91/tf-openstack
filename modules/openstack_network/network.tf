resource "openstack_networking_network_v2" "openstack_network" {
  name           = var.network_name
  admin_state_up = var.network_admin_state_up
}