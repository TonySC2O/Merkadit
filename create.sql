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
  `nombre` VARCHAR(70) NULL,
  PRIMARY KEY (`idPais`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`estados` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `idPais` INT NOT NULL,
  `nombre` VARCHAR(70) NULL,
  PRIMARY KEY (`idEstado`),
  INDEX `fk_estados_paises1_idx` (`idPais` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_estados_paises1`
    FOREIGN KEY (`idPais`)
    REFERENCES `merkadit`.`paises` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`ciudades` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `idEstados` INT NOT NULL,
  `nombre` VARCHAR(70) NULL,
  PRIMARY KEY (`idCiudad`),
  INDEX `fk_ciudades_estados1_idx` (`idEstados` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_ciudades_estados1`
    FOREIGN KEY (`idEstados`)
    REFERENCES `merkadit`.`estados` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Direciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Direciones` (
  `idDirecion` INT NOT NULL AUTO_INCREMENT,
  `idCiudad` INT NOT NULL,
  `nombre` VARCHAR(70) NULL,
  PRIMARY KEY (`idDirecion`),
  INDEX `fk_Direciones_ciudades1_idx` (`idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Direciones_ciudades1`
    FOREIGN KEY (`idCiudad`)
    REFERENCES `merkadit`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Edificios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Edificios` (
  `idEdificio` INT NOT NULL AUTO_INCREMENT,
  `idDirecion` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  PRIMARY KEY (`idEdificio`),
  INDEX `fk_Edificios_Direciones1_idx` (`idDirecion` ASC) VISIBLE,
  CONSTRAINT `fk_Edificios_Direciones1`
    FOREIGN KEY (`idDirecion`)
    REFERENCES `merkadit`.`Direciones` (`idDirecion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Categorias` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  `tarifa` DECIMAL(15,2) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Inventarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Inventarios` (
  `idInventario` INT NOT NULL AUTO_INCREMENT,
  `lastPost` DATETIME NULL,
  PRIMARY KEY (`idInventario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Mercados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Mercados` (
  `idMercado` INT NOT NULL AUTO_INCREMENT,
  `idCategoria` INT NOT NULL,
  `idInventario` INT NOT NULL,
  `codigo` VARCHAR(5) NULL,
  `sizem2` DECIMAL(15,2) NULL,
  `estado` ENUM("Disponible", "Ocupado", "En renovacion") NULL,
  `fechaInaguracion` DATETIME NULL,
  `lastPost` DATETIME NULL,
  `del` INT NULL,
  PRIMARY KEY (`idMercado`),
  INDEX `fk_Mercados_Categorias1_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `fk_Mercados_Inventario1_idx` (`idInventario` ASC) VISIBLE,
  CONSTRAINT `fk_Mercados_Categorias1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `merkadit`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mercados_Inventario1`
    FOREIGN KEY (`idInventario`)
    REFERENCES `merkadit`.`Inventarios` (`idInventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`MercadosxEdificios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`MercadosxEdificios` (
  `idEdificio` INT NOT NULL,
  `idMercado` INT NOT NULL,
  INDEX `fk_MercadosxEdificios_Edificios_idx` (`idEdificio` ASC) VISIBLE,
  INDEX `fk_MercadosxEdificios_Mercados1_idx` (`idMercado` ASC) VISIBLE,
  CONSTRAINT `fk_MercadosxEdificios_Edificios`
    FOREIGN KEY (`idEdificio`)
    REFERENCES `merkadit`.`Edificios` (`idEdificio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MercadosxEdificios_Mercados1`
    FOREIGN KEY (`idMercado`)
    REFERENCES `merkadit`.`Mercados` (`idMercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(70) NULL,
  `cedula` VARCHAR(20) NULL,
  `fechaInicio` DATETIME NULL,
  `lastPost` DATETIME NULL,
  `del` INT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`MercadosxUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`MercadosxUsuarios` (
  `idMercado` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  INDEX `fk_MercadosxUsuarios_Mercados1_idx` (`idMercado` ASC) VISIBLE,
  INDEX `fk_MercadosxUsuarios_Usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_MercadosxUsuarios_Mercados1`
    FOREIGN KEY (`idMercado`)
    REFERENCES `merkadit`.`Mercados` (`idMercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MercadosxUsuarios_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Roles` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NULL,
  `enabled` INT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`UsuariosxRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`UsuariosxRoles` (
  `idUsuario` INT NOT NULL,
  `idRol` INT NOT NULL,
  `lastPost` DATETIME NULL,
  `enabled` INT NULL,
  INDEX `fk_UsuariosxRoles_Usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_UsuariosxRoles_Roles1_idx` (`idRol` ASC) VISIBLE,
  CONSTRAINT `fk_UsuariosxRoles_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UsuariosxRoles_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `merkadit`.`Roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Permisos` (
  `idPermiso` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `codigo` BINARY(10) NULL,
  PRIMARY KEY (`idPermiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`PermisosxRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`PermisosxRoles` (
  `idRol` INT NOT NULL,
  `idPermiso` INT NOT NULL,
  `lastPost` DATETIME NULL,
  `enabled` INT NULL,
  INDEX `fk_PermisosxRoles_Roles1_idx` (`idRol` ASC) VISIBLE,
  INDEX `fk_PermisosxRoles_Permisos1_idx` (`idPermiso` ASC) VISIBLE,
  CONSTRAINT `fk_PermisosxRoles_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `merkadit`.`Roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PermisosxRoles_Permisos1`
    FOREIGN KEY (`idPermiso`)
    REFERENCES `merkadit`.`Permisos` (`idPermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`PermisosxUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`PermisosxUsuarios` (
  `idUsuario` INT NOT NULL,
  `idPermiso` INT NOT NULL,
  `lastPost` DATETIME NULL,
  `enabled` INT NULL,
  INDEX `fk_PermisosxUsuarios_Usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_PermisosxUsuarios_Permisos1_idx` (`idPermiso` ASC) VISIBLE,
  CONSTRAINT `fk_PermisosxUsuarios_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PermisosxUsuarios_Permisos1`
    FOREIGN KEY (`idPermiso`)
    REFERENCES `merkadit`.`Permisos` (`idPermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Contratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Contratos` (
  `idContratos` INT NOT NULL AUTO_INCREMENT,
  `idMercado` INT NOT NULL,
  `idUsuarioAdmin` INT NOT NULL,
  `idUsuarioOwner` INT NOT NULL,
  `fechaInicio` DATETIME NULL,
  `fechaFinal` DATETIME NULL,
  `fechaCobro` DATETIME NULL,
  `montoBase` DECIMAL(15,2) NULL,
  `estado` VARCHAR(45) NULL,
  `documento` BLOB NULL,
  `enabled` INT NULL,
  `lastPost` DATETIME NULL,
  PRIMARY KEY (`idContratos`),
  INDEX `fk_Contratos_Mercados1_idx` (`idMercado` ASC) VISIBLE,
  INDEX `fk_Contratos_Usuarios1_idx` (`idUsuarioAdmin` ASC) VISIBLE,
  INDEX `fk_Contratos_Usuarios2_idx` (`idUsuarioOwner` ASC) VISIBLE,
  UNIQUE INDEX `idUsuarioOwner_UNIQUE` (`idUsuarioOwner` ASC) VISIBLE,
  UNIQUE INDEX `idUsuarioAdmin_UNIQUE` (`idUsuarioAdmin` ASC) VISIBLE,
  CONSTRAINT `fk_Contratos_Mercados1`
    FOREIGN KEY (`idMercado`)
    REFERENCES `merkadit`.`Mercados` (`idMercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contratos_Usuarios1`
    FOREIGN KEY (`idUsuarioAdmin`)
    REFERENCES `merkadit`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contratos_Usuarios2`
    FOREIGN KEY (`idUsuarioOwner`)
    REFERENCES `merkadit`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`MercadosxContratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`MercadosxContratos` (
  `idMercado` INT NOT NULL,
  `idContratos` INT NOT NULL,
  INDEX `fk_MercadosxContratos_Mercados1_idx` (`idMercado` ASC) VISIBLE,
  INDEX `fk_MercadosxContratos_Contratos1_idx` (`idContratos` ASC) VISIBLE,
  CONSTRAINT `fk_MercadosxContratos_Mercados1`
    FOREIGN KEY (`idMercado`)
    REFERENCES `merkadit`.`Mercados` (`idMercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MercadosxContratos_Contratos1`
    FOREIGN KEY (`idContratos`)
    REFERENCES `merkadit`.`Contratos` (`idContratos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Productos` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `idInventario` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  `descripcion` VARCHAR(300) NULL,
  `precioUnitario` DECIMAL(15,2) NULL,
  `stockActual` INT NULL,
  `stockMinimo` INT NULL,
  `stockMaximo` INT NULL,
  `lastRestock` DATETIME NULL,
  `lastPost` DATETIME NULL,
  `del` INT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_Productos_Inventarios1_idx` (`idInventario` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Inventarios1`
    FOREIGN KEY (`idInventario`)
    REFERENCES `merkadit`.`Inventarios` (`idInventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Movimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Movimientos` (
  `idproducto` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `tipoMovimiento` ENUM("Entrada", "Salida", "Ajuste") NULL,
  `cantidad` INT NULL,
  `fechaMovimiento` DATETIME NULL,
  INDEX `fk_Movimientos_Productos1_idx` (`idproducto` ASC) VISIBLE,
  INDEX `fk_Movimientos_Usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Movimientos_Productos1`
    FOREIGN KEY (`idproducto`)
    REFERENCES `merkadit`.`Productos` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimientos_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `merkadit`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Ventas` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `idMercado` INT NOT NULL,
  `fechaVenta` DATETIME NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `fk_Ventas_Mercados1_idx` (`idMercado` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Mercados1`
    FOREIGN KEY (`idMercado`)
    REFERENCES `merkadit`.`Mercados` (`idMercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`VentasxProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`VentasxProductos` (
  `idVxP` INT NOT NULL AUTO_INCREMENT,
  `idVenta` INT NOT NULL,
  `idproducto` INT NOT NULL,
  `cantidadProducto` INT NULL,
  INDEX `fk_VentasxProductos_Ventas1_idx` (`idVenta` ASC) VISIBLE,
  INDEX `fk_VentasxProductos_Productos1_idx` (`idproducto` ASC) VISIBLE,
  PRIMARY KEY (`idVxP`),
  CONSTRAINT `fk_VentasxProductos_Ventas1`
    FOREIGN KEY (`idVenta`)
    REFERENCES `merkadit`.`Ventas` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentasxProductos_Productos1`
    FOREIGN KEY (`idproducto`)
    REFERENCES `merkadit`.`Productos` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merkadit`.`Facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merkadit`.`Facturas` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `idVxP` INT NOT NULL,
  `precioBruto` DECIMAL(15,2) NULL,
  `IVA` DECIMAL(15,2) NULL,
  `precioTotal` DECIMAL(15,2) NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_Facturas_VentasxProductos1_idx` (`idVxP` ASC) VISIBLE,
  CONSTRAINT `fk_Facturas_VentasxProductos1`
    FOREIGN KEY (`idVxP`)
    REFERENCES `merkadit`.`VentasxProductos` (`idVxP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
