### Terraform Openstack

Este proyecto despliega unos cuantos recursos en una instalación por defecto de Microstack, implementación que ha hecho Canonical de Openstack

### Backend

El backend para este proyecto de Terraform se almacena en un bucket S3 (cuenta mfq-pro-account)

### Workspaces

Este proyecto utiliza workspaces. En cada workspace utilizamos el fichero tfvars correspondiente

### Configuración como código

Las instancias que se generan ejecutan scripts de la carpeta cac

### Requerimientos

- Terraform instalado
- Canonical Microstack instalado en un servidor con Ubuntu

### Administración

Ejemplo de túnel ssh para acceder a Horizon (la interfaz web gráfica de Openstack):
```
ssh -L 8001:10.20.20.1:443 -N -f mauro@192.168.0.2 -f
```

Con eso ya podríamos acceder a Horizon visitando: "https://localhost:8001"

### Variables

De momento, el proyecto depende de los siguientes elementos:
- clave de administración (pass de Horizon, que se pasa de momento como variable)
- ip del host en el que se encuentra microstack (actualmente se pasa como variable y es la 192.168.0.2, de sylar en la red local)
- un keypair creado con nombre "test", que se inyectará en las instancias (pendiente de corregir)

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
terraform plan --var-file=.\env\pro.tfvars
```
Aplicar:
```
terraform apply --var-file=.\env\pro.tfvars
```
Destruir:
```
terraform destroy --var-file=.\env\pro.tfvars
```