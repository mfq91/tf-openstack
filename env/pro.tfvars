openstack_user_name = "admin"
openstack_tenant_name = "admin"
openstack_auth_url = "https://192.168.0.2:5000/v3"
ubuntu_instance_name = "cirros"
security_groups = [ "default" ]
image_name = "cirros"
flavor_name = "m1.tiny"
network_name = "pro"
network_admin_state_up = "true"
openstack_router_name = "pro"
#openstack_external_network_id = "afb7428f-63dc-4bf0-8050-02b5d9c08d3a"
openstack_security_group_name = "allowssh-sg"
openstack_security_group_desc = "allowssh-sg"
from_port = 22
to_port = 22
ip_protocol = "tcp"
cidr = "0.0.0.0/0"
subnet_name = "pro-subnet"
subnet_cidr = "10.0.1.0/24"
