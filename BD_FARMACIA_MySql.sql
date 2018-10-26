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

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.category
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`category` (
  `category_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`category_id`))
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  
-- ----------------------------------------------------------------------------
-- Table inkapharmacy.role
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`role` (
  `role_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`role_id`))
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.store
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`store` (
  `store_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `status` INT NULL,
  PRIMARY KEY (`store_id`))
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.customer
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`customer` (
  `customer_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(15) NOT NULL,
  `last_name1` VARCHAR(20) NOT NULL,
  `last_name2` VARCHAR(20) NULL,
  `address` VARCHAR(30) NULL,
  `telephone` VARCHAR(30) NULL,
  `email` VARCHAR(40) NULL,
  `document_number` VARCHAR(20) NULL,
  `status` INT NULL,
  PRIMARY KEY (`customer_id`))
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.empleado
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`employee` (
  `employee_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `last_name1` VARCHAR(30) NOT NULL,
  `last_name2` VARCHAR(30) NULL,
  `address` VARCHAR(30) NOT NULL,
  `telephone` VARCHAR(30) NULL,
  `role_id` BIGINT UNSIGNED NOT NULL,
  `store_id` BIGINT UNSIGNED NOT NULL,
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
    ON UPDATE NO ACTION)
	ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.medicamento
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`product` (
  `product_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `price` DECIMAL(19,4) NOT NULL,
  `currency` VARCHAR(3) NOT NULL,
  `stock` INT NOT NULL,
  `category_id` BIGINT UNSIGNED NOT NULL,
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
    ON UPDATE NO ACTION)
	ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.proveedor
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`provider` (
  `provider_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `document_number` VARCHAR(30) NOT NULL,
  `address` VARCHAR(30) NULL,
  `telephone` VARCHAR(30) NULL,
  `status` INT NULL,
  PRIMARY KEY (`provider_id`))
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.purchase_order
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`purchase_order` (
  `purchase_order_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_date` DATETIME NOT NULL,
  `provider_id` BIGINT UNSIGNED NOT NULL,
  `employee_id` BIGINT UNSIGNED NOT NULL,
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
    ON UPDATE NO ACTION)
	ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.purchase_order_detail
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`purchase_order_detail` (
  `purchase_order_detail_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_order_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
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
    ON UPDATE NO ACTION)
	ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.sale_order
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`sale_order` (
  `sale_order_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sale_date` DATETIME(6) NOT NULL,
  `customer_id` BIGINT UNSIGNED NOT NULL,
  `employee_id` BIGINT UNSIGNED NOT NULL,
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
    ON UPDATE NO ACTION)
	ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table inkapharmacy.sale_order_detail
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `inkapharmacy`.`sale_order_detail` (
  `sale_order_detail_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sale_order_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
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
    ON UPDATE NO ACTION)
	ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;