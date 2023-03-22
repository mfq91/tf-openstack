resource "openstack_compute_instance_v2" "openstack_instance" {
  count = 5
  name            = var.name
  security_groups = var.security_groups
  image_name = var.image_name
  flavor_name = var.flavor_name
  network {
    name = var.network_name  
    #port = "${openstack_networking_port_v2.port_1.id}"
  }
}