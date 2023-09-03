-- CREACION DE LA BASE DE DATOS Y TABLAS

DROP DATABASE IF EXISTS eventos;

CREATE DATABASE eventos;

USE eventos;

-- Drop en orden correcto de las tablas

DROP TABLE IF EXISTS patrocinio;
DROP TABLE IF EXISTS contrato;
DROP TABLE IF EXISTS respuesta_encuesta;
DROP TABLE IF EXISTS encuesta;
DROP TABLE IF EXISTS recursos;
DROP TABLE IF EXISTS servicios_extra;
DROP TABLE IF EXISTS asignacion;
DROP TABLE IF EXISTS invitado;
DROP TABLE IF EXISTS entradas;
DROP TABLE IF EXISTS evento;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS proveedor_producto;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS patrocinador;
DROP TABLE IF EXISTS log_nuevo_invitado;
DROP TABLE IF EXISTS log_modificaciones_evento;


CREATE TABLE evento(
	ID_Evento INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre_Evento VARCHAR(30) NOT NULL
    , Descripcion VARCHAR(200) NULL 
    , Lugar VARCHAR(100) NOT NULL
    , Horario_Inicio TIME
    , Horario_Fin TIME,
    PRIMARY KEY (ID_Evento)
);



CREATE TABLE cliente(
	ID_Cliente INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre VARCHAR(30) NOT NULL
    , Apellido VARCHAR(30) NULL
    , Telefono INT NOT NULL
    , Correo_Electronico VARCHAR(255) NULL,
    PRIMARY KEY (ID_Cliente)
);



CREATE TABLE contrato (
	ID_Contrato INT NOT NULL AUTO_INCREMENT UNIQUE
    , ID_Cliente INT NOT NULL
    , ID_Evento INT NOT NULL
    , Fecha_Inicio DATE NOT NULL
    , Fecha_Finalizacion DATE NOT NULL
    , Pago decimal(10,2) NOT NULL,
    PRIMARY KEY (ID_Contrato),
    FOREIGN KEY (ID_Cliente) REFERENCES cliente (ID_Cliente),
    FOREIGN KEY (ID_Evento) REFERENCES evento (ID_Evento)
);



CREATE TABLE servicios_extra(
	ID_Servicio INT NOT NULL UNIQUE AUTO_INCREMENT
    , ID_Evento INT NOT NULL
    , Nombre_Servicio VARCHAR(50) NULL
    , Descripcion VARCHAR(200) NULL,
    PRIMARY KEY (ID_Servicio),
    FOREIGN KEY (ID_Evento) REFERENCES Evento (ID_Evento)
);



CREATE TABLE invitado(
	ID_Invitado INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre VARCHAR(30) NOT NULL
    , Apellido VARCHAR(30) NOT NULL
    , DNI VARCHAR(12) NOT NULL
    , Edad INT NOT NULL,
    PRIMARY KEY (ID_Invitado)
);



CREATE TABLE entradas(
	ID_Entradas INT NOT NULL UNIQUE AUTO_INCREMENT
    , ID_Evento INT NOT NULL
    , ID_Invitado INT NOT NULL
    , Nombre_Invitado VARCHAR(30) NOT NULL
    , Apellido_Invitado VARCHAR(30) NOT NULL
    , DNI_Invitado VARCHAR(12) NOT NULL 
    , Edad INT NOT NULL
    , Tipo_Entrada VARCHAR(30) NOT NULL 
    , Contraseña_Codigo VARCHAR(30) NULL
    , Precio_Entrada DECIMAL(7,2) NULL,
    PRIMARY KEY (ID_Entradas),
    FOREIGN KEY (ID_Evento) REFERENCES evento (ID_Evento),
    FOREIGN KEY (ID_Invitado) REFERENCES invitado (ID_Invitado)
);



CREATE TABLE empleados(
	ID_Empleados INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre VARCHAR(30) NOT NULL
    , Apellido VARCHAR(30) NOT NULL
    , Correo_Electronico VARCHAR(255) NULL
    , Telefono INT NOT NULL
    , Disponibilidad CHAR(2) NOT NULL,
    PRIMARY KEY (ID_Empleados)
);



