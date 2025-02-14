
--	Seleccionar todas las categorias y productos
use Northwind

select * from Categories
inner join
Products
on Categories.CategoryID = Products.CategoryID

select Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from Categories
inner join
Products
on Categories.CategoryID = Products.CategoryID


select 
C.CategoryID, 
CategoryName as 'Nombre Categoria',
ProductName as [Nombre del Producto], 
UnitsInStock as 'Unidades en Stok',
UnitPrice as 'Precio'
from Categories as C
inner join
Products as P
on C.CategoryID = P.CategoryID


/*Seleccionar los productos de la categoria Beverage y condiments 
donde la exitencia este entre 18 y 30*/
Select * from Categories 
Select * from Products

Select * 
from Products as P
join Categories as Ca
on P.CategoryID = Ca.CategoryID
WHERE (ca.CategoryName = 'beverages' or ca.CategoryName = 'condiments')
and P.UnitsInStock >= 18 and P.UnitsInStock <= 30


Select C.CategoryID, CategoryName as 'Nombre Categoria',
ProductName as [Nombre del Producto], UnitsInStock as 'Unidades en Stok',
UnitPrice as 'Precio'
from 
Products as P
join 
Categories as C
on P.CategoryID = C.CategoryID
WHERE C.CategoryID in (1,2) and P.UnitsInStock between 18 and 30

-- Seleccionar los productos y sus importes realizados de marzo a junio de 1996,
-- mostrando la fecha de orden, el id del prodycto y el importe 

Select * from Orders
Select * from [Order Details]

select O.OrderID, O.OrderDate, OD.ProductID, (OD.UnitPrice * OD.Quantity) as 'Importe' from 
Orders  as O
join
[Order Details] as OD
on OD.OrderID = O.OrderID
where O.OrderDate between '1996-07-01' and '1996-10-30'
;

-- Mostrar el importe todal de ventas de la consulta anterior

select concat ('$',' ',sum,(od.Quantity * od.UnitPrice )) as 'Importe' from 
Orders  as O
join
[Order Details] as OD
on OD.OrderID = O.OrderID
where O.OrderDate between '1996-07-01' and '1996-10-30'
;

-- concat ('$',' ',sum,(OD.Quan))


	--Consultas Basicas con Inner Joib

-- 1. Obtener los nombre de los clientes y los paises a los que se enviaron sus pedidos
SELECT 
	Cu.CompanyName as 'Nombre de Cliente',
    O.ShipCountry as 'Pais de Envio'
FROM Orders AS O
INNER JOIN Customers AS Cu 
ON Cu.CustomerID = O.CustomerID
order by 2 desc;


--2. Obtener los productos y sus respectivos proveedores
SELECT
Pr.ProductName as 'Nombre del Producto', 
Su.CompanyName as 'Nombre Proveedor'
FROM
Products as Pr
INNER JOIN
Suppliers as Su
on Pr.SupplierID = Su.SupplierID

--3. Obtener los pedidos y los empleados que los gestiona 

SELECT 
	o.OrderID as 'ID orden',
	E.EmployeeID as 'Empleado id',
	concat(E.Title,' - ',E.FirstName,'  ',E.LastName) as 'Nombre Empleado'
FROM
Orders as O
INNER JOIN
Employees as E
ON E.EmployeeID = O.EmployeeID

--4. Listar los productos jutnos con sus precios y la categoriaa la que pertenecen

select
P.ProductName as 'Nombre Producto',
p.UnitPrice as 'Precio Porducto',
C.CategoryName as 'Nombre del Producto'
from
Products as P
INNER JOIN
Categories as C
ON C.CategoryID = P.CategoryID



--5. Obtener el nombre del cliente, el numero de orden y la fecha de orden

select 
	C.CompanyName AS 'Nombre del Cliente',
	o.OrderID,
	O.OrderDate AS 'Fecha de Orden'
from
Customers as C
INNER JOIN
Orders AS O
on C.CustomerID = o.CustomerID


--6. Listar las ordener mostrando el numero de orden, nombre del producto y la catidad que se vendio
Select 
O.OrderID as 'Numero de Orden',
P.ProductName AS 'Nombre del Procuto',
O.Quantity AS 'Cantidad'
from
Products as P
INNER JOIN
[Order Details] AS O
ON P.ProductID = O.ProductID
order by O.Quantity desc
------------------------------------------
Select 
O.OrderID as 'Numero de Orden',
P.ProductName AS 'Nombre del Procuto',
O.Quantity AS 'Cantidad'
from
Products as P
INNER JOIN
[Order Details] AS O
ON P.ProductID = O.ProductID
where O.OrderID = 11031
order by O.Quantity desc
------------------------------------------
Select 
O.OrderID as 'Numero de Orden',
count(*) as 'Cantidad de productos vendidos'
from
[Order Details] AS O
INNER JOIN
Products as P
ON P.ProductID = O.ProductID
group by o.OrderID
order by O.OrderID desc

select * from
[Order Details] as O
Where o.OrderID = 11077


-- 7. Obtener los empleados y sus respectivos jefes

select 
CONCAT (e1.FirstName,' ',e1.LastName) as 'Empleado',
CONCAT(j1.FirstName,' ',j1.LastName) AS [Jefe]
from Employees as e1
inner join Employees as j1
on e1.ReportsTo = j1.EmployeeID


