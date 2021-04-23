DROP TABLE IF EXISTS `dim_lugar`;
CREATE TABLE `dim_lugar`(
    `key_lugar` int(10) NOT NULL AUTO_INCREMENT,
    `ID_Parada` VARCHAR(20) NOT NULL,
    `Pais` VARCHAR(50),
    `Ciudad` VARCHAR(30),
    `Direccion` VARCHAR(30),
    `MediosAcceso` VARCHAR(30),
    `Clima` VARCHAR(30) CHECK (Clima in ('Atlantico','Mediterraneo','Montaña','Interior', 'Tundra', 'Desertico')),
    `Poblacion` INTEGER,
    `Costero` BOOLEAN,
    `Industrial` BOOLEAN,
    `Turistica` BOOLEAN,
    `Capital` BOOLEAN,
    `lugar_last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`key_lugar`)
);

DROP TABLE IF EXISTS `dim_tiempo`;
CREATE TABLE `dim_tiempo`(
    `key_tiempo` int(10) NOT NULL AUTO_INCREMENT,
    `ID_Pedido` VARCHAR(20) NOT NULL,
    `DiaEntrega` int(10),
    `MesEntrega` int(10),
    `AnhoEntrega` int(10),
    `HoraEntrega` VARCHAR(10),
    `DiaPedido` INTEGER,
    `MesPedido` INTEGER,
    `AnhoPedido` INTEGER,
    `HoraPedido` VARCHAR(10),
    `Festivo` BOOLEAN,
    `DiaSemana` VARCHAR(10),
    `VisperaFestivo` BOOLEAN,
    `Estacion` VARCHAR(10),
    `tiempo_last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`key_tiempo`)
);

DROP TABLE IF EXISTS `dim_devolucion`;
CREATE TABLE `dim_devolucion`(
    `key_devolucion` int(10) NOT NULL AUTO_INCREMENT,
    `ID_Devolucion` VARCHAR(20) NOT NULL,
    `devolucion_last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `Motivo` VARCHAR(30)
    CHECK ( Motivo IN ('Paquete danhado','No es lo que pedi','Ya no lo necesito')),
    PRIMARY KEY (`key_devolucion`)
);

DROP TABLE IF EXISTS `dim_cliente`;
CREATE TABLE `dim_cliente`(
    `key_cliente` int(10) NOT NULL AUTO_INCREMENT,
    `ID_Cliente` VARCHAR(20) NOT NULL,
    `Empresa_Ambito` VARCHAR(10),
    `cliente_last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `Particular_Edad` INTEGER,
    `Valido_desde` DATE,
    `Valido_hasta` DATE,
    `Version` SMALLINT,
    `Particular_Estudios` VARCHAR(10)
    CHECK (Particular_Estudios IN ('Secundaria','Bachillerato','Formación Profesional','Universitaria','Master','Doctorado')),
    `Particular_Nacionalidad` VARCHAR(10),
    `Cliente_Tipo` VARCHAR(10)
    CHECK(Cliente_Tipo IN ('Particular','Empresa')),
    PRIMARY KEY(`key_cliente`)
);

DROP TABLE IF EXISTS `dim_empleado`;
CREATE TABLE `dim_empleado`(
    `key_empleado` int(10) NOT NULL AUTO_INCREMENT,
    `DNI` VARCHAR(9) NOT NULL,
    `Nombre` VARCHAR(30),
    `Valido_desde` DATE,
    `Valido_hasta` DATE,
    `Version` SMALLINT,
    `Activo` VARCHAR(3),
    `empleado_last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `Apellidos` VARCHAR(30),
    `FechaNacimiento` VARCHAR(10),
    `SalarioBruto` INTEGER,
    `Antiguedad` INTEGER,
    `Almacen` INTEGER,
    `Departamento` INTEGER
    CHECK(Departamento>0 AND Departamento < 11),
    `Genero` VARCHAR(2)
    CHECK(Genero IN ('F','M')),
    `Productividad` INTEGER,
    `Hijos` BOOLEAN,
    PRIMARY KEY (`key_empleado`)
);

DROP TABLE IF EXISTS `fact_pedido`;
CREATE TABLE `fact_pedido`(
    `key_pedido` int(10) NOT NULL AUTO_INCREMENT,
    `ID_Pedido` VARCHAR(20),
    `numPedidos` int(10),
    `pedido_last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `numDevoluciones` int(10),
    `Exito` NUMERIC(3,2),
    `TiempoEntrega` VARCHAR(10),
    `key_cliente` int(10) NOT NULL,
    `key_lugar` int(10) NOT NULL,
    `key_tiempo` int(10) NOT NULL,
    `key_devolucion` int(10) NOT NULL,
    `key_empleado` int(10) NOT NULL,
    PRIMARY KEY (`key_pedido`),
    KEY `dim_cliente_fact_pedido_fk` (`key_cliente`),
    KEY `dim_tiempo_fact_pedido_fk` (`key_tiempo`),
    KEY `dim_lugar_fact_pedido_fk` (`key_lugar`),
    KEY `dim_empleado_fact_pedido_fk` (`key_empleado`),
    KEY `dim_devolucion_fact_pedido_fk` (`key_devolucion`)
);