-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: bd_farmacia
-- Source Schemata: bd_farmacia
-- Created: Fri Sep  7 11:27:34 2018
-- Workbench Version: 8.0.12
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema bd_farmacia
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `bd_farmacia` ;
CREATE SCHEMA IF NOT EXISTS `bd_farmacia` ;

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.categoria
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`categoria` (
  `cod_cat` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`cod_cat`));

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.empleado
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`empleado` (
  `ci` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `paterno` VARCHAR(30) NOT NULL,
  `materno` VARCHAR(30) NULL,
  `direccion` VARCHAR(30) NOT NULL,
  `telefono` VARCHAR(30) NULL,
  `id_perfil` INT NULL,
  `id_tienda` INT NULL,
  `usu` VARCHAR(30) NULL,
  `clave` VARCHAR(128) NULL,
  `correo` VARCHAR(40) NULL,
  `estado` INT NULL,
  PRIMARY KEY (`ci`),
  CONSTRAINT `FK_empleado_perfil`
    FOREIGN KEY (`id_perfil`)
    REFERENCES `bd_farmacia`.`perfil` (`id_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_empleado_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `bd_farmacia`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.laboratorio
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`laboratorio` (
  `cod_lab` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(30) NOT NULL,
  `telefono` CHAR(12) NOT NULL,
  `email` VARCHAR(40) NULL,
  `web` VARCHAR(200) NULL,
  `estado` INT NULL,
  PRIMARY KEY (`cod_lab`));

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.ajuste
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`ajuste` (
  `cod_ajt` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `observacion` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`cod_ajt`));

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.medicamento
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`medicamento` (
  `cod_med` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `precio` DECIMAL(19,4) NOT NULL,
  `stock` INT NOT NULL,
  `cod_cat` INT NULL,
  `NroLote` VARCHAR(40) NULL,
  `RegSanitario` VARCHAR(40) NULL,
  `FechRegistro` DATETIME(6) NULL,
  `FechVencimiento` DATETIME(6) NULL,
  `estado` INT NULL,
  `estado_stock` INT NULL,
  PRIMARY KEY (`cod_med`),
  CONSTRAINT `FK__medicamen__cod_c__1A14E395`
    FOREIGN KEY (`cod_cat`)
    REFERENCES `bd_farmacia`.`categoria` (`cod_cat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.detalleVenta
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`detalleVenta` (
  `nro_venta` INT NOT NULL,
  `cod_med` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DECIMAL(19,4) NOT NULL,
  `estado` INT NULL,
  PRIMARY KEY (`nro_venta`, `cod_med`),
  CONSTRAINT `FK__detalleVe__cod_m__1FCDBCEB`
    FOREIGN KEY (`cod_med`)
    REFERENCES `bd_farmacia`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleVe__nro_v__1ED998B2`
    FOREIGN KEY (`nro_venta`)
    REFERENCES `bd_farmacia`.`venta` (`nro_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.proveedor
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`proveedor` (
  `cod_provee` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `nit` VARCHAR(30) NOT NULL,
  `direccion` VARCHAR(30) NULL,
  `telefono` INT NOT NULL,
  `cod_lab` INT NOT NULL,
  `estado` INT NULL,
  PRIMARY KEY (`cod_provee`),
  CONSTRAINT `FK__proveedor__cod_l__24927208`
    FOREIGN KEY (`cod_lab`)
    REFERENCES `bd_farmacia`.`laboratorio` (`cod_lab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.compra
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`compra` (
  `cod_compra` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `cod_provee` INT NOT NULL,
  `cod_emp` INT NOT NULL,
  PRIMARY KEY (`cod_compra`),
  CONSTRAINT `FK__compra__cod_emp__300424B4`
    FOREIGN KEY (`cod_emp`)
    REFERENCES `bd_farmacia`.`empleado` (`ci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__compra__cod_prov__2F10007B`
    FOREIGN KEY (`cod_provee`)
    REFERENCES `bd_farmacia`.`proveedor` (`cod_provee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.detalleCompra
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`detalleCompra` (
  `cod_compra` INT NOT NULL,
  `cod_med` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `costo` DECIMAL(19,4) NOT NULL,
  PRIMARY KEY (`cod_compra`, `cod_med`),
  CONSTRAINT `FK__detalleCo__cod_c__34C8D9D1`
    FOREIGN KEY (`cod_compra`)
    REFERENCES `bd_farmacia`.`compra` (`cod_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleCo__cod_m__35BCFE0A`
    FOREIGN KEY (`cod_med`)
    REFERENCES `bd_farmacia`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.detalleAjuste
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`detalleAjuste` (
  `cod_ajt` INT NOT NULL,
  `cod_med` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`cod_ajt`, `cod_med`),
  CONSTRAINT `FK__detalleAj__cod_a__3A81B327`
    FOREIGN KEY (`cod_ajt`)
    REFERENCES `bd_farmacia`.`ajuste` (`cod_ajt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleAj__cod_m__3B75D760`
    FOREIGN KEY (`cod_med`)
    REFERENCES `bd_farmacia`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.ubicacion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`ubicacion` (
  `cod_med` INT NOT NULL,
  `cod_lab` INT NOT NULL,
  PRIMARY KEY (`cod_med`, `cod_lab`),
  CONSTRAINT `FK__ubicacion__cod_m__403A8C7D`
    FOREIGN KEY (`cod_med`)
    REFERENCES `bd_farmacia`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__ubicacion__cod_l__412EB0B6`
    FOREIGN KEY (`cod_lab`)
    REFERENCES `bd_farmacia`.`laboratorio` (`cod_lab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.sysdiagrams
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`sysdiagrams` (
  `name` VARCHAR(160) NOT NULL,
  `principal_id` INT NOT NULL,
  `diagram_id` INT NOT NULL AUTO_INCREMENT,
  `version` INT NULL,
  `definition` LONGBLOB NULL,
  PRIMARY KEY (`diagram_id`),
  UNIQUE INDEX `UK_principal_name` (`principal_id` ASC, `name` ASC));

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.venta
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`venta` (
  `nro_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME(6) NOT NULL,
  `cod_clt` INT NOT NULL,
  `cod_emp` INT NOT NULL,
  `estado` INT NULL,
  PRIMARY KEY (`nro_venta`),
  CONSTRAINT `FK__venta__cod_emp__15502E78`
    FOREIGN KEY (`cod_emp`)
    REFERENCES `bd_farmacia`.`empleado` (`ci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__venta__cod_clt__145C0A3F`
    FOREIGN KEY (`cod_clt`)
    REFERENCES `bd_farmacia`.`cliente` (`cod_clt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.perfil
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`perfil` (
  `id_perfil` INT NOT NULL AUTO_INCREMENT,
  `deta_perfil` VARCHAR(30) NULL,
  PRIMARY KEY (`id_perfil`));

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.tienda
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`tienda` (
  `id_tienda` INT NOT NULL AUTO_INCREMENT,
  `det_tienda` VARCHAR(50) NULL,
  `estado` INT NULL,
  PRIMARY KEY (`id_tienda`));

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.descripcion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`descripcion` (
  `id_descip` INT NOT NULL,
  `nombre_medic` VARCHAR(30) NULL,
  `desc_medicamen` VARCHAR(30) NULL,
  PRIMARY KEY (`id_descip`));

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.detalleMedicamento
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`detalleMedicamento` (
  `cod_med` INT NOT NULL,
  `id_descrip` INT NOT NULL,
  `estado` INT NULL,
  CONSTRAINT `FK_detalleMedicamento_medicamento`
    FOREIGN KEY (`cod_med`)
    REFERENCES `bd_farmacia`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_detalleMedicamento_descripcion`
    FOREIGN KEY (`id_descrip`)
    REFERENCES `bd_farmacia`.`descripcion` (`id_descip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table bd_farmacia.cliente
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_farmacia`.`cliente` (
  `cod_clt` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(15) NOT NULL,
  `paterno` VARCHAR(20) NOT NULL,
  `materno` VARCHAR(20) NULL,
  `direccion` VARCHAR(30) NULL,
  `telefono` VARCHAR(30) NULL,
  `correo` VARCHAR(40) NULL,
  `estado` INT NULL,
  PRIMARY KEY (`cod_clt`));
SET FOREIGN_KEY_CHECKS = 1;
