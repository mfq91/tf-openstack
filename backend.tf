# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  } 
  backend "s3" {
    bucket = "tf-mfq-openstack-bucket" # mfq-pro-account
    key    = "tf/terraform.tfstate"
    region = "eu-west-1"
  }
  
}

provider "openstack" {
  
  user_name = "${var.openstack_user_name}"
  tenant_name = "${var.openstack_tenant_name}"
  password  = "${var.openstack_password}"
  auth_url  = "${var.openstack_auth_url}"
  domain_name = "Default"
  insecure = true
}



# provider "openstack" {
#   auth_url   = "https://192.168.0.2:5000/v3"
#   user_name  = "admin"
#   password   = "cnocLrIndUVXZxJPeZhaDzRVINJUuB7A"
#   #project_id = "admin"
#   domain_name  = "Default"
#   insecure = true
  
#   # La configuración de certificados
#   # ca_cert    = "${file("<ruta al certificado ca>")}"
#   # cert       = "${file("<ruta al certificado>")}"
#   # key        = "${file("<ruta a la clave privada>")}"
# }