CREATE TABLE asignacion(
	ID_Asignacion INT NOT NULL UNIQUE AUTO_INCREMENT
    , ID_Empleados INT NOT NULL
    , ID_Evento INT NOT NULL
    , Rol VARCHAR(40) NOT NULL
    , Inicio_Laboral TIME NOT NULL
    , Fin_Laboral TIME NOT NULL,
    PRIMARY KEY (ID_Asignacion),
    FOREIGN KEY (ID_Evento) REFERENCES evento (ID_Evento),
    FOREIGN KEY (ID_Empleados) REFERENCES empleados (ID_Empleados)
);



CREATE TABLE recursos(
	ID_Recurso INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre_Recurso VARCHAR(30) NOT NULL
    , Descripcion VARCHAR(200) NULL
    , Cantidad INT NOT NULL
    ,Disponibilidad CHAR(2),
    PRIMARY KEY (ID_Recurso)
);



CREATE TABLE proveedores(
	ID_Proveedor INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre_Proveedor VARCHAR(30) NOT NULL
    , Contacto INT NOT NULL,
    PRIMARY KEY (ID_Proveedor)
);



CREATE TABLE proveedor_producto(
	ID_Producto_Prov INT NOT NULL UNIQUE AUTO_INCREMENT
    , ID_Proveedor INT NOT NULL
    , Nombre_Producto VARCHAR(30) NOT NULL
    , Precio DECIMAL(10,2) NOT NULL
    , Stock_Disponible INT NOT NULL,
    PRIMARY KEY (ID_Producto_Prov),
    FOREIGN KEY (ID_Proveedor) REFERENCES proveedores (ID_Proveedor)
);



CREATE TABLE patrocinador(
	ID_Patrocinador INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre_Patrocinador VARCHAR(30) NOT NULL
    , Contacto INT NOT NULL,
    PRIMARY KEY (ID_Patrocinador)
);



CREATE TABLE patrocinio(
	ID_Patrocinio INT NOT NULL UNIQUE AUTO_INCREMENT
    , ID_Patrocinador INT NOT NULL
    , Monto INT NOT NULL
    , Condiciones VARCHAR(200) NOT NULL,
    PRIMARY KEY (ID_Patrocinio),
    FOREIGN KEY (ID_Patrocinador) REFERENCES patrocinador (ID_Patrocinador)
);



CREATE TABLE encuesta(
	ID_Encuesta INT NOT NULL UNIQUE AUTO_INCREMENT
    , Pregunta VARCHAR(200) NOT NULL,
    PRIMARY KEY (ID_Encuesta)
);



CREATE TABLE respuesta_encuesta(
	ID_Respuesta INT NOT NULL UNIQUE AUTO_INCREMENT
    , ID_Evento INT NOT NULL
    , ID_Invitado INT NOT NULL
    , Puntuacion1 INT NULL
    , Puntuacion2 INT NULL
    , Puntuacion3 INT NULL
    , Puntuacion4 INT NULL,
    PRIMARY KEY (ID_Respuesta),
    FOREIGN KEY (ID_Evento) REFERENCES evento (ID_Evento),
    FOREIGN KEY (ID_Invitado) REFERENCES invitado (ID_Invitado)
);

-- Tablas de auditoria

CREATE TABLE log_nuevo_invitado(
	ID_Nuevo_Invitado INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre VARCHAR(30) NOT NULL
    , Apellido VARCHAR(30) NOT NULL
    , DNI VARCHAR(12) NOT NULL
    , Edad INT NOT NULL
    , Usuario VARCHAR(100) NOT NULL
    , Fecha_Hora_Carga DATETIME NOT NULL,
    PRIMARY KEY (ID_Nuevo_Invitado)
);


CREATE TABLE log_modificaciones_evento(
	ID_modificaciones_evento INT NOT NULL UNIQUE AUTO_INCREMENT
    , Nombre_Evento VARCHAR(30) NOT NULL
    , Lugar_Anterior VARCHAR(100) NOT NULL
    , Lugar_Nuevo VARCHAR(100) NOT NULL
    , Horario_Inicio_Anterior TIME NOT NULL
    , Horario_Inicio_Nuevo TIME NOT NULL
    , Horario_Fin_Anterior TIME NOT NULL
    , Horario_Fin_Nuevo TIME NOT NULL
    , Usuario VARCHAR(100) NOT NULL 
    , Fecha_Hora_Carga DATETIME NOT NULL,
    PRIMARY KEY (ID_modificaciones_evento)
);

