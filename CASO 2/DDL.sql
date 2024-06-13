-----------------------
-- ENTIDADES FUERTES --
-----------------------

CREATE TABLE transmision(
id int primary key not null,
nombre varchar(25) not null
);


CREATE TABLE condicion(
id int primary key not null,
nombre varchar(25) not null
);

CREATE TABLE tipo_transaccion(
id int primary key not null,
nombre varchar(25) not null
);

CREATE TABLE cliente(
dpi int primary key not null,
nit int not null,
nombre varchar(100) not null,
apellido varchar(100) not null,
telefono int(8) not null,
telefono_casa int(8) not null,
email varchar(100) not null
);

CREATE TABLE proveedor(
dpi int primary key not null,
nombre varchar(50) not null,
apellido varchar(50) not null,
telefono int(8)  not null,
email varchar(100) not null,
empresa varchar(50) not null
);

CREATE TABLE empleado(
dpi int primary key not null,
nombre varchar(25),
apellido varchar(25),
telefono int(8) not null,
email varchar(100) not null
);

CREATE TABLE departamento(
id int primary key not null,
nombre varchar(100) not null
);



-----------------------
--  ENTIDADES DÉBIL  --
-----------------------

CREATE TABLE vehiculo(
placa varchar(10) primary key not null,
color varchar(25),
marca varchar(25),
modelo varchar(25),
numero_puertas int(1),
id_transmision int not null,
id_condicion int not null,
FOREIGN KEY (id_transmision)
REFERENCES transmision(id),
FOREIGN KEY (id_condicion)
REFERENCES condicion(id)
);

CREATE TABLE municipio(
id int primary key not null,
nombre varchar(100) not null,
id_departamento int not null,
FOREIGN KEY (id_departamento)
REFERENCES departamento(id)
);


CREATE TABLE sucursal(
id int primary key not null,
nombre varchar(50),
direccion varchar(100) not null,
telefono  int(8) not null,
sitio_web varchar(100),
stock_vehiculo int not null,
id_municipio int not null,
FOREIGN KEY (id_municipio)
REFERENCES municipio(id)
);


CREATE TABLE tarjeta_credito_cliente(
numero_tarjeta int(10)  primary key not null,
monto decimal(6,2) not null,
id_cliente int not null,
FOREIGN KEY (id_cliente)
REFERENCES cliente(dpi)
);


CREATE TABLE tarjeta_credito_empleado(
numero_tarjeta int(10)  primary key not null,
monto decimal(6,2) not null,
id_empleado int not null,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);


CREATE TABLE empelado_sucursal(
id int primary key not null,
id_sucursal  int not null,
id_empleado int not null,
fecha_inicio DATE not null,
fecha_final DATE null,
FOREIGN KEY (id_sucursal)
REFERENCES sucursal(id),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi)
);

CREATE TABLE compra(
id int primary key not null,
id_vehiculo varchar(10) not null,
id_sucursal int not null,
id_empleado int not null,
id_proveedor int not null,
id_tipo_transaccion int not null,
monto int not null,
fecha_compra DATE not null,
FOREIGN KEY (id_vehiculo)
REFERENCES vehiculo(placa),
FOREIGN KEY (id_sucursal)
REFERENCES sucursal(id),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_proveedor)
REFERENCES proveedor(dpi),
FOREIGN key (id_tipo_transaccion)
REFERENCES tipo_transaccion(id)
);

CREATE TABLE venta(
id int primary key not null,
id_vehiculo varchar(10) not null,
id_sucursal int not null,
id_empleado int not null,
id_cliente int not null,
id_tipo_transaccion int not null,
monto int not null,
fecha_venta DATE not null,
FOREIGN KEY (id_vehiculo)
REFERENCES vehiculo(placa),
FOREIGN KEY (id_sucursal)
REFERENCES sucursal(id),
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_cliente)
REFERENCES cliente(dpi),
FOREIGN key (id_tipo_transaccion)
REFERENCES tipo_transaccion(id)
);

CREATE TABLE transaccion_credito_venta(
id  int primary key not null,
nombre_banco varchar(50) not null,
id_venta int not null,
tarjeta_cliente int not null,
FOREIGN key (id_venta)
REFERENCES venta(id),
FOREIGN key (tarjeta_cliente)
REFERENCES tarjeta_credito_cliente(numero_tarjeta)
);

CREATE TABLE transaccion_credito_compra(
id  int primary key not null,
nombre_banco varchar(50) not null,
id_compra int not null,
tarjeta_empleado int not null,
FOREIGN key (id_compra)
REFERENCES compra(id),
FOREIGN key (tarjeta_empleado)
REFERENCES tarjeta_credito_empleado(numero_tarjeta)
);

CREATE TABLE descuento(
id int primary key not null,
id_venta int not null,
motivo varchar(100) not null,
FOREIGN key (id_venta)
REFERENCES venta(id)
);


