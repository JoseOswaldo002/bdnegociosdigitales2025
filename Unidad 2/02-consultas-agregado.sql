-- Cosultas de agregado
	--Nota: Solo devuelven un solo regristro

	---sum, avg ,count,count(*), mas y min

	-- Cuantos clientes tengo
	use Northwind
	select count(*) as 'Numero de clientes' from Customers

	--Cuantas regiones hay
	select COUNT (*)
	from Customers 
	where Region is null

	select  count (distinct Region)
	from Customers 
	where Region is not null

	select * from Orders
	select COUNT(*) from Orders
	select COUNT(ShipRegion) from Orders
	select * from Products

	--Selecciona el precio mas bajo de los productos
	select min(UnitPrice) as 'Precio mas bajo' from Products

	select min (UnitPrice), max (UnitPrice), avg (UnitsInStock)from Products;

	--Seleccionar cuantos pedidos existen
	select COUNT(*) as 'Numero de Pedidos' from Orders

	--Calcular el total de dinero vendido
	select * from [Order Details]
	select sum(UnitPrice*Quantity) from [Order Details]

	select sum(UnitPrice*Quantity -(UnitPrice * Quantity * Discount)) from [Order Details]

	--Calcula el total de unidades en stock de todos los productos
	select * from Products
	select sum(UnitsInStock) as 'Total Stock' from Products

	--Seleccionar el total de dinero que se gano en el ultimo trimestre de 1996
	select * from [Order Details]
	select * from Orders

	--Seleccionar el numero de productos por categoria
	Select  CategoryID, COUNT(*) as 'Numero de productos'
	from Products
	group by CategoryID;


	Select Categories.CategoryName,
	COUNT(*) as 'Numero de productos'
	from Categories
	inner join Products as p
	on Categories.CategoryID = p.CategoryID
	group by Categories.CategoryName;

	-- Calcular el precio promedio de los productos por cada categoria 
	Select CategoryID , avg (UnitPrice) as 'Precio promedio'
	from Products
	group by CategoryID

	--Seleccionar el numero de pedidos realizados por cada empleado
	
	select EmployeeID as 'Empleado',COUNT (OrderID) as 'Ordenes por empleado' from Orders
	where OrderDate between '1996-10-1' and '1996-12-31'
	group by EmployeeID

	select EmployeeID as 'Empleado',COUNT (OrderID) as 'Ordenes por empleado' from Orders
	group by EmployeeID

	--

	

	--Seleccionar la suma de unidades vendidas por cada producto
	Select sum(UnitsOnOrder) from Products
	group by ProductID

	Select  ProductID, SUM (Quantity) as 'Numero de productos vendidos'
	from [Order Details]
	Group by ProductID
	order by  desc

	
	Select  OrderID,ProductID, SUM (Quantity) as 'Numero de productos vendidos'
	from [Order Details]
	Group by orderid, ProductID
	order by 2 desc

	/*Seleccionar el numero de productos por categoria, pero solo aquellos que
	tengan mas de 10 productos*/
	-- Paso 1
	Select * from Products
	--
	-- Paso 2
	Select CategoryID, UnitsInStock from Products
	where CategoryID in (2,4,8)
	order by CategoryID

	-- Paso 3
	Select CategoryID, sum(UnitsInStock) from Products
	where CategoryID in (2,4,8)
	group by CategoryID
	order by CategoryID

	-- Pas 4

	Select CategoryID, sum(UnitsInStock) from Products
	where CategoryID in (2,4,8)
	group by CategoryID
	Having count (*)>=12
	order by CategoryID
	--Having Filtra en grupos



	/* Listar las ordenes agrupadas por empleado, pero que solo mestre aquellas que hayan
	gestionado mas de 10 pedidos*/
	Select EmployeeID,count(OrderID) as 'Ordenes' from Orders
	group by EmployeeID
	Having COUNT (*) >10