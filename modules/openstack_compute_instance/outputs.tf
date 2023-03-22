output "name" {
  value = openstack_compute_instance_v2.openstack_instance.name
}

output "security_groups" {
  value = openstack_compute_instance_v2.openstack_instance.security_groups
}

output "image_name" {
  value = openstack_compute_instance_v2.openstack_instance.image_name
}

output "flavor_name" {
  value = openstack_compute_instance_v2.openstack_instance.flavor_name
}

output "flavor_name" {
  value = openstack_compute_instance_v2.openstack_instance.metwork.name
}