
-- Lenguaje SQL-LMD (INSERT, UPDATE, DELETE, SELECT -CRUD)
-- Consultas simples 

use Northwind;

-- Mostrar todos los clientes, provedores, categorias, productos, ordenes, detalles de orden, empredados con todas las columnas de la empresa
-- El "*" significa todos los campos
select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products
select * from Shippers;
select * from Categories;
select * from [Order Details];

-- Proyeccion 
-- Seleccionar ciertos campos
select ProductID, ProductName, UnitPrice, UnitsInStock from Products;

--Seleccionar el numero de mepleado, su primer nombre , su cargo, ciudad y pais.
select * from Employees;
select EmployeeID, FirstName, Title, City, Country from Employees;

-- Alias de columna
-- Basea a la consulta anterior visualizar el.
-- EmployeeID como NumeroEmpleado
-- FirstName como PirmerNombre
--Title como Cargo
--City como Ciudad
--Countr como Pais

select EmployeeID as 'NumeroEmpleado', FirstName as PirmerNombre, Title 'Cargo', City as [Ciudad], Country as Pais from Employees;

-- Campo calculado
-- Seleccionar el importe de cada uno de los productos vendidos en una orden

select *,(UnitPrice* Quantity - Discount) as Importe from [Order Details];

-- Seleccionar las fechas de orden, año, mes y dia, el cliente que las ordeno y el empleado que la realizo.
select OrderDate as 'Fecha de orden', year(OrderDate) as 'Año de orden', month (OrderDate) as 'Mes de orden', day (OrderDate) as 'Dia de orden',CustomerID, EmployeeID from Orders;
select * from Orders;

-- Filas Duplicadas 
select * from Customers;

-- Mostrar los paises donde se tienen clientes, mostrando el pais solamente

select distinct country from Customers
order by country;


-- Clausula where 
-- Operadores relacionales o test de comparacion (<,>,=,<=,>=)
select * from Customers;

-- Seleccionar el Cliente BOLID
select CustomerID, CompanyName, City , Country
from Customers
WHERE CustomerID = 'BOLID'
;

-- Seleccionar los Cliente mostrando su identificador, nombre de la empresa, contacto, ciudad, pais de alemania.
Select CustomerID, CompanyName as Compañia, ContactName as 'Nombre del contacto', City as Ciudad, Country as Pais 
from Customers
where Country = 'Germany'
;

-- seleccionar todos los clientes que no sean de alemania
Select CustomerID, CompanyName as Compañia, ContactName as 'Nombre del contacto', City as Ciudad, Country as Pais 
from Customers
where Country != 'Germany'
;

Select CustomerID, CompanyName as Compañia, ContactName as 'Nombre del contacto', City as Ciudad, Country as Pais 
from Customers
where Country <>'Germany'
;

--Seleccionar todos los productos, mostrando su nombre de producto, categoria a la que pertenece, sus unidades o existencia, precio 
--pero solamente donde su precio se mayor a 100 y costo de invenatario
Select * from Products;

Select ProductName as 'Nombre Producto', CategoryID as CategoriaID, UnitsInStock [Unidades Stock], UnitPrice as Precio,
(UnitPrice * UnitsInStock) as 'Costo de Inventario' 
from Products
where UnitPrice > 100
;

-- Seleccionar las ordenes de compra
-- Mostrando la fecha de orden, la fecha de entrega, la fecha de envio, el cliente que se le vendio
-- De 1996

Select * from Orders;

Select OrderDate AS 'Orden de entrega' , ShippedDate, RequiredDate , ShipName
from Orders
where YEAR (OrderDate) != 1996
;


-- Mostrar todas las ordenes de compra donde la cantidad de productos comprados sea mayor a 5

select Quantity from [Order Details]
where Quantity >= 40;

--Mostrar el nombre completo del empleado, su numero de empleado, fecha de naciemiento y fecha de contratacion y esta debe de 
-- ser de aquellos que fueron contratados despues de 1993 los resultados en su encabezados deben ser mostrados en español

select * from Employees;

select EmployeeID as 'ID empleado',
(FirstName + '  '+ LastName) as 'Nombre completo', BirthDate as 'Fecha de nacimiento',
City as 'Ciudad',HireDate as 'Fecha de contratacion' 
from Employees
where year (HireDate) > 1993
;

select EmployeeID as 'ID empleado',
Concat(FirstName,'  ',LastName, ' - ', Title) as 'Nombre Completo', BirthDate as 'Fecha de nacimiento',
City as 'Ciudad',HireDate as 'Fecha de contratacion' 
from Employees
where year (HireDate) > 1993
;

--Mostrar los empleados que no son dirigidos por el Jefe 2
SELECT EmployeeID as 'ID empleado',
(FirstName + '  '+ LastName) as 'Nombre completo', BirthDate as 'Fecha de nacimiento',
City as 'Ciudad',HireDate as 'Fecha de contratacion', ReportsTo as 'Jefe'  FROM Employees
where ReportsTo != 2;

--Seleccionar los empelados que no tengan jefe
select * from Employees
where ReportsTo is null
;
