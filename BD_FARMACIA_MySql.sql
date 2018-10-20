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
-- Table inkapharmacy.category
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`category_id`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.empleado
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `last_name1` VARCHAR(30) NOT NULL,
  `last_name2` VARCHAR(30) NULL,
  `address` VARCHAR(30) NOT NULL,
  `telephone` VARCHAR(30) NULL,
  `role_id` INT NULL,
  `store_id` INT NULL,
  `username` VARCHAR(30) NULL,
  `password` VARCHAR(128) NULL,
  `email` VARCHAR(40) NULL,
  `status` INT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `FK_employee_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `inkapharmacy`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_employee_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `inkapharmacy`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.laboratorio
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`laboratory` (
  `laboratory_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `address` VARCHAR(30) NOT NULL,
  `telephone` CHAR(12) NOT NULL,
  `email` VARCHAR(40) NULL,
  `web` VARCHAR(200) NULL,
  `status` INT NULL,
  PRIMARY KEY (`laboratory_id`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.ajuste
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`ajuste` (
  `cod_ajt` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `remarks` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`cod_ajt`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.medicamento
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `price` DECIMAL(19,4) NOT NULL,
  `currency` VARCHAR(3) NOT NULL,
  `stock` INT NOT NULL,
  `category_id` INT NULL,
  `lot_number` VARCHAR(40) NULL,
  `sanitary_registration_number` VARCHAR(40) NULL,
  `registration_date` DATETIME(6) NULL,
  `expiration_date` DATETIME(6) NULL,
  `status` INT NULL,
  `stock_status` INT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `FK__medicamen__cod_c__1A14E395`
    FOREIGN KEY (`category_id`)
    REFERENCES `inkapharmacy`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.sale_order_detail
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`sale_order_detail` (
  `sale_order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `sale_order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(19,4) NOT NULL,
  `currency` VARCHAR(3) NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`sale_order_detail_id`),
  CONSTRAINT `FK__detalleVe__cod_m__1FCDBCEB`
    FOREIGN KEY (`product_id`)
    REFERENCES `inkapharmacy`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleVe__nro_v__1ED998B2`
    FOREIGN KEY (`sale_order_id`)
    REFERENCES `inkapharmacy`.`sale_order` (`sale_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.proveedor
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`provider` (
  `provider_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `document_number` VARCHAR(30) NOT NULL,
  `address` VARCHAR(30) NULL,
  `telephone` VARCHAR(30) NULL,
  `laboratory_id` INT NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`provider_id`),
  CONSTRAINT `FK__provider__cod_l__24927208`
    FOREIGN KEY (`laboratory_id`)
    REFERENCES `inkapharmacy`.`laboratory` (`laboratory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.purchase_order
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`purchase_order` (
  `purchase_order_id` INT NOT NULL AUTO_INCREMENT,
  `purchase_date` DATETIME NOT NULL,
  `provider_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`purchase_order_id`),
  CONSTRAINT `FK__compra__cod_emp__300424B4`
    FOREIGN KEY (`employee_id`)
    REFERENCES `inkapharmacy`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__compra__cod_prov__2F10007B`
    FOREIGN KEY (`provider_id`)
    REFERENCES `inkapharmacy`.`provider` (`provider_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.purchase_order_detail
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`purchase_order_detail` (
  `purchase_order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `purchase_order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `cost` DECIMAL(19,4) NOT NULL,
  `currency` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`purchase_order_detail_id`),
  CONSTRAINT `FK__detalleCo__cod_c__34C8D9D1`
    FOREIGN KEY (`purchase_order_id`)
    REFERENCES `inkapharmacy`.`purchase_order` (`purchase_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleCo__cod_m__35BCFE0A`
    FOREIGN KEY (`product_id`)
    REFERENCES `inkapharmacy`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.detalleAjuste
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`detalleAjuste` (
  `cod_ajt` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `currency` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`cod_ajt`, `product_id`),
  CONSTRAINT `FK__detalleAj__cod_a__3A81B327`
    FOREIGN KEY (`cod_ajt`)
    REFERENCES `inkapharmacy`.`ajuste` (`cod_ajt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__detalleAj__cod_m__3B75D760`
    FOREIGN KEY (`product_id`)
    REFERENCES `inkapharmacy`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.ubicacion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`ubicacion` (
  `product_id` INT NOT NULL,
  `laboratory_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `laboratory_id`),
  CONSTRAINT `FK__ubicacion__cod_m__403A8C7D`
    FOREIGN KEY (`product_id`)
    REFERENCES `inkapharmacy`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__ubicacion__cod_l__412EB0B6`
    FOREIGN KEY (`laboratory_id`)
    REFERENCES `inkapharmacy`.`laboratory` (`laboratory_id`)
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
-- Table inkapharmacy.sale_order
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`sale_order` (
  `sale_order_id` INT NOT NULL AUTO_INCREMENT,
  `sale_date` DATETIME(6) NOT NULL,
  `customer_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`sale_order_id`),
  CONSTRAINT `FK__sale__employee_id__15502E78`
    FOREIGN KEY (`employee_id`)
    REFERENCES `inkapharmacy`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__sale__customer_id__145C0A3F`
    FOREIGN KEY (`customer_id`)
    REFERENCES `inkapharmacy`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.role
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`role_id`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.store
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`store` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `status` INT NULL,
  PRIMARY KEY (`store_id`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.descripcion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`descripcion` (
  `id_descip` INT NOT NULL,
  `name_medic` VARCHAR(30) NULL,
  `desc_medicamen` VARCHAR(30) NULL,
  PRIMARY KEY (`id_descip`));

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.detalleproduct
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`detalleproduct` (
  `product_id` INT NOT NULL,
  `id_descrip` INT NOT NULL,
  `status` INT NULL,
  CONSTRAINT `FK_detalleproduct_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `inkapharmacy`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_detalleproduct_descripcion`
    FOREIGN KEY (`id_descrip`)
    REFERENCES `inkapharmacy`.`descripcion` (`id_descip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.customer
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(15) NOT NULL,
  `last_name1` VARCHAR(20) NOT NULL,
  `last_name2` VARCHAR(20) NULL,
  `address` VARCHAR(30) NULL,
  `telephone` VARCHAR(30) NULL,
  `email` VARCHAR(40) NULL,
  `document_number` VARCHAR(20) NULL,
  `status` INT NULL,
  PRIMARY KEY (`customer_id`));
SET FOREIGN_KEY_CHECKS = 1;
