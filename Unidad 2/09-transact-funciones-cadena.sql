USE Northwind;

-- FUNCIONES DE CADENA

/* Las funciones de cadena permiten manipular tipos de datos como VARCHAR, 
NVARCHAR, CHAR, NCHAR */

-- Funcion LEN -> Devuelve la longitud de una cadena

-- Declaraci�n de una variable 

-- Declarar una variable de tipo varchar(50)
--DECLARE @Texto varchar(50) = 'Hola, Mundo!';
DECLARE @Numero int = 7;  
PRINT @Numero;

-- Obtener el tama�o de la cadena almacenada en la variable @Texto
SELECT LEN(@Texto) AS 'Longitud';

-- Obtener la longitud del nombre de la empresa en la tabla Customers
SELECT CompanyName, LEN(CompanyName) AS 'N�mero de caracteres' FROM Customers;

-----------------------------------------------------------------------------------------
DECLARE @Texto varchar(50) = 'Hola, Mundo!';
-- Funcion LEFT -> Extrae un n�mero espec�fico de caracteres desde el inicio de la cadena
SELECT LEFT(@Texto, 4) AS 'Inicio';

-- Funcion RIGHT -> Extrae un n�mero determinado de caracteres del final de la cadena
SELECT RIGHT(@Texto, 6) AS 'Final';

-- SUBSTRING -> Extrae una parte de la cadena, donde el primer par�metro es la posici�n inicial y el segundo es la cantidad de caracteres a extraer
SELECT SUBSTRING(@Texto, 7, 5) AS 'Cadena';

-- REPLACE -> Reemplaza una subcadena por otra
SELECT REPLACE(@Texto, 'Mundo', 'Amigo') AS 'Reemplazo';

-- CHARINDEX -> Devuelve la posici�n de la primera aparici�n de una subcadena dentro de otra
SELECT CHARINDEX('Mundo', @Texto) AS 'Posici�n';

-- UPPER -> Convierte una cadena en may�sculas
SELECT UPPER(@Texto) AS 'Texto en May�sculas';
---
DECLARE @Texto2 varchar(50) = 'Hola, Mundo!';

SELECT CONCAT(
    LEFT(@Texto2, 6), -- "Hola, " (los primeros 6 caracteres sin cambios)
    UPPER(SUBSTRING(@Texto2, 7, 5)), -- "MUNDO" (posici�n 7, extrae 5 caracteres y los convierte en may�sculas)
    RIGHT(@Texto2, 1) -- "!" (el �ltimo car�cter sin cambios)
) AS 'Texto Modificado';


-- TRIM -> Permite quitar espacios en blanco al inicio y al final de una cadena
SELECT TRIM('     test    ') AS 'Resultado Trim';

-----------------------------------------------------------------------------------------

-- Crear un stored procedure para seleccionar todos los clientes
GO
CREATE OR ALTER PROCEDURE spu_mostrar_clientes
AS
BEGIN
    SELECT * FROM Customers;
END;
GO

-- Ejecutar un stored procedure en Transact-SQL
EXEC spu_mostrar_clientes;

-----------------------------------------------------------------------------------------

-- Uso de m�ltiples funciones de cadena en una consulta
SELECT CONCAT(
    LEFT(@Texto2, 6),
    UPPER(SUBSTRING(@Texto2, 7, 5)),
    RIGHT(@Texto2, 1)
) AS 'TextoNuevo';

-- Aplicaci�n de funciones de cadena en nombres de empresas de la tabla Customers
SELECT 
    CompanyName, 
    LEN(CompanyName) AS 'N�mero de caracteres',
    LEFT(CompanyName, 4) AS 'Inicio',
    RIGHT(CompanyName, 6) AS 'Final',
    SUBSTRING(CompanyName, 7, 5) AS 'Cadena'
FROM Customers;
