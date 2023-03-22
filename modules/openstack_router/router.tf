# resource "openstack_networking_router_v2" "openstack_router" {
#   name                = var.openstack_router_name
#   external_network_id = var.openstack_router_network_id
# }

# resource "openstack_networking_router_interface_v2" "router_interface" {
#   router_id = openstack_networking_router_v2.openstack_router.id
#   subnet_id = var.subnet_id
# }