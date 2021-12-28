# Terraform

O como me hubiera gustado que me lo enseñaran.

## Prerequistos

Conocimiento basico de la terminal.

## Indice

- Instalación
  - MacOS
    brew install terraform
  - Linux
    apt/pacman/yum/curl
  - tfenv
- Resources y Providers
  - Comandos de Terraform
    - init
    - plan
    - apply
- State
  - Archivo de State
  - Comando show
- Variables, Outputs y Locals
  - Variables
  - Outputs
  - Locals
- Data Sources
- Expressions
  - Types and Values
  - String and Templates
  - Reference to Values
  - Operators
  - Function Calls
  - Conditional Expressions
  - For Expressions
- Modules
- Practica en AWS
  - Modulo de red
  - Modulo de servidor de aplicacion
  - Implementacion de modulo de red y servidor de aplicacion en dos ambientes, development y production.

Terraform es una herramienta para crear, actualizar o eliminar recursos computacionales en la nube con un acercamiento de Infraestructura como Código.

Utilizando el HCL (Hashicorp Language Configuration), tú puedes definir los recursos que necesites en la nube. Terraform soporta los proveedores de nube más populares, tales como: AWS, GCP, Microsoft Azure, DigitalOcean, entre otros más.

En estos tutoriales, veremos los conceptos de Terraform, y como lo puedes usar para definir tu infraestructura en la nube.

## Recursos y Providers

### Recursos

Los recursos son el elemento atómico más importante de Terraform, pues describe un elemento de la infraestructura, puede ser desde una máquina virtual, hasta una VPC.

Los recursos son proporcionados por un provider y puedes tener mas de un provider en tu proyecto de terraform.

La sintaxis que se rige normalmente para describir un recurso es:

```terraform
resource "type_name" <name> {
    argument = value
    arguments {
        argument = value
    }
}
```

Los argumentos de los recursos pueden ser opcionales o requeridos, esto varia entre recursos y siempre es recomendable mirar la documentacion.

### Providers

Los providers son un set de plugins que interactuan con algun Proveedor de Nube o con alguna plataforma de SaaS(Software as a Service).

Ejemplos de providers

- AWS
- GCP
- Azure
- Okta
- Vault

Y tambien pueden ser locales, como:

- Hashicorp/Local

Para utilizar un provider es importante que primero lo declaremos. La sintaxis es:

```terraform
provider "provider_name" {
    option = value
}
```

### Comandos de Terraform

Existen tres comandos basicos y muy empleados al momento de trabajar con Terraform, estos son:

- terraform init
- terraform plan
- terraform apply

#### Init

Terraform init se encarga de descargar todos los providers, modules, estados remotos, etc. Es como instalar las dependencias de un proyecto de programacion.

#### Plan

Genera un plan de ejecucion con las acciones que Terraform ejecutara. Dichas acciones pueden ser la creacion, actualizacion y/o la destruccion de algun recurso dentro del proyecto.

#### Apply

Ejecuta las operaciones estipuladas en el plan, nota: Este comando puede ser destructivo, es importante que revisen muy bien el plan antes de ejecutarlo.

### Practica

La mayoria de los proyectos de terraform llevan la extension `.tf`. Tambien existen otras extensiones como `.tf.json`, `.tfvars`.

1. Crear un archivo llamado `main.tf`.
1. Declarar el provider de hashicorp/local.
1. Declarar un recurso para crear un archivo en el disco duro.
1. Init, Plan, y Apply!

## State

El state de terraform es un archivo que contiene todas las referencias a los recursos declarados en el proyecto de Terraform y los providers, junto con informacion adicional como la version de terraform.

### Archivo de State

Por ejemplo, el state generado por la practica de resources y providers queda de la siguiente manera:

```json
{
  "version": 4,
  "terraform_version": "1.1.2",
  "serial": 1,
  "lineage": "233efbaa-6ac9-c2b0-e2d8-84557838d2e5",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "local_file",
      "name": "hello_world",
      "provider": "provider[\"registry.terraform.io/hashicorp/local\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "content": "Hello World",
            "content_base64": null,
            "directory_permission": "0777",
            "file_permission": "0777",
            "filename": "hello_world.txt",
            "id": "0a4d55a8d778e5022fab701977c5d840bbc486d0",
            "sensitive_content": null,
            "source": null
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    }
  ]
}
```

- outputs: Contiene las referencias a los recursos creados, normalmente son sus propiedades, pero tambien podemos tener otros tipos de outputs.
- resources: Un arreglo de recursos, cada uno de los recursos corresponde a un recurso declarado en el proyecto de Terraform. En el encontramos informacion como el provider, las instancias de cada recurso y sus atributos.

