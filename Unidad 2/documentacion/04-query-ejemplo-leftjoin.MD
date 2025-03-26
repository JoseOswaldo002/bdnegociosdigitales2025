# Ejemplo LEFT JOIN - Northwind

---

## Configuración y eliminación previa

```sql
--Ejemplo left join

use Northwind;
select * from products_new;
drop table products_new
```

---

## Crear tabla desde consulta 

```sql
--Crear una tabla a partir de una consulta
SELECT TOP 0
	p.ProductID, 
    p.ProductName,
	cu.CompanyName,  
    c.CategoryName, 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS insert_date
INTO products_new
FROM Products AS p
INNER JOIN Categories AS c
ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od
ON od.ProductID = p.ProductID
INNER JOIN Orders AS o
ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu
ON cu.CustomerID = o.CustomerID;
```

---

## Crear tabla con alias

```sql
--Con alias
SELECT TOP 0 0 AS [productbk],
	p.ProductID, 
    p.ProductName AS 'Producto',
	cu.CompanyName AS 'Custumer',  
    c.CategoryName AS 'Category', 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS insert_date
INTO products_new
FROM Products AS p
INNER JOIN Categories AS c
ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od
ON od.ProductID = p.ProductID
INNER JOIN Orders AS o
ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu
ON cu.CustomerID = o.CustomerID;
```

---

## Carga completa

```sql
-- Carga full 
INSERT INTO products_new
SELECT
	p.ProductID, p.ProductName,
	cu.CompanyName,  c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as 'insert_date'
FROM Products AS p
INNER JOIN Categories as c
ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od
ON od.ProductID = p.ProductID
INNER JOIN Orders AS o
ON o.OrderID = od.OrderID
INNER JOIN Customers as cu
ON cu.CustomerID = o.CustomerID

select * from products_new;
```

---

## Agregar clave primaria

```sql
alter table products_new 
add constraint pk_products_new
primary key (productbk) 
```

---

## Crear tabla desde consulta y agregar identidad luego

```sql
-- crear la tabal mediante consulta y s e agrega el campo identidad y clave primaria depues

drop table products_new

SELECT TOP 0 
	p.ProductID, 
    p.ProductName AS 'Producto',
	cu.CompanyName AS 'Custumer',  
    c.CategoryName AS 'Category', 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS insert_date
INTO products_new
FROM Products AS p
INNER JOIN Categories AS c
ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od
ON od.ProductID = p.ProductID
INNER JOIN Orders AS o
ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu
ON cu.CustomerID = o.CustomerID;
```

---

## Añadir campo identidad y clave primaria

```sql
--Nuevo campo
alter table products_new
add productbk int not null IDENTITY (1,1)

--Crear primaty key
alter table products_new
add constraint pk_products_new
primary key (productbk)
```

---

## Carga FULL adicional

```sql
-- CARGA FULLLLLLLLLLL
INSERT INTO products_new
SELECT
	p.ProductID, p.ProductName,
	cu.CompanyName,  c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as 'insert_date'
FROM Products AS p
INNER JOIN Categories as c
ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od
ON od.ProductID = p.ProductID
INNER JOIN Orders AS o
ON o.OrderID = od.OrderID
INNER JOIN Customers as cu
ON cu.CustomerID = o.CustomerID

SELECT * FROM products_new

SELECT * FROM Products
```

---

## Comparación con INNER JOIN

```sql
--INNER JOIN
SELECT 
	pn.ProductID,
	pn.Producto,
	pn.Custumer,
	pn.Category,
	pn.UnitPrice,
	pn.Discontinued,
	pn.insert_date,
	p.ProductID,
	p.ProductName
FROM Products as p
INNER JOIN products_new AS pn
ON p.ProductID = pn.ProductID
```

---

## LEFT JOIN - producto específico

```sql
--LEFT JOIN
SELECT 
	pn.ProductID,
	pn.Producto,
	pn.Custumer,
	pn.Category,
	pn.UnitPrice,
	pn.Discontinued,
	pn.insert_date,
	p.ProductID,
	p.ProductName
FROM Products as p
LEFT JOIN products_new AS pn
ON p.ProductID = pn.ProductID
WHERE ProductName = 'Elote Feliz'
```

---

## LEFT JOIN - detectar productos faltantes

```sql
SELECT 
	pn.ProductID,
	pn.Producto,
	pn.Custumer,
	pn.Category,
	pn.UnitPrice,
	pn.Discontinued,
	pn.insert_date,
	p.ProductID,
	p.ProductName
FROM Products as p
LEFT JOIN products_new AS pn
ON p.ProductID = pn.ProductID
WHERE pn.ProductID IS NULL
```

---

## Carga Delta (diferenciales)

```sql
--CARGA DELTA
SELECT
	p.ProductID, p.ProductName,
	cu.CompanyName,  c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as 'insert_date', pn.ProductID AS 'PN_ID'
FROM Products AS p
LEFT JOIN Categories as c
ON p.CategoryID = c.CategoryID
LEFT JOIN [Order Details] AS od
ON od.ProductID = p.ProductID
LEFT JOIN Orders AS o
ON o.OrderID = od.OrderID
LEFT JOIN Customers as cu
ON cu.CustomerID = o.CustomerID
LEFT JOIN products_new as pn
ON pn.ProductID = p.ProductID
WHERE pn.ProductID is NULL
```

---

## Clonar Products a Products2 y JOINs

```sql
SELECT TOP 10 * 
INTO Products2
from Products

SELECT * FROM Products
SELECT * FROM Products2
```

---

## Comparaciones entre tablas

```sql
--INNER JOIN
SELECT * FROM Products AS p1
INNER JOIN Products2 AS p2
ON p1.ProductID = p2.ProductID

--left join
SELECT * FROM Products AS p1
LEFT JOIN Products2 AS p2
ON p1.ProductID = p2.ProductID

--RIGHT JOIN
SELECT * FROM Products AS p1
RIGHT JOIN Products2 AS p2
ON p1.ProductID = p2.ProductID
```

---


