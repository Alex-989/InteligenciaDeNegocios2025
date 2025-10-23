# Tema: Funciones SQL
## Alejandro Daniel Aguilar Hernández
## Matricula: 22301621
## Materia: Inteligencia de Negocios
## Fecha: 09-10-2025
---

# Funciones de cadenas en SQL

- Las **funciones de cadenas** en SQL permiten **manipular y trabajar con texto** (cadenas de caracteres) dentro de una base de datos.

- Estas funciones se utilizan para **modificar, analizar o extraer información** de los textos almacenados en columnas tipo `CHAR`, `VARCHAR` o similares.

- En términos teóricos, estas funciones permiten realizar operaciones como **concatenar**, **convertir texto a mayúsculas o minúsculas**, **obtener la longitud** o **extraer subcadenas**, facilitando el tratamiento y análisis de información textual en las consultas SQL.

## Sintaxis
```sql
SELECT LEN('Texto');

SELECT CHAR_LENGTH('Texto');

SELECT UPPER('texto');

SELECT LOWER('TEXTO');

SELECT SUBSTRING('Programar', 1, 4);

SELECT CONCAT('Hola', ' ', 'Mundo');

SELECT TRIM('   Hola   ');

SELECT LTRIM('   Hola');

SELECT RTRIM('Hola   ');

SELECT REPLACE('Base de datos', 'datos', 'información');

SELECT REVERSE('SQL');

SELECT LEFT('Programar', 4);

SELECT RIGHT('Programar', 3);

SELECT POSITION('a' IN 'Programar');

SELECT REPEAT('SQL', 3);
```

## Ejemplos y tabla de resultados

| **Función** | **Descripción** | **Ejemplo** | **Resultado** |
|--------------|----------------|--------------|----------------|
| `LEN` | Devuelve la longitud del texto | `LEN('Hola')` | `4` |
| `UPPER` | Convierte el texto a mayúsculas | `UPPER('hola')` | `HOLA` |
| `LOWER` | Convierte el texto a minúsculas | `LOWER('SQL')` | `sql` |
| `SUBSTRING` | Extrae una parte de la cadena desde una posición específica | `SUBSTRING('Programar', 1, 4)` | `Prog` |
| `CONCAT` | Une dos o más cadenas de texto | `CONCAT('Hola', ' ', 'Mundo')` | `Hola Mundo` |
| `TRIM` | Elimina los espacios en blanco al inicio y final del texto | `TRIM('  Hola  ')` | `Hola` |
| `LTRIM` | Elimina los espacios del lado izquierdo | `LTRIM('  Hola')` | `Hola` |
| `RTRIM` | Elimina los espacios del lado derecho | `RTRIM('Hola  ')` | `Hola` |
| `REPLACE` | Reemplaza un carácter o texto dentro de la cadena | `REPLACE('SQL', 'S', 'P')` | `PQL` |
| `REVERSE` | Invierte el orden de los caracteres | `REVERSE('Hola')` | `aloH` |
| `LEFT` | Devuelve los primeros caracteres especificados | `LEFT('Programar', 4)` | `Prog` |
| `RIGHT` | Devuelve los últimos caracteres especificados | `RIGHT('Programar', 3)` | `mar` |
| `CHARINDEX` | Devuelve la posición de la primera aparición de un carácter | `CHARINDEX('a', 'Programar')` | `6` |
| `REPLICATE` | Repite una cadena un número de veces | `REPLICATE('SQL', 3)` | `SQLSQLSQL` |

**Nota:**  
Algunas funciones pueden variar según el sistema gestor de base de datos (por ejemplo, `CHARINDEX` en SQL Server o `INSTR` en Oracle).

## En resumen
Las funciones de cadenas son muy útiles para **transformar, limpiar y analizar datos textuales** directamente desde las consultas SQL.

---

# Funciones de fechas en SQL

- Las **funciones de fechas** en SQL se utilizan para **manipular, comparar y formatear valores de tipo fecha y hora** dentro de una base de datos.

