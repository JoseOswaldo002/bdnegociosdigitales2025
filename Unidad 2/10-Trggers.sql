-- ============================================
-- TRIGGERS (DISPARADORES)
-- ============================================
-- Tipos de TRIGGERS: AFTER / FOR / INSTEAD OF
-- Se usan en operaciones INSERT, UPDATE, DELETE.
-- Utilizan las llamadas "tablas mágicas": INSERTED y DELETED

-- Sintaxis general:
-- CREATE OR ALTER TRIGGER nombre_trigger
-- ON tabla
-- AFTER [INSERT|UPDATE|DELETE]
-- AS
-- BEGIN
--     -- lógica del trigger
-- END;

USE BDEJEMPLO2;
GO

-- ============================================
-- EJEMPLO: TRIGGER AL INSERTAR UN PEDIDO
-- Este trigger se dispara después de insertar un pedido.
-- Verifica si hay suficiente stock del producto.
-- Si hay stock suficiente, se descuenta del inventario.
-- Si no hay suficiente, se cancela el pedido.
-- ============================================

CREATE OR ALTER TRIGGER tg_pedidos_insertar
ON Pedidos
AFTER INSERT
AS
BEGIN
    DECLARE @existencia INT;
    DECLARE @fab CHAR(3);
    DECLARE @prod CHAR(5);
    DECLARE @cantidad INT;

    SELECT 
        @fab = fab, 
        @prod = producto,
        @cantidad = cantidad
    FROM inserted;

    SELECT 
        @existencia = Stock 
    FROM Productos
    WHERE Id_fab = @fab AND id_producto = @prod;

    IF @existencia >= @cantidad
    BEGIN
        UPDATE Productos
        SET stock = stock - @cantidad
        WHERE Id_fab = @fab AND Id_producto = @prod;
    END
    ELSE 
    BEGIN
        RAISERROR('No hay suficiente stock para el pedido', 16, 1);
        ROLLBACK;
    END
END;
GO

-- ============================================
-- PRUEBAS Y CONSULTAS COMPLEMENTARIAS
-- ============================================

-- Ver todos los pedidos
SELECT * FROM Pedidos;

-- Ver el último número de pedido
SELECT MAX(Num_Pedido) FROM Pedidos;

-- Ver productos (antes o después de la inserción)
SELECT * FROM Productos;

-- Calcular importe para un pedido específico
DECLARE @importe MONEY;

SELECT @importe = (p.Cantidad * pr.Precio)
FROM Pedidos AS p
INNER JOIN Productos AS pr
    ON p.Fab = pr.Id_fab
    AND p.Producto = pr.Id_producto;

-- Insertar nuevo pedido (disparará el trigger)
INSERT INTO Pedidos (
    Num_Pedido, Fecha_Pedido, Cliente, Rep, Fab, Producto, Cantidad, Importe
)
VALUES (
    113071, GETDATE(), 2103, 106, 'ACI', '41001', 77, @importe
);

-- Verificar stock del producto afectado
SELECT * 
FROM Productos 
WHERE Id_fab = 'ACI' AND Id_producto = '41001';


-- Crear un trigger que cada vez que se elimine un pedido se debe de actualizar el stock de los productos con la cantidad eliminada
GO
CREATE OR ALTER TRIGGER tg_pedidos_eliminar
ON Pedidos
AFTER DELETE
AS
BEGIN
    DECLARE @existencia INT;
    DECLARE @fab CHAR(3);
    DECLARE @prod CHAR(5);
    DECLARE @cantidad INT;

    


	BEGIN TRY

	SELECT 
        @fab = fab, 
        @prod = producto, 
        @cantidad = cantidad
    FROM deleted;

    UPDATE Productos
    SET stock = stock + @cantidad
    WHERE Id_fab = @fab AND Id_producto = @prod;

    print 'Se actualizo correctamente'
    END TRY
    BEGIN CATCH
    RAISERROR('No hay suficiente stock para el pedido', 16, 1);
    ROLLBACK;
    END CATCH;
END;
GO
 
DELETE FROM Pedidos
where Num_Pedido = 113072

SELECT * FROM Pedidos;
SELECT * FROM Productos;
