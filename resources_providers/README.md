# Practica de Resources y Providers

## Init

Primero que nada tenemos que inicializar el proyecto de terraform. Esto lo hacemos ejecuntando le siguiente comando:

```shell
terraform init
```

Podemos observar que se crea un archivo llamado `terraform.lock.hcl` y un folder llamado `.terraform` (que contiene otros varios archivos). Estos son basicamente las dependencias que se necesitan para ejecutar el proyecto de Terraform de manera satisfactoria.

## Plan

Ahora que ya tenemos el proyecto inicializaro, toca ejecutar el plan, para esto ejecutamos el siguiente comando:

```shell
terraform plan
```

El output del comando son las acciones que se van a realizar.

```shell
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.hello_world will be created
  + resource "local_file" "hello_wvorld" {
      + content              = "Hello World"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "hello_world.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

Del recurso `local_file`, el unico argumento que es requerido es `filename`. Los otros, de no ser declarados, toman un valor default. Se recomienda mirar la documentacion para saber cuales son requiridos, cuales son opcionales y sus valores por default.

Existe una opcion llamada `-out` que lo que hace es escribir el plan a un archivo. Es opcional, pero se recomienda crearlo para garantizar que lo mostrado por el comando de `plan` sea lo que aplique el comando de `apply`.

Lo que podemos deducir de este plan, es que se creara un archivo llamado `hello_world.txt`, que tendra como contenido el texto `Hello World`, y que los permisos con los que se generara el archivo son `0777`.

Existen otros argumentos que forman parte del recursos que son conocidos hasta despues de crear el recurso. Por ejemplo, en AWS el ARN es un ID que se sabe hasta que el recurso fue generado.

## Apply

Una vez que ya tenemos claro que es lo que Terraform va a crear, podemos entonces proceder a aplicar el plan. Para esto, simplemente ejecutamos el siguiente comando

```shell
terraform apply
```

```shell
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.hello_world will be created
  + resource "local_file" "hello_world" {
      + content              = "Hello World"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "hello_world.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Como no estamos usando la opcion `-out`, terraform vuelve a crear el plan y a mostrarlo. Tambien espera por el input del usuario para aplicar el cambio.

Escribimos la palabra `yes` para aplicar el cambio.

Terraform nos mostrara los logs de las operaciones ejecutadas.

```shell
local_file.hello_world: Creating...
local_file.hello_world: Creation complete after 0s [id=0a4d55a8d778e5022fab701977c5d840bbc486d0]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Podemos ver que el archvio de `hello_world.txt` ha sido creado, junto con otro llamado `terraform.tfstate`. De momento no nos preocuparemos por el state, lo veremos mas adelante. Solo hay que decir que este archivo es muy importante, pues es el que contiene la informacion de la configuracion actual de nuestro proyecto de Terraform.

Para validar que nuestro archivo se genero correctamente, podemos ejecutar:

```shell
cat hello_world.txt && echo \ && ls -l hello_world.txt
```

### Practica para ustedes:

1. Creen un archivo con permisos de solo lectura para el owner.
1. Utilicen el argumento de -out con el plan y el apply, y comparen las diferencias.
1. Creen el archivo en un folder superior al actual.
