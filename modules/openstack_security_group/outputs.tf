output "sg_name" {
  value = openstack_compute_secgroup_v2.openstack_security_group.name
}

output "sg_desc" {
  value = openstack_compute_secgroup_v2.openstack_security_group.description
}

output "sg_cidr" {
  value = openstack_compute_secgroup_v2.openstack_security_group.cidr
}

