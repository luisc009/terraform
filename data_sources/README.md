# Data Sources

En este proyecto ya contamos con el archivo de hello_world.txt, y lo que queremos hacer es buscarlo y usar como output el contenido del archivo.

Para eso declaramos el data source de file de la siguiente manera:

```terraform
data "local_file" "hello_world" {
  filename = "hello_world.txt"
}
```

Y para poder referenciarlo en el output, usamos una expresion que nos diga lo siguiente: el `content` que es parte de `local_file` que a su vez es expuesto por el `data source`, y que pertenece a la instancia de `hello_world`, quedando en `data.local_file.hello_world.content`.

```terraform
output "content"{
  value = data.local_file.hello_world.content
}
```
