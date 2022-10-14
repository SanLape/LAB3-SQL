
CREATE DATABASE Actividad1_1
GO

USE Actividad1_1
GO

CREATE TABLE Alumnos(
    Legajo SMALLINT NOT NULL PRIMARY KEY IDENTITY (1000,1),
    IDCarrera VARCHAR (4) NOT NULL,
    Apellido VARCHAR (50) NOT NULL,
    Nombre VARCHAR (50) NOT NULL,
    FechaNac DATE NOT NULL CHECK (FechaNac <= getdate()), -- GETDATE() DEVUELVE LA FEHCA DEL SISTEMA 
    Mail VARCHAR (150) NOT NULL UNIQUE,
    Telefono VARCHAR (15) NULL
)
GO

CREATE TABLE Carreras (
    ID VARCHAR (4) PRIMARY KEY,
    Nombre VARCHAR(50),
    FechaCreacion DATE NOT NULL CHECK (FechaCreacion <= getdate()),
    Mail VARCHAR (150) NOT NULL,
    Nivel VARCHAR (50)
)
GO

ALTER TABLE Alumnos                                         -- LA TABLA Q SE MODIFICA 
ADD CONSTRAINT FK_Alumnos_Carrera FOREIGN KEY (IDCarrera)   -- AGREGA UN RESTRICCION - "NOMBRE" - TIPO FK - ("COLUMNA Q SE AFECTA")
REFERENCES Carreras (ID)                                    -- REFERENCIADA A LA TABLA "CARRERAS" Y LA ("COLUMNA") ==> PARA ESTABLECER LA FK

GO

CREATE TABLE Materias (
    ID SMALLINT PRIMARY KEY IDENTITY (1,1),
    IDCarrera VARCHAR (4) FOREIGN KEY REFERENCES Carreras (ID),
    Nombre VARCHAR (50) NOT NULL,
    CargaHoraria SMALLINT NOT NULL CHECK(CargaHoraria > 0)
)



