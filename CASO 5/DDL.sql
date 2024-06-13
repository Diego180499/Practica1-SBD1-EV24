-------------
-- FUERTES --
-------------


CREATE TABLE puesto(
id INT PRIMARY KEY NOT NULL,
nombre VARCHAR(25)
);

CREATE TABLE area(
id INT PRIMARY KEY NOT NULL,
nombre VARCHAR(25)
);

CREATE TABLE seguro(
id INT PRIMARY KEY NOT NULL,
nombre VARCHAR(25)
);

CREATE TABLE cliente(
dpi   INT(13) PRIMARY KEY NOT NULL,
nombre VARCHAR(25),
apellido VARCHAR(25),
direccion VARCHAR(100) not null,
telefono  INT(8) NOT NULL,
email VARCHAR(100)
);

CREATE TABLE forma_pago(
id INT PRIMARY KEY NOT NULL,
descripcion VARCHAR(25)
);


-------------
-- DEBILES --
-------------

CREATE TABLE departamento(
id  INT PRIMARY KEY NOT NULL,
nombre  VARCHAR(50),
id_area INT NOT NULL,
FOREIGN KEY (id_area)
REFERENCES area(id)
);


CREATE TABLE funcion(
id INT PRIMARY KEY NOT NULL,
nombre VARCHAR(50)NOT NULL,
id_depto  INT NOT NULL,
FOREIGN KEY (id_depto)
REFERENCES departamento(id)
);



CREATE TABLE empleado(
dpi INT(13) PRIMARY KEY NOT NULL,
nombre VARCHAR(50),
apellido VARCHAR(50),
fecha_nacimiento DATE,
fecha_inicio_laboral DATE NOT NULL,
edad INT NOT NULL,
telefono INT(8) NOT NULL,
direccion VARCHAR(100) NOT NULL,
salario  INT NOT NULL,
id_puesto  INT NOT NULL,
id_depto  INT NOT NULL,
FOREIGN KEY (id_puesto)
REFERENCES puesto(id),
FOREIGN KEY (id_depto)
REFERENCES departamento(id)
);


CREATE TABLE solicitud_seguro(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_empleado  INT(8) NOT NULL,
nombre_cliente VARCHAR(50) not null,
numero_cliente INT(8) NOT NULL,
id_seguro  INT NOT NULL,
fecha_hora DATETIME,
duracion_min_llamada  INT,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_seguro)
REFERENCES seguro(id)
);

CREATE TABLE contrato_seguro(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_empleado  INT(13) NOT NULL,
id_cliente  INT(13)  not null,
id_seguro  INT NOT NULL,
monto  INT NOT NULL,
fecha_inicio  DATE NOT NULL,
fecha_fin DATE not null,
periodo_pago  VARCHAR(25),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_cliente)
REFERENCES cliente(dpi),
FOREIGN KEY (id_seguro)
REFERENCES seguro(id)
);

CREATE TABLE pago_contrato(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_contrato INT NOT NULL,
id_cliente INT(13) NOT NULL,
id_empleado INT(13) not null,
mora VARCHAR(25) NULL,
id_forma_pago  VARCHAR(25),
fecha_pago  DATE,
FOREIGN KEY (id_contrato)
REFERENCES contrato_seguro(id),
FOREIGN KEY (id_cliente)
REFERENCES cliente(dpi),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_forma_pago)
REFERENCES forma_pago(id)
);

