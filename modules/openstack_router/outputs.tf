output "router_name" {
  value = openstack_networking_router_v2.openstack_router.name
}

output "router_external_network_id" {
  value = openstack_networking_router_v2.openstack_router.external_network_id
}