-- INSERCION DE DATOS

USE eventos;

INSERT INTO evento(Nombre_Evento, Descripcion, Lugar, Horario_Inicio, Horario_Fin)
VALUES 
('Cumpleaños de 15', NULL, 'Janos San Martin', '19:30:00', '22:00:00'),
('Casamiento', 'Con lluvia se pospone el evento', 'Quinta Los Janos', '13:00:00', '16:00:00'),
('Concierto', 'Invitacion de parte de la empresa', 'Cafe Janos', '17:00:00', '19:00:00');


INSERT INTO cliente(Nombre, Apellido, Telefono, Correo_Electronico)
VALUES
('Adrian', 'Rivaduro', '1158392022', 'adrianduro56@gmail.com'),
('Santiago', 'Gordomez', '1148292200', NULL),
('Leonardo', 'Nevera', '114892020', 'Leonardovera@gmail.com');


INSERT INTO contrato(ID_Cliente, ID_Evento, Fecha_Inicio, Fecha_Finalizacion, Pago)
VALUES
('1', '1', '2023-07-23', '2023-07-23', '330000.00'),
('2', '2', '2023-07-18', '2023-07-18', '500000.00'),
('3', '3', '2023-07-28', '2023-07-28', '0.00');


INSERT INTO invitado(Nombre, Apellido, DNI, Edad)
VALUES
('Arancha', 'ornejo', '80390220', '26'),
('Valentilin', 'Muñon', '46493067', '16'),
('Guillermo', 'Bocha', '44893467', '20'),
('Martin', 'Panzarreta', '44812936', '20'),
('Dante', 'Leonardo', '42938273', '25'),
('Tomas', 'Conter', '41684493', '30'),
('Valentino', 'Colasanto', '44382940', '21'),
('Luis', 'Veiga', '84864363', '10'),
('Petra', 'Acosta', '71376704', '26'),
('Ikram', 'Acosta', '77142932', '14'),
('Rufino', 'Heredia', '38475155', '29'),
('Aitana', 'Salas', '80019561', '45'),
('Noel', 'Heras', '34528826', '15'),
('Marcial', 'Espin', '26863774', '41');


INSERT INTO entradas(ID_Evento, ID_Invitado, Nombre_Invitado, Apellido_Invitado, DNI_Invitado, Edad, Tipo_Entrada, Contraseña_Codigo, Precio_Entrada)
VALUES
('1', '1', 'Valentilin', 'Muñon', '46493067', '16', 'Invitacion en lista', NULL, NULL),
('1', '2', 'Guillermo', 'Bocha', '44893467', '20', 'Invitacion en lista', NULL, NULL),
('2', '3', 'Martin', 'Panzarreta', '44812936', '20', 'Invitacion en lista', NULL, NULL),
('2', '4', 'Dante', 'Leonardo', '42938273', '25', 'Invitacion en lista', NULL, NULL),
('3', '5', 'Tomas', 'Conter', '41684493', '30', 'Ticket', 'QR' , '2000.00'),
('3', '6', 'Valentino', 'Colasanto', '44382940', '21', 'Ticket', 'QR' , '2000.00'),
('1', '7','Arancha', 'ornejo', '80390220', '26', 'Invitacion en lista', NULL, NULL),
('2', '8', 'Luis', 'Veiga', '84864363', '10', 'Invitacion en lista', NULL, NULL),
('3', '9', 'Petra', 'Acosta', '71376704', '26', 'Invitacion en lista', 'QR' , '2000.00'),
('1', '10', 'Ikram', 'Acosta', '77142932', '14', 'Invitacion en lista', NULL, NULL),
('2', '11', 'Rufino', 'Heredia', '38475155', '29', 'Invitacion en lista', NULL, NULL),
('3', '12', 'Aitana', 'Salas', '80019561', '45', 'Invitacion en lista', 'QR' , '2000.00'),
('1', '13', 'Noel', 'Heras', '34528826', '15', 'Invitacion en lista', NULL, NULL),
('2', '14', 'Marcial', 'Espin', '26863774', '41', 'Invitacion en lista', NULL, NULL);


