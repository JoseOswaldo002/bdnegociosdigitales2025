``` sql

-- seleccionar todas las categorias y productos

select * from
Categories
inner join
Products
on categories.CategoryID = products.CategoryID;

select c.CategoryID as [Numero de categoria], CategoryName as 'Nombre categoria', 
ProductName as 'Nombre de Producto', UnitsInStock as 'Existencia', UnitPrice as Precio 
from
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID;


-- Selecionar los productos de la categoria beverages y condiments donde la existencia este entre 18 y 30

select c.CategoryID as [Numero de categoria], CategoryName as 'Nombre categoria', 
ProductName as 'Nombre de Producto', UnitsInStock as 'Existencia', UnitPrice as Precio 
from
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID
where (c.CategoryName In('Beverages', 'Condiments'))
and p.UnitsInStock between  18 and 30;

select *
from Products as p
join Categories as ca
on p.CategoryID = ca.CategoryID
where (ca.CategoryName = 'beverages' or ca.CategoryName = 'condiments')
and (p.UnitsInStock>=18 and p.UnitsInStock<=30)

-- seleccionar los productos y sus importes realizados de marzo a junio de 1996, mostrando la fecha de la orden
-- el id del producto y el importe

select o.OrderID, o.OrderDate, od.ProductID,
(od.UnitPrice * od.Quantity) as Importe
from Orders as o
join [Order Details] as od
on o.OrderID = od.OrderID
where (o.OrderDate >= '1996-07-01' and o.OrderDate <='1996-10-31')

-- mostrar el importe total de ventas de la consulta anterior

select 
concat('$', ' ', sum(od.Quantity * od.UnitPrice)) as 'Importe'
from orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate Between '1996-07-01' and '1996-10-31'

 ```

