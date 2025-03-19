-- Store procedures
use Northwind
-- crear un store procedure para seleccionar todos los clientes
go
create or alter procedure spu_mostrar_clientes
as
begin 
select * from Customers;
end;
go

-- Ejecutar un store en transact

exec spu_mostrar_clientes

-- Crear un store procedure que muestre los clientes por país.
-- Parametros de entrada
go
create or alter proc spu_customersporpais

-- Parametros

@pais nvarchar(15),
@pais2 nvarchar(15)
  -- Paramentro de entrada
as
begin
	select * from Customers
	where Country in (@pais, @pais2);
end;

-- fin del store

-- Ejecuta un store procedure

Declare @p1 nvarchar(15) = 'Spain';
Declare @p2 nvarchar(15) = 'Germany';

exec spu_customersporpais @p1, @p2;
go


-- generar un reporte que permite visualizar los datos de compra de un determinado cliente,
-- en un rango de fechas, mostrando el monto total de compras de producto, mediante un sp.

create or alter proc spu_informe_ventas_clientes
--PARAMETROS
@nombre nvarchar (40) = 'Berglunds snabbköp', --Parametro de entrada con valor por default
@fechaInicial DateTime,
@fechaFinal DateTime
AS
begin
select 
	[Nombre Producto],
	sum(Importe) AS 'Monto total'
from vistaOrdenesDeCompra
where [Nombre del cliente] = @nombre
and [Fecha de orden] between @fechaInicial and @fechaFinal
group by [Nombre Producto],[Nombre del cliente]
end;
go


--Ejecucion de un Store con parametros de entrada

exec spu_informe_ventas_clientes
	'Berglunds snabbköp',
    '1996-07-04','1997-01-01'

--Ejecucion de un store procedure con parametros en diferente posicion

exec spu_informe_ventas_clientes 
	@fechaInicial = '1996-07-04',
	@fechaFinal = '1997-01-01'


--Ejecucion de un store procedore con parameteos de entrada con un campo que tiene un valr por default

exec spu_informe_ventas_clientes 
	@fechaFinal = '1997-01-01',
	@nombre = 'Berglunds snabbköp',
	@fechaInicial = '1996-07-04'

	go


--Store procedure con parametros de salida
create or alter proc spu_obtener_numero_clientes
@custumerid nchar (5), --Parametro de entrada
@totalCustumers int output --Parametro de salida
AS
Begin
	select @totalCustumers = count (*) from Customers
	where CustomerID = @custumerid
end;
GO
-------
declare @numero as int;
exec  spu_obtener_numero_clientes 
	@custumerid = 'ANATR',
	@totalCustumers = @numero output;
print @numero;
go


--Crear un store procedure que permita saber si un alumno aprobo o reprobo
create or alter procedure spu_comparar_calificacion
@calif decimal (10,2) --Parametro de entrada
AS
BEGIN
	if @calif >= 0 and @calif <=10
	begin
		if @calif>=8
		print 'La calificacion es aprobatoria'
		else 
		print 'La calificacion es reprobatoria'
	end
	else
		print 'Calificacion no valida'
END;
GO

exec spu_comparar_calificacion @calif = 8


GO

--Crear un SP que permita verificar si un cliente exite antes de devolver su informacion
create or alter procedure spu_obtener_cliente_siexite
@numeroCliente nchar(5)
AS
BEGIN
	if exists (select 1 from Customers where CustomerID = @numeroCliente)
		select * from Customers where CustomerID = @numeroCliente;
	else
		print 'El cliente no existe'
END;
GO

exec spu_obtener_cliente_siexite @numeroCliente = 'AROUT'

select * from Customers
select 1 from Customers where CustomerID = 'AROUT'

go
-- Crear un store procedure que permita insertar un cliente, 
--pero se debe de verificar primero que no exista
create or alter procedure spu_obtener_cliente_siexite
@numeroCliente nchar(5)
AS
BEGIN
	if exists (select 1 from Customers where CustomerID = @numeroCliente)
		select * from Customers where CustomerID = @numeroCliente;
	else
		print 'El cliente no existe'
END;
GO

exec spu_obtener_cliente_siexite @numeroCliente = 'AROUT'

select * from Customers
select 1 from Customers where CustomerID = 'AROUT'

go

-- Crear un store procedure que permita insertar un cliente, 
--pero se debe de verificar primero que no exista
use Northwind
select * from Customers

create or alter procedure spu_agregar_cliente
	@id nchar(5),
	@nombre nvarchar (40),
	@city nvarchar(15) = 'San miguel'
as
begin
	if exists (select 1 from Customers where CustomerID = @id)
	begin
		print ('El cliente ya existe')
		return 1
	end

	insert into Customers(CustomerID, CompanyName)
	values (@id, @nombre);
	print('Cliente insertado exitosamente');
	return 0;

end;

	
go

exec spu_agregar_cliente 'ALFIK','Patito de hule'
exec spu_agregar_cliente 'ALFKC','Patito de hule'

GO

--Try catch
create or alter procedure spu_agregar_cliente_try_catch
	@id nchar(5),
	@nombre nvarchar (40),
	@city nvarchar(15) = 'San miguel'
AS
BEGIN
	begin try
	insert into Customers(CustomerID, CompanyName)
	values (@id, @nombre);
	print('Cliente insertado exitosamente');
	end try

	begin catch
			print ('El cliente ya existe')

	end catch
END;

exec spu_agregar_cliente 'ALFKD','Muñeca vieja'
GO
--Manejo de ciclos en store
 
 --Imprimir el numero de veces que indique el usuario

 CREATE OR ALTER PROCEDURE spu_imprimir
 --Parametro
	@numero int
AS
BEGIN
--Varibale
		if @numero <= 0
		begin
				print'El numero no puede ser 0 o negativo'
		return
		end

	declare @i int
	SET @i = 1
	while (@i<=@numero)
	begin
		print concat('numero ', @i)
		set @i = @i + 1
	end
END;

exec spu_imprimir @numero =1


GO






/*create or alter proc datos_compra_cliente
AS
select 
	*
from
Customers AS c
INNER JOIN
Orders as o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON od.OrderID = o.OrderID


exec datos_compra_cliente*/
