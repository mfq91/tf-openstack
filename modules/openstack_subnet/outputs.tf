output "subnet_name" {
  value = "${openstack_networking_subnet_v2.openstack_subnet.name}"
}

output "subnet_network_id" {
  value = "${openstack_networking_subnet_v2.openstack_subnet.network_id}"
}

output "subnet_id" {
  value = "${openstack_networking_subnet_v2.openstack_subnet.id}"
}

output "subnet_cidr" {
  value = "${openstack_networking_subnet_v2.openstack_subnet.cidr}"
}

