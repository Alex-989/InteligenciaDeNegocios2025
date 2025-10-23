IF NOT EXISTS (SELECT name FROM sys.databases WHERE name =N'miniBD')
BEGIN
	CREATE DATABASE miniBD
	COLLATE Latin1_General_100_CI_AS_SC_UTF8;
END

SELECT name FROM sys.databases;

USE miniBD;
GO

-- Creacion de tablas

IF OBJECT_ID ('clientes', 'U') IS NOT NULL DROP TABLE clientes;

CREATE TABLE clientes(
	idcliente INT NOT NULL,
	nombre NVARCHAR(100),
	edad INT,
	ciudad NVARCHAR(100),
	CONSTRAINT pk_clientes
	PRIMARY KEY (idcliente)
);


IF OBJECT_ID ('productos', 'U') IS NOT NULL DROP TABLE productos;

CREATE TABLE productos(
	Idproducto INT PRIMARY KEY,
	NombreProducto NVARCHAR(200),
	Categoria NVARCHAR(200),
	Precio DECIMAL(12,2)
);
GO

/*
	================Insercion de registros en las tablas============
*/

INSERT INTO clientes
VALUES (1, 'Ana Torres', 25, 'Cuidad de Mexico');

INSERT INTO clientes (idcliente, nombre, edad, ciudad)
VALUES(2, 'Luis Perez', 34, 'Guadalajara');

INSERT INTO clientes (idcliente, edad, nombre, ciudad)
VALUES (3, 29, 'Soyla Vaca', NULL);

INSERT INTO clientes (idcliente, nombre, edad)
VALUES (4, 'Natasha', 41);

INSERT INTO clientes (idcliente, nombre, edad, ciudad)
VALUES (5, 'Sofia Lopez', 19, 'Chapulhuacan'),
	   (6, 'Laura Hernandez', 38, NULL),
	   (7, 'Victor Trujillo', 25, 'Zacualtipan');
GO


CREATE OR ALTER PROCEDURE sp_add_customer
	@Id INT, @Nombre NVARCHAR (100), @Edad INT, @Ciudad NVARCHAR(100)
AS
BEGIN
	INSERT INTO clientes (idcliente, nombre, edad, ciudad)
	VALUES (@Id, @Nombre, @Edad, @Ciudad);

END;
GO

EXEC sp_add_customer 8, 'Carlos Ruiz', 41, 'Monterrey';
EXEC sp_add_customer 9, 'Jose Angel Perez', 74, 'Salte si puedes';

SELECT * FROM clientes;

SELECT COUNT(*) AS [Numero de clientes]
FROM clientes;

-- Mostrar todos los clientes ordenados por edad de menor a mayor
SELECT UPPER (nombre) AS [Cliente], edad, UPPER (ciudad) AS [Ciudad]
FROM clientes
ORDER BY edad DESC;

-- Listar los clientes que viven en Guadalajara
SELECT UPPER (nombre) AS [Cliente], edad, UPPER (ciudad) AS [Ciudad]
FROM clientes
WHERE ciudad = 'Guadalajara';

-- Listar los clientes con una edad mayor o igual a 30
SELECT UPPER (nombre) AS [Cliente], edad, UPPER (ciudad) AS [Ciudad]
FROM clientes
WHERE edad >= 30;

-- Listar los clientes cuya ciudad sea nula
SELECT UPPER (nombre) AS [Cliente], edad, UPPER (ciudad) AS [Ciudad]
FROM clientes
WHERE ciudad IS NULL

-- Remplazar en la consulta las ciuadades nulas por la palabra DESCONOCIDA
-- (Sin modificar los datos originales)
SELECT UPPER (nombre) AS [Cliente], edad, ISNULL(UPPER(ciudad), 'DESCONOCIDO') AS [Ciudad]
FROM clientes

-- Selecciona los clientes que tengan edad entre 20 y 35 
-- y que vivan en Puebla o Monterrey

SELECT UPPER (nombre) AS [Cliente], edad, ISNULL(UPPER(ciudad), 'DESCONOCIDO') AS [Ciudad]
FROM clientes
WHERE edad BETWEEN 20 AND 35
	AND 
	CIUDAD IN ('Guadalajara','Chapulhuacan');


/*
==================== Actualización de Datos ===========================
*/

SELECT * 
FROM clientes;

UPDATE clientes
SET Ciudad = 'Xochitlan'
WHERE IdCliente = 5;