- Estas funciones permiten **realizar cálculos temporales**, como obtener la fecha actual, sumar o restar días, extraer partes específicas de una fecha o calcular diferencias entre fechas.

## Sintaxis
```sql
SELECT GETDATE();

SELECT SYSDATETIME();

SELECT CURRENT_TIMESTAMP;

SELECT DATEADD(DAY, 5, GETDATE());

SELECT DATEDIFF(DAY, '2025-01-01', GETDATE());

SELECT DATEPART(YEAR, GETDATE());

SELECT DATENAME(MONTH, GETDATE());

SELECT EOMONTH(GETDATE());

SELECT GETUTCDATE();

SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-06:00');
```

## Ejemplos y tabla de resultados

| **Función** | **Descripción** | **Ejemplo** | **Resultado** |
|--------------|----------------|--------------|----------------|
| `GETDATE()` | Devuelve la fecha y hora actual del sistema | `SELECT GETDATE();` | `2025-10-09 18:45:00.000` |
| `SYSDATETIME()` | Devuelve la fecha y hora actual con mayor precisión | `SELECT SYSDATETIME();` | `2025-10-09 18:45:00.1234567` |
| `CURRENT_TIMESTAMP` | Devuelve la fecha y hora actual (igual que `GETDATE()`) | `SELECT CURRENT_TIMESTAMP;` | `2025-10-09 18:45:00.000` |
| `DATEADD(DAY, 5, GETDATE())` | Suma un número de unidades de tiempo a una fecha | `SELECT DATEADD(DAY, 5, GETDATE());` | `2025-10-14 18:45:00.000` |
| `DATEDIFF(DAY, '2025-01-01', GETDATE())` | Calcula la diferencia entre dos fechas | `SELECT DATEDIFF(DAY, '2025-01-01', GETDATE());` | `282` |
| `DATEPART(YEAR, GETDATE())` | Devuelve una parte específica de una fecha (año, mes, día, etc.) | `SELECT DATEPART(YEAR, GETDATE());` | `2025` |
| `DATENAME(MONTH, GETDATE())` | Devuelve el nombre de una parte específica de la fecha | `SELECT DATENAME(MONTH, GETDATE());` | `October` |
| `EOMONTH(GETDATE())` | Devuelve el último día del mes actual | `SELECT EOMONTH(GETDATE());` | `2025-10-31` |
| `GETUTCDATE()` | Devuelve la fecha y hora actual en formato UTC | `SELECT GETUTCDATE();` | `2025-10-09 23:45:00.000` |
| `SWITCHOFFSET(SYSDATETIMEOFFSET(), '-06:00')` | Convierte una fecha y hora a una zona horaria específica | `SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-06:00');` | `2025-10-09 12:45:00.0000000 -06:00` |

## En resumen
Las funciones de fechas permiten **gestionar el tiempo y realizar operaciones temporales** en consultas SQL, siendo muy útiles para reportes, cálculos de antigüedad o programación de eventos.

---

# Control de valores nulos en SQL

- El **control de valores nulos** en SQL permite **gestionar los datos que no tienen un valor definido** dentro de una tabla. 

- Un valor `NULL` indica la **ausencia de información** (no es cero, ni una cadena vacía, ni “ningún valor”), por lo que necesita un tratamiento especial en las consultas.

- Estas funciones permiten **verificar, reemplazar o tratar valores nulos** para evitar errores o resultados incorrectos en las consultas, comparaciones y cálculos dentro de la base de datos.

