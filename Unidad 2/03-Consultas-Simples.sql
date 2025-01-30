
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
-- Ejercicio
SELECT * FROM Customers;
select CustomerID as 'Identificador',
CompanyName as 'Compañia',
ContactName as 'Nombre de Contacto',
ContactTitle as 'Nombre de cargo',
concat (Country, ' - ', PostalCode) as 'Pais y CP',
Phone as 'Numero de telefono' from Customers
where  Country = 'Mexico'
;

---------------------------------------------------------------------------------------------------------------------------------------------------
-- Operadores logicos (or , and y not)

--Seleccionar los productos que tengan un precio de entre 10 y 50 

select * from Products;

select ProductName as Producto, UnitPrice as Precio, UnitsInStock as Existencia
from Products
where UnitPrice >=10
and UnitPrice <=50;


-- Mostrar todos los pedidos realizados por clientes que no son  alemania

select * from Orders;

select * from Orders
where NOT ShipCountry <> 'Germany'
;


select * from Orders
where NOT ShipCountry = 'Germany'
;


--Seleccionar clientes de Mexico o Estados unidos
select * from Customers
where Country = 'Mexico' or Country = 'USA'
;

--Selecciona Empleados que nacieron entre 1955 y 1958 y que viven en Londres

select  * from Employees;

select  * from Employees 
where (year(BirthDate)>=1955 and year(BirthDate)<=1958) and City = 'London'
;

--Seleccionar los pedidos con flete de peso (Freight) mayor a 100 y enviados a francia o España

Select * from Orders;

Select OrderID, OrderDate, ShipCountry, Freight from Orders
where Freight >= 100 and (ShipCountry = 'France' or ShipCountry = 'Spain')   
;


-- Seleccionar ordenes de compra top 5
Select * from Orders
Select top 5* from Orders;

--Seleccionar los productos con precio entre $10 y $50,
-- que no esten desontinuados y tengan mas de 20 unidades en stok

Select * from Products;

Select ProductName, UnitPrice, UnitsInStock, Discontinued from Products
where UnitPrice >= 10 and UnitPrice <= 50 and Discontinued = 0 and UnitsInStock > 20
;

-- Pedidos enviados a Francia o alemania, pero con un flete menor a 50.
Select OrderID, OrderDate, ShipCountry, Freight from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight <= 50 
;
-- Clientes que no sean de Mexico o USA y que tengan fax registrado.

Select Country, City, Fax, CompanyName from Customers
where Not (Country = 'Mexico' or Country ='USA') and Fax is Not null
;


--TAREAAAAAAAAAAAAAAA
/*Seleccionar Pedidos con un flete mayor a 100
Enviados a Brasil o Argentina 
pero No enviados por el Transportista 1*/

Select *from Orders
where Freight >= 100 and (ShipCountry = 'Brazil' or ShipCountry = 'Argentina') and NOT ShipVia = 1
;

-- seleccionar empleqdos que no viven en londres o seattle y que fueron contratados despues de 1992

select concat(FirstName , ' ', LastName) as [Nombre Completo], HireDate, city, Country
from Employees
where NOT(City = 'London' or City = 'Seattle')
and year(HireDate) >= 1992

-- Clausula IN (or)
-- Seleccionar los productos con categoria 1, 2 o 3

Select ProductName, CategoryID , UnitPrice from Products
Where CategoryID in (1,3,5);

--Seleccionar todas las ordenes de la region RJ, TACHIRA y que no tengan region asignada

Select * From Orders;

Select OrderID, OrderDate, ShipRegion From Orders
where ShipRegion in ('RJ','Táchira') or not ShipRegion is Null
;


 -- Selecciona las ordenes que tengan unidades de 12, 9 o 40 y descuento de  0.15 o 0.05
  select * from [Order Details];

 select OrderID,Quantity,Discount,(UnitPrice* Quantity - Discount) as Importe from [Order Details]
 where Quantity in (12, 9, 40) and Discount in (0.15,0.05)
 ;



-- Clausula Beetween
