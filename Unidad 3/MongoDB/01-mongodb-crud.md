# MongoDB Crud

## Crear una base de datos

**Solo se crea si contiene por lo menos una coleccion**


````json

use basede

````

##

``use db1
db.createCollection('Empleado')``

## Mostrar Collecciones 
``show collections``

## Inserción de un documento

db.empleado.insertOne(
    {
    nombre:'Soyla',
    appellido:'Vaca',
    edad:32,
    ciudad:'San Miguel de las piedras'
    }
)