USE Carpinteria
GO

-- 1 La cantidad de colaboradores que nacieron luego del año 1995.

SELECT COUNT(*) FROM Colaboradores
WHERE YEAR(FechaNacimiento) > 1995

-- 2 El costo total de todos los pedidos que figuren como Pagado.

SELECT SUM(Costo) AS 'TOTAL' FROM Pedidos
WHERE Pagado = 1

-- 3 La cantidad total de unidades pedidas del producto con ID igual a 30.

SELECT COUNT(P.IDProducto) AS TOTAL FROM Pedidos AS P
WHERE P.IDProducto = 30

-- 4 La cantidad de clientes distintos que hicieron pedidos en el año 2020.

SELECT COUNT(DISTINCT IDCliente) FROM Pedidos AS P
WHERE YEAR(P.FechaSolicitud) = 2020

-- 5 Por cada material, la cantidad de productos que lo utilizan.

SELECT MxP.IDMaterial, COUNT(DISTINCT IDProducto) AS CANT_PROD FROM Materiales_x_Producto AS MxP
GROUP BY MxP.IDMaterial

-- 6 Para cada producto, listar el nombre y la cantidad de pedidos pagados.

SELECT P.Descripcion, P.ID, COUNT (PED.ID) AS 'PEDIDSO_PAGADOS' FROM Productos AS P
LEFT JOIN Pedidos AS PED ON P.ID = PED.IDProducto
WHERE PED.Pagado = 1
GROUP BY P.Descripcion, P.ID

-- 7 Por cada cliente, listar apellidos y nombres de los clientes y la cantidad de productos
-- distintos que haya pedido.

SELECT C.Apellidos, C.Nombres, COUNT(DISTINCT P.IDProducto) AS 'CANTIDAD_PRODUCTOS' FROM Clientes AS C
LEFT JOIN Pedidos AS P ON C.ID = P.IDCliente
GROUP BY C.Apellidos, C.Nombres

-- 8 Por cada colaborador y tarea que haya realizado, listar apellidos y nombres, nombre
-- de la tarea y la cantidad de veces que haya realizado esa tarea.

SELECT C.Apellidos, C.Nombres, T.Nombre, COUNT (T.ID) AS CANTIDAD FROM Tareas_x_Pedido AS TxP 
    LEFT JOIN Colaboradores AS C ON TxP.Legajo = C.Legajo
    LEFT JOIN Tareas AS T ON TXP.IDTarea = T.ID
GROUP BY C.Apellidos, C.Nombres, T.Nombre ORDER BY C.Apellidos ASC

-- 9 Por cada cliente, listar los apellidos y nombres y el importe individual más caro que
-- hayan abonado en concepto de pago.

SELECT C.ID, C.Apellidos, C.Nombres, MAX(Costo) AS MAXIMO FROM Pedidos AS P
    LEFT JOIN Clientes AS C ON P.IDCliente = C.ID
GROUP BY C.ID, C.Apellidos, C.Nombres
ORDER BY C.Apellidos, C.Nombres

-- 10 Por cada colaborador, apellidos y nombres y la menor cantidad de unidades
-- solicitadas en un pedido individual en el que haya trabajado.

SELECT C.Legajo, C.Apellidos, C.Nombres, MIN(P.Cantidad) FROM Tareas_x_Pedido AS TxP
    LEFT JOIN Pedidos AS P ON TxP.IDPedido = P.ID
    LEFT JOIN Colaboradores AS C ON C.Legajo = TxP.Legajo
GROUP BY C.Legajo, C.Apellidos, C.Nombres 
ORDER BY C.Legajo ASC

-- 11 Listar apellidos y nombres de aquellos clientes que no hayan realizado ningún
-- pedido. Es decir, que contabilicen 0 pedidos.

SELECT C.ID, C.Apellidos + ' ' + C.Nombres AS APNOM, COUNT(P.ID) AS 'CANTIDAD' FROM Clientes AS C 
    LEFT JOIN Pedidos AS P ON P.IDCliente = C.ID
GROUP BY C.ID, C.Apellidos + ' ' + C.Nombres
HAVING COUNT(P.ID) = 0

-- 12 Obtener un listado de productos indicando descripción y precio de aquellos
-- productos que hayan registrado más de 15 pedidos.

SELECT P.Descripcion, P.Costo, COUNT(PED.ID) AS 'CANT_PEDIDOS' FROM Productos AS P
    LEFT JOIN Pedidos AS PED ON P.ID = PED.IDProducto
GROUP BY P.Descripcion, P.Costo
HAVING COUNT (PED.ID) > 15

-- 13 Obtener un listado de productos indicando descripción y nombre de categoría de los
-- productos que tienen un precio promedio de pedidos mayor a $25000.

SELECT PROD.Descripcion, CAT.Nombre, AVG(P.Costo) AS 'PROMEDIO' FROM Pedidos AS P
    LEFT JOIN Productos AS PROD ON P.IDProducto = PROD.ID
    LEFT JOIN Categorias AS CAT ON PROD.IDCategoria = CAT.ID
GROUP BY PROD.Descripcion, CAT.Nombre
HAVING AVG(P.Costo) > 25000
ORDER BY PROD.Descripcion ASC

-- 14 Apellidos y nombres de los clientes que hayan registrado más de 15 pedidos que
-- superen los $15000.

SELECT C.ID, C.Apellidos, C.Nombres, COUNT (P.ID) AS 'CANTIDAD' FROM Pedidos AS P
    LEFT JOIN Clientes AS C ON P.IDCliente = C.ID
GROUP BY C.ID, C.Apellidos, C.Nombres
HAVING SUM(P.Costo) > 15000 AND COUNT (P.ID) > 15 

-- 15 Para cada producto, listar el nombre, el texto 'Pagados' y la cantidad de pedidos
-- pagados. Anexar otro listado con nombre, el texto 'No pagados' y cantidad de
-- pedidos no pagados.

SELECT P.ID, P.Descripcion, 'PAGADO' AS 'ESTADO', COUNT(PED.ID) AS 'CANTIDAD' FROM Productos AS P
    LEFT JOIN Pedidos AS PED ON P.ID = PED.IDProducto
    WHERE PED.Pagado = 1
GROUP BY P.ID, P.Descripcion
UNION
SELECT P.ID, P.Descripcion, 'NO PAGADO' AS 'ESTADO', COUNT(PED.ID) AS 'CANTIDAD' FROM Productos AS P
    LEFT JOIN Pedidos AS PED ON P.ID = PED.IDProducto
    WHERE PED.Pagado = 0
GROUP BY P.ID, P.Descripcion
