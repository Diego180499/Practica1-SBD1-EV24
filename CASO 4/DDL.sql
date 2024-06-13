CREATE DATABASE caso4;

------------------------
--  ENTIDADES FUERTES --
------------------------


CREATE TABLE avion(
matricula  VARCHAR(20) PRIMARY KEY NOT NULL,
modelo  VARCHAR(20) not null,
asientos_primera_clase  INT NOT NULL,
asientos_clase_ejecutiva  INT NOT NULL,
asientos_clase_economica  INT NOT NULL,
fecha_ultimo_mantenimiento  DATE NOT NULL,
fecha_proximo_mantenimiento  DATE NOT NULL,
galones_gasolina_necesarios   INT NOT NULL,
distancia_maxima    INT NOT NULL,
altura_maxima     INT NOT NULL
);


CREATE TABLE empleado(
dpi  INT(13)  PRIMARY KEY NOT NULL,
nombre  VARCHAR(50)  NOT NULL,
apellido  VARCHAR(50) NOT NULL,
direccion VARCHAR(100) NOT NULL,
fecha_contratacion  DATE NOT NULL,
fecha_nacimiento DATE,
email  VARCHAR(100) NOT NULL,
idiomas   VARCHAR(100),
jornada  VARCHAR(20) NULL,
horas_acumuladas  INT NULL
);

CREATE TABLE puesto(
id  INT PRIMARY KEY not null,
nombre VARCHAR(25) NOT NULL
);


CREATE TABLE cliente(
numero_pasaporte  INT(13) PRIMARY KEY NOT NULL,
nombre VARCHAR(50) not null,
apellido VARCHAR(50) not null,
edad   INT,
fecha_nacimiento DATE,
email  VARCHAR(100) NOT NULL,
telefono INT(8) NOT NULL,
direccion  VARCHAR(100)  NOT NULL,
codigo_postal  INT(4) NOT NULL
);



------------------------
--  ENTIDADES DEBILES --
------------------------


CREATE TABLE mantenimiento_avion(
id  INT PRIMARY KEY NOT NULL,
matricula_avion VARCHAR(20) NOT NULL,
fecha_programada DATE NOT NULL,
observaciones  VARCHAR(100) NULL,
FOREIGN KEY (matricula_avion)
REFERENCES avion(matricula)
);


CREATE TABLE mantenimiento_avion_empleado(
id INT PRIMARY KEY NOT NULL,
id_mantenimiento_avion INT NOT NULL,
id_empleado INT(13) NOT NULL,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);



CREATE TABLE puesto_empleado(
id INT PRIMARY KEY NOT NULL,
id_puesto  int not null,
dpi_empleado INT(13) NOT NULL,
hora_inicio  INT NOT NULL,
hora_salida  INT NOT NULL,
FOREIGN KEY (dpi_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_puesto)
REFERENCES puesto(id)
);


CREATE TABLE asistencia_empleado(
id  INT PRIMARY KEY NOT NULL,
dpi_empleado  INT(13) NOT NULL,
hora_entrada  INT NOT NULL,
hora_salida  INT NOT NULL,
FOREIGN KEY (dpi_empleado)
REFERENCES empleado(dpi)
);


CREATE TABLE vuelo(
id   VARCHAR(20) PRIMARY KEY NOT NULL,
id_avion  VARCHAR(20) NOT NULL,
origen  VARCHAR(100) NOT NULL,
destino  VARCHAR(100) NOT NULL,
horas_duracion  INT NOT NULL,
FOREIGN KEY (id_avion)
REFERENCES avion(matricula)
);

CREATE TABLE tripulacion_vuelo(
id  INT PRIMARY KEY NOT NULL,
id_vuelo  VARCHAR(20) NOT NULL,
id_empleado  INT NOT NULL,
FOREIGN KEY (id_vuelo)
REFERENCES vuelo(id),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);


CREATE TABLE boleto(
id  INT PRIMARY KEY NOT NULL,
id_vuelo  VARCHAR(20) NOT NULL,
fecha_despegue  DATE NOT NULL,
clase  VARCHAR(50) NOT NULL,
peso_maleta_permitido  INT NOT NULL,
costo  INT NOT NULL,
FOREIGN KEY (id_vuelo)
REFERENCES vuelo(id)
);


CREATE TABLE cliente_boleto(
id  INT NOT NULL,
pasaporte_cliente  INT(13) NOT NULL,
id_boleto INT NOT NULL,
modo_pago  VARCHAR(20),
tarjeta  INT,
fecha_salida  DATE NOT NULL,
fecha_regreso  DATE NOT NULL,
FOREIGN KEY (pasaporte_cliente)
REFERENCES cliente(numero_pasaporte)
);

