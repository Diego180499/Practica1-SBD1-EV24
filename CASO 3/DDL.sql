-----------------------
-- ENTIDADES FUERTES --
-----------------------

CREATE TABLE tipo_bodega(
id  int PRIMARY KEY not null,
nombre_tipo  varchar(50)
);

CREATE TABLE etapa(
id  int primary key not null,
estado_etapa  varchar(50) not null,
costo_funcionamiento INT not null
);

CREATE TABLE linea_ensamblaje(
id   int primary key not null,
tipo_linea  varchar(10) not null,
nombre varchar(50),
ubicacion  varchar(100)
);

CREATE TABLE empleado(
dpi   int(13) primary key not null,
nombre varchar(25),
apellido varchar(25),
direccion varchar(50) not null,
telefono  int(8) not null,
email  varchar(100) not null
);

CREATE TABLE proveedor(
id  int primary key not null,
nombre  varchar(25),
telefono  int(15) not null,
pais  varchar(50) not null,
empresa  varchar(50) not null
);


CREATE TABLE cliente(
id  int primary key not null,
nombre varchar(25) not null,
direccion varchar(100) not null,
pais   varchar(25)
);

-----------------------
-- ENTIDADES DEBILES --
-----------------------


CREATE TABLE bodega(
id  int primary key not null,
id_empleado  int not null,
direccion  varchar(100) not null,
stock_productos  int,
id_tipo_bodega  int not null,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_tipo_bodega)
REFERENCES tipo_bodega(id)
);


CREATE TABLE puesto(
id  int  primary key not null,
nombre  varchar(50) not null,
id_linea  int not null,
FOREIGN KEY (id_linea)
REFERENCES linea_ensamblaje(id)
);



CREATE TABLE puesto_empleado(
id  int primary key not null,
id_empleado  int(13) not null,
id_puesto int not null,
hora_entrada  int not null,
hora_salida  int not null,
FOREIGN KEY (id_empleado)
REFERENCES empleado(dpi),
FOREIGN KEY (id_puesto)
REFERENCES puesto(id)
);



CREATE TABLE factura(
id  int primary key not null,
id_proveedor  int not null,
fecha_compra  DATE not null,
monto  int not null,
FOREIGN KEY (id_proveedor)
REFERENCES proveedor(id)
);


CREATE TABLE parte(
id  int primary key not null,
nombre  varchar(25) not null,
color   varchar(20),
tipo    varchar(20),
id_proveedor  int not null,
id_etapa int not null,
precio int not null,
FOREIGN KEY (id_proveedor)
REFERENCES proveedor(id),
FOREIGN KEY (id_etapa)
REFERENCES etapa(id)
);

CREATE TABLE detalle_factura(
id   int primary key not null,
id_factura  int not null,
id_parte int not null,
monto  int not null,
FOREIGN KEY (id_factura)
REFERENCES factura(id),
FOREIGN KEY (id_parte)
REFERENCES parte(id)
);


CREATE TABLE reclamo_proveedor(
id int primary key not null,
id_factura int not null,
id_parte  int not null,
descripcion  varchar(100),
FOREIGN KEY (id_factura)  
REFERENCES factura(id),
FOREIGN KEY (id_parte)
REFERENCES parte(id)
);


CREATE TABLE pedido(
id  int primary key not null,
id_cliente  int not null,
fecha_pedido DATE NOT NULL,
monto  int not null,
FOREIGN KEY (id_cliente)
REFERENCES cliente(id)
);


CREATE TABLE producto(
id  int primary key not null,
nombre  varchar(50) not null,
marca  varchar(50),
id_etapa  int not null,
fecha_finalizacion  DATE  null,
costo  int not null,
FOREIGN KEY (id_etapa)
REFERENCES etapa(id)
);


CREATE TABLE ingreso_bodega(
id  int primary key not null,
id_bodega  int not null,
id_producto int not null,
FOREIGN KEY (id_bodega)
REFERENCES bodega(id),
FOREIGN KEY (id_producto)
REFERENCES producto(id)
);


CREATE TABLE detalle_pedido(
id int primary key not null,
id_pedido  int not null,
id_producto int not null,
monto int not null,
FOREIGN KEY (id_pedido)
REFERENCES pedido(id),
FOREIGN KEY (id_producto)
REFERENCES producto(id)
);


CREATE TABLE devolucion(
id  int primary key not null,
id_pedido  int not null,
id_producto_defectuoso  int not null,
fecha_devolucion  DATE null,
FOREIGN KEY (id_pedido)
REFERENCES pedido(id),
FOREIGN KEY (id_producto_defectuoso)
REFERENCES producto(id)
);

