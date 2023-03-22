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
  key_pair        = data.openstack_compute_keypair_v2.test_keypair.name
  network {
    name =   "${openstack_networking_network_v2.openstack_network.name}"
    #port = "${openstack_networking_port_v2.port_1.id}"
  }

  depends_on = [
    openstack_networking_subnet_v2.openstack_subnet
  ]

}

# Revisar

# resource "openstack_compute_openstack_security_group_v2" "openstack_security_group" {
#   name        = var.openstack_security_group_name
#   description = var.openstack_security_group_desc

#   rule {
#     from_port   = var.from_port
#     to_port     = var.to_port
#     ip_protocol = var.ip_protocol
#     cidr        = var.cidr
#   }
# }

# resource "openstack_networking_port_v2" "port_1" {
#   name               = "port_1"
#   network_id         = "${openstack_networking_network_v2.openstack_network.id}"
#   admin_state_up     = "true"
#   security_group_ids = ["${openstack_compute_openstack_security_group_v2.openstack_security_group.id}"]

#   fixed_ip {
#     subnet_id  = "${openstack_networking_subnet_v2.openstack_subnet.id}"
#     ip_address = "10.0.1.10"
#   }
# }

#-----------------------------
# Call modules
#-----------------------------


# variable "enable_module" {
#   default = {
#     openstack_network              = true
#     openstack_router              = true
#     openstack_subnet = true
#     openstack_network_port = false
#     openstack_security_group              = true
#     openstack_compute_instance      = true
#   }
#   type = object({
#     openstack_network              = bool
#     openstack_router              = bool
#     openstack_subnet = bool
#     openstack_network_port = bool
#     openstack_security_group              = bool
#     openstack_compute_instance      = bool
#   })
# }

# # Networking

# module "openstack_network" {
#   source               = "./modules/openstack_network"
#   count                = var.enable_module.openstack_network ? 1 : 0
#   network_name = "pro"
#   network_admin_state_up = "true"
# }

# module "openstack_router" {
#   source               = "./modules/openstack_router"
#   count                = var.enable_module.openstack_router ? 1 : 0
#   openstack_router_name = "pro"
#   openstack_external_network_id = "035ed6d7-be31-41aa-b943-75b167200ae5"
#   subnet_id = module.openstack_subnet.subnet_id
# }

# module "openstack_subnet" {
#   source               = "./modules/openstack_subnet"
#   count                = var.enable_module.openstack_subnet ? 1 : 0
#   subnet_name = module.openstack_network.network_name
#   network_id = module.openstack_network.network_id
#   cidr = "0.0.0.0/0"
#   ip_version = 4
  
# }

# module "openstack_network_port" {
#   source               = "./modules/openstack_network_port"
#   count                = var.enable_module.openstack_network_port ? 1 : 0


# }

# module "openstack_security_group" {
#   source               = "./modules/openstack_security_group"
#   count                = var.enable_module.openstack_security_group ? 1 : 0
#   openstack_security_group_name = "allow-ssh-sg"
#   openstack_security_group_desc = "allow-ssh-sg"
# }

# module "openstack_compute_instance" {
#   source               = "./modules/openstack_compute_instance"
#   count                = var.enable_module.openstack_compute_instance ? 1 : 0
#   name= "ubuntu"
#   security_groups = [module.openstack_security_group[0].sg_name]
#   image_name = "ubuntu-22.04"
#   flavor_name = "m1.small"
#   network_name = module.openstack_network.network_name
# }