## Sintaxis
```sql
-- IS NULL
-- Verifica si un valor es nulo.
-- Devuelve TRUE si la expresión es NULL.
SELECT 
    CASE 
        WHEN columna IS NULL THEN 'Sí es nulo' 
        ELSE 'No es nulo' 
    END AS Resultado
FROM tabla;

-- Ejemplo directo sin tabla:
SELECT CASE WHEN NULL IS NULL THEN 'Sí es nulo' ELSE 'No es nulo' END;

------------------------------------------------------------

-- IS NOT NULL
-- Verifica si un valor NO es nulo.
-- Devuelve TRUE si la expresión tiene un valor.
SELECT 
    CASE 
        WHEN columna IS NOT NULL THEN 'Tiene valor' 
        ELSE 'Sin valor' 
    END AS Resultado
FROM tabla;

-- Ejemplo directo:
SELECT CASE WHEN 'Texto' IS NOT NULL THEN 'Tiene valor' ELSE 'Sin valor' END;

------------------------------------------------------------

-- Sintaxis general:
-- ISNULL(expresión, valor_reemplazo)
SELECT ISNULL(columna, 'Sin dato') AS Resultado
FROM tabla;

-- Ejemplo directo:
SELECT ISNULL(NULL, 'Desconocido') AS Resultado;

------------------------------------------------------------

-- Sintaxis general:
-- COALESCE(valor1, valor2, ...)
SELECT COALESCE(NULL, columna, 'Valor por defecto') AS Resultado
FROM tabla;

-- Ejemplo directo:
SELECT COALESCE(NULL, NULL, 'Disponible') AS Resultado;

------------------------------------------------------------

-- Sintaxis general:
-- NULLIF(valor1, valor2)
SELECT NULLIF(columna1, columna2) AS Resultado
FROM tabla;

-- Ejemplo directo:
SELECT NULLIF(10, 10) AS Resultado;  -- Devuelve NULL
SELECT NULLIF(10, 20) AS Resultado;  -- Devuelve 10
```

## Ejemplos y tabla de resultados

| **Función** | **Descripción** | **Ejemplo** | **Resultado** |
|--------------|----------------|--------------|----------------|
| `IS NULL` | Verifica si un valor es nulo | `SELECT CASE WHEN NULL IS NULL THEN 'Sí es nulo' ELSE 'No es nulo' END;` | `Sí es nulo` |
| `IS NOT NULL` | Verifica si un valor no es nulo | `SELECT CASE WHEN 'Dato' IS NOT NULL THEN 'Tiene valor' ELSE 'Sin valor' END;` | `Tiene valor` |
| `ISNULL(expresión, valor)` | Sustituye un valor nulo por otro valor especificado | `SELECT ISNULL(NULL, 'Desconocido');` | `Desconocido` |
| `COALESCE(valor1, valor2, ...)` | Devuelve el primer valor no nulo de una lista | `SELECT COALESCE(NULL, NULL, 'Disponible');` | `Disponible` |
| `NULLIF(valor1, valor2)` | Devuelve NULL si ambos valores son iguales | `SELECT NULLIF(10, 10);` | `NULL` |

## En resumen
El control de valores nulos es esencial para **evitar errores y resultados incompletos** en consultas SQL, garantizando que los datos faltantes sean tratados correctamente.

---

# Uso de MERGE en SQL

- La instrucción **MERGE** en SQL se utiliza para **sincronizar dos tablas** (una fuente y una destino), permitiendo **insertar, actualizar o eliminar registros** en una sola sentencia según las coincidencias entre ambas.

- Es muy útil para **mantener actualizados los datos** entre tablas, como cuando se cargan datos nuevos en una tabla maestra desde otra tabla temporal o de respaldo.

- En términos teóricos, su objetivo es **mantener actualizada una tabla destino** con los cambios de otra tabla, evitando duplicidad de datos y mejorando la eficiencia en procesos de integración o carga masiva de información.

## Sintaxis general

```sql
MERGE INTO tabla_destino AS destino
USING tabla_fuente AS fuente
ON destino.campo_clave = fuente.campo_clave

-- Cuando las filas coinciden (ya existen en la tabla destino)
WHEN MATCHED THEN
    UPDATE SET 
        destino.columna1 = fuente.columna1,
        destino.columna2 = fuente.columna2

-- Cuando las filas no coinciden (no existen en la tabla destino)
WHEN NOT MATCHED BY TARGET THEN
    INSERT (columna1, columna2, columna3)
    VALUES (fuente.columna1, fuente.columna2, fuente.columna3)

-- Cuando las filas existen en destino pero no en la fuente (opcional)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Opcional: mostrar cuántas filas fueron afectadas
OUTPUT 
    $action AS Accion, 
    inserted.*, 
    deleted.*;
```
## Explicación: Partes del comando MERGE en SQL Server

