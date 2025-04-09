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

db.Empleado.insertOne(
    {
    nombre:'Soyla',
    appellido:'Vaca',
    edad:32,
    ciudad:'San Miguel de las piedras'
    }
)

## Inserción de un documento mas complejocon array

```json
db.Empleado.insertOne(
    {
    nombre: 'Ivan',
    apellido: 'Baltazar',
    apellido2: 'Rodriguez',
    aficiones: ['Cerveza', 'Canabis', 'Crico', 'Mentir'] 

    }
)
```
**Eliminar una coleccion**

```json
db.coleccion.drop()
```

__Ejemplo__

```json
db.empleado.drop()
```

## Para hacer busquedas 
```json
db.Empleado.find({})
```


## Insercion de documentos mas complejos con anidados, arrays i ID
```json
db.Empleado.insertOne(
    {
        nombre: 'Jose Luis',
        apellido1: 'Herrera',
        apellido2: 'Gallardo',
        edad: 41,
        estudios:[
        'Ingenieria en Sistemas Computacionales',
        'Maestria en Administracion de Tecnologias de la informacion'
        ],
        experiencia:{
            lenguaje:'SQ;',
            sgb:'SqlServer',
            anios_experiencia: 20
        }
    }
)
```

```json
db.Alumno.insertOne({
    _id:3,
    nombre:'Sergio',
    apellido:'Ramos',
    equipo:'Monterrey',
    aficiones:['Dinero','Hombre','Fiesta'],
    talentos:{
        furbol:true,
        bañarse: false 
    }
})
```

## Insertar Multiples Documentos
```json
db.Alumno.insertMany(
[
    {
        _id:12,
        nombre:'Oswaldo',
        apellido:'Venado',
        edad:20,
        descripcion:'Es un quejumbroso'
    },
    {
        nombre:'Maritza',
        apellido:'Rechicken',
        edad:20,
        habilidades:[
            'Ser vibora', 'Ilusionar', 'Caguamear'
        ],
        direcciones:{
            calle:'Del infierno',
            numero:666
        },
        esposos:[
            {
                nombre:'Joshua',
                edad:20,
                pension:-34,
                hijos:['Ivan','Jose']
            },
            {
                nombre:'Leo',
                edad:15,
                pension:70,
                complaciente:true 
            }
        ]
    }
]
)
```


# Busquedas. Condiciones simples de igualdad Metodo Find()

1. Seleccionar todos los documentos de la coleccion libros.
```json
db.libros.find({})
```

2. Seleccionar todos los documentos que sean de la editorial biblio.
```json
db.libros.find({editorial:'Biblio'})
```

3. Mostrar todos los documentos que el precio sea 25.
```json
db.libros.find({precio:25})
```

4. Seleccionar todos los documentos donde el titulo sea 'json para todos.
```json
db.libros.find({titulo:'JSON para todos'})
```