INSERT INTO empleados(Nombre, Apellido, Correo_Electronico, Telefono, Disponibilidad)
VALUE
('Maria', 'Pelaez', 'MariaPelaez@gmail.com', '1118376524', 'SI' ),
('Nieves', 'Osuna', NULL, '1168455425', 'SI' ),
('Pascuala', 'Del-Rio', 'pascualadelrio@gmail.com', '1158320597', 'NO' ),
('Virgínia', 'Infante', 'virginiainfante@gmail.com', '1146708979', 'NO' ),
('Gemma', 'Molinero', 'gemmamolinero@gmail.com', '1158184930', 'SI' ),
('Catalina', 'Ramiro', 'catalinaramiro@gmail.com', '1196511736', 'SI' );


INSERT INTO asignacion(ID_Empleados, ID_Evento, Rol, Inicio_Laboral, Fin_Laboral)
VALUES
('1', '1', 'Cocinero', '19:30:00', '22:00:00'),
('2', '1', 'Mesero', '19:30:00', '22:00:00'),
('3', '2','Cocinero', '13:00:00', '19:00:00'),
('4', '2','Organizador', '13:00:00', '19:00:00'),
('5', '3','Cocinero', '13:00:00', '19:00:00'),
('6', '3','Mesero', '17:00:00', '19:00:00');


INSERT INTO encuesta(Pregunta)
VALUES
('¿Que tanto te gusto el evento?'),
('¿Que tanto te gusto la organizacion del evento?'),
('¿Que tanto te gusto la atencion de nuestros empleados?'),
('¿Que tanto te gusto el establecimiento?');


INSERT INTO respuesta_encuesta (ID_Evento, ID_Invitado, Puntuacion1, Puntuacion2, Puntuacion3, Puntuacion4)
VALUES
('1', '1', '10', '10', '9', '9'),
('1', '2', '9', '8', '9', '8'),
('2', '3', NULL, NULL, NULL, NULL),
('2', '4', '6', '5', '9', '8'),
('3', '5', '7', '8', '9', '8'),
('3', '6', NULL, NULL, NULL, NULL),
('1', '7', '10', '10', '9', '9'),
('2', '8', '9', '8', '9', '8'),
('3', '9', NULL, NULL, NULL, NULL),
('1', '10', '6', '5', '9', '8'),
('2', '11', '10', '10', '9', '9'),
('3', '12', '9', '8', '9', '8'),
('1', '13', '6', '5', '9', '8'),
('2', '14', NULL, NULL, NULL, NULL);


INSERT INTO patrocinador(Nombre_Patrocinador, Contacto)
values
('Cocacola', '1107694661'),
('Corona', '1181769398'),
('Pedidosya', '1102957962');


INSERT INTO patrocinio(ID_Patrocinador, Monto, Condiciones)
VALUES
('1', '30000.00', 'Espacios publicitarios y servicios exclusivos de mesa en base a la marca'),
('2', '30000.00', 'Espacios publicitarios y servicios exclusivos de mesa en base a la marca'),
('3', '10000.00', 'Espacios publicitarios');

INSERT INTO proveedores(Nombre_Proveedor, Contacto)
VALUES
('Frigorifico-MC', '1169737977'),
('Unilever', '1183473779');


INSERT INTO proveedor_producto(ID_Proveedor, Nombre_Producto, Precio, Stock_Disponible)
VALUES
('1', 'Asado', '3000.00', '30'),
('1', 'Bife de chorizo', '3900.00', '10'),
('1', 'Lomo', '3400.00', '13'),
('2', 'Savora', '3625.00', '200'),
('2', 'Cif', '3800', '120'),
('2', 'Fanacoa', '2950', '480');

INSERT INTO servicios_extra(ID_Evento, Nombre_Servicio, Descripcion)
VALUES
('1', 'Show de baile', NULL),
('2', 'Alquiler de coche', 'Mercedes Benz 300S'),
('3', NULL, NULL);

INSERT INTO recursos(Nombre_Recurso, Descripcion, Cantidad, Disponibilidad)
VALUES
('Chebrolet clasic', 'Uso exclusivo del personal', '1', 'SI'),
('Fiat Ducato', 'Uso exclusivo del personal', '1', 'SI'),
('Maquina De Humo Gadnic', NULL, '3', 'SI'),
('Maquina de haz de luz', NULL, '3', 'SI');

-- VISTAS

USE eventos;

-- Vista 1

DROP VIEW IF EXISTS eventos.vista_patrocinadores_pagos;