| **Parte** | **Descripción** |
|------------|----------------|
| `MERGE INTO` | Indica la **tabla destino** donde se aplicarán los cambios (inserciones, actualizaciones o eliminaciones). |
| `USING` | Especifica la **tabla fuente** o una **subconsulta** que contiene los nuevos datos que se compararán con la tabla destino. |
| `ON` | Define la **condición de coincidencia** entre los registros de ambas tablas (por ejemplo, por una clave primaria o un identificador único). |
| `WHEN MATCHED THEN` | Indica la acción a realizar **cuando los registros coinciden** (normalmente una actualización con `UPDATE`). |
| `WHEN NOT MATCHED BY TARGET THEN` | Indica la acción a realizar **cuando no hay coincidencia en la tabla destino** (normalmente una inserción con `INSERT`). |
| `WHEN NOT MATCHED BY SOURCE THEN` | Indica la acción a realizar **cuando un registro existe en la tabla destino pero no en la fuente** (normalmente una eliminación con `DELETE`). |
| `OUTPUT` | (Opcional) Muestra información sobre las operaciones realizadas, como qué filas fueron insertadas, actualizadas o eliminadas. |
| `END` | Marca el final de la instrucción `MERGE`. |

## Ejemplo 1
```sql
-- EJEMPLO 1: MERGE CON TABLAS REALES

-- Si ya existen las tablas, se eliminan
DROP TABLE IF EXISTS Empleados;
DROP TABLE IF EXISTS NuevosEmpleados;

-- Crear tabla destino
CREATE TABLE Empleados (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Salario DECIMAL(10,2)
);

-- Crear tabla fuente
CREATE TABLE NuevosEmpleados (
    ID INT,
    Nombre NVARCHAR(50),
    Salario DECIMAL(10,2)
);

-- Insertar datos de ejemplo
INSERT INTO Empleados VALUES 
(1, 'Carlos', 5000),
(2, 'Ana', 6000),
(3, 'Pedro', 4500);

INSERT INTO NuevosEmpleados VALUES 
(2, 'Ana', 6500),    -- Ana será actualizada
(3, 'Pedro', 4500),  -- Pedro sin cambios
(4, 'Laura', 5200);  -- Laura será agregada

-- Ejecutar MERGE
MERGE INTO Empleados AS e
USING NuevosEmpleados AS n
ON e.ID = n.ID

WHEN MATCHED THEN
    UPDATE SET e.Salario = n.Salario

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ID, Nombre, Salario)
    VALUES (n.ID, n.Nombre, n.Salario)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Ver resultado final
SELECT * FROM Empleados;
```
## Tabla de resultados
| **ID** | **Nombre** | **Salario** |
|--------|-------------|-------------|
| 2 | Ana | 6500 |
| 3 | Pedro | 4500 |
| 4 | Laura | 5200 |

**En resumen:**  
La sentencia `MERGE` evalúa los datos de una tabla fuente contra una tabla destino y, según la coincidencia, **actualiza, inserta o elimina** registros en una sola instrucción SQL.

---

# Uso de CASE en SQL

- La instrucción **CASE** en SQL se utiliza para **evaluar condiciones y devolver un valor específico según el resultado**, similar a una estructura condicional `if...else`. 

- Permite realizar **comparaciones lógicas dentro de una consulta**, facilitando la creación de **columnas calculadas, clasificaciones o transformaciones de datos** directamente desde una sentencia `SELECT`, `UPDATE` o `ORDER BY`.

