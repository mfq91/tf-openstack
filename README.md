### Terraform Openstack

Este proyecto despliega unos cuantos recursos en una instalación por defecto de Microstack, implementación que ha hecho Canonical de Openstack

### Backend

El backend para este proyecto de Terraform se almacena en un bucket S3 (cuenta mfq-pro-account)

### Workspaces

Este proyecto utiliza workspaces. En cada workspace utilizamos el fichero tfvars correspondiente

### Requerimientos

- Terraform instalado en nuestro equipo
- AWS CLI instalado en nuestro equipo y configurado con credenciales que tengan permisos sobre el S3 en el que se guardan los ficheros de estado de Terraform
- Canonical Microstack instalado en un servidor con Ubuntu (min 8 GB RAM)
```
sudo snap install --edge microstack
sudo microstack init --auto --control
```

### Administración

Ejemplo de túnel ssh para acceder a Horizon (la interfaz web de Openstack) desde nuestro equipo:

```
ssh -L 8001:10.20.20.1:443 -N -f mauro@192.168.0.2 -f
```

Con eso ya podríamos acceder a Horizon visitando: "https://localhost:8001"

Usuario Horizon: admin
Password Horizon: resultado de ejecutar en el servidor "sudo snap get microstack config.credentials.keystone-password"

### Definir variable de entorno con pass de openstack

Obtener password:

```
sudo snap get microstack config.credentials.keystone-password
```

Setear variable de entorno (powershell):

```
$Env:openstack_password="oniX43aBFL1SacrA9Hk0dXAkLIMFbO06"
```


### Ejemplo de uso para desplegar en el workspace productivo

Inicializar:
```
terraform init -reconfigure
```
Listar workspaces:
```
terraform workspace list
```
Seleccionar workspace:
```
terraform workspace select pro
```
Planear:
```
terraform plan --var-file=.\env\pro.tfvars -var "openstack_password=$env:openstack_password"
```
Aplicar pidiendo confirmación:
```
terraform apply --var-file=.\env\pro.tfvars -var "openstack_password=$env:openstack_password"
```
Aplicar sin pedir confirmación:
```
terraform apply --auto-approve --var-file=.\env\pro.tfvars -var "openstack_password=$env:openstack_password"
```
Destruir:
```
terraform destroy --auto-approve --var-file=.\env\pro.tfvars -var "openstack_password=$env:openstack_password"
```

### Outputs a variables de entorno
```
$env:TF_VAR_ssh_chain = (terraform output ssh_chain)
Write-Host "El valor de TF_VAR_ssh_chain es $($env:TF_VAR_ssh_chain)"
```
