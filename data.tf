data "openstack_networking_network_v2" "external_network" {
  name = "external"
}

# data "openstack_compute_keypair_v2" "test_keypair" {
#   name = "test"
# }