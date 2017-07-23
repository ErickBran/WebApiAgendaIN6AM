CREATE DATABASE Agenda;
USE Agenda;

CREATE TABLE Cita(
	idCita INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    lugar VARCHAR(100) NOT NULL,
    fecha VARCHAR(50) NOT NULL,
    idContacto INT NOT NULL,
    PRIMARY KEY(idCita),
    FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY(idContacto) REFERENCES Contacto(idContacto)
);

CREATE TABLE Tarea(
	idTarea INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    fechaInicial VARCHAR(50) NOT NULL,
    fechaFinal VARCHAR(50) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    PRIMARY KEY (idTarea),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
);


CREATE TABLE Categoria(
	idCategoria INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR (30) NOT NULL,
    PRIMARY KEY (idCategoria)
);
CREATE TABLE Usuario(
	idUsuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR (30) NOT NULL,
    contrasena VARCHAR (30) NOT NULL,
    PRIMARY KEY (idUsuario)
);

CREATE TABLE Contacto(
	idContacto INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    nombre VARCHAR (30) NOT NULL,
    apellido VARCHAR (30) NOT NULL,
    direccion VARCHAR (30) NOT NULL,
    telefono VARCHAR (12) NOT NULL,
    idCategoria INT NOT NULL,
    PRIMARY KEY (idContacto),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario),
    FOREIGN KEY (idCategoria) REFERENCES Categoria (idCategoria)
);



CREATE TABLE DetalleUsuario(
	idDetalle INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idContacto INT NOT NULL,
    PRIMARY KEY (idDetalle),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario),
    FOREIGN KEY (idContacto) REFERENCES Contacto (idContacto)
);

CREATE TABLE Historial(
	idHistorial INT NOT NULL AUTO_INCREMENT,
    Accion VARCHAR(100) NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    idUsuario INT NOT NULL,
    PRIMARY KEY (idHistorial),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
);



SELECT * FROM Historial;
SELECT * FROM Usuario;

SELECT ud.idDetalle, c.nombre, c.apellido, c.direccion, c.telefono, 
	a.nombre, a.contrasena, b.nombre FROM DetalleUsuario ud
INNER JOIN Contacto c ON ud.idContacto = c.idContacto
INNER JOIN Usuario a ON ud.idUsuario = a.idUsuario
INNER JOIN Categoria b ON c.idCategoria = b.idCategoria;

/*CITA*/
DELIMITER $$
CREATE PROCEDURE selectCita(
  IN _idUsuario INT)
BEGIN
   SELECT * FROM Cita WHERE idUsuario = _idUsuario;
END$$

CALL selectCita(1)

DELIMITER $$
CREATE PROCEDURE addCita(
  IN _idUsuario INT,
  IN _lugar VARCHAR(100),
  IN _fecha VARCHAR(50),
  IN _idContacto VARCHAR (50))
BEGIN
   INSERT INTO Cita (idUsuario, lugar, fecha, idContacto) VALUES(_idUsuario, _lugar, _fecha, _idContacto);
END$$

CALL addCita(1, 'Mi casa2', '2017-05-18', 1);
SELECT * FROM Cita;

DELIMITER $$
CREATE PROCEDURE editCita(
  IN _idCita INT,
  IN _lugar VARCHAR(100),
  IN _fecha VARCHAR(50),
  IN _idContacto VARCHAR (50))
BEGIN
   UPDATE Cita 
   SET lugar = _lugar, fecha = _fecha, idContacto = _idContacto
   WHERE idCita = _idCita;
END$$

CALL editCita(1, 'HELLO', '2017-01-01', 1);

DELIMITER $$
CREATE PROCEDURE deleteCita(
  IN _idCita INT)
BEGIN
   DELETE FROM Cita 
   WHERE idCita = _idCita;
END$$


/*TAREA*/
DELIMITER $$
CREATE PROCEDURE selectTarea(
  IN _idUsuario INT)
BEGIN
   SELECT * FROM Tarea WHERE idUsuario = _idUsuario;
END$$

DELIMITER $$
CREATE PROCEDURE addTarea(
  IN _idUsuario INT,
  IN _titulo VARCHAR(100),
  IN _descripcion TEXT,
  IN _fechaInicial VARCHAR (50),
  IN _fechaFinal VARCHAR (50),
  IN _estado VARCHAR(100))
BEGIN
   INSERT INTO Tarea (idUsuario, titulo, descripcion, fechaInicial, fechaFinal, estado) VALUES(_idUsuario, _titulo, _descripcion, _fechaInicial, _fechaFinal, _estado);
END$$

CALL addTarea(1, 'Hola', 'Muy buenas a todos guapisimos', '18/08/2017', '20/08/2017', 'Normal');
SELECT * FROM Tarea;

DELIMITER $$
CREATE PROCEDURE editTarea(
  IN _idTarea INT,
  IN _titulo VARCHAR(100),
  IN _descripcion TEXT,
  IN _fechaInicial VARCHAR (50),
  IN _fechaFinal VARCHAR (50),
  IN _estado VARCHAR(100))
BEGIN
   UPDATE Trea 
   SET titulo = _titulo, descripcion = _descripcion, fechaInicial = _fechaInicial, fechaFinal = _fechaFinal, estado = _estado
   WHERE idTarea = _idTarea;
END$$

CALL editTarea(2, 'HELLO', 'Muy buenas a todos guapisimos', '18/08/2017', '20/08/2017', 'Normal');

