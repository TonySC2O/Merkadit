-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema merkadit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema merkadit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `merkadit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `merkadit` ;

-- -----------------------------------------------------
-- Table `merkadit`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`paises` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `countryName` VARCHAR(150) NOT NULL,
  `countryCode` VARCHAR(10) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idPais`),
  UNIQUE INDEX `countrycode_UNIQUE` (`countryCode` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`estados` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `idPais` INT NOT NULL,
  `stateName` VARCHAR(150) NOT NULL,
  `stateCode` VARCHAR(10) NULL DEFAULT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idEstado`),
  INDEX `fk_estados_paises1_idx` (`idPais` ASC) VISIBLE,
  CONSTRAINT `fk_estados_paises1`
    FOREIGN KEY (`idPais`)
    REFERENCES `merkadit`.`paises` (`idPais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`ciudades` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `idEstados` INT NOT NULL,
  `cityName` VARCHAR(150) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idCiudad`),
  INDEX `fk_ciudades_estados1_idx` (`idEstados` ASC) VISIBLE,
  CONSTRAINT `fk_ciudades_estados1`
    FOREIGN KEY (`idEstados`)
    REFERENCES `merkadit`.`estados` (`idEstado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`direciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`direciones` (
  `idDirecion` INT NOT NULL AUTO_INCREMENT,
  `idCiudad` INT NOT NULL,
  `adressLine1` VARCHAR(255) NOT NULL,
  `adressLine2` VARCHAR(255) NULL DEFAULT NULL,
  `zipCode` VARCHAR(20) NULL DEFAULT NULL,
  `geoPosition` POINT NULL DEFAULT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idDirecion`),
  INDEX `fk_Direciones_ciudades1_idx` (`idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Direciones_ciudades1`
    FOREIGN KEY (`idCiudad`)
    REFERENCES `merkadit`.`ciudades` (`idCiudad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`edificios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`edificios` (
  `idEdificio` INT NOT NULL AUTO_INCREMENT,
  `idDirecion` INT NOT NULL,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `uso` VARCHAR(20) NULL,
  PRIMARY KEY (`idEdificio`),
  INDEX `fk_edificios_direciones1_idx` (`idDirecion` ASC) VISIBLE,
  CONSTRAINT `fk_edificios_direciones1`
    FOREIGN KEY (`idDirecion`)
    REFERENCES `merkadit`.`direciones` (`idDirecion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`locales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`locales` (
  `idLocal` INT NOT NULL AUTO_INCREMENT,
  `idEdificio` INT NOT NULL,
  `codigoPiso` VARCHAR(10) NULL DEFAULT NULL,
  `descripcion` VARCHAR(300) NULL DEFAULT NULL,
  `fechaInaguracion` DATETIME NULL DEFAULT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idLocal`),
  INDEX `fk_Locales_edificios1_idx` (`idEdificio` ASC) VISIBLE,
  CONSTRAINT `fk_Locales_edificios1`
    FOREIGN KEY (`idEdificio`)
    REFERENCES `merkadit`.`edificios` (`idEdificio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`kioskos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`kioskos` (
  `idKiosko` INT NOT NULL AUTO_INCREMENT,
  `idLocal` INT NOT NULL,
  `codigo` VARCHAR(5) NOT NULL,
  `sizem2` DECIMAL(15,2) NULL DEFAULT NULL,
  `tipo` ENUM("Gastronomic", "Retail") NULL,
  `estado` ENUM('Disponible', 'Ocupado', 'En renovacion') NULL DEFAULT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idKiosko`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_Kioskos_Locales1_idx` (`idLocal` ASC) VISIBLE,
  CONSTRAINT `fk_Kioskos_Locales1`
    FOREIGN KEY (`idLocal`)
    REFERENCES `merkadit`.`locales` (`idLocal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(70) NOT NULL,
  `cedula` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `fechaRegistro` DATETIME NOT NULL,
  `password` VARBINARY(25) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`contratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`contratos` (
  `idContrato` INT NOT NULL AUTO_INCREMENT,
  `idKiosko` INT NOT NULL,
  `idUsuarioA` INT NOT NULL,
  `idUsuarioC` INT NOT NULL,
  `FechaInicial` DATETIME NULL,
  `fechaFinal` DATETIME NULL,
  `SiguientePago` DATETIME NULL,
  `pagoBase` DECIMAL(15,2) NULL,
  `tarifaVentas` DECIMAL(15,2) NULL,
  `estado` ENUM("Activo", "Finalizado") NULL,
  `documento` BLOB NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idContrato`),
  INDEX `fk_contratos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  INDEX `fk_contratos_usuarios1_idx` (`idUsuarioA` ASC) VISIBLE,
  INDEX `fk_contratos_usuarios2_idx` (`idUsuarioC` ASC) VISIBLE,
  CONSTRAINT `fk_contratos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contratos_usuarios1`
    FOREIGN KEY (`idUsuarioA`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contratos_usuarios2`
    FOREIGN KEY (`idUsuarioC`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`KioskosxContratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`KioskosxContratos` (
  `idKiosko` INT NOT NULL,
  `idContrato` INT NOT NULL,
  INDEX `fk_KioskosxContratos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  INDEX `fk_KioskosxContratos_contratos1_idx` (`idContrato` ASC) VISIBLE,
  CONSTRAINT `fk_KioskosxContratos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_KioskosxContratos_contratos1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `merkadit`.`contratos` (`idContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`UsuariosxKioskos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`UsuariosxKioskos` (
  `idKiosko` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  INDEX `fk_UsuariosxKioskos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  INDEX `fk_UsuariosxKioskos_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_UsuariosxKioskos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UsuariosxKioskos_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `idKiosko` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  `barCode` VARCHAR(30) NULL,
  `descripcion` VARCHAR(300) NULL,
  `precioUnitario` DECIMAL(15,2) NULL,
  `stockActual` INT NULL,
  `stockMaximo` INT NULL,
  `lastRestock` DATETIME NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Productos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Roles` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  `lastDel` DATETIME NULL,
  PRIMARY KEY (`idRol`),
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Permisos` (
  `idPermiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  `lastDel` DATETIME NULL,
  PRIMARY KEY (`idPermiso`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`PermisosxRol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`PermisosxRol` (
  `idRol` INT NOT NULL,
  `idPermiso` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  `lastDel` DATETIME NULL,
  INDEX `fk_PermisosxRol_Roles1_idx` (`idRol` ASC) VISIBLE,
  INDEX `fk_PermisosxRol_Permisos1_idx` (`idPermiso` ASC) VISIBLE,
  CONSTRAINT `fk_PermisosxRol_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `merkadit`.`Roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PermisosxRol_Permisos1`
    FOREIGN KEY (`idPermiso`)
    REFERENCES `merkadit`.`Permisos` (`idPermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`RolesxUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`RolesxUsuarios` (
  `idUsuario` INT NOT NULL,
  `idRol` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  `lastDel` DATETIME NULL,
  INDEX `fk_table1_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_table1_Roles1_idx` (`idRol` ASC) VISIBLE,
  CONSTRAINT `fk_table1_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `merkadit`.`Roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`PermisosxUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`PermisosxUsuarios` (
  `usuarios_idUsuario` INT NOT NULL,
  `Permisos_idPermiso` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  `lastDel` DATETIME NULL,
  INDEX `fk_PermisosxUsuarios_usuarios1_idx` (`usuarios_idUsuario` ASC) VISIBLE,
  INDEX `fk_PermisosxUsuarios_Permisos1_idx` (`Permisos_idPermiso` ASC) VISIBLE,
  CONSTRAINT `fk_PermisosxUsuarios_usuarios1`
    FOREIGN KEY (`usuarios_idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PermisosxUsuarios_Permisos1`
    FOREIGN KEY (`Permisos_idPermiso`)
    REFERENCES `merkadit`.`Permisos` (`idPermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Facturas` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `idContrato` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `codigo` VARCHAR(20) NOT NULL,
  `precioBruto` DECIMAL(15,2) NOT NULL,
  `IVA` DECIMAL(15,2) NULL,
  `precioTotal` DECIMAL(15,2) NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_Facturas_contratos1_idx` (`idContrato` ASC) VISIBLE,
  INDEX `fk_Facturas_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Facturas_contratos1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `merkadit`.`contratos` (`idContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facturas_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`FacturasxProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`FacturasxProductos` (
  `idProducto` INT NOT NULL,
  `idFactura` INT NOT NULL,
  `cantidad` INT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  INDEX `fk_FacturasxProductos_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_FacturasxProductos_Facturas1_idx` (`idFactura` ASC) VISIBLE,
  CONSTRAINT `fk_FacturasxProductos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `merkadit`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FacturasxProductos_Facturas1`
    FOREIGN KEY (`idFactura`)
    REFERENCES `merkadit`.`Facturas` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Movimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Movimientos` (
  `idMovimiento` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `tipo` ENUM("Entrada", "Salida") NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `costo` DECIMAL(15,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `cantAntes` INT NULL,
  `cantDespues` INT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idMovimiento`),
  INDEX `fk_Restocks_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Restocks_Productos1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Restocks_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restocks_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `merkadit`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Gastos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Gastos` (
  `idGasto` INT NOT NULL AUTO_INCREMENT,
  `idContrato` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idGasto`),
  INDEX `fk_Gastos_contratos1_idx` (`idContrato` ASC) VISIBLE,
  INDEX `fk_Gastos_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Gastos_contratos1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `merkadit`.`contratos` (`idContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gastos_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
