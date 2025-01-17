

-- Creacion de la Base de Datos tienda1

-- Crea la Base de Datos tienda1
create database tienda1;

-- Utilizar una base de datos
use tienda1;

--SQL-LDD
-- Crear la tabla categoria
create table categoria(
categoriaid int not null,
nombre varchar (20) not null,
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre
unique(nombre)
);

--SQL-LMD
-- Agregar registros a la tabla categoria

insert into categoria
values(1,'Carnes Frias');

insert into categoria(categoriaid,nombre)
values (2,'Liena Blanca');

insert into categoria(nombre,categoriaid)
values ('Vinos y licores',3);

insert into categoria
values (4, 'ropa'),
		(5,'Dulces'),
		(6,'Lacteos');

insert into categoria (nombre, categoriaid)
values ('Panaderia', 7),
		('Zapateria',8),
		('Jugueteria',9);


/*insert into categoria
values (10,'Jugueteria');
*/
Select * from categoria;
--order by categoriaid asc;