UPDATE clientes
SET Ciudad = 'Sin ciudad'
WHERE Ciudad IS NULL;

UPDATE clientes
SET Edad = 30
WHERE IdCliente BETWEEN 3 AND 6;

UPDATE clientes
SET Ciudad = 'Metropoli'
WHERE Ciudad IN ('ciudad de México', 'Guadalajara', 'Monterrey');

UPDATE clientes
SET Nombre = 'Juan Perez',
	Edad = 27,
	Ciudad = 'Ciudad Gotica'
WHERE IdCliente = 2;

UPDATE clientes
SET Nombre = 'Cliente Premiun'
WHERE Nombre LIKE 'A%';

UPDATE clientes
SET Nombre = 'Silver customer'
WHERE Nombre LIKE 'er%';

UPDATE clientes
SET Edad = (Edad * 2)
WHERE Edad >= 30 AND Ciudad = 'Metropili';


/*
==================== Eliminación de Datos ===========================
*/

SELECT * 
FROM clientes;

DELETE FROM clientes
WHERE Edad BETWEEN 25 AND 30;

DELETE clientes
WHERE Nombre LIKE '%r';

TRUNCATE TABLE clientes;
GO

/*
=================== Store prosedures de update, delete y select ========================
*/

-- MODIFICA LOS DATOS POR ID
CREATE OR ALTER PROCEDURE sp_update_customers
	@id INT,
	@nombre NVARCHAR(100),
	@edad INT,
	@ciudad NVARCHAR(100)
AS
BEGIN
	UPDATE clientes 
	SET nombre = @nombre,
		edad = @edad,
		ciudad = @ciudad
	WHERE idcliente = @id;
END;
GO

EXEC sp_update_customers 
7, 'Benito Kano', 24, 'Lima los Pies'

EXEC sp_update_customers 
@ciudad = 'Martinez de la Torre', 
@edad = 56, @id = 3, 
@nombre = 'Toribio Trompudo';


-- Ejercicio completo donde se pueda insertar datos en una tabla
-- principal (Encabezado) y una tabla detalle utilizando un SP

CREATE TABLE ventas(
Idventa INT IDENTITY (1,1) PRIMARY KEY,
FechaVenta DATETIME NOT NULL DEFAULT GETDATE(),
Cliente NVARCHAR(100) NOT NULL,
Total DECIMAL(10,2) NULL
);


-- Table Detalle
CREATE TABLE DetalleVenta(
IdDetalle INT IDENTITY (1,1) PRIMARY KEY,
IdVenta INT NOT NULL,
Producto NVARCHAR(100) NOT NULL,
Cantidad INT NOT NULL,
PRECIO DECIMAL(10,2) NOT NULL,
CONSTRAINT pk_detalleVenta_venta
FOREIGN KEY (IdVenta)
REFERENCES Ventas(IdVenta)
);


-- Crear un tipo de tabla  (Table Type)

-- Este tipo de tabla servira como estructura para enviar los
-- detalles al sp

CREATE TYPE TipoDetalleVentas AS TABLE (
	Producto NVARCHAR(100),
	Cantidad INT,
	Precio DECIMAL(10,2)
);
GO

-- Crear el Store Procedure
-- El SP insertara el encabezado y luego todos los detalles
-- utilizando el tipo de tabla

CREATE OR ALTER PROCEDURE InsertarVentaConDetalle
@Cliente NVARCHAR(100),
@Detalles TipoDetalleVentas READONLY
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdVenta INT;

	BEGIN TRY
		BEGIN TRANSACTION;

		-- Insertar en la tabla principal
		INSERT INTO ventas (Cliente)
		VALUES(@Cliente)

		-- Obtener el ID recien generado
		SET @IdVenta = SCOPE_IDENTITY();

		-- Insertar los detalles (Tabla Detalles)
		INSERT INTO DetalleVenta (IdVenta, Producto, Cantidad, PRECIO)
		SELECT @IdVenta, Producto, cantidad, precio
		FROM @Detalles

		-- Calcular el total de venta
		UPDATE ventas
		SET Total = (SELECT SUM(Cantidad * Precio) FROM @Detalles)
		WHERE Idventa = @IdVenta;

		COMMIT TRANSACTION

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	THROW;
END CATCH
END
;
GO

-- Ejecutar el SP con datos de prueba

