-- ==========================
--          VISTAS
-- ==========================

-- SINTAXIS B�SICA PARA CREAR UNA VISTA:
-- Una vista es una consulta almacenada que permite simplificar consultas frecuentes.
-- Sintaxis:
-- CREATE VIEW nombreVista AS SELECT columnas FROM tabla WHERE condici�n;

USE Northwind;


-- ============================================
-- CREACI�N DE UNA VISTA PARA VER TODAS LAS CATEGOR�AS
-- ============================================
GO
CREATE VIEW VistaCategoriasTodas
AS
SELECT 
    CategoryID,
    CategoryName,
    [Description],
    Picture
FROM Categories;
GO

-- ============================================
-- MODIFICACI�N DE UNA VISTA EXISTENTE
-- ============================================

ALTER VIEW VistaCategoriasTodas
AS
SELECT 
    CategoryID,
    CategoryName,
    [Description],
    Picture
FROM Categories;
GO

-- ============================================
-- MODIFICACI�N DE LA VISTA PARA FILTRAR POR UNA CATEGOR�A ESPEC�FICA
-- ============================================

ALTER VIEW VistaCategoriasTodas
AS
SELECT 
    CategoryID,
    CategoryName,
    [Description],
    Picture
FROM Categories
WHERE CategoryName = 'Beverages';
GO

-- CONSULTAR LA VISTA FILTRANDO POR CATEGOR�A "Beverages"
SELECT * FROM VistaCategoriasTodas WHERE CategoryName = 'Beverages';

-- ELIMINAR LA VISTA SI YA NO SE NECESITA
DROP VIEW VistaCategoriasTodas;

-- ============================================
-- CREAR UNA VISTA PARA CLIENTES DE M�XICO Y BRASIL
-- ============================================

GO
CREATE OR ALTER VIEW clientesLatinos
AS
SELECT * 
FROM Customers
WHERE Country IN ('Mexico', 'Brazil');
GO

-- CONSULTAR CLIENTES LATINOS ORDENADOS POR NOMBRE DE CONTACTO
SELECT * FROM clientesLatinos ORDER BY ContactName;

-- CONSULTAR CLIENTES LATINOS CON CAMPOS ESPEC�FICOS
SELECT 
    CompanyName AS Cliente,
    City AS Ciudad,
    Country AS Pais
FROM clientesLatinos
ORDER BY Ciudad DESC;

-- CONSULTAR �RDENES REALIZADAS POR CLIENTES LATINOS
SELECT * 
FROM Orders AS o
INNER JOIN clientesLatinos AS cl
ON o.CustomerID = cl.CustomerID;

-- ============================================
-- CREAR UNA VISTA PARA VISUALIZAR �RDENES, PRODUCTOS Y CLIENTES
-- ============================================

GO
CREATE OR ALTER VIEW [dbo].[vistaOrdenesDeCompra]
AS
SELECT 
    o.OrderID AS 'Numero de orden',
    o.OrderDate AS 'Fecha de orden',
    o.RequiredDate AS 'Fecha de Requisici�n',
    CONCAT(e.FirstName, ' ', e.LastName) AS 'Nombre empleados',
    cu.CompanyName AS 'Nombre del cliente',
    p.ProductName AS 'Nombre Producto',
    c.CategoryName AS 'Nombre de la categor�a',
    od.UnitPrice AS 'Precio de venta',
    od.Quantity AS 'Cantidad vendida',
    (od.Quantity * od.UnitPrice) AS 'Importe'  
FROM Categories AS c
INNER JOIN Products AS p ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
INNER JOIN Orders AS o ON od.OrderID = o.OrderID
INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID
INNER JOIN Employees AS e ON e.EmployeeID = o.EmployeeID;
GO

-- CONSULTAR TODOS LOS REGISTROS DE LA VISTA
SELECT * FROM vistaOrdenesDeCompra;

-- CONTAR �RDENES �NICAS EN LA VISTA
SELECT COUNT(DISTINCT [Numero de orden]) FROM vistaOrdenesDeCompra;

-- CALCULAR EL IMPORTE TOTAL DE TODAS LAS �RDENES
SELECT SUM([Cantidad vendida] * [Precio de venta]) AS 'Importe total'
FROM vistaOrdenesDeCompra;
GO

-- CALCULAR EL IMPORTE TOTAL FILTRADO ENTRE LOS A�OS 1995 Y 1996
SELECT SUM(Importe) AS 'Importe total'
FROM vistaOrdenesDeCompra
WHERE YEAR([Fecha de orden]) BETWEEN 1995 AND 1996;
GO

-- ============================================
-- CREAR UNA VISTA PARA �RDENES FILTRADAS ENTRE 1995 Y 1996
-- ============================================

CREATE OR ALTER VIEW vista_ordenes_1995_1996
AS
SELECT
    [Nombre del cliente] AS 'Nombre cliente',
    SUM(Importe) AS 'Importe total'
FROM vistaOrdenesDeCompra
WHERE YEAR([Fecha de orden]) BETWEEN 1995 AND 1996
GROUP BY [Nombre del cliente]
HAVING COUNT(*) > 2;  
GO

-- CONSULTAR LOS DATOS DE LA NUEVA VISTA
SELECT * FROM vista_ordenes_1995_1996;

-- ============================================
-- CREACI�N DE UN SCHEMA Y UNA TABLA EN ESE SCHEMA
-- ============================================

-- Un schema permite organizar las tablas dentro de una base de datos
CREATE SCHEMA rh;
-- CREACI�N DE UNA TABLA DENTRO DEL SCHEMA "rh"
CREATE TABLE rh.tablarh (
    id INT PRIMARY KEY,
    nombre NVARCHAR(50)
);

-- ============================================
-- CREAR UNA VISTA HORIZONTAL PARA RELACIONAR CATEGOR�AS Y PRODUCTOS
-- ============================================

CREATE OR ALTER VIEW rh.viewCategoriaProductos
AS
SELECT 
    c.CategoryID,
    c.CategoryName,
    p.ProductID,
    p.ProductName
FROM Categories AS c
INNER JOIN Products AS p
ON c.CategoryID = p.CategoryID;

-- CONSULTAR LOS DATOS DE LA VISTA
SELECT * FROM rh.viewCategoriaProductos;
