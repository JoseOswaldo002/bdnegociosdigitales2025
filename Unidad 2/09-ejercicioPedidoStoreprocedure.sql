-- ====================================================================================
-- Procedimiento almacenado: spu_realizar_pedido
-- Descripción:
--   - Valida que el pedido no exista previamente.
--   - Valida que el cliente, representante y producto existan en la base de datos.
--   - Verifica que la cantidad de producto a vender esté disponible en stock.
--   - Inserta un nuevo pedido y calcula el importe (cantidad * precio del producto).
--   - Actualiza el stock del producto después de la venta.
-- ====================================================================================

USE BDEJEMPLO2;
GO

CREATE OR ALTER PROCEDURE spu_realizar_pedido
    @numPedido INT,            -- Número de pedido
    @cliente INT,              -- ID del cliente
    @representante INT,        -- ID del representante de ventas
    @fabricante CHAR(3),       -- Código del fabricante del producto
    @producto CHAR(5),         -- Código del producto
    @cantidad INT              -- Cantidad de unidades vendidas
AS
BEGIN
    -- Verificar si el pedido ya existe
    IF EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numPedido)
    BEGIN
        PRINT 'Error: El pedido ya existe.';
        RETURN;
    END

    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @cliente)
    BEGIN
        PRINT 'Error: El cliente con ID ' + CAST(@cliente AS NVARCHAR) + ' no existe.';
        RETURN;
    END

    -- Verificar si el representante existe
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @representante)
    BEGIN
        PRINT 'Error: El representante con ID ' + CAST(@representante AS NVARCHAR) + ' no existe.';
        RETURN;
    END
    -- Verificar si el producto existe
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @fabricante AND Id_producto = @producto)
    BEGIN
        PRINT 'Error: El producto con código ' + @producto + ' del fabricante ' + @fabricante + ' no existe.';
        RETURN;
    END

    -- Verificar que la cantidad ingresada sea válida
    IF @cantidad <= 0
    BEGIN
        PRINT 'Error: La cantidad debe ser mayor a 0.';
        RETURN;
    END

    -- Verificar que haya suficiente stock disponible
    DECLARE @stockValido INT;
    SELECT @stockValido = Stock 
    FROM Productos 
    WHERE Id_fab = @fabricante AND Id_producto = @producto;

    IF @cantidad > @stockValido
    BEGIN
        PRINT 'Error: No hay suficiente stock disponible. Solo hay ' + CAST(@stockValido AS NVARCHAR) + ' unidades.';
        RETURN;
    END

    -- Obtener el precio del producto
    DECLARE @precio MONEY;
    SELECT @precio = Precio 
    FROM Productos 
    WHERE Id_fab = @fabricante AND Id_producto = @producto;

    -- Calcular el importe total del pedido
    DECLARE @importe MONEY;
    SET @importe = @cantidad * @precio;

    PRINT 'El importe total del pedido es: $' + CAST(@importe AS NVARCHAR);

    -- Intentar insertar el pedido y actualizar el stock
    BEGIN TRY
        -- Insertar el nuevo pedido en la tabla Pedidos
        INSERT INTO Pedidos
        VALUES (@numPedido, GETDATE(), @cliente, @representante, @fabricante, @producto, @cantidad, @importe);

        -- Actualizar el stock del producto
        UPDATE Productos
        SET Stock = Stock - @cantidad
        WHERE Id_fab = @fabricante AND Id_producto = @producto;

        PRINT 'Pedido registrado exitosamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error: Ocurrió un problema al registrar el pedido.';
        RETURN;
    END CATCH;
END;
GO


-- =============================================================
-- PRUEBAS DEL PROCEDIMIENTO ALMACENADO CON DIFERENTES PEDIDOS
-- =============================================================

exec spu_realizar_pedido 
	@numPedido = 113070, 
	@cliente = 2000, 
	@representante=106, 
	@fabricante = 'REI',
	@producto = '2A44L', 
	@cantidad =20

exec spu_realizar_pedido 
	@numPedido = 113070, 
	@cliente = 2117, 
	@representante=111, 
	@fabricante = 'REI',
	@producto = '2A44L', 
	@cantidad =20

exec spu_realizar_pedido 
	@numPedido = 113071, 
	@cliente = 2117, 
	@representante=101, 
	@fabricante = 'ACI',
	@producto = '4100X', 
	@cantidad =20

select * from Productos
where Id_fab = 'ACI' and Id_producto = '4100x'


-- =============================================================
-- CONSULTA PARA VERIFICAR LOS PEDIDOS REGISTRADOS
-- =============================================================
SELECT * FROM Productos

SELECT * FROM Pedidos