-- Declarar una variable tipo tabla
DECLARE @MisDetalles AS TipoDetalleVentas

-- Insertar productos en type table
INSERT INTO @MisDetalles (Producto, Cantidad, Precio)
VALUES
('Laptop', 1, 15000),
('Mause', 2, 300),
('Teclado', 1, 500),
('Pantalla', 5, 4500)


-- Ejecutar el SP
EXEC InsertarVentaConDetalle @cliente='Uriel Edgar', @Detalles=@MisDetalles

SELECT * FROM ventas
SELECT * FROM DetalleVenta


-- Funciones Integradas (Built-in Fuctions)

SELECT 
Nombre as [Nombre Fuente],
LTRIM(UPPER(Nombre)) AS Mayusculas,
LOWER(Nombre) AS Minusculas,
LEN(Nombre) AS Longitud,
SUBSTRING(Nombre, 1, 3) AS Prefijo,
LTRIM(Nombre) AS [Sin Espacios Izquierda],
CONCAT(Nombre, ' - ', Edad) AS [Nombre Edad],
UPPER(REPLACE(TRIM(Ciudad), 'Chapulhuacan', 'Chapu'))AS [Ciudad Normal]
FROM clientes;

SELECT * FROM clientes

INSERT INTO clientes(Idcliente, Nombre, Edad, Ciudad)
VALUES(10,'Luis Lopez', 45, 'Achichinilco');

INSERT INTO clientes(Idcliente, Nombre, Edad, Ciudad)
VALUES(11,'German Galindo', 32, 'Achichinilco2 ');

INSERT INTO clientes(Idcliente, Nombre, Edad, Ciudad)
VALUES(12,'Jean Porfirio', 19, 'Achichinilco3');

INSERT INTO clientes(Idcliente, Nombre, Edad, Ciudad)
VALUES(13,'Roberto Estrada  ', 19, 'Chapulhuacan');



-- Crear una tabla a partir de una consulta
SELECT TOP 0
idCliente, 
Nombre as [Nombre Fuente],
LTRIM(UPPER(Nombre)) AS Mayusculas,
LOWER(Nombre) AS Minusculas,
LEN(Nombre) AS Longitud,
SUBSTRING(Nombre, 1, 3) AS Prefijo,
LTRIM(Nombre) AS [Sin Espacios Izquierda],
CONCAT(Nombre, ' - ', Edad) AS [Nombre Edad],
UPPER(REPLACE(TRIM(Ciudad), 'Chapulhuacan', 'Chapu'))AS [Ciudad Normal]
into stage_clientes
FROM clientes;


-- Agrega un constrint a la tabla(primary key)
ALTER TABLE stage_clientes
ADD CONSTRAINT pk_stage_clientes
PRIMARY KEY(idCliente);

SELECT * FROM 
stage_clientes;

-- Insetar datos a partir de una consulta
INSERT INTO stage_clientes (Idcliente,
							[Nombre Fuente],
							Mayusculas,
							Minusculas,
							Longitud,
							Prefijo,
							[Sin Espacios Izquierda],
							[Nombre Edad], [Ciudad Normal]);


SELECT 
idCliente, 
Nombre as [Nombre Fuente],
LTRIM(UPPER(Nombre)) AS Mayusculas,
LOWER(Nombre) AS Minusculas,
LEN(Nombre) AS Longitud,
SUBSTRING(Nombre, 1, 3) AS Prefijo,
LTRIM(Nombre) AS [Sin Espacios Izquierda],
CONCAT(Nombre, ' - ', Edad) AS [Nombre Edad],
UPPER(REPLACE(TRIM(Ciudad), 'Chapulhuacan', 'Chapu'))AS [Ciudad Normal]
FROM clientes;

-- Funciones de Fecha
USE NORTHWND

SELECT OrderDate,
GETDATE() AS [Fecha Actual],
DATEADD(DAY, 10, OrderDate) AS [FechaMas10Dias],
DATEDIFF(DAY, -10, OrderDate) AS [FechaMenos10Dias],
DATEPART(QUARTER, OrderDate) AS [Trimestre],
DATENAME(MONTH, OrderDate) AS [MesConNumero],
DATENAME(MONTH, OrderDate) AS [MesConNombre],
DATENAME(WEEKDAY, OrderDate) AS [NombreDia],
DATEDIFF(DAy, OrderDate, GETDATE()) AS [DiasTranscurridos],
DATEDIFF(YEAR, OrderDate, GETDATE()) AS [AñosTranscurridos],
DATEDIFF(YEAR, '2003-07-13', GETDATE()) AS [EdadJaen],
DATEDIFF(YEAR, '1979-07-13', GETDATE()) AS [EdadJaen]
FROM Orders