--8. Listar los pedidos y el nombre de la empresa de transporte Utilizada
SELECT
O.OrderID,
sh.CompanyName as 'Transportista'
FROM
Shippers as sh
inner join
Orders as O
On Sh.ShipperID = O.ShipVia
 

 -- Consultas inner join intermedias

 --9. Obten la cantidad total de productos vendidos por categoria.
 select sum(Quantity) from [Order Details]

select 
C.CategoryName AS 'Nombre Categoria',
sum(Quantity) as 'Productos Vendidos'
from
Categories as c
INNER JOIN
Products as P
ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] AS od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName

 --10 Obten el total de vetnas por empleado.

 SELECT 
	CONCAT(FirstName,' ',LastName) as 'Nombre empleado',
	sum(UnitPrice * Quantity) as 'Total de ventas'
FROM
Orders as o
inner join
Employees as e
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName

----------------------------
 SELECT 
	CONCAT(FirstName,' ',LastName) as 'Nombre empleado',
	sum(UnitPrice * Quantity) as 'Total de ventas'
FROM
Orders as o
inner join
Employees as e
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName


--11. Listar los clientes y la cantidad de pedidos que han realizado.
select * from Employees;
select * from Orders;

SELECT
c.CompanyName as 'Cliente',
COUNT(*) as 'Numero de pedidos'
FROM
Customers AS C
INNER JOIN
Orders AS o
on c.CustomerID = o.CustomerID
group by c.CompanyName
order by 'Numero de pedidos' desc


--12. Obtener los empleados que han gestioando pedidos enviados a alemania.
select * from Employees;
select * from Orders;

SELECT
distinct CONCAT(e.FirstName,' ',e.LastName) as 'Nombre empleado',
o.ShipCountry as 'Pais de destino'
FROM
Employees as e
INNER JOIN
Orders as O
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'







--13. Listar los productos junto con el nombre del proveedor y el pais de origen.

SELECT 
	p.ProductName as 'Nombre producto',
	s.CompanyName as 'Nombre proveedor',
	s.Country as 'Pais de origen'
FROM
Suppliers as s
inner join
Products as p
on s.SupplierID = p.SupplierID

--14. Obtener los pedidos agrupados por país de envio.
Select 
	COUNT(OrderID) as 'Orden' ,
	ShipCountry as 'Pais de envio' from Orders
group by ShipCountry


--15. Obtener los empleados y la cantidad de territorios en los que trabajan.
SELECT
	CONCAT (e.FirstName,' ',LastName) as 'Nombre empleado',
	COUNT(et.TerritoryID) AS 'Cantidad de territorios'
FROM
Employees as e
INNER JOIN
EmployeeTerritories AS et
on e.EmployeeID = et.EmployeeID
group by e.FirstName, e.LastName, et.TerritoryID;
---------------------------------------------------
SELECT
CONCAT (e.FirstName,' ',LastName) as 'Nombre empleado',
COUNT(*) AS 'Cantidad de territorios'
FROM
Employees as e
INNER JOIN
EmployeeTerritories AS et
on e.EmployeeID = et.EmployeeID
group by CONCAT (e.FirstName,' ',LastName);
-------------------------------------------
SELECT
CONCAT (e.FirstName,' ',LastName) as 'Nombre empleado',
t.TerritoryDescription as 'Descripcion del territorio',
COUNT(*) AS 'Cantidad de territorios'
FROM
Employees as e
INNER JOIN
EmployeeTerritories AS et
on e.EmployeeID = et.EmployeeID
inner join Territories as T
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, t.TerritoryDescription
order by 'Nombre empleado', 'Descripcion del territorio';
--16. Listar las categorias y la cantidad de productos que contienen
SELECT 
	c.CategoryName as 'Nombre Categoria',
	COUNT(*) as 'Cantidad de productos'
FROM
Categories as c
INNER JOIN
Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
------------------------------------------
SELECT 
	c.CategoryName as 'Nombre Categoria',
	COUNT(p.ProductID) as 'Cantidad de productos'
FROM
Categories as c
INNER JOIN
Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 desc;


--17. Obtener la cantidad total de productos vendidos por proveedor.
SELECT
	s.SupplierID as [ID],
	s.CompanyName as 'Nombre proveedor',
	COUNT(*) as 'Ventas por proveedor '
FROM
Suppliers as s
INNER JOIN
Products as p
on s.SupplierID = p.SupplierID
Group by s.SupplierID, s.CompanyName
---------------------------------
select sp.CompanyName as Proveedores, sum(od.Quantity) as 'Productos vendidos'
from Products as p
inner join Suppliers as sp
on p.SupplierID = sp.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by sp.CompanyName

--18. Obtener la cantidad de pedidos enviados por cada empresa de transporte.

SELECT
s.CompanyName as 'Émpresa Transporte',
COUNT(o.OrderID) as 'Cantidad de pedidos'
FROM
Shippers as s
INNER JOIN
Orders AS o
on s.ShipperID = o.ShipVia
group by s.CompanyName, o.OrderID
---------------------------------------
select * from Shippers
SELECT
s.CompanyName as 'Émpresa Transporte',
COUNT(*) as 'Cantidad de pedidos'
FROM
Shippers as s
INNER JOIN
Orders AS o
on s.ShipperID = o.ShipVia
group by s.CompanyName


-- CONSULTAS AVANZADAS

--19. 