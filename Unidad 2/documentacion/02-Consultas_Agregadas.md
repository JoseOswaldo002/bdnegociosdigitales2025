# Consultas de Agregación - Northwind

---

##  Notas

```sql
-- Nota: Estas consultas devuelven un solo registro (a excepción de las que usan GROUP BY)
-- Funciones agregadas: SUM, AVG, COUNT, COUNT(*), MAX y MIN
```

---

##  Consultas generales de conteo

```sql
USE Northwind;

-- ¿Cuántos clientes hay?
SELECT COUNT(*) AS 'Número de clientes' FROM Customers;

-- ¿Cuántas regiones nulas hay?
SELECT COUNT(*) FROM Customers WHERE Region IS NULL;

-- ¿Cuántas regiones diferentes existen?
SELECT COUNT(DISTINCT Region) FROM Customers WHERE Region IS NOT NULL;
```

---

##  Conteo y resumen en órdenes y productos

```sql
SELECT * FROM Orders;
SELECT COUNT(*) FROM Orders;
SELECT COUNT(ShipRegion) FROM Orders;

SELECT * FROM Products;
SELECT MIN(UnitPrice) AS 'Precio más bajo' FROM Products;

-- Mínimo, máximo y promedio de precios y unidades
SELECT 
    MIN(UnitPrice), 
    MAX(UnitPrice), 
    AVG(UnitsInStock) 
FROM Products;

-- Total de pedidos
SELECT COUNT(*) AS 'Número de Pedidos' FROM Orders;
```

---

##  Suma total de ingresos

```sql
SELECT * FROM [Order Details];

-- Ingreso bruto sin descuento
SELECT SUM(UnitPrice * Quantity) FROM [Order Details];

-- Ingreso neto con descuento aplicado
SELECT SUM(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) FROM [Order Details];
```

---

##  Suma de stock general

```sql
SELECT * FROM Products;
SELECT SUM(UnitsInStock) AS 'Total Stock' FROM Products;
```

---

##  Total vendido en el último trimestre de 1996

```sql
SELECT * FROM [Order Details];
SELECT * FROM Orders;
-- Aquí faltaría una consulta específica, sugerencia:
-- JOIN entre Orders y Order Details filtrando por fechas.
```

---

##  Número de productos por categoría

```sql
SELECT CategoryID, COUNT(*) AS 'Número de productos'
FROM Products
GROUP BY CategoryID;

SELECT 
    Categories.CategoryName,
    COUNT(*) AS 'Número de productos'
FROM Categories
INNER JOIN Products AS p ON Categories.CategoryID = p.CategoryID
GROUP BY Categories.CategoryName;
```

---

##  Precio promedio por categoría

```sql
SELECT CategoryID, AVG(UnitPrice) AS 'Precio promedio'
FROM Products
GROUP BY CategoryID;
```

---

##  Número de pedidos por empleado

```sql
-- En el último trimestre de 1996
SELECT 
    EmployeeID AS 'Empleado',
    COUNT(OrderID) AS 'Órdenes por empleado'
FROM Orders
WHERE OrderDate BETWEEN '1996-10-01' AND '1996-12-31'
GROUP BY EmployeeID;

-- Total acumulado
SELECT 
    EmployeeID AS 'Empleado',
    COUNT(OrderID) AS 'Órdenes por empleado'
FROM Orders
GROUP BY EmployeeID;
```

---

##  Suma de unidades vendidas por producto

```sql
-- Usando Products (menos preciso)
SELECT SUM(UnitsOnOrder) FROM Products GROUP BY ProductID;

-- Correcto: usando Order Details
SELECT 
    ProductID, 
    SUM(Quantity) AS 'Número de productos vendidos'
FROM [Order Details]
GROUP BY ProductID
ORDER BY [Número de productos vendidos] DESC;

SELECT 
    OrderID, 
    ProductID, 
    SUM(Quantity) AS 'Número de productos vendidos'
FROM [Order Details]
GROUP BY OrderID, ProductID
ORDER BY 3 DESC;
```

---

##  Productos por categoría con más de 10 productos

```sql
-- Paso 1: Vista general
SELECT * FROM Products;

-- Paso 2: Filtrar ciertas categorías
SELECT CategoryID, UnitsInStock 
FROM Products
WHERE CategoryID IN (2, 4, 8)
ORDER BY CategoryID;

-- Paso 3: Agrupar y sumar stock
SELECT CategoryID, SUM(UnitsInStock) 
FROM Products
WHERE CategoryID IN (2, 4, 8)
GROUP BY CategoryID
ORDER BY CategoryID;

-- Paso 4: Filtrar categorías con al menos 12 productos
SELECT CategoryID, SUM(UnitsInStock) 
FROM Products
WHERE CategoryID IN (2, 4, 8)
GROUP BY CategoryID
HAVING COUNT(*) >= 12
ORDER BY CategoryID;
```

---

##  Órdenes por empleado con más de 10 pedidos

```sql
SELECT 
    EmployeeID, 
    COUNT(OrderID) AS 'Órdenes'
FROM Orders
GROUP BY EmployeeID
HAVING COUNT(*) > 10;
```

---

