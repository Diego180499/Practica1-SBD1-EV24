CREATE DATABASE caso1;

-----------------------
-- ENTIDADES FUERTES --
-----------------------

CREATE TABLE categoria_producto(
id  INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL
);


CREATE TABLE tipo_tienda(
id  INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE tipo_transporte(
id  INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE ruta(
id  INT PRIMARY KEY NOT NULL,
direccion_inicial VARCHAR(20) NOT NULL,
direccion_final VARCHAR(20) NOT NULL
);

CREATE TABLE area_trabajo(
id  INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE jornada(
id  INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE empresa_proveedora(
id  INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE tipo_certificado(
id  INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL
);

-----------------------
-- ENTIDADES DÉBILES --
-----------------------

CREATE TABLE producto(
id int primary KEY NOT NULL,
nombre varchar(10) not null,
precio_unitario  decimal(4,2),
id_categoria_producto  int not null,
FOREIGN KEY (id_categoria_producto)
REFERENCES categoria_producto(id)
);

CREATE TABLE empleado(
dpi int(13) primary KEY not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
telefono int(8) not null,
email varchar(100),
id_area_trabajo int not null,
id_jornada int not null,
numero_igss int,
salario  int not null,
FOREIGN KEY (id_area_trabajo)
REFERENCES area_trabajo(id),
FOREIGN KEY (id_jornada)
REFERENCES jornada(id)
);

CREATE TABLE proveedor(
dpi int(13) primary KEY NOT null,
nombre varchar(20) not null,
apellido varchar(20) not null,
telefono int(8) not null,
email varchar(100),
id_empresa_proveedora int not null,
FOREIGN KEY (id_empresa_proveedora)
REFERENCES empresa_proveedora(id)
);

CREATE TABLE mercaderia(
id int primary KEY not null,
id_empleado int(13) not null,
fecha_ingreso DATE not null,
id_proveedor int not null,
total_mercaderia decimal(5,2) not null,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);

CREATE TABLE detalle_mercaderia(
id int primary KEY not null,
id_mercaderia int not null,
id_producto int not null,
cantidad int not null,
total_detalle decimal(5,2),
FOREIGN KEY (id_mercaderia)
REFERENCES mercaderia(id),
FOREIGN KEY (id_producto)
REFERENCES producto(id)
);

CREATE TABLE tienda(
id int primary KEY not null,
nombre varchar(50) not null,
direccion varchar(100) not null,
id_tipo_tienda int not null,
FOREIGN KEY (id_tipo_tienda)
REFERENCES tipo_tienda(id)
);


CREATE TABLE pedido(
id int primary KEY not null,
id_tienda int not null,
id_empleado int(13) not null,
fecha_pedido DATE not null,
descripcion VARCHAR(100),
total_pedido decimal(5,2) not null,
FOREIGN KEY (id_tienda)
REFERENCES tienda(id),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);

CREATE TABLE detalle_pedido(
id int primary KEY not null,
id_pedido int not null,
id_producto int not null,
cantidad int not null,
total_detalle decimal(5,2) not null,
FOREIGN KEY (id_pedido)
REFERENCES producto(id)
);

CREATE TABLE entrega(
id int primary key not null,
id_pedido int not null,
fecha_entrega DATE not null,
FOREIGN KEY (id_pedido)
REFERENCES pedido(id)
);

CREATE TABLE transporte(
placa int primary key not null,
id_tipo_transporte int not null,
id_empleado int(13) not null,
FOREIGN KEY (id_tipo_transporte)
REFERENCES tipo_transporte(id),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);

CREATE TABLE ruta_transporte(
id_ruta  int not null,
id_transporte int not null,
PRIMARY KEY (id_ruta, id_transporte)
FOREIGN KEY (id_ruta) 
REFERENCES ruta(id),
FOREIGN KEY (id_transporte)
REFERENCES transporte(placa)
);

CREATE TABLE falta_empleado(
id int primary key not null,
id_empleado int(13) not null,
descripcion varchar(100) not null,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);


CREATE TABLE maquinaria_equipo(
id int primary key not null,
nombre varchar(50) not null,
id_empleado int(13) not null,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);


CREATE TABLE reclamo_pedido(
id int primary key not null,
id_pedido int not null,
descripcion varchar(100),
FOREIGN KEY (id_pedido)
REFERENCES pedido(id)
);


CREATE TABLE capacitacion(
id int primary key not null,
id_area_trabajo int not null,
id_empleado int(13) not null,
fecha_capacitacion DATE not null,
tiempo_duracion_dias  int ,
id_tipo_certificado int not null,
FOREIGN KEY (id_area_trabajo)
REFERENCES area_trabajo(id),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);