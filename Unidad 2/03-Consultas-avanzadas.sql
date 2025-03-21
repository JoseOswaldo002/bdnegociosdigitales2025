
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

select concat ('$',' ',sum,(OD.Quan*od.UnitPrice)) as 'Importe' from 
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

--14. Obtener los pedidos agrupados por pa�s de envio.
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
order by s.CompanyName
---------------------------------
select sp.CompanyName as Proveedores, sum(od.Quantity) as 'Productos vendidos'
from Products as p
inner join Suppliers as sp
on p.SupplierID = sp.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by sp.CompanyName
order by sp.CompanyName


--18. Obtener la cantidad de pedidos enviados por cada empresa de transporte.

SELECT
s.CompanyName as '�mpresa Transporte',
COUNT(o.OrderID) as 'Cantidad de pedidos'
FROM
Shippers as s
INNER JOIN
Orders AS o
on s.ShipperID = o.ShipVia
group by s.CompanyName, o.OrderID
---------------------------------------
select * from Shippers
-- COUNT cuenta sin importar que sean nulos 
SELECT
s.CompanyName as '�mpresa Transporte',
COUNT(*) as 'Cantidad de pedidos'
FROM
Shippers as s
INNER JOIN
Orders AS o
on s.ShipperID = o.ShipVia
group by s.CompanyName

select * from Orders

select COUNT(*) as 'Total de ordenes' from Orders


select COUNT(OrderID) as 'Total de ordenes ID' from Orders


select COUNT(ShipRegion) as 'Region de compra NO NULL'from Orders



-- CONSULTAS AVANZADAS

--19. Obtener los clientes que han realizado pedidos con mas de un producto

select 
	C.CompanyName as 'Nombre cliente',
	COUNT(distinct ProductID)
from
Customers as c
INNER JOIN
Orders as o
on C.CustomerID = O.CustomerID
INNER JOIN [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 desc
;

select * from [Order Details]
select * from Orders

 /*
20. Listar los empleados cono la cantidad total de pedidos que han gestionado, y a que 
clientes les han vendido, agrupandolos por nombre completo y dentro de este nombre por
cliente, ordenadolos por la cantidad mayor de pedidos
*/
--custumers
--orders
--employees



SELECT 
	CONCAT(e.FirstName,' ',e.LastName) as 'Nombre empleado',
	c.CompanyName as 'Cliente',
	COUNT(OrderID) as 'Numero de ordenes'
FROM
Customers as c
INNER JOIN
Orders as o
on c.CustomerID = o.CustomerID
INNER JOIN
Employees as e
on e.EmployeeID = o.EmployeeID
	group by e.FirstName, e.LastName, c.CompanyName
	order by 'Nombre empleado' asc,'Cliente'



-- 21. Listar las categorias con un total de ingresos generados por sus productos

SELECT 
	c.CategoryName as 'Categoria',
	sum(od.Quantity * od.UnitPrice) as '$ Ingresos'
FROM Categories as c
INNER JOIN 
Products as p
ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] as od
ON od.ProductID = p.ProductID
group by c.CategoryName

---------------------------------------------------------
SELECT
	c.CategoryName as 'Categoria',
	p.ProductName as 'Producto',
	sum(od.Quantity * od.UnitPrice) as '$ Ingresos'
FROM Categories as c
INNER JOIN 
Products as p
ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] as od
ON od.ProductID = p.ProductID
group by c.CategoryName, p.ProductName
order by c.CategoryName 


-- 22. Listar los clientes con el total ($) gastado en pedidos

SELECT
    c.CompanyName AS 'Cliente',
    SUM(od.Quantity * od.UnitPrice) AS 'Gasto Total'
FROM Customers AS c
INNER JOIN 
Orders AS o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON od.OrderID = o.OrderID
GROUP BY c.CompanyName
ORDER BY SUM(od.Quantity * od.UnitPrice) DESC;

-- 23. Listar los pedidos realizados entre 1 de enero y el 30 de junio de 1997 y mostrar el total en dinero 

SELECT 
	o.OrderDate as 'Fecha de orden',
	SUM(od.Quantity * od.UnitPrice) AS 'Gasto Total'
FROM
Orders as o
INNER JOIN
[Order Details] as od
	on o.OrderID = od.OrderID
Where o.OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate

-- 24. Listar los productos con las categorias Beverages, seafood, confections

SELECT
	p.ProductName as Producto,
	c.CategoryName as Categoria
FROM
Products AS p
INNER JOIN
Categories AS c
ON	c.CategoryID = p.CategoryID
where c.CategoryName in ('Beverages', 'Seafood', 'Confections')

-- 25. Listar lso clientes ubicados en alemania y que hayan realizados pedidos antes del 1 de enero de 1997
SELECT 
	c.Country as 'Pais',
	c.CompanyName as 'Cliente',
	o.OrderDate as 'Fecha de orden'
FROM Customers AS c
INNER JOIN Orders as o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
Where o.OrderDate < '1997-01-01' and  o.ShipCountry = 'Germany'
;


-- 26. Listar los clientes que han realizado pedidos con un total entre $500 y $2000

SELECT
	c.CompanyName as 'Cliente',
	SUM(od.Quantity * od.UnitPrice) AS '$ Gasto Pedidos'
FROM Customers as c
INNER JOIN Orders as o
	on c.CustomerID = o.CustomerID
INNER JOIN
[Order Details] as od
	ON od.OrderID = o.OrderID
group by c.CompanyName
Having SUM(od.Quantity * od.UnitPrice) between 500 and 2000
order by 2 desc;


-- Left Join, Right Join, Full Join, Cross Join


-- Practica de utilizacion de LEFT JOIN

--	Seleccionar los datos que se van a utilizar para insertar en la tabla poducts_new

select productid, productName, Customer, Category, unitprice, discontinued, inserted_date from products_new