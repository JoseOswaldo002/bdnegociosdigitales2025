
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