CREATE VIEW vista_patrocinadores_pagos AS
SELECT p.Nombre_Patrocinador AS nombre_patrocinador, pa.Monto AS monto_pago_empresa
FROM patrocinador p
JOIN patrocinio pa ON p.ID_Patrocinador = pa.ID_Patrocinador
UNION ALL
SELECT 'Total' AS nombre_patrocinador, SUM(pa.Monto) AS monto_pago_empresa
FROM patrocinio pa;

/*Funcion: Muestra el nombre de los patrocinadores y el pago que realizan por aceptar sus terminos,
despues realiza la suma de los pagos para generar un total de los ingresos.

Ejemplo de uso:
SELECT * FROM eventos.vista_patrocinadores_pagos;
*/

-- Vista 2

DROP VIEW IF EXISTS eventos.vista_invitados_encuesta_pregunta1;

CREATE VIEW vista_invitados_encuesta_pregunta1 AS
SELECT n.Nombre AS nombre_invitado, e.Nombre_Evento AS evento, p.Puntuacion1 AS valoracion
FROM invitado n
JOIN respuesta_encuesta p ON n.ID_Invitado = p.ID_Invitado
JOIN evento e ON e.ID_Evento = p.ID_Evento;

/*Funcion: Muestra los nombres de los invitados, el evento al que asistieron y la puntuacion dada de dicho evento
sobre la pregunta 1.

Ejemplo de uso:
SELECT * FROM eventos.vista_invitados_encuesta_pregunta1;
*/

-- Vista 3

DROP VIEW IF EXISTS eventos.vista_invitados_encuesta_pregunta2;

CREATE VIEW vista_invitados_encuesta_pregunta2 AS
SELECT n.Nombre AS nombre_invitado, e.Nombre_Evento AS evento, p.Puntuacion2 AS valoracion
FROM invitado n
JOIN respuesta_encuesta p ON n.ID_Invitado = p.ID_Invitado
JOIN evento e ON e.ID_Evento = p.ID_Evento;

/*Funcion: Muestra los nombres de los invitados, el evento al que asistieron y la puntuacion dada de dicho evento
sobre la pregunta 2.

Ejemplo de uso:
SELECT * FROM eventos.vista_invitados_encuesta_pregunta2;
*/

-- Vista 4

DROP VIEW IF EXISTS eventos.vista_invitados_encuesta_pregunta3;

CREATE VIEW vista_invitados_encuesta_pregunta3 AS
SELECT n.Nombre AS nombre_invitado, e.Nombre_Evento AS evento, p.Puntuacion3 AS valoracion
FROM invitado n
JOIN respuesta_encuesta p ON n.ID_Invitado = p.ID_Invitado
JOIN evento e ON e.ID_Evento = p.ID_Evento;

/*Funcion: Muestra los nombres de los invitados, el evento al que asistieron y la puntuacion dada de dicho evento
sobre la pregunta 3.

Ejemplo de uso:
SELECT * FROM eventos.vista_invitados_encuesta_pregunta3;
*/

-- Vista 5

DROP VIEW IF EXISTS eventos.vista_invitados_encuesta_pregunta4;

CREATE VIEW vista_invitados_encuesta_pregunta4 AS
SELECT n.Nombre AS nombre_invitado, e.Nombre_Evento AS evento, p.Puntuacion4 AS valoracion
FROM invitado n
JOIN respuesta_encuesta p ON n.ID_Invitado = p.ID_Invitado
JOIN evento e ON e.ID_Evento = p.ID_Evento;

/*Funcion: Muestra los nombres de los invitados, el evento al que asistieron y la puntuacion dada de dicho evento
sobre la pregunta 4.

Ejemplo de uso:
SELECT * FROM eventos.vista_invitados_encuesta_pregunta4;
*/

-- Vista 6

DROP VIEW IF EXISTS eventos.vista_empleados_roles;

CREATE VIEW vista_empleados_roles AS
SELECT n.Nombre AS Nombre_Empleado, n.Apellido AS apellido_empleado, r.Rol AS rol, e.Nombre_Evento AS evento
FROM empleados n
JOIN asignacion r ON n.ID_Empleados = r.ID_Empleados
JOIN evento e ON e.ID_Evento = r.ID_Evento;

/*Funcion: Muestra el nombre y apellido del empleado tambien su rol y al evento al que participaron.

Ejemplo de uso:
SELECT * FROM eventos.vista_empleados_roles;
*/