Es muy importante resguardar el estado, pues sin el, basicamente se pierde la relacion entre tu proyecto de Terraform y el provider.

### Comando Show

Terraform cuenta con un comando llamado `show`, dicho comando nos muestra el estado del proyecto entre human readable y terraform format.

Por ejemplo, si ejecutamos `terraform show`, el resultado es el siguiente

```terraform
# local_file.hello_world:
resource "local_file" "hello_world" {
    content              = "Hello World"
    directory_permission = "0777"
    file_permission      = "0777"
    filename             = "hello_world.txt"
    id                   = "0a4d55a8d778e5022fab701977c5d840bbc486d0"
}
```

### Ejercicio

Despues de haber hecho `plan` y `apply` en el proyecto de resources_providers, elimina el archivo `terraform.tfstate` y mira que pasa cuando vuelves a correr el plan (pista: checa la fecha y hora de creacion)

## Variables, Outputs y Local Values

### Variables

Muy bonito y todo, pero como imaginemos que en lugar de Hello World, queremos poder escribir lo que queramos sin necesidad de alterar el codigo? Para eso utilizamos Variables, que son la forma en la que podemos modificar el comportamiento del proyecto sin modificar el codigo.

Para declarar un input, se hace de la siguiente manera:

```terraform
variable "name" {
  type = string/number/bool
  default = ${value}
}
```

Para usar dicha variable, solo hay que referenciarla en la argumento dentro del bloque del recurso. Para ello solo es cuestin de usar la sintaxis `var.${variable_name}`

```terraform
variable "file_name" {
  type    = string
  default = "hello_world.txt"
}

resource "local_file" "hello_world" {
  filename = var.file_name
  ...
}
```

Los argumentos que se pueden utilizar al momento de declarar una variable de input son:

- default, el valor que tendra la variable en caso de no ser suministrada.
- type, el tipo de dato de la variable.
- description, la descripcion (su razon de estar) de la variable.
- validation, un set de reglas que sirver para validar el contenido de la variable.
- sensitive, marca la variable como sensible, y no la muestra en el output. Lo valores possibles son true o false.
- nullable, especifica si la variable puede ser nula o no.