## Sintaxis
```sql
-- 1. CASE en SELECT
SELECT 
    Nombre,
    CASE 
        WHEN Edad < 18 THEN 'Menor de edad'
        WHEN Edad BETWEEN 18 AND 64 THEN 'Adulto'
        ELSE 'Adulto mayor'
    END AS Categoria
FROM Personas;
----------------------------------------------------------------------

-- 2. CASE en UPDATE
UPDATE Empleados
SET Bonificacion = 
    CASE 
        WHEN Desempeño = 'Excelente' THEN 1000
        WHEN Desempeño = 'Bueno' THEN 500
        ELSE 200
    END;
----------------------------------------------------------------------

-- 3. CASE en DELETE
DELETE FROM Clientes
WHERE 
    CASE 
        WHEN Activo = 0 THEN 1
        ELSE 0
    END = 1;
----------------------------------------------------------------------

-- 4. CASE en ORDER BY
SELECT Nombre, Departamento, Salario
FROM Empleados
ORDER BY 
    CASE 
        WHEN Departamento = 'Ventas' THEN 1
        WHEN Departamento = 'TI' THEN 2
        ELSE 3
    END;
----------------------------------------------------------------------

-- 5. CASE en GROUP BY
SELECT 
    CASE 
        WHEN Edad < 18 THEN 'Menores'
        WHEN Edad BETWEEN 18 AND 59 THEN 'Adultos'
        ELSE 'Adultos Mayores'
    END AS GrupoEdad,
    COUNT(*) AS Total
FROM Personas
GROUP BY 
    CASE 
        WHEN Edad < 18 THEN 'Menores'
        WHEN Edad BETWEEN 18 AND 59 THEN 'Adultos'
        ELSE 'Adultos Mayores'
    END;
```
## Explicación de ejemplos del comando CASE

| **Ejemplo** | **Sentencia SQL** | **Descripción / Explicación** |
|--------------|------------------|-------------------------------|
| CASE en `SELECT` | `SELECT ... CASE ... END AS Categoria` | Evalúa la columna `Edad` y clasifica cada registro como *Menor de edad*, *Adulto* o *Adulto mayor*. Se utiliza para crear una columna calculada según condiciones. |
| CASE en `UPDATE` | `UPDATE ... SET columna = CASE ... END` | Modifica la columna `Bonificacion` según el valor del campo `Desempeño`. Asigna diferentes montos según el rendimiento del empleado. |
| CASE en `DELETE` | `DELETE FROM ... WHERE CASE ... END = 1` | Elimina registros cuando el campo `Activo` es igual a 0. El `CASE` se usa para determinar si se cumple la condición de eliminación. |
| CASE en `ORDER BY` | `ORDER BY CASE ... END` | Ordena los resultados en un orden lógico definido por el usuario: primero *Ventas*, luego *TI* y después otros departamentos. Permite personalizar el orden de los datos. |
| CASE en `GROUP BY` | `GROUP BY CASE ... END` | Agrupa los registros según rangos de edad (por ejemplo: *Menores*, *Adultos*, *Adultos Mayores*). Se usa para crear categorías de agrupación en consultas con funciones agregadas. |

## Ejemplos
### Ejemplo 1
```sql
-- CASE en SELECT
-- Crear tabla de ejemplo
DROP TABLE IF EXISTS Personas;
CREATE TABLE Personas (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Edad INT
);

-- Insertar datos
INSERT INTO Personas VALUES 
(1, 'Luis', 15),
(2, 'Ana', 25),
(3, 'Pedro', 68);

-- Usar CASE en SELECT
SELECT 
    Nombre,
    Edad,
    CASE 
        WHEN Edad < 18 THEN 'Menor de edad'
        WHEN Edad BETWEEN 18 AND 64 THEN 'Adulto'
        ELSE 'Adulto mayor'
    END AS Categoria
FROM Personas;
```
## Tabla de resultados
| **Nombre** | **Edad** | **Categoria**     |
|-------------|-----------|------------------|
| Luis        | 15        | Menor de edad    |
| Ana         | 25        | Adulto           |
| Pedro       | 68        | Adulto mayor     |

