-- Actividad 2.1
-- # Consulta
-- 1 Apellido, nombres y fecha de ingreso de todos los colaboradores

SELECT Apellidos, Nombres, AñoIngreso from Colaboradores

-- 2 Apellido, nombres y antigüedad de todos los colaboradores

SELECT Apellidos, Nombres, YEAR(GETDATE()) - AñoIngreso AS 'ANTIGUEDAD' FROM Colaboradores 

-- 3 Apellido y nombres de aquellos colaboradores que trabajen part-time.

SELECT Apellidos, Nombres 
FROM COLABORADORES 
WHERE ModalidadTrabajo = 'P'

-- 4 Apellido y nombres, antigüedad y modalidad de trabajo de aquellos colaboradores
-- cuyo sueldo sea entre 50000 y 100000.

SELECT Apellidos, Nombres, YEAR(GETDATE()) - AñoIngreso AS 'ANTIGUEDAD' 
FROM Colaboradores
WHERE Sueldo BETWEEN 50000 AND 100000

-- 5 Apellidos y nombres y edad de los colaboradores con legajos 4, 6, 12 y 25.

SELECT Apellidos, Nombres, DATEDIFF(year, FechaNacimiento, GETDATE()) AS 'EDAD'
FROM colaboradores 
WHERE Legajo like '%4%' or Legajo like '%6%' or Legajo like '%12%' or legajo like '%25%' 

-- 6 Todos los datos de todos los productos ordenados por precio de venta. Del más
-- caro al más barato

SELECT * FROM Productos ORDER BY Costo DESC

-- 7 El nombre del producto más costoso.

SELECT TOP 1 * FROM Productos ORDER BY Costo DESC

-- 8 Todos los datos de todos los pedidos que hayan superado el monto de $20000.

SELECT * FROM Pedidos 
WHERE Costo > 20000

-- 9 Apellido y nombres de los clientes que no hayan registrado teléfono.

SELECT Apellidos, Nombres FROM Clientes
WHERE Telefono IS NOT NULL

-- 10 Apellido y nombres de los clientes que hayan registrado mail pero no teléfono.

SELECT Apellidos, Nombres FROM Clientes
WHERE Mail IS NOT NULL and Telefono IS NULL

-- 11 Apellidos, nombres y datos de contacto de todos los clientes.
-- Nota: En datos de contacto debe figurar el número de celular, si no tiene celular el
-- número de teléfono fijo y si no tiene este último el mail. En caso de no tener ninguno
-- de los tres debe figurar 'Incontactable'.

SELECT Apellidos, Nombres, COALESCE(Celular, Telefono, Mail, 'INCONTACTABLES') AS 'CONTACTO' 
FROM Clientes
WHERE Celular IS NOT NULL
OR Telefono IS NOT NULL
OR Mail IS NOT NULL 

-- 12 Apellidos, nombres y medio de contacto de todos los clientes. Si tiene celular debe
-- figurar 'Celular'. Si no tiene celular pero tiene teléfono fijo debe figurar 'Teléfono fijo'
-- de lo contrario y si tiene Mail debe figurar 'Email'. Si no posee ninguno de los tres
-- debe figurar NULL.

SELECT
    Apellidos, Nombres, 
    CASE 
        WHEN Celular IS NOT NULL THEN 'CELULAR'
        WHEN Telefono IS NOT NULL THEN 'TELEFONO FIJO'
        WHEN Mail IS NOT NULL THEN 'EMAIL'
        ELSE 'NULL'
    END AS CONTACTO
FROM Clientes

-- 13 Todos los datos de los colaboradores que hayan nacido luego del año 2000

SELECT * FROM Colaboradores
WHERE YEAR(FechaNacimiento) > 2000

-- 14 Todos los datos de los colaboradores que hayan nacido entre los meses de Enero y
-- Julio (inclusive)

SELECT * FROM Colaboradores
WHERE DATEPART(MONTH,FechaNacimiento) BETWEEN 1 AND 07

-- 15 Todos los datos de los clientes cuyo apellido finalice con vocal

SELECT * FROM Clientes
WHERE Apellidos LIKE '%[AEIOU]'

-- 16 Todos los datos de los clientes cuyo nombre comience con 'A' y contenga al menos
-- otra 'A'. Por ejemplo, Ana, Anatasia, Aaron, etc

SELECT * FROM Clientes
WHERE Nombres LIKE 'A%%A%'

-- 17 Todos los colaboradores que tengan más de 10 años de antigüedad

SELECT * FROM Colaboradores
WHERE YEAR(GETDATE()) - AñoIngreso > 10

-- 18 Los códigos de producto, sin repetir, que hayan registrado al menos un pedido

SELECT DISTINCT IDProducto FROM Pedidos

-- 19 Todos los datos de todos los productos con su precio aumentado en un 20%

SELECT ID, IDCategoria, Descripcion, DiasConstruccion, Costo, Precio, PrecioVentaMayorista, CantidadMayorista, Estado, Precio * 1.20 AS 'AUMENTO 20%' FROM Productos

-- 20 Todos los datos de todos los colaboradores ordenados por apellido
-- ascendentemente en primera instancia y por nombre descendentemente en segunda
-- instancia.

SELECT * FROM Colaboradores 
ORDER BY Apellidos, Nombres DESC