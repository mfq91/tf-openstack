output "ssh_chain" {
  value = "ssh -o \"PubkeyAcceptedKeyTypes +ssh-rsa\" ubuntu@${openstack_networking_floatingip_v2.openstack_fip.address}" #ver como quitar escape
}

