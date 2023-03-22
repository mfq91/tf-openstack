## Terraform Openstack

### Este proyecto despliega unos cuantos recursos en una instalación por defecto de Microstack, implementación que ha hecho Canonical de Openstack

## Backend de Terraform

### en s3 (cuenta mfq-pro-account)

## Terraform workspaces

### Este proyecto utiliza workspaces. En cada workspace utilizamos el fichero tfvars correspondiente

## Configuración como código

## Las instancias que se generan ejecutan scripts de la carpeta cac

# dependencias

## clave de administración (pass que se pasa de momento como variable)
## ip del host (actualmente se pasa como variable y es la 192.168.0.2, de sylar en la red local)
## un keypair creado con nombre "test", que se inyectará en las instancias

# ejemplo de uso para desplegar en el workspace de PRO

`terraform init -reconfigure`
`terraform workspace list`
`terraform workspace select pro`
`terraform plan --var-file=.\env\pro.tfvars`
`terraform apply --var-file=.\env\pro.tfvars`
`terraform destroy --var-file=.\env\pro.tfvars`