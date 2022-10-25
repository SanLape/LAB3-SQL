USE MASTER 
GO

USE Actividad1_3
GO

-- MODIFICACION DE BSAE (ACTIVIDAD 1.3)

-- La posibilidad de indicar por cada pedido cuáles son los colaboradores que han
-- trabajado. Para ello se debe poder registrar qué colaborador trabajó en cada pedido,
-- qué tarea realizó o realizará y el tiempo que le llevó la tarea en minutos. En caso de
-- que se le haya asignado la tarea pero que aún no se encuentre finalizada, no se debe
-- completar este dato. 

CREATE TABLE Trabajdor_Pedido(
    IDPedido BIGINT NOT NULL FOREIGN KEY REFERENCES Pedido (ID),
    IDLegajo INT NOT NULL FOREIGN KEY REFERENCES Colaborador (Legajo),
    IDTarea INT NOT NULL,
    Horas INT NULL
)
GO

-- Las tareas realizadas por los colaboradores en los muebles están definidas. Por
-- ejemplo, trozado, lijado, cepillado, listoneado, pintura, barnizado, etc. Al dueño de la
-- fábrica le interesaría poder elegir de una lista las tareas y no tener que escribirlas
-- cada vez.

CREATE TABLE Tarea(
    ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR (50) NOT NULL
)
GO

ALTER TABLE Trabajdor_Pedido
ADD CONSTRAINT FK_PEDIDO_TAREA FOREIGN KEY (IDTarea)
REFERENCES Tarea (ID)
GO

-- Algunos pedidos pueden ser enviados a domicilio. Para realizar un envío de un
-- pedido es necesario conocer cuál es el cliente al que debe realizarse el envío, la
-- dirección de envío (incluyendo la localidad) y el rango horario del envío y la fecha del
-- envío. También debe poder registrarse si el envío fue entregado no. Algunos envíos
-- se cobran y otros están bonificados. Se debe poder registrar esta información.

CREATE TABLE Envio (
    ID BIGINT NOT NULL PRIMARY KEY,
    IDPedido BIGINT NOT NULL FOREIGN KEY REFERENCES Pedido (ID),
    IDCliente INT NOT NULL FOREIGN KEY REFERENCES Cliente (ID),
    Dia DATE NOT NULL,
    InicioEntrega TIME NOT NULL,
    FinEntrega TIME NOT NULL,
    Entregado BIT NOT NULL,
    Bonificado BIT NOT NULL,
    Cobrado BIT NOT NULL,
    Costo MONEY NOT NULL,
    CHECK (InicioEntrega < FinEntrega)
)
GO

-- La mueblería hace un solo intento por realizar el envío por lo que no admite múltiples
-- envíos por pedido.

-- Los productos pueden o no registrar un material de manufactura. Por ejemplo, un
-- "Escritorio de PC Deluxe" puede estar compuesto por los materiales Roble y Hierro.
-- Otros materiales de manufactura pueden ser Plástico, Plata, Oro, Pino, etc.

CREATE TABLE Material (
    ID INT NOT NULL PRIMARY KEY,
    Detalle VARCHAR (100) NOT NULL
)
GO

CREATE TABLE Materiales_Producto (
    IDProducto INT NOT NULL FOREIGN KEY REFERENCES Producto (ID),
    IDMaterial INT NOT NULL FOREIGN KEY REFERENCES Material (ID)
)
GO

-- Algunos pedidos requieren el pago de un adelanto para poder registrarlos. Otros
-- admiten que el cliente vaya realizando pagos hasta completar el total y otros deben
-- ser pagados en un solo pago. De la misma manera, es posible que ciertos clientes
-- puedan retirar o recibir el pedido aunque no haya completado los pagos y otros
-- deban pagar la totalidad del pedido para poder recibir o retirar el mueble. Se solicita
-- que la base de datos tenga la capacidad de poder registrar todos los pagos que va
-- realizando el cliente a cada pedido.
-- Debe poder conocerse, el pedido, el importe del
-- pago, la fecha del pago, quien es el cliente que está pagando y si cumplió o no la
-- totalidad del importe del pedido. Luego de recibir un pago, la mueblería otorgaría un
-- recibo con un número identificatorio del pago.

CREATE TABLE Pago (
    ID BIGINT NOT NULL PRIMARY KEY IDENTITY (1,1),
    IDPedido BIGINT NOT NULL FOREIGN KEY REFERENCES Pedido (ID),
    Fecha DATETIME NOT NULL, 
    IDCliente INT NOT NULL FOREIGN KEY REFERENCES Cliente (ID),
    Importe MONEY NOT NULL,
    PagoParcial BIT NOT NULL
)
GO
