## creamos la base de datos -> tiene ese nombre porque es el nombre que se utilizara en el archivo 99.test
#CREATE DATABASE `movies`;

USE `movies`;

CREATE TABLE `pelicula` (
	`pelicula_id` INT NOT NULL,
    `titulo` VARCHAR(1000) CHARACTER SET utf8 NULL,
    `presupuesto` BIGINT,
    `sitio_web` VARCHAR(1000),
    `resumen` VARCHAR(1000) CHARACTER SET utf8 NULL,
    `popularidad` DECIMAL(12,6),
    `fecha_estreno` DATE,
    `ingresos` BIGINT,
    `duracion` INT,
    `estado` VARCHAR(50),
    `lema` VARCHAR(1000) CHARACTER SET utf8 NULL,
    `promedio_votos` DECIMAL(4,2),
    `cantidad_votos` INT
    ,
    CONSTRAINT `PK_pelicula` PRIMARY KEY (`pelicula_id`)
);

CREATE TABLE `pais` (
	`pais_id` INT NOT NULL,
    `pais_codigo_iso` VARCHAR(10),
    `pais_nombre` VARCHAR(200)
    ,
    CONSTRAINT `PK_pais` PRIMARY KEY (`pais_id`)
);

CREATE TABLE `pelicula_pais` (
	`pelicula_id` INT NOT NULL,
    `pais_id` INT NOT NULL
    ,
    CONSTRAINT `FK_pelicula_pais_pelicula` FOREIGN KEY (`pelicula_id`) REFERENCES `pelicula`(`pelicula_id`),
    CONSTRAINT `FK_pelicula_pais_pais` FOREIGN KEY (`pais_id`) REFERENCES `pais`(`pais_id`)
    ,
    CONSTRAINT `PK_pelicula_pais` PRIMARY KEY (`pelicula_id`,`pais_id`)
);

CREATE TABLE `idioma` (
	`idioma_id` INT NOT NULL,
    `idioma_codigo` VARCHAR(10),
    `idioma_nombre` VARCHAR(500) CHARACTER SET utf8 NULL
    ,
    CONSTRAINT `PK_idioma` PRIMARY KEY (`idioma_id`)
);

CREATE TABLE `idioma_rol` (
	`rol_id` INT,
    `idioma_rol` VARCHAR(20)
    ,
    CONSTRAINT `PK_idioma_rol` PRIMARY KEY (`rol_id`)
);

CREATE TABLE `pelicula_idiomas` (
	`pelicula_id` INT NOT NULL,
    `idioma_id` INT NOT NULL,
    `idioma_rol_id` INT NOT NULL
    ,
    CONSTRAINT `FK_pelicula_idiomas_pelicula` FOREIGN KEY (`pelicula_id`) REFERENCES `pelicula`(`pelicula_id`),
    CONSTRAINT `FK_pelicula_idiomas_idioma` FOREIGN KEY (`idioma_id`) REFERENCES `idioma`(`idioma_id`),
    CONSTRAINT `FK_pelicula_idiomas_idioma__rol` FOREIGN KEY (`idioma_rol_id`) REFERENCES `idioma_rol`(`rol_id`)
    ,
    CONSTRAINT `PK_pelicula_idiomas` PRIMARY KEY (`pelicula_id`,`idioma_id`,`idioma_rol_id`)
);

CREATE TABLE `categoria` (
	`categoria_id` INT NOT NULL,
    `categoria_nombre` VARCHAR(100)
    ,
    CONSTRAINT `PK_categoria` PRIMARY KEY (`categoria_id`)
);

CREATE TABLE `pelicula_categorias` (
	`pelicula_id` INT NOT NULL,
    `categoria_id` INT NOT NULL
    ,
    CONSTRAINT `FK_pelicula_categorias_pelicula` FOREIGN KEY (`pelicula_id`) REFERENCES `pelicula`(`pelicula_id`),
    #CONSTRAINT `FK_pelicula_categorias_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria`(`categoria_id`),
    CONSTRAINT `PK_pelicula_categorias` PRIMARY KEY (`pelicula_id`,`categoria_id`)
);

