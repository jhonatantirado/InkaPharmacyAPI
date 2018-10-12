-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: inkapharmacy
-- Source Schemata: inkapharmacy
-- Created: Fri Sep  7 11:27:34 2018
-- Workbench Version: 8.0.12
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- Schema inkapharmacy
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `inkapharmacy` ;
CREATE SCHEMA IF NOT EXISTS `inkapharmacy` ;

SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------------------------------------------------------
-- Table inkapharmacy.categoria
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`categoria` (
  `cod_cat` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`cod_cat`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.empleado
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`empleado` (
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
    REFERENCES `inkapharmacy`.`perfil` (`id_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_empleado_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `inkapharmacy`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.laboratorio
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`laboratorio` (
  `cod_lab` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(30) NOT NULL,
  `telefono` CHAR(12) NOT NULL,
  `email` VARCHAR(40) NULL,
  `web` VARCHAR(200) NULL,
  `estado` INT NULL,
  PRIMARY KEY (`cod_lab`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.ajuste
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`ajuste` (
  `cod_ajt` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `observacion` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`cod_ajt`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.medicamento
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`medicamento` (
  `cod_med` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `precio` DECIMAL(19,4) NOT NULL,
  `moneda` VARCHAR(3) NOT NULL,
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
    REFERENCES `inkapharmacy`.`categoria` (`cod_cat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.detalleVenta
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`detalleVenta` (
  `detalleVentaId` INT NOT NULL AUTO_INCREMENT,
  `nro_venta` INT NOT NULL,
  `cod_med` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DECIMAL(19,4) NOT NULL,
  `moneda` VARCHAR(3) NOT NULL,
  `estado` INT NULL,
  PRIMARY KEY (`detalleVentaId`),
  CONSTRAINT `FK__detalleVe__cod_m__1FCDBCEB`
    FOREIGN KEY (`cod_med`)
    REFERENCES `inkapharmacy`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleVe__nro_v__1ED998B2`
    FOREIGN KEY (`nro_venta`)
    REFERENCES `inkapharmacy`.`venta` (`nro_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.proveedor
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`proveedor` (
  `cod_provee` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `nit` VARCHAR(30) NOT NULL,
  `direccion` VARCHAR(30) NULL,
  `telefono` VARCHAR(30) NULL,
  `cod_lab` INT NOT NULL,
  `estado` INT NULL,
  PRIMARY KEY (`cod_provee`),
  CONSTRAINT `FK__proveedor__cod_l__24927208`
    FOREIGN KEY (`cod_lab`)
    REFERENCES `inkapharmacy`.`laboratorio` (`cod_lab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.compra
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`compra` (
  `cod_compra` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `cod_provee` INT NOT NULL,
  `cod_emp` INT NOT NULL,
  PRIMARY KEY (`cod_compra`),
  CONSTRAINT `FK__compra__cod_emp__300424B4`
    FOREIGN KEY (`cod_emp`)
    REFERENCES `inkapharmacy`.`empleado` (`ci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__compra__cod_prov__2F10007B`
    FOREIGN KEY (`cod_provee`)
    REFERENCES `inkapharmacy`.`proveedor` (`cod_provee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.detalleCompra
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`detalleCompra` (
  `detalleCompraId` INT NOT NULL AUTO_INCREMENT,
  `cod_compra` INT NOT NULL,
  `cod_med` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `costo` DECIMAL(19,4) NOT NULL,
  `moneda` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`detalleCompraId`),
  CONSTRAINT `FK__detalleCo__cod_c__34C8D9D1`
    FOREIGN KEY (`cod_compra`)
    REFERENCES `inkapharmacy`.`compra` (`cod_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleCo__cod_m__35BCFE0A`
    FOREIGN KEY (`cod_med`)
    REFERENCES `inkapharmacy`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.detalleAjuste
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`detalleAjuste` (
  `cod_ajt` INT NOT NULL,
  `cod_med` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `moneda` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`cod_ajt`, `cod_med`),
  CONSTRAINT `FK__detalleAj__cod_a__3A81B327`
    FOREIGN KEY (`cod_ajt`)
    REFERENCES `inkapharmacy`.`ajuste` (`cod_ajt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleAj__cod_m__3B75D760`
    FOREIGN KEY (`cod_med`)
    REFERENCES `inkapharmacy`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.ubicacion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`ubicacion` (
  `cod_med` INT NOT NULL,
  `cod_lab` INT NOT NULL,
  PRIMARY KEY (`cod_med`, `cod_lab`),
  CONSTRAINT `FK__ubicacion__cod_m__403A8C7D`
    FOREIGN KEY (`cod_med`)
    REFERENCES `inkapharmacy`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__ubicacion__cod_l__412EB0B6`
    FOREIGN KEY (`cod_lab`)
    REFERENCES `inkapharmacy`.`laboratorio` (`cod_lab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.sysdiagrams
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`sysdiagrams` (
  `name` VARCHAR(160) NOT NULL,
  `principal_id` INT NOT NULL,
  `diagram_id` INT NOT NULL AUTO_INCREMENT,
  `version` INT NULL,
  `definition` LONGBLOB NULL,
  PRIMARY KEY (`diagram_id`),
  UNIQUE INDEX `UK_principal_name` (`principal_id` ASC, `name` ASC));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.venta
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`venta` (
  `nro_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME(6) NOT NULL,
  `cod_clt` INT NOT NULL,
  `cod_emp` INT NOT NULL,
  `estado` INT NULL,
  PRIMARY KEY (`nro_venta`),
  CONSTRAINT `FK__venta__cod_emp__15502E78`
    FOREIGN KEY (`cod_emp`)
    REFERENCES `inkapharmacy`.`empleado` (`ci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__venta__cod_clt__145C0A3F`
    FOREIGN KEY (`cod_clt`)
    REFERENCES `inkapharmacy`.`cliente` (`cod_clt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.perfil
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`perfil` (
  `id_perfil` INT NOT NULL AUTO_INCREMENT,
  `deta_perfil` VARCHAR(30) NULL,
  PRIMARY KEY (`id_perfil`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.tienda
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`tienda` (
  `id_tienda` INT NOT NULL AUTO_INCREMENT,
  `det_tienda` VARCHAR(50) NULL,
  `estado` INT NULL,
  PRIMARY KEY (`id_tienda`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.descripcion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`descripcion` (
  `id_descip` INT NOT NULL,
  `nombre_medic` VARCHAR(30) NULL,
  `desc_medicamen` VARCHAR(30) NULL,
  PRIMARY KEY (`id_descip`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.detalleMedicamento
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`detalleMedicamento` (
  `cod_med` INT NOT NULL,
  `id_descrip` INT NOT NULL,
  `estado` INT NULL,
  CONSTRAINT `FK_detalleMedicamento_medicamento`
    FOREIGN KEY (`cod_med`)
    REFERENCES `inkapharmacy`.`medicamento` (`cod_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_detalleMedicamento_descripcion`
    FOREIGN KEY (`id_descrip`)
    REFERENCES `inkapharmacy`.`descripcion` (`id_descip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.cliente
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`cliente` (
  `cod_clt` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(15) NOT NULL,
  `paterno` VARCHAR(20) NOT NULL,
  `materno` VARCHAR(20) NULL,
  `direccion` VARCHAR(30) NULL,
  `telefono` VARCHAR(30) NULL,
  `correo` VARCHAR(40) NULL,
  `documento` VARCHAR(20) NULL,
  `estado` INT NULL,
  PRIMARY KEY (`cod_clt`));
SET FOREIGN_KEY_CHECKS = 1;
