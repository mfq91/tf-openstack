resource "openstack_networking_network_v2" "openstack_network" {
  name           = var.network_name
  admin_state_up = var.network_admin_state_up
}

resource "openstack_networking_router_v2" "openstack_router" {
  name                = var.openstack_router_name
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = "${openstack_networking_router_v2.openstack_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.openstack_subnet.id}"
}

resource "openstack_networking_subnet_v2" "openstack_subnet" {
  name       = var.subnet_name
  network_id = "${openstack_networking_network_v2.openstack_network.id}"
  cidr       = var.subnet_cidr
  ip_version = 4

}

resource "openstack_compute_instance_v2" "openstack_instance" {
  #count = 5
  name            = var.ubuntu_instance_name 
  security_groups = var.security_groups
  image_name = var.image_name
  flavor_name = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.sylar_keypair.name
  network {
    name =   "${openstack_networking_network_v2.openstack_network.name}"
    #port = "${openstack_networking_port_v2.port_1.id}"
  }

  depends_on = [
    openstack_networking_subnet_v2.openstack_subnet
  ]

}

resource "openstack_networking_floatingip_v2" "openstack_fip" {
  pool = "external"
}

resource "openstack_compute_floatingip_associate_v2" "openstack_fip_association" {
  floating_ip = "${openstack_networking_floatingip_v2.openstack_fip.address}"
  instance_id = "${openstack_compute_instance_v2.openstack_instance.id}"
}

resource "openstack_compute_keypair_v2" "sylar_keypair" {
  name       = "sylar-keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwO2yC+tK8UtPzc+7DnsZOhD7WutyzludC6NoMZ2tTx6aRl89EL90WXy7p1l4uHhJ4brGdub78dakmYYhSGQQAI2nU/7gAwX7w2h9hJE5KfWL/DKTKW7WL8R+wtBunQsg+5gptJVWJTVvNMnsOPgk2bfG4XMpBDLCCTOY4POXBpOucGYjloUM8rYJLmVmQrWnJ/ljewwJ1mC4f3UrgWaowMP6sBvEqKFvv8Jt3chNMhhC5DQ3Sz3B7k2BYQt+/qQw6xF8weZlJpPSa5b7bE1CjXQl7bBSmtX37hYvUwHNKZwQEY880J/+7K6tCARf8qlit8nFabn/y+ihu1PJ6kt58cPsIIXk2D6D5jkv0pBFIitL4CXu8PvVSkTqys2FBx6r2//PjpNhGCZTzI9tNLJ0wnAn0Fp6eV2luPt3o2V8FKiZXaXRNz1cn7FmicyNq2XJhxchozDyVkF+SwKjfm5HYXuzWLFdC981Lkzd56U+FDpFhnf/QTMWePn1o9p8DhSk= mauro@sylar"
}

resource "openstack_images_image_v2" "rancheros" {
  name             = "RancherOS"
  image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility = "public"
}

resource "openstack_images_image_v2" "ubuntu_jammy" {
  name             = "UbuntuJammy"
  image_source_url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"
  container_format = "bare"
  disk_format      = "raw"
  visibility = "public"
}


resource "openstack_compute_flavor_v2" "openstack_m1_mini_flavor" {
  name  = "mfq.mini"
  ram   = "1024"
  vcpus = "1"
  disk  = "16"

  extra_specs = {
    "hw:cpu_policy"        = "CPU-POLICY",
    "hw:cpu_thread_policy" = "CPU-THREAD-POLICY"
  }
}