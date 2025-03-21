-- ============================================
--            PROCEDIMIENTOS ALMACENADOS (SP)
-- ============================================

USE Northwind;


-- =====================================================
-- 1. CREAR UN STORED PROCEDURE PARA SELECCIONAR TODOS LOS CLIENTES
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_mostrar_clientes
AS
BEGIN
    SELECT * FROM Customers;
END;
GO

-- Ejecutar el procedimiento almacenado
EXEC spu_mostrar_clientes;


-- =====================================================
-- 2. CREAR UN STORED PROCEDURE PARA MOSTRAR CLIENTES POR PA�S
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_customers_por_pais
    @pais NVARCHAR(15),  -- Primer pa�s
    @pais2 NVARCHAR(15)  -- Segundo pa�s
AS
BEGIN
    SELECT * FROM Customers
    WHERE Country IN (@pais, @pais2);
END;
GO

EXEC spu_customers_por_pais 'Mexico', 'Germany';


-- Ejecutar el procedimiento almacenado con par�metros
DECLARE @p1 NVARCHAR(15) = 'Mexico';
DECLARE @p2 NVARCHAR(15) = 'Germany';

EXEC spu_customersporpais @p1, @p2;


-- =====================================================
-- 3. GENERAR UN REPORTE DE COMPRAS POR CLIENTE EN UN RANGO DE FECHAS
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_informe_ventas_clientes
    @nombre NVARCHAR(40) = 'Berglunds snabbk�p',  -- Cliente por defecto
    @fechaInicial DATETIME, 
    @fechaFinal DATETIME
AS
BEGIN
    SELECT 
        [Nombre Producto], 
        [Nombre del Cliente],  
        SUM(Importe) AS [Monto Total]
    FROM vistaOrdenesDeCompra
    WHERE [Nombre del Cliente] = @nombre 
    AND [Fecha de Orden] BETWEEN @fechaInicial AND @fechaFinal
    GROUP BY [Nombre Producto], [Nombre del Cliente];
END;
GO

-- Ejecuci�n del procedimiento almacenado con par�metros
EXEC spu_informe_ventas_clientes 'Berglunds snabbk�p', '1996-07-04', '1997-01-01';

-- Ejecuci�n del procedimiento almacenado con par�metros en diferente orden
EXEC spu_informe_ventas_clientes @fechaFinal = '1997-01-01', 
                                 @nombre = 'Berglunds snabbk�p', 
                                 @fechaInicial = '1996-07-04';

-- Ejecuci�n con valores por defecto
EXEC spu_informe_ventas_clientes @fechaInicial ='1996-07-04', 
                                 @FechaFinal = '1997-01-01';
GO

-- =====================================================
-- 4. STORE PROCEDURE CON PAR�METROS DE SALIDA
-- =====================================================

CREATE OR ALTER PROCEDURE spu_obtener_numero_clientes
    @customerid NCHAR(5),  -- Par�metro de entrada
    @totalCustomers INT OUTPUT -- Par�metro de salida
AS 
BEGIN
    SELECT @totalCustomers = COUNT(*) FROM Customers
    WHERE CustomerID = @customerid;
END;
GO

-- Declarar la variable de salida
DECLARE @numero INT;

-- Ejecutar el procedimiento almacenado
EXEC spu_obtener_numero_clientes @customerid = 'ALFKI', @totalCustomers = @numero OUTPUT;

-- Mostrar el resultado
PRINT 'N�mero de clientes encontrados: ' + CAST(@numero AS NVARCHAR);


-- =====================================================
-- 5. VERIFICAR SI UN CLIENTE EXISTE ANTES DE DEVOLVER SU INFORMACI�N
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_obtener_cliente_siexiste
    @numeroCliente NCHAR(5)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @numeroCliente)
        SELECT * FROM Customers WHERE CustomerID = @numeroCliente;
    ELSE
        PRINT 'El cliente no existe';
END;
GO

-- Ejecutar procedimiento
EXEC spu_obtener_cliente_siexiste @numeroCliente = 'AROUT';

-- =====================================================
-- 6. INSERTAR UN CLIENTE VERIFICANDO QUE NO EXISTA
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_agregar_cliente 
    @id NCHAR(5), 
    @nombre NVARCHAR(40), 
    @city NVARCHAR(15) = 'San Miguel'
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @id)
    BEGIN
        PRINT 'El cliente ya existe';
        RETURN 1;
    END

    INSERT INTO Customers(CustomerID, CompanyName)
    VALUES(@id, @nombre);

    PRINT 'Cliente insertado exitosamente';
    RETURN 0;
END;
GO

-- Ejecutar procedimiento
EXEC spu_agregar_cliente 'ALFKI', 'Patito de Hule';
EXEC spu_agregar_cliente 'ALFKC', 'Patito de Hule';


-- =====================================================
-- 7. INSERTAR UN CLIENTE CON MANEJO DE ERRORES (TRY-CATCH)
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_agregar_cliente_try_catch
    @id NCHAR(5), 
    @nombre NVARCHAR(40), 
    @city NVARCHAR(15) = 'San Miguel'
AS
BEGIN 
    BEGIN TRY
        INSERT INTO Customers(CustomerID, CompanyName)
        VALUES(@id, @nombre);
        PRINT 'Cliente insertado exitosamente';
    END TRY
    BEGIN CATCH
        PRINT 'Error: No se pudo insertar el cliente';
    END CATCH
END;
GO

EXEC spu_agregar_cliente_try_catch 'ALFKD', 'Mu�eca Vieja';

-- =====================================================
-- 8. VERIFICAR SI UN ALUMNO APROB� O REPROB�
-- =====================================================

CREATE OR ALTER PROCEDURE spu_comparar_calificacion
    @calif DECIMAL(10,2) -- Par�metro de entrada
AS
BEGIN 
    IF @calif >= 0 AND @calif <= 10
    BEGIN
        IF @calif >= 8 
            PRINT 'La calificaci�n es aprobatoria';
        ELSE
            PRINT 'La calificaci�n es reprobatoria';
    END
    ELSE 
        PRINT 'Calificaci�n no v�lida';
END;
GO

-- Ejecutar procedimiento
EXEC spu_comparar_calificacion @calif = 5;
GO

-- =====================================================
-- 9. MANEJO DE CICLOS EN STORED PROCEDURES (IMPRIMIR N VECES)
-- =====================================================

CREATE OR ALTER PROCEDURE spu_imprimir
    @numero INT
AS
BEGIN 
    IF @numero <= 0
    BEGIN
        PRINT 'El n�mero no puede ser 0 o negativo';
        RETURN;
    END 

    DECLARE @i INT = 1;
    WHILE(@i <= @numero)
    BEGIN 
        PRINT CONCAT('N�mero ', @i);
        SET @i = @i + 1;
    END
END;
GO

-- Ejecutar procedimiento
EXEC spu_imprimir 10;
