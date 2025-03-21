-- ==========================
--       FUNCIONES DE CADENA
-- ==========================

USE Northwind;
GO

/* 
    Las funciones de cadena permiten manipular datos de tipo VARCHAR, 
    NVARCHAR, CHAR y NCHAR. Son útiles para formatear, modificar y analizar cadenas de texto.
*/

-- ============================================
-- DECLARACIÓN DE VARIABLES EN SQL SERVER
-- ============================================

-- Declarar una variable de tipo INT y asignarle un valor inicial
DECLARE @Numero INT = 7;
PRINT @Numero;  -- Muestra el valor de la variable en la consola

-- ============================================
-- FUNCIÓN LEN: DEVUELVE LA LONGITUD DE UNA CADENA
-- ============================================

-- Declarar una variable de tipo VARCHAR y obtener su longitud
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT LEN(@Texto) AS 'Longitud';  -- Devuelve 12 porque cuenta caracteres, pero ignora espacios finales

-- Obtener la longitud del nombre de la empresa en la tabla Customers
SELECT CompanyName, LEN(CompanyName) AS 'Número de caracteres' FROM Customers;

-----------------------------------------------------------------------------------------
-- ============================================
-- FUNCIONES PARA MANIPULACIÓN DE SUBCADENAS
-- ============================================
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';

-- LEFT: Extrae un número específico de caracteres desde el inicio de la cadena
SELECT LEFT(@Texto, 4) AS 'Inicio'; -- Devuelve 'Hola'

-- RIGHT: Extrae un número determinado de caracteres desde el final de la cadena
SELECT RIGHT(@Texto, 6) AS 'Final'; -- Devuelve 'Mundo!'

-- SUBSTRING: Extrae una parte de la cadena especificando la posición inicial y la cantidad de caracteres
SELECT SUBSTRING(@Texto, 7, 5) AS 'Cadena'; -- Devuelve 'Mundo'

-- REPLACE: Reemplaza una subcadena dentro de otra
SELECT REPLACE(@Texto, 'Mundo', 'Amigo') AS 'Reemplazo'; -- Devuelve 'Hola, Amigo!'

-- CHARINDEX: Devuelve la posición de la primera aparición de una subcadena dentro de otra
SELECT CHARINDEX('Mundo', @Texto) AS 'Posición'; -- Devuelve 7 (donde comienza 'Mundo')

-- UPPER: Convierte una cadena en mayúsculas
SELECT UPPER(@Texto) AS 'Texto en Mayúsculas'; -- Devuelve 'HOLA, MUNDO!'

-- TRIM: Elimina los espacios en blanco al inicio y al final de una cadena
SELECT TRIM('     test    ') AS 'Resultado Trim'; -- Devuelve 'test'

-----------------------------------------------------------------------------------------
-- ============================================
-- USO COMBINADO DE FUNCIONES DE CADENA
-- ============================================

DECLARE @Texto2 VARCHAR(50) = 'Hola, Mundo!';

SELECT CONCAT(
    LEFT(@Texto2, 6), -- 'Hola, ' (primeros 6 caracteres sin cambios)
    UPPER(SUBSTRING(@Texto2, 7, 5)), -- 'MUNDO' (posición 7, extrae 5 caracteres y los convierte en mayúsculas)
    RIGHT(@Texto2, 1) -- '!' (último carácter sin cambios)
) AS 'Texto Modificado'; -- Resultado: 'Hola, MUNDO!'

-----------------------------------------------------------------------------------------
-- ============================================
-- CREACIÓN DE UN STORED PROCEDURE PARA MOSTRAR CLIENTES
-- ============================================

GO
CREATE OR ALTER PROCEDURE spu_mostrar_clientes
AS
BEGIN
    SELECT * FROM Customers;
END;
GO

-- Ejecutar el stored procedure
EXEC spu_mostrar_clientes;

-----------------------------------------------------------------------------------------
-- ============================================
-- USO DE MÚLTIPLES FUNCIONES DE CADENA EN UNA CONSULTA
-- ============================================
DECLARE @Texto2 VARCHAR(50) = 'Hola, Mundo!';

SELECT CONCAT(
    LEFT(@Texto2, 6), -- 'Hola, '
    UPPER(SUBSTRING(@Texto2, 7, 5)), -- 'MUNDO'
    RIGHT(@Texto2, 1) -- '!'
) AS 'TextoNuevo'; -- Resultado: 'Hola, MUNDO!'

-- ============================================
-- APLICACIÓN DE FUNCIONES DE CADENA A NOMBRES DE EMPRESAS EN LA TABLA CUSTOMERS
-- ============================================

SELECT 
    CompanyName, 
    LEN(CompanyName) AS 'Número de caracteres', -- Longitud del nombre de la empresa
    LEFT(CompanyName, 4) AS 'Inicio', -- Primeros 4 caracteres del nombre de la empresa
    RIGHT(CompanyName, 6) AS 'Final', -- Últimos 6 caracteres del nombre de la empresa
    SUBSTRING(CompanyName, 7, 5) AS 'Cadena' -- Extrae 5 caracteres desde la posición 7
FROM Customers;
