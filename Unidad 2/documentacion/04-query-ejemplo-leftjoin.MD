# LEFT JOIN y Manipulación de Tablas - Northwind


---

```sql
-- Ejemplo LEFT JOIN

USE Northwind;

SELECT * FROM products_new;
DROP TABLE products_new;

-- Crear una tabla a partir de una consulta (estructura vacía con TOP 0)
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
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
INNER JOIN Orders AS o ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

-- Con alias y un campo adicional
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
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
INNER JOIN Orders AS o ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

-- Carga completa
INSERT INTO products_new
SELECT
    p.ProductID, p.ProductName,
    cu.CompanyName, c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() AS insert_date
FROM Products AS p
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
INNER JOIN Orders AS o ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

SELECT * FROM products_new;

-- Agregar clave primaria
ALTER TABLE products_new 
ADD CONSTRAINT pk_products_new PRIMARY KEY (productbk);

-- Nueva tabla con campo identidad y clave primaria
DROP TABLE products_new;

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
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
INNER JOIN Orders AS o ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

ALTER TABLE products_new
ADD productbk INT NOT NULL IDENTITY (1,1);

ALTER TABLE products_new
ADD CONSTRAINT pk_products_new PRIMARY KEY (productbk);

-- Carga completa
INSERT INTO products_new
SELECT
    p.ProductID, p.ProductName,
    cu.CompanyName, c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() AS insert_date
FROM Products AS p
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
INNER JOIN Orders AS o ON o.OrderID = od.OrderID
INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

SELECT * FROM products_new;
SELECT * FROM Products;

-- INNER JOIN con tabla nueva
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
FROM Products AS p
INNER JOIN products_new AS pn ON p.ProductID = pn.ProductID;

-- LEFT JOIN (producto inexistente)
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
FROM Products AS p
LEFT JOIN products_new AS pn ON p.ProductID = pn.ProductID
WHERE ProductName = 'Elote Feliz';

-- LEFT JOIN con filtro IS NULL (productos no insertados)
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
FROM Products AS p
LEFT JOIN products_new AS pn ON p.ProductID = pn.ProductID
WHERE pn.ProductID IS NULL;

-- CARGA DELTA (solo nuevos productos no insertados)
SELECT
    p.ProductID, p.ProductName,
    cu.CompanyName, c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() AS insert_date, pn.ProductID AS 'PN_ID'
FROM Products AS p
LEFT JOIN Categories AS c ON p.CategoryID = c.CategoryID
LEFT JOIN [Order Details] AS od ON od.ProductID = p.ProductID
LEFT JOIN Orders AS o ON o.OrderID = od.OrderID
LEFT JOIN Customers AS cu ON cu.CustomerID = o.CustomerID
LEFT JOIN products_new AS pn ON pn.ProductID = p.ProductID
WHERE pn.ProductID IS NULL;

-- Comparación entre tablas Products y Products2
SELECT TOP 10 * INTO Products2 FROM Products;
SELECT * FROM Products;
SELECT * FROM Products2;

-- INNER JOIN entre Products y Products2
SELECT * FROM Products AS p1
INNER JOIN Products2 AS p2 ON p1.ProductID = p2.ProductID;

-- LEFT JOIN
SELECT * FROM Products AS p1
LEFT JOIN Products2 AS p2 ON p1.ProductID = p2.ProductID;

-- RIGHT JOIN
SELECT * FROM Products AS p1
RIGHT JOIN Products2 AS p2 ON p1.ProductID = p2.ProductID;
```

---