CREATE TABLE `palabra_clave` (
	`palabra_clave_id` INT NOT NULL,
    `palabra_clave_nombre` VARCHAR(200)
    ,
    CONSTRAINT `PK_palabra_clave` PRIMARY KEY (`palabra_clave_id`)
);

CREATE TABLE `pelicula_palabra_claves` (
	`pelicula_id` INT NOT NULL,
    `palabra_clave_id` INT NOT NULL
    ,
    CONSTRAINT `FK_pelicula_palabra_claves_pelicula` FOREIGN KEY (`pelicula_id`) REFERENCES `pelicula`(`pelicula_id`),
    CONSTRAINT `FK_pelicula_palabra_claves_palabra` FOREIGN KEY (`palabra_clave_id`) REFERENCES `palabra_clave`(`palabra_clave_id`)
    ,
    CONSTRAINT `PK_pelicula_palabra_claves` PRIMARY KEY (`pelicula_id`,`palabra_clave_id`)
);

CREATE TABLE `productora` (
	`productora_id` INT NOT NULL,
    `productora_nombre` VARCHAR(200) CHARACTER SET utf8 NULL
    ,
    CONSTRAINT `PK_productora` PRIMARY KEY (`productora_id`)
);

CREATE TABLE `pelicula_productora` (
	`pelicula_id` INT NOT NULL,
    `productora_id` INT NOT NULL
    ,
    CONSTRAINT `FK_pelicula_productora_pelicula` FOREIGN KEY (`pelicula_id`) REFERENCES `pelicula`(`pelicula_id`),
    CONSTRAINT `FK_pelicula_productora_productora` FOREIGN KEY (`productora_id`) REFERENCES `productora`(`productora_id`)
    ,
    CONSTRAINT `PK_pelicula_productora` PRIMARY KEY (`pelicula_id`,`productora_id`)
);

CREATE TABLE `genero` (
	`genero_id` INT NOT NULL,
    `genero` VARCHAR(20)
    ,
    CONSTRAINT `PK_genero` PRIMARY KEY (`genero_id`)
);

CREATE TABLE `persona` (
	`persona_id` INT NOT NULL,
    `persona_nombre` VARCHAR(500)
    ,
    CONSTRAINT `PK_persona` PRIMARY KEY (`persona_id`)
);

CREATE TABLE `especialidad` (
	`especialidad_id` INT NOT NULL,
    `especialidad_nombre` VARCHAR(200)
    ,
    CONSTRAINT `PK_especialidad` PRIMARY KEY (`especialidad_id`)
);

CREATE TABLE `pelicula_elenco` (
	`pelicula_id` INT,
    `persona_id` INT,
    `personaje_nombre` VARCHAR(400) CHARACTER SET utf8 NULL,
    `genero_id` INT,
    `elenco_orden` INT NOT NULL
    ,
    CONSTRAINT `FK_pelicula_elenco_pelicula` FOREIGN KEY (`pelicula_id`) REFERENCES `pelicula`(`pelicula_id`),
    CONSTRAINT `FK_pelicula_elenco_persona` FOREIGN KEY (`persona_id`) REFERENCES `persona`(`persona_id`),
    CONSTRAINT `FK_pelicula_elenco_genero` FOREIGN KEY (`genero_id`) REFERENCES `genero`(`genero_id`),
    CONSTRAINT `PK_pelicula_elenco` PRIMARY KEY (`elenco_orden`,`pelicula_id`,`genero_id`,`persona_id`)
);

CREATE TABLE `pelicula_equipo` (
	`pelicula_id` INT,
    `persona_id` INT,
    `especialidad_id` INT,
    `trabajo` VARCHAR(200)
    ,
    CONSTRAINT `FK_pelicula_equipo_pelicula` FOREIGN KEY (`pelicula_id`) REFERENCES `pelicula`(`pelicula_id`),
    CONSTRAINT `FK_pelicula_equipo_persona` FOREIGN KEY (`persona_id`) REFERENCES `persona`(`persona_id`),
    CONSTRAINT `FK_pelicula_equipo_especialidad` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad`(`especialidad_id`),
    CONSTRAINT `PK_pelicula_equipo` PRIMARY KEY (`trabajo`,`pelicula_id`,`persona_id`,`especialidad_id`)
);