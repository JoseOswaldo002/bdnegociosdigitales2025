-- Cosultas de agregado
	--Nota: Solo devuelven un solo regristro

	---sum, avg ,count,count(*), mas y min

	-- Cuantos clientes tengo

	select count(*) as 'Numero de clientes' from Customers

	--Cuantas regiones hay
	select COUNT (*)
	from Customers 
	where Region is null

	select  count (distinct Region)
	from Customers 
	where Region is not null

