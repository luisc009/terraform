# Variables y Outputs

## Variables

Las variables son siempre son requeridas a menos de que sean nullables (tengan cuidado cuando usen variables nulas, siempre hay resultados inesperados). Si las variables cuentan con el argumento de default, Terraform lo usara de forma automatica. Se pueden cambiar sus valores de diferentes formas.

### Desde el CLI

Tanto el comando `plan` como `apply` soportan la opcion `-var ${variable_name}=${value}`, con esto podemos cambiar el valor default.

```shell
terraform plan -var 'content=this is a new world'
terraform apply -var 'content=this is a new world'
```

En el output podremos ver como es que el valor es reemplazado por el que le estamos pasando en el commando de `plan`/`apply`.

### Desde un archivo de variables.

Dentro del archivo override.tfvars escribiremos los valores que nosotros deseamos. El formato es el siguiente:

```terraform
variable_name = value
```

Y para utilizarlo, solo hay que pasar la opcion `-var-file="${file_name}.tfvars"`.

```shell
terraform plan -var-file="override.tfvars"
terraform apply -var-file="override.tfvars"
```

### Desde variables de entorno

Tambien se pueden usar variables de entorno para declarar variables. Para ello es importante usar el prefijo `TF_VAR_${variable_name}`.

```shell
TF_VAR_content="this is a new world from env vars" terraform plan
TF_VAR_content="this is a new world from env vars" terraform apply
```

O tambien se pueden exportar.

```shell
export TF_VAR_content="this is a new world from exported variable"
terraform plan
terraform apply
```

Noten como es necesario usar los mismos valores al momento de hacer `plan` y luego `apply`, ahora mas que nunca se nota la utilidad de escribir el plan usando la opcion `-out`.

## Output values

Los valores de output normalmente se muestran al concluir la ejecucion de un plan. Por ejemplo, si quisieramos saber el id del archivo, lo hacemos de la siguiente forma:

```terraform
output "id" {
    value = local_file.hello_world.id
}
```

Una vez que ejecutamos `apply` la salida del comando muestra lo siguiente:

```shell
local_file.hello_world: Creating...
local_file.hello_world: Creation complete after 0s [id=0c063810bc64aa92acc8d4b4e5f1bd827e992731]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

id = "0c063810bc64aa92acc8d4b4e5f1bd827e992731" <-- Nuestro valor!
```

### Accediendo a los valores de los recursos

Para acceder a los valores de los recursos, usamos una expresion. Es el `id` que es el atributo expuesto por `local_file` y que pertenece a la instancia `hello_world`, entonces es: `local_file.hello_world.id`

Estas expresiones pueden tener mas niveles pues dependen de como son declaradas. En ejercicios posteriores (modules) lo veremos mas a detalle.

## Local values

Un local value asigna un nombre a una expresion. Daremos un vistazo a las expresiones mas adelante. Se mencionan ahora por su cercania con variables y output values.

Estos local value (o tambien llamados como locals), son como variables temporales que existen durante el proceso de plan y apply.

Su declaracion se hace dentro del bloque locals, como se ilustra de la siguiente manera:

```terraform
locals {
    name = expression
}
```

Y se referencian usando la expresion local.${name}

Por ejemplo, usemos un local para crear el nombre del archivo.

```terraform
locals {
    file_name = "${var.filename}.txt" #1 what is that?!
}

resource "local_file" "hello_world" {
  filename = local.file_name
}
```

Noten que se usa local (sin la s) para obtener la referencia a file_name

#1 Es una interpolacion! Pero eso lo veremos mas adelante :)