### Ejemplo 2
```sql
-- CASE en UPDATE
-- Crear tabla
DROP TABLE IF EXISTS Empleados;
CREATE TABLE Empleados (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Desempeño NVARCHAR(20),
    Bonificacion INT
);

-- Insertar datos
INSERT INTO Empleados VALUES 
(1, 'Carlos', 'Excelente', 0),
(2, 'Ana', 'Bueno', 0),
(3, 'Pedro', 'Regular', 0);

-- Actualizar usando CASE
UPDATE Empleados
SET Bonificacion = 
    CASE 
        WHEN Desempeño = 'Excelente' THEN 1000
        WHEN Desempeño = 'Bueno' THEN 500
        ELSE 200
    END;

-- Ver resultado
SELECT * FROM Empleados;
```
## Tabla de resultados
| **ID** | **Nombre** | **Desempeño** | **Bonificacion** |
|---------|-------------|----------------|------------------|
| 1 | Carlos | Excelente | 1000 |
| 2 | Ana | Bueno | 500 |
| 3 | Pedro | Regular | 200 |

### Ejemplo 3
```sql
-- CASE en DELETE
-- Crear tabla
DROP TABLE IF EXISTS Clientes;
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Activo BIT
);

-- Insertar datos
INSERT INTO Clientes VALUES 
(1, 'Luis', 1),
(2, 'Ana', 0),
(3, 'Pedro', 1);

-- Eliminar registros inactivos
DELETE FROM Clientes
WHERE 
    CASE 
        WHEN Activo = 0 THEN 1
        ELSE 0
    END = 1;

-- Ver registros restantes
SELECT * FROM Clientes;
```
## Tabla de resultados
| **ID** | **Nombre** | **Activo** |
|---------|-------------|------------|
| 1 | Luis | 1 |
| 3 | Pedro | 1 |

### Ejemplo 4
```sql
-- CASE en ORDER BY
-- Crear tabla
DROP TABLE IF EXISTS EmpleadosOrden;
CREATE TABLE EmpleadosOrden (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Departamento NVARCHAR(20)
);

-- Insertar datos
INSERT INTO EmpleadosOrden VALUES
(1, 'Luis', 'TI'),
(2, 'Ana', 'Ventas'),
(3, 'Pedro', 'Recursos Humanos');

-- Ordenar con CASE
SELECT Nombre, Departamento
FROM EmpleadosOrden
ORDER BY 
    CASE 
        WHEN Departamento = 'Ventas' THEN 1
        WHEN Departamento = 'TI' THEN 2
        ELSE 3
    END;
```
## Tabla de resultados
| **Nombre** | **Departamento**     |
|-------------|---------------------|
| Ana         | Ventas              |
| Luis        | TI                  |
| Pedro       | Recursos Humanos    |

### Ejemplo 5
```sql
-- CASE en GROUP BY
-- Crear tabla
DROP TABLE IF EXISTS PersonasGrupo;
CREATE TABLE PersonasGrupo (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Edad INT
);

-- Insertar datos
INSERT INTO PersonasGrupo VALUES
(1, 'Luis', 15),
(2, 'Ana', 22),
(3, 'Pedro', 40),
(4, 'Laura', 70);

-- Agrupar usando CASE
SELECT 
    CASE 
        WHEN Edad < 18 THEN 'Menores'
        WHEN Edad BETWEEN 18 AND 59 THEN 'Adultos'
        ELSE 'Adultos Mayores'
    END AS GrupoEdad,
    COUNT(*) AS Total
FROM PersonasGrupo
GROUP BY 
    CASE 
        WHEN Edad < 18 THEN 'Menores'
        WHEN Edad BETWEEN 18 AND 59 THEN 'Adultos'
        ELSE 'Adultos Mayores'
    END;
```
## Tabla de resultados
| **GrupoEdad**      | **Total** |
|--------------------|-----------|
| Menores            | 1 |
| Adultos            | 2 |
| Adultos Mayores    | 1 |

**En resumen:**  
El comando `CASE` permite incluir **decisiones condicionales** dentro de una sentencia SQL, devolviendo diferentes resultados según las condiciones especificadas.