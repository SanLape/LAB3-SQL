-- Actividad Integradora
-- A partir de la base de datos llamada ActividadIntegradora. Resolver las siguientes consultas:
-- Aclaraciones
-- - Un cliente de tipo particular registra 'P' en el campo Tipo. Mientras que uno de tipo
-- empresa registra 'E'.
-- - Las formas de pago pueden ser 'E' para efectivo, 'B' - Bitcoin, 'T' para tarjeta y 'C' para
-- cheque.
-- - Los servicios con garantía tienen al menos un día de garantía.
-- Resolver:


-- 1) Listado con Apellido y nombres de los técnicos que, en promedio, hayan demorado
-- más de 225 minutos en la prestación de servicios.

SELECT T.Apellido, T.Nombre FROM Tecnicos AS T
LEFT JOIN Servicios AS S ON S.IDTecnico = T.ID
GROUP BY T.ID, T.Apellido, T.Nombre
HAVING AVG(S.Duracion) > 225

-- 2) Listado con Descripción del tipo de servicio, el texto 'Particular' y la cantidad de
-- clientes de tipo Particular. Luego añadirle un listado con descripción del tipo de
-- servicio, el texto 'Empresa' y la cantidad de clientes de tipo Empresa.

SELECT TS.Descripcion, 'PARTICULAR' AS 'TIPO', COUNT (DISTINCT C.ID) AS 'CANTIDAD'
FROM TiposServicio AS TS 
INNER JOIN Servicios AS S ON TS.ID = S.IDTipo
INNER JOIN Clientes AS C ON S.IDCliente = C.ID
WHERE C.Tipo = 'P'
GROUP BY TS.Descripcion
UNION 
SELECT TS.Descripcion, 'EMPRESA' AS 'TIPO', COUNT (DISTINCT C.ID) AS 'CANTIDAD'
FROM TiposServicio AS TS 
INNER JOIN Servicios AS S ON TS.ID = S.IDTipo
INNER JOIN Clientes AS C ON S.IDCliente = C.ID
WHERE C.Tipo = 'E'
GROUP BY TS.Descripcion

-- 3) Listado con Apellidos y nombres de los clientes que hayan abonado con las cuatro
-- formas de pago.

SELECT C.Apellido, C.Nombre
FROM Servicios AS S
INNER JOIN Clientes AS C ON S.IDCliente = C.ID
GROUP BY S.IDCliente, C.Apellido, C.Nombre
HAVING COUNT (DISTINCT S.FormaPago) = 4

-- 4) La descripción del tipo de servicio que en promedio haya brindado mayor cantidad
-- de días de garantía.

SELECT TOP 1 WITH TIES TS.Descripcion 
FROM TiposServicio AS TS 
INNER JOIN Servicios AS S ON TS.ID = S.IDTipo
GROUP BY TS.Descripcion
ORDER BY AVG (S.DiasGarantia*1.0) DESC

-- 5) Agregar las tablas y/o restricciones que considere necesario para permitir a un
-- cliente que contrate a un técnico por un período determinado. Dicha contratación
-- debe poder registrar la fecha de inicio y fin del trabajo, el costo total, el domicilio al
-- que debe el técnico asistir y la periodicidad del trabajo (1 - Diario, 2 - Semanal, 3 -
-- Quincenal).

CREATE TABLE Contratos (
    ID BIGINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    IDCliente INT NOT NULL FOREIGN KEY REFERENCES Clientes (ID),
    IDTecnico INT NOT NULL FOREIGN KEY REFERENCES Tecnicos (ID),
    Inicio DATE NOT NULL, 
    Fin DATE NULL,
    Costo MONEY NULL CHECK (Costo > 0),
    Domicilio VARCHAR (500) NOT NULL,
    Periodicidad TINYINT NOT NULL CHECK (Periodicidad IN ( 1, 2, 3)),
    CHECK (Fin >= Inicio) 
)
