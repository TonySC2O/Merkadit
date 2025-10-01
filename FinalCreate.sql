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
AUTO_INCREMENT = 1
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
AUTO_INCREMENT = 1
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
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`direcciones` (
  `idDireccion` INT NOT NULL AUTO_INCREMENT,
  `idCiudad` INT NOT NULL,
  `addressLine1` VARCHAR(255) NOT NULL,
  `adressLine2` VARCHAR(255) NULL DEFAULT NULL,
  `zipCode` VARCHAR(20) NULL DEFAULT NULL,
  `geoPosition` POINT NULL DEFAULT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idDireccion`),
  INDEX `fk_Direciones_ciudades1_idx` (`idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Direciones_ciudades1`
    FOREIGN KEY (`idCiudad`)
    REFERENCES `merkadit`.`ciudades` (`idCiudad`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`edificios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`edificios` (
  `idEdificio` INT NOT NULL AUTO_INCREMENT,
  `idDireccion` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `uso` VARCHAR(20) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idEdificio`),
  INDEX `fk_edificios_direciones1_idx` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_edificios_direciones1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `merkadit`.`direcciones` (`idDireccion`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`locales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`locales` (
  `idLocal` INT NOT NULL AUTO_INCREMENT,
  `idEdificio` INT NOT NULL,
  `codigoPiso` VARCHAR(10) NULL DEFAULT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `estado` ENUM('Disponible', 'Sin cupo') NOT NULL,
  `tipo` ENUM('Gastronomico', 'Rental') NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idLocal`),
  INDEX `fk_Locales_edificios1_idx` (`idEdificio` ASC) VISIBLE,
  CONSTRAINT `fk_Locales_edificios1`
    FOREIGN KEY (`idEdificio`)
    REFERENCES `merkadit`.`edificios` (`idEdificio`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`kioskos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`kioskos` (
  `idKiosko` INT NOT NULL AUTO_INCREMENT,
  `idLocal` INT NOT NULL,
  `codigo` VARCHAR(5) NOT NULL,
  `sizem2` DECIMAL(15,2) NOT NULL,
  `estado` ENUM('Disponible', 'Ocupado', 'En renovacion') NOT NULL,
  `costeRemodelacion` DECIMAL(15,2) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idKiosko`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_Kioskos_Locales1_idx` (`idLocal` ASC) VISIBLE,
  CONSTRAINT `fk_Kioskos_Locales1`
    FOREIGN KEY (`idLocal`)
    REFERENCES `merkadit`.`locales` (`idLocal`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
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
  `password` VARBINARY(32) NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
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
  `fechaInicial` DATETIME NOT NULL,
  `fechaFinal` DATETIME NOT NULL,
  `tarifaVentas` DECIMAL(15,2) NOT NULL,
  `estadoContrato` ENUM('Activo', 'Finalizado') NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idContrato`),
  INDEX `fk_contratos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  INDEX `fk_contratos_usuarios1_idx` (`idUsuarioA` ASC) VISIBLE,
  INDEX `fk_contratos_usuarios2_idx` (`idUsuarioC` ASC) VISIBLE,
  CONSTRAINT `fk_contratos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`),
  CONSTRAINT `fk_contratos_usuarios1`
    FOREIGN KEY (`idUsuarioA`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`),
  CONSTRAINT `fk_contratos_usuarios2`
    FOREIGN KEY (`idUsuarioC`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`alquileres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`alquileres` (
  `idAlquiler` INT NOT NULL AUTO_INCREMENT,
  `idContrato` INT NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFinal` DATETIME NOT NULL,
  `montoAlquiler` DECIMAL(15,2) NOT NULL,
  `montoPagado` DECIMAL(15,2) NULL DEFAULT NULL,
  `estadoPago` ENUM('Pagado', 'Sin pagar', 'Atraso') NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAlquiler`),
  INDEX `fk_Alquileres_contratos1_idx` (`idContrato` ASC) VISIBLE,
  CONSTRAINT `fk_Alquileres_contratos1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `merkadit`.`contratos` (`idContrato`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`facturas` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `idContrato` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `codigo` VARCHAR(20) NOT NULL,
  `referencia` INT NOT NULL,
  `tipoPago` ENUM('Efectivo', 'Tarjeta') NOT NULL,
  `confirmacion` VARCHAR(10) NOT NULL,
  `precioBruto` DECIMAL(15,2) NOT NULL,
  `IVA` DECIMAL(15,2) NOT NULL,
  `precioTotal` DECIMAL(15,2) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idFactura`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_Facturas_contratos1_idx` (`idContrato` ASC) VISIBLE,
  INDEX `fk_Facturas_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  UNIQUE INDEX `referencia_UNIQUE` (`referencia` ASC) VISIBLE,
  CONSTRAINT `fk_Facturas_contratos1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `merkadit`.`contratos` (`idContrato`),
  CONSTRAINT `fk_Facturas_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `idKiosko` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `barCode` VARCHAR(30) NOT NULL,
  `descripcion` VARCHAR(300) NULL DEFAULT NULL,
  `precioUnitario` DECIMAL(15,2) NOT NULL,
  `stockActual` INT NOT NULL,
  `lastRestock` DATETIME NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Productos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`facturasxproductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`facturasxproductos` (
  `idProducto` INT NOT NULL,
  `idFactura` INT NOT NULL,
  `precioUnitario` DECIMAL(15,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  INDEX `fk_FacturasxProductos_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_FacturasxProductos_Facturas1_idx` (`idFactura` ASC) VISIBLE,
  CONSTRAINT `fk_FacturasxProductos_Facturas1`
    FOREIGN KEY (`idFactura`)
    REFERENCES `merkadit`.`facturas` (`idFactura`),
  CONSTRAINT `fk_FacturasxProductos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `merkadit`.`productos` (`idProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`gastos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`gastos` (
  `idGasto` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idKiosko` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `monto` DECIMAL(15,2) NOT NULL,
  `fechaGasto` DATETIME NULL DEFAULT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idGasto`),
  INDEX `fk_Gastos_usuarios2_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Gastos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  CONSTRAINT `fk_Gastos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`),
  CONSTRAINT `fk_Gastos_usuarios2`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`kioskosxcontratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`kioskosxcontratos` (
  `idKiosko` INT NOT NULL,
  `idContrato` INT NOT NULL,
  INDEX `fk_KioskosxContratos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  INDEX `fk_KioskosxContratos_contratos1_idx` (`idContrato` ASC) VISIBLE,
  CONSTRAINT `fk_KioskosxContratos_contratos1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `merkadit`.`contratos` (`idContrato`),
  CONSTRAINT `fk_KioskosxContratos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`movimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`movimientos` (
  `idMovimiento` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `idFactura` INT NULL DEFAULT NULL,
  `tipo` ENUM('Entrada', 'Salida') NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `monto` DECIMAL(15,2) NOT NULL DEFAULT '0.00',
  `cantidad` INT NOT NULL,
  `cantAntes` INT NOT NULL,
  `cantDespues` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idMovimiento`),
  INDEX `fk_Restocks_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Restocks_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_movimientos_facturas1_idx` (`idFactura` ASC) VISIBLE,
  CONSTRAINT `fk_movimientos_facturas1`
    FOREIGN KEY (`idFactura`)
    REFERENCES `merkadit`.`facturas` (`idFactura`),
  CONSTRAINT `fk_Restocks_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `merkadit`.`productos` (`idProducto`),
  CONSTRAINT `fk_Restocks_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`pagosalquiler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`pagosalquiler` (
  `idPagoAlquiler` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idAlquiler` INT NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `monto` DECIMAL(15,2) NOT NULL,
  `pagoAntes` DECIMAL(15,2) NOT NULL,
  `pagoDespues` DECIMAL(15,2) NOT NULL,
  `postTime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idPagoAlquiler`),
  INDEX `fk_PagosAlquiler_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_PagosAlquiler_Alquileres1_idx` (`idAlquiler` ASC) VISIBLE,
  CONSTRAINT `fk_PagosAlquiler_Alquileres1`
    FOREIGN KEY (`idAlquiler`)
    REFERENCES `merkadit`.`alquileres` (`idAlquiler`),
  CONSTRAINT `fk_PagosAlquiler_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`permisos` (
  `idPermiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  `lastDel` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idPermiso`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`roles` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  `lastDel` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idRol`),
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`permisosxrol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`permisosxrol` (
  `idRol` INT NOT NULL,
  `idPermiso` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  `lastDel` DATETIME NULL DEFAULT NULL,
  INDEX `fk_PermisosxRol_Roles1_idx` (`idRol` ASC) VISIBLE,
  INDEX `fk_PermisosxRol_Permisos1_idx` (`idPermiso` ASC) VISIBLE,
  CONSTRAINT `fk_PermisosxRol_Permisos1`
    FOREIGN KEY (`idPermiso`)
    REFERENCES `merkadit`.`permisos` (`idPermiso`),
  CONSTRAINT `fk_PermisosxRol_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `merkadit`.`roles` (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`permisosxusuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`permisosxusuarios` (
  `idUsuario` INT NOT NULL,
  `idPermiso` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  `lastDel` DATETIME NULL DEFAULT NULL,
  INDEX `fk_PermisosxUsuarios_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_PermisosxUsuarios_Permisos1_idx` (`idPermiso` ASC) VISIBLE,
  CONSTRAINT `fk_PermisosxUsuarios_Permisos1`
    FOREIGN KEY (`idPermiso`)
    REFERENCES `merkadit`.`permisos` (`idPermiso`),
  CONSTRAINT `fk_PermisosxUsuarios_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`rolesxusuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`rolesxusuarios` (
  `idUsuario` INT NOT NULL,
  `idRol` INT NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT '0',
  `lastDel` DATETIME NULL DEFAULT NULL,
  INDEX `fk_table1_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_table1_Roles1_idx` (`idRol` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `merkadit`.`roles` (`idRol`),
  CONSTRAINT `fk_table1_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`usuariosxkioskos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`usuariosxkioskos` (
  `idKiosko` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  INDEX `fk_UsuariosxKioskos_kioskos1_idx` (`idKiosko` ASC) VISIBLE,
  INDEX `fk_UsuariosxKioskos_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_UsuariosxKioskos_kioskos1`
    FOREIGN KEY (`idKiosko`)
    REFERENCES `merkadit`.`kioskos` (`idKiosko`),
  CONSTRAINT `fk_UsuariosxKioskos_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `merkadit`.`Descuentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Descuentos` (
  `idDescuento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(70) NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `descuento` DECIMAL(15,2) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idDescuento`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `merkadit`.`tarifas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`tarifas` (
  `idTarifa` INT NOT NULL AUTO_INCREMENT,
  `idFactura` INT NOT NULL,
  `idContrato` INT NOT NULL,
  `tarifaVenta` DECIMAL(15,2) NOT NULL,
  `monto` DECIMAL(15,2) NOT NULL,
  `montoPagado` DECIMAL(15,2) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `del` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idTarifa`),
  INDEX `fk_tarifas_facturas1_idx` (`idFactura` ASC) VISIBLE,
  INDEX `fk_tarifas_contratos1_idx` (`idContrato` ASC) VISIBLE,
  CONSTRAINT `fk_tarifas_facturas1`
    FOREIGN KEY (`idFactura`)
    REFERENCES `merkadit`.`facturas` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tarifas_contratos1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `merkadit`.`contratos` (`idContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `merkadit`.`pagosTarifas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`pagosTarifas` (
  `idpagoTarifas` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idTarifa` INT NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `monto` DECIMAL(15,2) NOT NULL,
  `pagoAntes` DECIMAL(15,2) NOT NULL,
  `pagoDespues` DECIMAL(15,2) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idpagoTarifas`),
  INDEX `fk_pagosTarifas_tarifas1_idx` (`idTarifa` ASC) VISIBLE,
  INDEX `fk_pagosTarifas_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_pagosTarifas_tarifas1`
    FOREIGN KEY (`idTarifa`)
    REFERENCES `merkadit`.`tarifas` (`idTarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagosTarifas_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `merkadit`.`DescuentosxFacturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`DescuentosxFacturas` (
  `idDescuento` INT NOT NULL,
  `idFactura` INT NOT NULL,
  `montoDescuento` DECIMAL(15,2) NOT NULL,
  `postTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_DescuentosxFacturas_Descuentos1_idx` (`idDescuento` ASC) VISIBLE,
  INDEX `fk_DescuentosxFacturas_facturas1_idx` (`idFactura` ASC) VISIBLE,
  CONSTRAINT `fk_DescuentosxFacturas_Descuentos1`
    FOREIGN KEY (`idDescuento`)
    REFERENCES `merkadit`.`Descuentos` (`idDescuento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DescuentosxFacturas_facturas1`
    FOREIGN KEY (`idFactura`)
    REFERENCES `merkadit`.`facturas` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