Para mayor informacion, revisar el apartado de [variables](https://www.terraform.io/language/values/variables) de la documentacion de Terraform.

### Outputs

Los outputs son valores de los recursos que conformar tu proyect de Terraform y que estan disponibles para su consumo. Su declaracion luce de la siguiente manera:

```terraform
output "name" {
  value = ${value}
}
```

Los argumentos que se pueden utilizar al momento de declarar un valor de output son:

- description, la descripcion (su razon de estar) del valor.
- sensitive, marca el valor como sensible, y no la muestra en el output. Lo valores possibles son true o false.

### Local Values

Un local value asigna un nombre a una expresion. Daremos un vistazo a las expresiones mas adelante. Se mencionan ahora por su cercania con variables y output values.

Estos local value (o tambien llamados como locals), son como variables temporales que existen durante el proceso de plan y apply.

Su declaracion se hace dentro del bloque locals, como se ilustra de la siguiente manera:

```terraform
locals {
    name = expression
}
```

Y se referencian usando la expresion `local.${name}`

## Data Sources

Los data sources permiten a Terraform utilizar informacion que se encuentra fuera del proyecto. Pueden ser recursos que de crearon en otros proyectos de Terraform, o de forma totalmente ajena a Terraform.

Estos data sources dependen de los providers que se esten utilizando.

Para utilizaros, usamos la siguiente sintaxis

```terraform
data "resource_type" "${name}" {
  name = expression
}
```

Cada uno de los attributos dentro del bloque de data son usados como filtros. Cada data source tiene sus propios atributos y es recomendable ir a la documentacion del provider.

## Expressions

Las expresiones son usadas para referir valores computados. La expresion mas basica que existe es una literal, es decir, valores como cadenas o numeros. `"Hello World"` es una expresion que se evaula a string con el valor tal cual, lo mismo cuando se tiene `1`, en este caso es un numero.

Podemos usar el comando `console` (`terraform console`), para hacer experimentos con expresiones.

### Types and Values

Sabemos entonces que el resultado de una expresion es un valor. Dichos valores tienen un tipo que pueden ser `string`, `number`, `bool`, `list`, `map`, existe un caso adicional para un valor que no tiene tipo, ese es `null`.

```terraform
output "string" {
  value = "I'm a string!"
}

output "number" {
  value = 3.1416
}

output "bool" {
  value = true
}

output "list" {
  value = ["i'm string", 3, true]
}

output "map" {
  value = {
    "1" = 1,
    "2" = 2,
  }
}
```

### String and Templates

Strings son de los tipos mas complejos y mas usados. Terraform soporta quoted syntax y heredoc.

#### Strings

```terraform
#quoted syntax
output "quoted_string" {
  value = "Hello world \n Goodbye world!/s"
}

output "heredoc_string" {
  value = <<<EOT
Hello
World
EOT
}
```

#### Templates

Dentro de un string (o de un heredoc) podemos usar templates para poder embeber una expresion. Se utiliza la ${} para delimitar la secuencia de templates.

```terraform
variable "five" {
  value = 5
}

output "five" {
  value = "the number five is ${var.five}"
}
```

### Reference to Values

Terraform pone a nuestra disposicion muchos tipos de valores nombrados, ejemplos de estos pueden ser:

- Resources, y se referencia asi: <resource_type>.<name>
- Variables, y se referencia asi: var.<name>
- Valores Locales, y se referencia asi: local.<name>
- Child module outputs, y se referencia asi: module.<name>
- Data sources, y se referencia asi: data.<name>

### Operators

Un operador es un tipo de expresion que convierte o combina una o mas expresiones. Existen diferentes tipos de operadores.

#### Aritmeticos

Los clasicos operadores de suma, resta, multiplicacion, division, etc.

- `+`, a + b.
- `-`, a - b.
- `*`, a \* b.
- `/`, a / b.
- `%`, a % b.
- `-`, - a.

#### De igualdad

Evaluan si los terminos son iguales o diferentes, su resultado es booleano.

- `==`, a == b.
- `!=`, a != b.

#### De Comparacion

Evaluan si los terminos son mayor, menos, mayor igual, o menor igual, su resultado es un booleano.

- `<`, a < b.
- `<=`, a <= b.
- `>`, a > b.
- `>=`, a >= b.

### Function Calls

Terraform cuenta con una gran variedad de funciones que puedes usar en expresiones para combinar o transformar valores. La sintaxis que siguien es:

`<function name>(argument, argument, ...)`

Por ejemplo, existe una funcion para sacar el valor mas pequenio de un conjunto de numeros.

```terraform
output "min" {
  value = min(2,3,5)
}
```

En la documentacion de Terraform podemos encontrar todas las [funciones](https://www.terraform.io/language/functions) disponibles.

### Conditional Expressions

Una expresion condcional nos ayuda a elegir un valor u otro dependiendo del resultado de la expresion booleana. La sintaxis recuerda a un if ternario.

```
condition ? if_true : if_false
```

### For Expressions

La expresion de for es utilizada para crear estructuras mas complejas, mediante la transformacion de los elementos de una lista o mapa.

```
[for <element> in <elements> : expressions]
```

Un ejemplo sencillo de transformacion puede ser el de convertir una lista a un mapa.

```
{for <element> in <elements> : key => expression}
```

## Modules

Un module es un contenedor de de recursos que son usados en conjunto. En general, estos consisten en una coleccion de archivos de terraform (`.tf`, `tf.json`) que estan almacenados en el mismo directorio.

Cada proyecto de Terraform consiste en al menos un modulo, tambien llamado modulo raiz, que como ya lo mencionamos, es una coleccion de archivos de terraform en el directorio de trabajo principal.

Un module puede llamar a otros modulos, lo cual nos permite incluir sus recorsos en el modulo raiz. Los modulos se pueden llamar mas de una vez y pueden estar ya sea dentro del mismo directorio de trabajo o en otros directorios, permitiendonos empaquetar recursos y re-utilizarlos.

Para llamar a un modulo, es necesario declarar donde se encuentra y configurar los valores para las variables que utilice dicho modulo.

```terraform
module "config_files" {
  source = "./modules/config_files"

  app_config_filename      = "myapp.txt"
  database_config_filename = "myappdb.txt"
}
```

El argumento `source` es mandatorio. Y se utiliza para indicar donde esta la configuracion de el modulo. Soporta multiples origenes, tales como:

- Sistemas de archivos
- Github/Gitlab/Bitbucket
- Registros de modules (por ejemplo el de hashicorp)

Otros argumentos que tambien soportados:

- version (Recomendado cuando el origen es algun repositorio o registro de modulos)
- las variables de entrada (que pueden ser o no opcionales, depende de la configuracion del modulo)
- meta-argumentos, como `for_each` y `depends_on`

De igual forma, podemos declarar outputs dentro de los modulos que podemos utilizar en otros modulos o recursos o incluso como outputs del modulo raiz.

Por ejemplo, para obtener el id de los archivos generados dentro del modulo.

```terraform
output "myapp_id" {
  value = module.config_files.app_config_id
}

output "myappdb_id" {
  value = module.config_files.database_config_id
}

```

## Practica en AWS
