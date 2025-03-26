# Procedimientos Almacenados (Stored Procedures)


---

## Configuración inicial

```sql
-- ============================================
--            PROCEDIMIENTOS ALMACENADOS (SP)
-- ============================================

USE Northwind;
```

---

## 1. Mostrar todos los clientes

```sql
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
```

---

## 2. Mostrar clientes por país

```sql
-- =====================================================
-- 2. CREAR UN STORED PROCEDURE PARA MOSTRAR CLIENTES POR PAÍS
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_customers_por_pais
    @pais NVARCHAR(15),  -- Primer país
    @pais2 NVARCHAR(15)  -- Segundo país
AS
BEGIN
    SELECT * FROM Customers
    WHERE Country IN (@pais, @pais2);
END;
GO

EXEC spu_customers_por_pais 'Mexico', 'Germany';

-- Ejecutar con variables
DECLARE @p1 NVARCHAR(15) = 'Mexico';
DECLARE @p2 NVARCHAR(15) = 'Germany';
EXEC spu_customersporpais @p1, @p2;
```

---

## 3. Reporte de ventas por cliente en rango de fechas

```sql
-- =====================================================
-- 3. GENERAR UN REPORTE DE COMPRAS POR CLIENTE EN UN RANGO DE FECHAS
-- =====================================================
GO
CREATE OR ALTER PROCEDURE spu_informe_ventas_clientes
    @nombre NVARCHAR(40) = 'Berglunds snabbköp',
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

-- Ejecuciones
EXEC spu_informe_ventas_clientes 'Berglunds snabbköp', '1996-07-04', '1997-01-01';
EXEC spu_informe_ventas_clientes @fechaFinal = '1997-01-01', @nombre = 'Berglunds snabbköp', @fechaInicial = '1996-07-04';
EXEC spu_informe_ventas_clientes @fechaInicial ='1996-07-04', @FechaFinal = '1997-01-01';
GO
```

---

## 4. Parámetros de salida

```sql
-- =====================================================
-- 4. STORE PROCEDURE CON PARÁMETROS DE SALIDA
-- =====================================================

CREATE OR ALTER PROCEDURE spu_obtener_numero_clientes
    @customerid NCHAR(5),
    @totalCustomers INT OUTPUT
AS 
BEGIN
    SELECT @totalCustomers = COUNT(*) FROM Customers
    WHERE CustomerID = @customerid;
END;
GO

DECLARE @numero INT;
EXEC spu_obtener_numero_clientes @customerid = 'ALFKI', @totalCustomers = @numero OUTPUT;
PRINT 'Número de clientes encontrados: ' + CAST(@numero AS NVARCHAR);
```

---

## 5. Verificar existencia de cliente

```sql
-- =====================================================
-- 5. VERIFICAR SI UN CLIENTE EXISTE ANTES DE DEVOLVER SU INFORMACIÓN
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

EXEC spu_obtener_cliente_siexiste @numeroCliente = 'AROUT';
```

---

## 6. Insertar cliente verificando existencia

```sql
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

EXEC spu_agregar_cliente 'ALFKI', 'Patito de Hule';
EXEC spu_agregar_cliente 'ALFKC', 'Patito de Hule';
```

---

## 7. Insertar cliente con manejo de errores

```sql
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

EXEC spu_agregar_cliente_try_catch 'ALFKD', 'Muñeca Vieja';
```

---

## 8. Comparar calificación (aprobado o reprobado)

```sql
-- =====================================================
-- 8. VERIFICAR SI UN ALUMNO APROBÓ O REPROBÓ
-- =====================================================

CREATE OR ALTER PROCEDURE spu_comparar_calificacion
    @calif DECIMAL(10,2)
AS
BEGIN 
    IF @calif >= 0 AND @calif <= 10
    BEGIN
        IF @calif >= 8 
            PRINT 'La calificación es aprobatoria';
        ELSE
            PRINT 'La calificación es reprobatoria';
    END
    ELSE 
        PRINT 'Calificación no válida';
END;
GO

EXEC spu_comparar_calificacion @calif = 5;
GO
```

---

## 9. Procedimiento con ciclo WHILE

```sql
-- =====================================================
-- 9. MANEJO DE CICLOS EN STORED PROCEDURES (IMPRIMIR N VECES)
-- =====================================================

CREATE OR ALTER PROCEDURE spu_imprimir
    @numero INT
AS
BEGIN 
    IF @numero <= 0
    BEGIN
        PRINT 'El número no puede ser 0 o negativo';
        RETURN;
    END 

    DECLARE @i INT = 1;
    WHILE(@i <= @numero)
    BEGIN 
        PRINT CONCAT('Número ', @i);
        SET @i = @i + 1;
    END
END;
GO

EXEC spu_imprimir 10;
```

---