## Consultas basicas con inner join

 ``` sql
-- 1. Obtener los nombres de los clientes y los paises a los que se enviaron sus pedidos

select c.CompanyName as nombre, o.ShipCountry as 'Pedido enviado'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID

select c.CompanyName as nombre, o.ShipCountry as 'Pedido enviado'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
order by o.ShipCountry desc

-- 2. obtener los productos y sus respectivos proveedores

select p.ProductName as 'Nombre del producto', sp.CompanyName as Proveedor
from Products as p
inner join Suppliers as sp
on p.SupplierID = sp.SupplierID

-- 3 Obtener los pedidos y los empleados que los gestiona

select o.OrderID as 'Id del pedido',
e.EmployeeID as 'Id empleado', concat(e.Title, ' - ', e.FirstName, '  ', e.LastName) as 'Nombre del empleado'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID

-- 4 Listar los productos juntos con sus precios y la categoria a la que pertenecen

select p.ProductID as 'Id del producto', p.ProductName as 'Nombre del Producto', p.UnitPrice as Precio, 
c.CategoryName as 'Categoria'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID

-- 5 Obtener el nombre del cliente, el numero de orden y la fecha de orden

select c.ContactName as 'Nombre del cliente', o.OrderID as 'Numero de orden', o.OrderDate as 'Fecha de pedido'
from Customers as c
inner join Orders o
on c.CustomerID = o.CustomerID


-- 6. Listar las ordenes mostrando el numero de orden, el nombre del producto y la cantidad que se vendio

select od.OrderID as 'Numero de Orden', p.ProductName as 'Nombre del producto', od.Quantity [Cantidad Vendida]
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc

select top 5 od.OrderID as 'Numero de Orden', p.ProductName as 'Nombre del producto', od.Quantity [Cantidad Vendida]
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc

select od.OrderID as 'Numero de Orden', 
count(*) as 'cantidad de productos vendidos'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
group by od.OrderID
order by od.OrderID desc

select * from
[Order Details] as od
where od.OrderID = 11077


-- 7 obtener los empleados y sus respectivos jefes
select concat(e1.FirstName, ' ', e1.LastName) as Empleado,
concat(j1.FirstName, ' ', j1.LastName) as Jefe
from Employees as e1
inner join Employees as j1
on e1.ReportsTo = j1.EmployeeID

select FirstName, ReportsTo
from Employees

-- 8 Listar los pedidos y el nombre de la empresa de transporte utilzada

select o.OrderID as 'Numero de orden', s.CompanyName as 'Empresa de transporte'
from Orders as o
inner join Shippers as s
on o.ShipVia = s.ShipperID

-- consultas inner join intermedias

-- 9. Obtener la cantidad total de productos vendidos por categoria

select sum(Quantity)
from [Order Details]

select c.CategoryName as 'Nombre Categoria', 
sum(Quantity) as 'Productos Vendidos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName

-- 10. Obtener el total de ventas por empleado

select concat(e.FirstName, '  ', e.LastName) as 'Nombre del empleado',
sum(od.UnitPrice * od.Quantity) as 'total de ventas'
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName

-- 11 Listar los clientes y la cantidad de pedidos que han realizado

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

-- 12 Obtener los empleados que han gestionado pedidos enviados a alemania

select concat (e.FirstName, '', e.LastName) as 'Nombre completo'
From Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'

-- 13 Listar los productos junto con el nombre del proveedor y el pais de origen

SELECT 
	p.ProductName as 'Nombre producto',
	s.CompanyName as 'Nombre proveedor',
	s.Country as 'Pais de origen'
FROM
Suppliers as s
inner join
Products as p
on s.SupplierID = p.SupplierID

-- 14 obtener los pedidos agrupados por pais de envio

select count(*) as Pedidos, ShipCountry as 'Pais de envio'
from Orders
group by ShipCountry 
order by 2 desc


-- 15. Obtener los empleados y la cantidad de territorios en los que trabajan

select concat(e.FirstName, ' ', e.LastName) as 'Nombre completo', count(*) as Territorios 
from Employees as e
inner join EmployeeTerritories et
on e.EmployeeID = et.EmployeeID
group by e.FirstName, e.LastName

select concat(e.FirstName, ' ', e.LastName) as 'Nombre completo', count(*) as Territorios 
from Employees as e
inner join EmployeeTerritories et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, t.TerritoryDescription
order by [Nombre], t.TerritoryDescription desc


-- 16 Listar las categorias y la cantidad de productos que contienen

select c.CategoryName as categorias, count(p.ProductID) as 'Productos'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
group by c.CategoryName
order by 2 desc

-- 17. obtener la cantidad total de productos vendidos por proveedor

select sp.CompanyName as Proveedores, sum(od.Quantity) as 'Productos vendidos'
from Products as p
inner join Suppliers as sp
on p.SupplierID = sp.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by sp.CompanyName

-- 18. obtener la cantidad de pedidos enviados por cada empresa de transporte

select sp.CompanyName as 'Empresa de Transporte', count(o.OrderID) as Pedidos
from Orders as o
inner join Shippers as sp
on o.ShipVia = sp.ShipperID
group by sp.CompanyName

select * from Orders

select count(*) from Orders

select count(OrderID) from Orders

select count(ShipRegion) from Orders

-- Consultas Avanzadas

-- 19 Obtener los clientes que han realizado pedidos con mas de un producto

select c.CompanyName, count(distinct ProductID) as 'Numero de productos'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 Desc


-- 20. Listar los empleados con la cantidad total de pedidos que han gestionado, y a que clientes les han vendido
-- agrupandolos por nombre completo y dentro de el con este nombre por cliente, ordenandolos por la cantidad mayor de pedidos.

select concat(e.FirstName, ' ', e.LastName) as Empleados, c.CompanyName as cliente ,count(o.OrderID) as 'Numero de ordenes'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by Empleados asc, cliente

select concat(e.FirstName, ' ', e.LastName) as Empleados, count(o.OrderID) as 'Numero de ordenes'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
group by e.FirstName, e.LastName
order by Empleados asc

-- 21. Listar las categorias con el total de ingresos generados por sus productos

select c.CategoryName as Categoria, pr.ProductName as 'Nombre del pedido', sum(od.Quantity*pr.UnitPrice) as 'Ingresos generados' from Categories as c
inner join Products as pr
on c.CategoryID = pr.CategoryID
inner join [Order Details] as od
on pr.ProductID = od.ProductID
group by pr.ProductName, c.CategoryName

-- 22. Listar los clientes con el total ($) gastado en pedidos.

select c.CompanyName as Clientes, sum(od.UnitPrice*od.Quantity) as 'Total Gastado' from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] od
on o.OrderID = od.OrderID
group by c.CompanyName

-- 23 Listar los pedidos realizados entre el 1 de enero de 1997 
-- y el 30 de junio de 1997 y mostrar el total en dinero

select o.OrderID as 'Numero de orden', o.OrderDate as 'Fecha de orden', sum(o.OrderID * od.UnitPrice) as 'Total de dinero' from [Order Details] as od
inner join Orders as o
on od.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderID, o.OrderDate

-- 24 Listar los productos con las categorias beverages, seafood, confections

select c.CategoryName as categoria, p.ProductName as Productos from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryName In ('beverages', 'seafood', 'confections')


-- 25 Listar los clientes ubicados en alemania y que hayan realizado pedidos antes del  1 de enero de 1997

select c.CompanyName as Cliente, c.Country as Pais, o.OrderDate as 'Pedido realizado' from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
where o.OrderDate < '1997-01-01' and c.Country = 'Germany'

-- 26 Listar los clientes que han realizados pedidos con un total entre $500 y $2000

select c.CompanyName as Clientes, sum(od.Quantity * od.UnitPrice) as 'Total' from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName
having sum(od.Quantity * od.UnitPrice) between '500' and '2000'


-- left join, right join, full join y cross join

-- practica de utilizacion de left join

-- seleccionar los datos que se van a utilizar para insertar en la tabla products_new

-- product_id, product_Name, customer, category, unitprice, discontinued, inserted_date