DELIMITER $$
CREATE PROCEDURE deleteTarea(
  IN _idTarea INT)
BEGIN
   DELETE FROM Tarea 
   WHERE idTarea = _idTarea;
END$$

/*USUARIOS */
DELIMITER $$
CREATE PROCEDURE perfilUsuario(
  IN _idUsuario INT)
BEGIN
   SELECT * FROM Usuario 
   WHERE idUsuario = _idUsuario;
END$$

CALL perfilUsuario(1);

DELIMITER $$
CREATE PROCEDURE getUsuario(
  IN _nombre VARCHAR(30),
  IN _contrasena VARCHAR(30))
BEGIN
   SELECT * FROM Usuario WHERE nombre = _nombre AND contrasena = _contrasena;
END$$


DELIMITER $$
CREATE PROCEDURE addUsuario(
  IN _nombre VARCHAR(30),
  IN _contrasena VARCHAR(30))
BEGIN
   INSERT INTO Usuario (nombre, contrasena) VALUES(_nombre, _contrasena);
END$$


DELIMITER $$
CREATE PROCEDURE editUsuario(
  IN _idUsuario INT,
  IN _nombre VARCHAR(30),
  IN _contrasena VARCHAR(30))
BEGIN
   UPDATE Usuario 
   SET nombre = _nombre, contrasena = _contrasena
   WHERE idUsuario = _idUsuario;
END$$

DELIMITER $$
CREATE PROCEDURE deleteUsuario(
  IN _idUsuario INT)
BEGIN
   DELETE FROM Usuario 
   WHERE idUsuario = _idUsuario;
END$$

CALL getUsuario('pato', 'll');
CALL addUsuario('patoMomo', '1234');
CALL editUsuario(3,'patoMomos', '1234');
CALL deleteUsuario(3);
SELECT * FROM Usuario;
/*CATEGORIA */
DELIMITER $$
CREATE PROCEDURE addCategoria(
  IN _nombre VARCHAR(30))
BEGIN
   INSERT INTO Categoria (nombre) VALUES(_nombre);
END$$

CALL addCategoria('Prueba');

SELECT * FROM Categoria;

/*Contacto */
DELIMITER $$
CREATE PROCEDURE selectContacto(
  IN _idUsuario INT)
BEGIN
   SELECT * FROM Contacto WHERE idUsuario = _idUsuario;
END$$

CALL selectContacto(1);


DELIMITER $$
CREATE PROCEDURE editCategoria(
  IN _idCategoria INT,
  IN _nombre VARCHAR(30))
BEGIN
   UPDATE Categoria 
   SET nombre = _nombre
   WHERE idCategoria = _idCategoria;
END$$

DELIMITER $$
CREATE PROCEDURE addContacto(
  IN _idUsuario INT,
  IN _nombre VARCHAR(30),
  IN _apellido VARCHAR (30),
  IN _direccion VARCHAR (30),
  IN _telefono VARCHAR (12),
  IN _idCategoria INT)
BEGIN
   INSERT INTO Contacto (idUsuario, nombre, apellido, direccion, telefono, idCategoria) VALUES(_idUsuario, _nombre, _apellido, _direccion, _telefono, _idCategoria);
END$$

DELIMITER $$
CREATE PROCEDURE editContacto(
  IN _idContacto INT,
  IN _nombre VARCHAR(30),
  IN _apellido VARCHAR (30),
  IN _direccion VARCHAR (30),
  IN _telefono VARCHAR (12),
  IN _idCategoria INT)
BEGIN
   UPDATE Contacto 
   SET nombre = _nombre, apellido = _apellido, direccion = _direccion, telefono = _telefono, idCategoria = _idCategoria
   WHERE idContacto = _idContacto;
END$$

DELIMITER $$
CREATE PROCEDURE deleteContacto(
  IN _idContacto INT)
BEGIN
   DELETE FROM Contacto 
   WHERE idContacto = _idContacto;
END$$

CALL addContacto(1,'prueba', 'prueba', 'en su casa', '12345678', 1);
CALL editContacto(1,'patoMomos', 'prueba', 'en su casa','12345678', 1);
CALL deleteContacto(2);
SELECT * FROM Contacto;

/*DETALLE USUARIO */
DELIMITER $$
CREATE PROCEDURE addDetalleUsuario(
  IN _idUsuario INT,
  IN _idContacto INT)
BEGIN
   INSERT INTO DetalleUsuario (idUsuario, idContacto) VALUES(_idUsuario, _idContacto);
END$$


DELIMITER $$
CREATE PROCEDURE deleteDetalleUsuario(
  IN _idDetalleUsuario INT)
BEGIN
   DELETE FROM DetalleUsuario 
   WHERE idDetalle = _idDetalleUsuario;
END$$

CALL addDetalleUsuario(1,1);
CALL deleteDetalleUsuario(2);
SELECT * FROM DetalleUsuario;

CREATE PROCEDURE addContacto(   IN _idUsuario INT,   IN _nombre VARCHAR(30),   IN _apellido VARCHAR (30),   IN _direccion VARCHAR (30),   IN _telefono VARCHAR (12),   IN _correo VARCHAR (40),   IN _idCategoria INT) BEGIN    INSERT INTO Contacto (idUsuario ,nombre, apellido, direccion, telefono, correo, idCategoria) VALUES(_idUsuario ,_nombre, _apellido, _direccion, _telefono, _correo, _idCategoria)