-- Manejo de valores nulos
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    SecondaryEmail NVARCHAR(100),
    Phone NVARCHAR(20),
    Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2)
);
GO

INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, SecondaryEmail,
			Phone, Salary, Bonus)

VALUES (1, 'Ana', 'Lopez', 'ana.lopez@empresa.com',NULL,'555-2345', 12000, 100),
       (2, 'Carlos', 'Ramirez', NULL, 'c.ramirez@empresa.com', NULL, 9500, NULL),
       (3, 'Laura', 'Gomez', NULL, NULL, '555-8900', 0, 500),
       (4, 'Jorge', 'Diaz', 'jorge.diaz@empresa.com', NULL, NULL, 15000, 0);

-- Ejercicio ISNULL
-- Mostrar el nombre completo del empleado junto con su numero de telefono,
-- sino tiene telefono, mostrar el texto "No disponible"

SELECT CONCAT(FirstName, '', LastName) AS [FullName],
ISNULL(Phone, 'No disponible') AS [Phone]
FROM Employees;

-- Mostrar el nombre del empleado y su correo de contacto
SELECT CONCAT(FirstName, ' ', LastName) AS [Nombre Completo],
Email,
SecondaryEmail,
COALESCE(Email,SecondaryEmail, 'Sin Correo') AS Correo_Contacto
FROM Employees

-- Ejercicio 3. NULLIF
-- Mostrar el nombre del empleado, su salario y el resultado de
-- NULLIF(salary, 0) para detectar quien tiene salario cero.

SELECT CONCAT(FirstName, ' ' , LastName) AS [Nombre Completo],
Salary,
NULLIF(Salary, 0) AS [Salario Evalueble]
FROM Employees;

-- Evita divicion por 0:

SELECT FirstName,
Bonus,
(Bonus/NULLIF(Salary, 0)) AS Bonus_Salario
FROM Employees

-- Expreciones condicionales Case

-- Permite crear 

SELECT
	UPPER(CONCAT(FirstName, ' ', LastName)) AS [Full Name],
	ROUND (Salary, 2) AS [Salario],
	CASE
		WHEN ROUND(Salary,2) >= 10000 THEN 'Alto'
		WHEN ROUND(Salary,2) BETWEEN 5000 AND 9999 THEN 'Medio'
		ELSE 'Bajo'
	END AS [Nivel Salarial]
FROM Employees;

-- Combinar Funciones y CASE

-- Seleccionar el nombre del producto, la fecha de la orden, telefono
-- el nombre del cliente en Mayusculas, validar si el telefono
-- es NULL poner la palabra "No disponible",
-- Comprobar la fecha de la orden restando los dias de la fecha de orden
-- con respecto a la fecha de hoy, si estos dias son menores a 30 entonces
-- mostrar la palabra "Reciente" y si no "Antiguo", el campo debe llamarse Estado de 
-- pedido, utiliza la bd NORTHWIND.

-- Create tabla a partir de esta consulta

SELECT UPPER(c.CompanyName) AS [Nombre Cliente],
ISNULL(c.Phone, 'No Disponible') AS [Telefono],
p.ProductName,
CASE
    WHEN DATEDIFF(day, o.OrderDate, GETDATE()) < 30 THEN 'Reciente'
    ELSE 'Antiguo'
END AS [Estado del Pedido]
INTO tablaformateada
FROM (SELECT CustomerID, CompanyName, Phone FROM Customers) AS c
INNER JOIN (SELECT OrderID, CustomerID, OrderDate FROM Orders) AS o
ON c.CustomerID = o.CustomerID
INNER JOIN (SELECT ProductID, OrderID FROM [Order Details]) AS od
ON o.OrderID = od.OrderID
INNER JOIN (SELECT ProductID, ProductName FROM Products) AS p
ON p.ProductID = od.ProductID;


CREATE OR ALTER VIEW v_pedidosAntiguos

SELECT * FROM tablaformateada
WHEN ID=1;




SELECT *
FROM Orders

SELECT *
FROM Products

SELECT *
FROM Customers
