# Ejercicio de pedidos con Store procedure

- Realizar un pedido
- Validar que el pedido exista +
- Validad que el cliente, el empleado y el producto exista +
- Validad que la cantidad a vender tenga stock
- Insertar el pedido y calcular el importe(multiplicar el precio del producto por la cantidad vendida)
- Actualizar el stock del producto(restando el stock menos la cantidad vendida)

```SQL

CREATE OR ALTER PROCEDURE spu_realizar_pedido
@numPedido int,
@cliente int,
@representante int,
@fabricante char(3),
@producto char(5),
@cantidad int
AS
begin
	if not exists (select 1 from Pedidos where Num_Pedido = @numPedido) or
	   not exists (select 1 from Clientes where Num_Cli = @cliente) or
	   not exists (select 1 from Representantes where Num_Empl = @representante) or
	   not exists (select 1 from Productos where Id_fab = @fabricante or Id_producto = @producto)
	    begin
		print ('Los datos no son validos')
		return 
		end

	if exists (select 1 from Pedidos where Num_Pedido = @numPedido)
	begin
		print ('El pedido ya existe')
		return 
	end

	if exists (select 1 from Clientes where Num_Cli = @cliente)
	begin
		print ('El cliente existe')
		return 
	end

	if exists (select 1 from Representantes where Num_Empl = @representante)
	begin
		print ('El representante es valido')
		return 
	end

	if exists (select 1 from Productos where Id_fab = @fabricante AND Id_producto = @producto)
	begin
		print ('El producto existe')
		return 
	end

	if @cantidad <= 0
	begin
		print'La cantidad no puede ser 0'
		return;
		end
	declare @stockValido int
	select Stock from Productos where Id_fab = @fabricante and Id_producto = @producto

	if @cantidad > @stockValido
	begin
	print 'No hay suficinete stock'
	return
	end
	declare @precio money
	declare @importe money

	select @precio=Precio from Productos where Id_fab = @fabricante and Id_producto = @fabricante
	set @importe = @cantidad * @precio

	begin try
	-- Se inserto un pedido
	insert into Pedidos
	values (@numPedido,GETDATE(),@cliente,@representante,@fabricante,@producto,@cantidad,@importe)

	update Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fabricante and Id_producto = @producto
	end try
	begin catch
		print 'Error al actualizar datos'
		return;
	end catch


END;
```

##Pruebas

````SQL

execute spu_realizar_pedido @numPedido = 113069,
    @Cliente = 2109,
	@representante= 107,
	@fabricante= 'IMM',
	@Producto= '775C ',
	@Cantidad =20

execute spu_realizar_pedido @numPedido = 11261,
    @Cliente = 2117,
	@representante= 106,
	@fabricante= 'REI',
	@Producto= '2A44L',
	@Cantidad =20


execute spu_realizar_pedido @numPedido = 11261,
    @Cliente = 2117,
	@representante= 106,
	@fabricante= 'REI',
	@Producto= '2A44L',
	@Cantidad =20

	execute spu_realizar_pedido @numPedido = 113070,
    @Cliente = 2117,
	@representante= 101,
	@fabricante= 'ACI',
	@Producto= '4100X',
	@Cantidad =20;

	select * from Pedidos
	where Id_fab = 'ACI' and Id_producto = '4100x'

````