-- FUNCIONES

USE eventos;
DROP function IF EXISTS `calcular_ganacias_entradas`;

-- FUNCION 1

DELIMITER $$
USE eventos$$
CREATE FUNCTION calcular_ganacias_entradas (Entradas_vendidas INT)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
	DECLARE resultado INT;
	SET resultado = (Entradas_vendidas) * 2000;
RETURN resultado;
END$$

/*
Funcion: Calcula las ganacias por entradas vendidas.
Ejemplo de uso:
SELECT calcular_ganacias_entradas(4) AS Ganancias_Entradas;
*/

DELIMITER ;

-- FUNCION 2

USE eventos;
DROP function IF EXISTS `horas_trabajadas`;

DELIMITER $$
USE eventos$$
CREATE FUNCTION horas_trabajadas (Inicio_Laboral TIME, Fin_Laboral TIME)
RETURNS TIME
DETERMINISTIC
NO SQL
BEGIN
	DECLARE resultado TIME;
    SET resultado = TIMEDIFF(Inicio_Laboral, Fin_Laboral);
RETURN resultado;
END;$$

/*
Funcion: Calcula la cantidad de hora trabajadas por empleados desde el inicio laboral hasta el fin laboral.
Ejemplo de uso:
SELECT horas_trabajadas ('19:30:00', '22:00:00') AS total_laboral;
*/

DELIMITER ;

-- STORE PROCESDURES

-- Estore procedure 1

USE eventos;
DROP procedure IF EXISTS obtener_invitados_ordenados;

DELIMITER $$
USE eventos$$
CREATE PROCEDURE obtener_invitados_ordenados(IN ordenamiento VARCHAR(10))
BEGIN
    
    IF ordenamiento = 'Nombre' THEN
        SELECT * FROM invitado ORDER BY Nombre;
    ELSE
    IF ordenamiento = 'Apellido' THEN
        SELECT * FROM invitado ORDER BY Apellido;
	END IF;
    END IF;
END;$$

/*Funcion: Ordena a los invitados por medio del Nombre o Apellido
Ejemplo de uso:
call eventos.obtener_invitados_ordenados('Nombre');
call eventos.obtener_invitados_ordenados('Apellido');
*/
DELIMITER ;


-- Estore procedure 2


USE eventos;
DROP procedure IF EXISTS mover_asignacion_empleado;

DELIMITER $$
USE eventos$$
CREATE PROCEDURE mover_asignacion_empleado 
(
    IN id_empleado INT,
    IN id_evento_actual INT,
    IN id_nuevo_evento INT,
    IN nuevo_rol VARCHAR(20)
)
BEGIN
    IF EXISTS (SELECT 1 FROM asignacion WHERE ID_Empleados = id_empleado AND ID_Evento = id_evento_actual)
    THEN
        IF EXISTS (SELECT 1 FROM evento WHERE ID_Evento = id_nuevo_evento)
        THEN
            UPDATE asignacion
            SET ID_Evento = id_nuevo_evento, Rol = nuevo_rol
            WHERE ID_Empleados = id_empleado AND ID_Evento = id_evento_actual;
        END IF;
    END IF;
END;$$

/*Funcion: Cambia la asignacion de los empleados a un nuevo rol y evento
Ejemplo de uso:
call eventos.mover_asignacion_empleado(1, 1, 2, 'mesera');
*/

DELIMITER ;

-- Usuarios

USE eventos;

-- 1º Usuario

DROP USER IF EXISTS 'MariaPelaez'@'localhost';

CREATE USER 'MariaPelaez'@'localhost' IDENTIFIED BY '123';

GRANT SELECT ON evento TO 'MariaPelaez'@'localhost';

FLUSH PRIVILEGES;

/*
Funcion: El usuario MariaPelaez tendra solo los privilegios de realizar select
sobre la base de datos eventos.
*/

-- 2º Usuario

DROP USER IF EXISTS 'NievesOsuna'@'localhost';

CREATE USER 'NievesOsuna'@'localhost' IDENTIFIED BY '0502';

GRANT SELECT, INSERT, UPDATE ON evento TO 'NievesOsuna'@'localhost';

FLUSH PRIVILEGES;

/*
Funcion: El usuario NievesOsuna tendra solo los privilegios de seleccionar tablas, modificarlas e
insertarles datos.
*/