## Operadores de comparacion
[Operadores de comparación](https://www.mongodb.com/docs/manual/reference/operator/query/)

![Operadores de comparación](./img/operadores-Relacionales.png)

1. Mostrar todos los docuementos  donde el precio sea mayor a 25
````json
db.libros.find({precio:{$gt:25}})
````

2. Mostrar los docuementos donde el precio sea 25
````json
db.libros.find({precio:{$eq:25}})
db.libros.find({precio:25})
````

3. Mostrar los documentos cuya cantidad sea menor a 5
````json
db.libros.find({cantidad:{$lt:5}})
````
4. Mostrar los documentos que pertenecen a la editorial biblio y planeta($in)
````json
db.libros.find({editorial: { $in: ['Biblio', 'Planeta'] } })
````
5. Mostrar todos los docuemtnos que no cuestan 20, 25

````json
db.libros.find({precio: { $in: [20,25] } })
````

6. Recuperar todos los documentos que no cuentasn

````json
db.libros.find({precio: { $nin: [20,25] } })
````

## Instruccion finOne

7. Recupera solo una fila (Devuelve el primer elemento que cumpla la condicicon)

````json
db.libros.findOne({precio: { $in: [20,25] } })
````

## Operadores logicos

[Operadores logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

## Operador AND

- Dos posibles ocpciones

 1. La simple, mediante condiciones epradas por comas 
    - db.libros.find({condicion1,condicion2,..... }) -> Con esto se asume que en un AND

1. Usando el operador AND
 { $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }
    - db.libros.find({condicion1,condicion2,..... })

1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 15
````json
db.libros.find({
    precio:{$gt:25},
    cantidad:{$lt:15}
})
````
2. Modo 2

````json
db.libros.find(
    {
        $and:[
            {precio:{$gt:25}},
            {cantidad:{$lt:15}}
        ]
    }
)
````

### Operador or ($or)

- Mostrar todos aquellos libros que cuenten mas de $25 o cuya cantidad sea inferiro a 15

````json
db.libros.find(
    {
        $or:[
            {precio:{$gt:25}},
            {cantidad:{$lt:15}}
        ]
    }
)
````


### Ejemplo con AND y OR combinados

- Mostrar los libros de la editorial Biblio con precio mayor a 40 o libros de la editorial planeta con precio mayor a 30

````json
db.libros.find( {
    $and: [
        { $or: [ {editorial:'Biblio' }, {precio:{$gt:40}} ] },
         { $or: [ {editorial:{$eq:'Planeta'}}, {precio:{$gt:30}} ] }
    ]
} )
````

````json
db.libros.find( {
    $and: [
        { $or: [ {editorial:'Biblio' }, {precio:{$gt:30}} ] },
         { $or: [ {editorial:{$eq:'Planeta'}}, {precio:{$gt:20}} ] }
    ]
} )
````

### Proyeccion (ver ciertas columnas)
**Sintaxis**
````json
db.coleccion.find(filtro,columnas)
````

1. Seleccionar todos los libros solo mostrando el titulo

````json
db.libros.find({},{titulo:1})
````

````json
db.libros.find({},{titulo:1,_id:0})
````

````json
db.getCollection('libros').find(
  {},
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
);
````

### Operador exists (Permite saber si un campo se encuentra o no en un docuemtno)
[Operador Exists](https://www.mongodb.com/docs/manual/reference/operator/query/exists/)
````json
{ field: { $exists: <boolean> } }
````

````json
db.libros.find({editorial:{$exists:true}})
````

### Operador Type (Permite solicitar a MongoBD si un campo correspode a un tipo)
[Operador Type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)



````json
{ field: { $type: <BSON type> } }
````
- Mostrar todos los docuemtnso donde el precio sea de tipo double o entero o cualquier otro tipo de dato
````json
db.libros.find(
{
    precio:{$type:16}
}
)

db.libros.find(
{
    precio:{$type:	"int"}
}
)
````
````json

db.libros.insertOne(
{
    _id:10,
    titulo: 'Mongo en Negocios Digitales',
    editorial: 'Terra',
    precio: 125
}
)

db.libros.insertMany(
 [
    {
    _id:12,
    titulo:'IA',
    editorial:'Terra',
    precio:125,
    cantidad:20
 },
 {
    _id:13,
    titulo:'Python para todos',
    editorial:2001,
    precio:200,
    cantidad:30
 }
 ]
)
````

- Seleccionar todos los docuementos de libros donde los valores de la editorial sean String
````json
db.libros.find(
{
    editorial:{$type:"string"},
}
)

db.libros.find(
{
    editorial:{$type:"2"},
}
)
````


````json
db.libros.find(
{
    editorial:{$type:"int"}
}
)

db.libros.find(
{
    editorial:{$type:"16"}
}
)
````


# Modificando Documentos
## Comandos importantes

1. updateOne  -> Modifica un solo docuemento
2. updateMany -> Modificar multiples docuemtnos
3. replaceOne -> Sustituir el contenido completo de un docuemento

Tiene el siguiente formato
````json
db.collections.updateOne(
{
    {filtro},
    {operador:}
}
)
````

[Operadores Udate](https://www.mongodb.com/docs/manual/reference/operator/update/)

**Operador $set**

1. Modificar un documento


````json
db.libros.updateOne(
{titulo:'Python para torpes'},
{$set:{titulo:'Python para todos'}}
)
````

db.libros.insertOne({})

- Modificar el docuemento con id 10 estableciendo el precio en 100 y la cantidad en 50

````json
db.libros.updateOne(
{_id: 10},
{$set:{_id:10,precio:100,cantidad:50}}
)
````

- Utilizando el updateMany , modificar todos los libros donde el precio sea mayor a 100 y cambiarlo por  150
precio:{$gt:100}
````json
db.libros.updateMany(
 {
    precio:{$gt:100}
 },
 {
    $set:{precio:150}
 }
)
````


## Operadores $inc y $mul

- Incrementar todos los precios de los libros en 5
````json
db.libros.updateMany(
    {},
 {
    $inc:{precio:5}
 }
)
````

````json
db.libros.updateMany(
    {editorial:'Terra'},
 {
    $inc:{precio:5}
 }
)
````

--Multiplicar todos los libros donde la cantidad sea mayor a 20, multiplicar la cantidad x2 ($mul)


````json
db.libros.updateMany(
 {
    cantidad:{$gt:20}
 },
 {
    $mul:{cantidad:2}
 }
)
````
````json
db.libros.find({_id:{$in:[1,7,10,13]}})

db.libros.find({})
````

-- Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20

````json
db.libros.updateMany(
 {
    precio:{$gt:20}
 },
 {
    $mul:{cantidad:2},
    $mul:{precio:2},
 }
)
````

## Reemplazar documentos (replaceOne)

--Actualizar todo el docuemento del id 2 por el titulo de la tierra a la luna, autor julio verne, editorial Terra, precio 100
db.libros.find({_id:2})

````json
db.libros.replaceOne(
 {_id:2},
 {
    titulo: 'De la Tierra a la Luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100,
 }
)
````

## Eliminar el documento con el _id:2
````json
db.libros.deleteOne(
 {_id:2}
)
````

-- Eliminar todos los libros donde la cantidad en mayor a 150

````json
db.libros.deleteMany(
 { 
    cantidad:{$gt:150}
}
)
````
## Expreciones Regulares

--Seleccionar todos los libros que contengan el el titulo una "t" minuscula
````json
db.libros.find({titulo:/t/})
````

--Seleccionar todos los libros que en el titulo contenga la palabra json
````json
db.libros.find({titulo:/JSON/})
````

--Seleccionar todos los libros que en el titulo terminen con tos
````json
db.libros.find({titulo:/tos$/})
````

--Seleccionar todos los lteribros que en el titulo
````json
db.libros.find({titulo:/^J/})
````

## Operador $regex
[Operador Regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

-- Seleccionar los libros que contengas la palabra "para" en el titulo

````json
db.libros.find({
    titulo:{
        $regex:'para'
    }
})

db.libros.find({
    titulo:{
        $regex:/para/
    }
})
````

--Seleccionar todos los titulos que contengan la palabra 'Json'
````json
db.libros.find({
    titulo:{
        $regex:'JSON'
    }
})

db.libros.find({
    titulo:{
        $regex:/JSON/
    }
})
````

-- Distinguir entre ayusculas y minusculas
````json
db.libros.find({
    titulo:{
        $regex:/json/i
    }
})
````
````json
db.libros.find({
    titulo:{
        $regex:/json/,$options:'i'
    }
})
````

````json
db.libros.find({
    titulo:{
        $regex:/^j/,$options:'i'
    }
})
````

--Seleccionar todods los documentos de libros donde el titulo comience con j y no disinga entre mayusculas y minusculas
````json
db.libros.find({
    titulo:{
        $regex:/^j/,$options:'i'
    }
})
````


--Seleccionar todods los documentos de libros donde el titulo termine con 'es' y no disinga entre mayusculas y minusculas
````json
db.libros.find({
    titulo:{
        $regex:/es$/,$options:'i'
    }
})
````
## Metodo sort (Ordenar docuemtnos)

--Ordenar los docuemtnos de manera acendente por el precio
````json
db.libros.find({},{
     _id:0,
    titulo:1,
    precio:1
})
````
-- Ordenar de manera acendente
````json
db.libros.find({},{
     _id:0,
    titulo:1,
    precio:1
}).sort({precio:1})
````
-- Ordenar de manera decendente
````json
db.libros.find({},{
     _id:0,
    titulo:1,
    precio:1
}).sort({precio:-1})
````

--Ordenas los libros de manera acendente por la editorial y de manera decendente por el precio mostrando el titulo, el precio y la editorial
````json
db.libros.find({},{
    _id:0,
    precio:1,
    editorial:1
}).sort({editorial:1,precio:-1})
````


## Otros metodos skip, limit, size

````json
db.libros.find({}).size()
````

````json
db.libros.find({
    titulo:{
        $regex:/^j/,$options:'i'
    }
}).size()
````

-- Buscar todods los libros pero solo mostrando los 2 primeros
````json
db.libros.find({}).limit(2)
````

````json
db.libros.find({}).skip(2)
````
## Borrar colecciones y base de datos
````json
db.libros.drop()
````
````json
db.dropDatabase()
````