# Network

resource "openstack_networking_network_v2" "openstack_network" {
  name           = var.network_name
  admin_state_up = var.network_admin_state_up
}

resource "openstack_networking_subnet_v2" "openstack_subnet" {
  name       = var.subnet_name
  network_id = "${openstack_networking_network_v2.openstack_network.id}"
  cidr       = var.subnet_cidr
  ip_version = 4

}

# Router

resource "openstack_networking_router_v2" "openstack_router" {
  name                = var.openstack_router_name
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = "${openstack_networking_router_v2.openstack_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.openstack_subnet.id}"
}

# Instance

resource "openstack_compute_instance_v2" "openstack_instance" {
  #count = 5
  name            = var.ubuntu_instance_name 
  security_groups = [ "${openstack_compute_secgroup_v2.openstack_mfq_default_sg.name}" ]
  image_name = openstack_images_image_v2.ubuntu_jammy.name
  flavor_name = var.flavor_name #"${openstack_compute_flavor_v2.openstack_mfq_medium_flavor.name}" #"m1.small"
  key_pair        = "${openstack_compute_keypair_v2.sylar_keypair.name}"
  network {
    name =   "${openstack_networking_network_v2.openstack_network.name}"
  }
  depends_on = [
    openstack_networking_subnet_v2.openstack_subnet,
    openstack_compute_keypair_v2.sylar_keypair,
    openstack_compute_flavor_v2.openstack_mfq_medium_flavor,
    openstack_compute_secgroup_v2.openstack_mfq_default_sg,
    openstack_images_image_v2.ubuntu_jammy,
    openstack_networking_network_v2.openstack_network
  ]
}

# Floating IP

resource "openstack_networking_floatingip_v2" "openstack_fip" {
  pool = "external"
}

resource "openstack_compute_floatingip_associate_v2" "openstack_fip_association" {
  floating_ip = "${openstack_networking_floatingip_v2.openstack_fip.address}"
  instance_id = "${openstack_compute_instance_v2.openstack_instance.id}"
}

# Keypair

resource "openstack_compute_keypair_v2" "sylar_keypair" {
  name       = "sylar-keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwO2yC+tK8UtPzc+7DnsZOhD7WutyzludC6NoMZ2tTx6aRl89EL90WXy7p1l4uHhJ4brGdub78dakmYYhSGQQAI2nU/7gAwX7w2h9hJE5KfWL/DKTKW7WL8R+wtBunQsg+5gptJVWJTVvNMnsOPgk2bfG4XMpBDLCCTOY4POXBpOucGYjloUM8rYJLmVmQrWnJ/ljewwJ1mC4f3UrgWaowMP6sBvEqKFvv8Jt3chNMhhC5DQ3Sz3B7k2BYQt+/qQw6xF8weZlJpPSa5b7bE1CjXQl7bBSmtX37hYvUwHNKZwQEY880J/+7K6tCARf8qlit8nFabn/y+ihu1PJ6kt58cPsIIXk2D6D5jkv0pBFIitL4CXu8PvVSkTqys2FBx6r2//PjpNhGCZTzI9tNLJ0wnAn0Fp6eV2luPt3o2V8FKiZXaXRNz1cn7FmicyNq2XJhxchozDyVkF+SwKjfm5HYXuzWLFdC981Lkzd56U+FDpFhnf/QTMWePn1o9p8DhSk= mauro@sylar"
}

# Images

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

# Flavors

resource "openstack_compute_flavor_v2" "openstack_mfq_mini_flavor" {
  name  = "mfq.mini"
  ram   = "1024"
  vcpus = "1"
  disk  = "16"

  extra_specs = {
    "hw:cpu_policy"        = "CPU-POLICY",
    "hw:cpu_thread_policy" = "CPU-THREAD-POLICY"
  }
}

resource "openstack_compute_flavor_v2" "openstack_mfq_medium_flavor" {
  name  = "mfq.medium"
  ram   = "2048"
  vcpus = "1"
  disk  = "32"

  extra_specs = {
    "hw:cpu_policy"        = "CPU-POLICY",
    "hw:cpu_thread_policy" = "CPU-THREAD-POLICY"
  }
}

resource "openstack_compute_flavor_v2" "openstack_mfq_large_flavor" {
  name  = "mfq.large"
  ram   = "4096"
  vcpus = "2"
  disk  = "32"

  extra_specs = {
    "hw:cpu_policy"        = "CPU-POLICY",
    "hw:cpu_thread_policy" = "CPU-THREAD-POLICY"
  }
}

# Security Groups


resource "openstack_compute_secgroup_v2" "openstack_mfq_default_sg" {
  name        = "openstack-mfq-default-sg"
  description = "Security Group that allows 22 and 80 from anywhere"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}