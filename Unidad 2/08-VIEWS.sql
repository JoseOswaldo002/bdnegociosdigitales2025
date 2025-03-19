

-- VIEWS

--SINTAXIS
/*
CREATE VIEW nombreVista
AS
SELECT columnas
FROM tabla
where condicion
*/


use Northwind
go

create view VistaCategoriasTodas
AS
select 
	CategoryID,
	CategoryName,
	[Description],
	Picture
from Categories
go

-------------------- ALTER VIEW
alter view VistaCategoriasTodas
AS
select 
	CategoryID,
	CategoryName,
	[Description],
	Picture
from Categories
go

-------------------CREATE OR ALTER VIEW
alter view VistaCategoriasTodas
AS
select 
	CategoryID,
	CategoryName,
	[Description],
	Picture
from Categories
WHERE CategoryName = 'Beverages'
go

----------------- SELECT
SELECT * FROM VistaCategoriasTodas
WHERE CategoryName = 'Beverages'


drop view VistaCategoriasTodas



--CREAR UNA VISTA QUE PERMITA VISUALIZAR SOLO LOS CLIENTES DE MEXICO Y BRASIL
go

create or alter view clientesLatinos
AS
select 
	*
from Customers
WHERE Country IN ('Mexico','Brazil')
go

SELECT * FROM clientesLatinos
order by ContactName

SELECT 
	CompanyName as Cliente,
	City AS Ciudad,
	Country AS Pais
FROM clientesLatinos
ORDER BY 2 desc


SELECT 
	*
FROM Orders as o
INNER JOIN
clientesLatinos AS cl
ON o.CustomerID = cl.CustomerID


--Crear una vista que contenga los datos de todas las ordenes, los productos, categorias de productos,empleados y clientes,
--en la orden calcular el importe

go
CREATE or ALTER VIEW [dbo].[vistaOrdenesDeCompra]
AS
SELECT 
	o.OrderID as 'Numero de orden',
	o.OrderDate AS 'Fecha de orden',
	o.RequiredDate AS 'Fecha de Requisicion',
	CONCAT (e.FirstName,' ',e.LastName) AS 'Nombre emepleados',
	cu.CompanyName AS 'Nombre del cliente',
	p.ProductName AS 'Nombre Producto',
	c.CategoryName AS 'Nombre de la categoria',
	od.UnitPrice AS 'Precio de venta',
	od.Quantity AS 'Cantidad vendida',
	(od.Quantity * od.UnitPrice) AS 'Importe'
FROM
Categories AS c
INNER JOIN Products AS p
ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] as od
ON od.ProductID = p.ProductID
INNER JOIN Orders as o
ON od.OrderID = o.OrderID
INNER JOIN Customers as cu
ON cu.CustomerID = o.CustomerID
INNER JOIN Employees as e
ON e.EmployeeID = o.EmployeeID
go

select * from vistaOrdenesDeCompra
SELECT COUNT(distinct [Numero de orden]) FROM vistaOrdenesDeCompra
----------
select 
sum([Cantidad vendida]*[Precio de venta]) as 'Importe total'
from vistaOrdenesDeCompra
go
---------
select 
sum(Importe) as 'Importe total'
from vistaOrdenesDeCompra
WHERE YEAR ([Fecha de orden]) between '1995' and '1996'
go
------
CREATE or ALTER view vista_ordenes_1995_1996
AS
select
	[Nombre del cliente] as 'Nombre ciente',
	sum(Importe) as 'Importe total'
from vistaOrdenesDeCompra
WHERE YEAR ([Fecha de orden]) between '1995' and '1996'
GROUP BY [Nombre del cliente]
having COUNT(*)>2
go

select * from vista_ordenes_1995_1996


CREATE SCHEMA rh

create table rh.tablarh(
	id int primary key,
	nombre nvarchar(50)
)



--Vista horizontal

CREATE or ALTER view rh.viewCategoriaProductos
AS
select 
	c.CategoryID,
	c.CategoryName,
	p.ProductID,
	p.ProductName
from Categories as c
INNER JOIN Products as p
ON c.CategoryID = p.CategoryID

SELECT * FROM rh.viewCategoriaProductos

