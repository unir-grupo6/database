-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rutina_go
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rutina_go
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rutina_go` DEFAULT CHARACTER SET utf8 ;
USE `rutina_go` ;

-- -----------------------------------------------------
-- Table `rutina_go`.`dificultad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`dificultad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nivel` VARCHAR(255) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`grupos_musculares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`grupos_musculares` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`ejercicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`ejercicios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `grupos_musculares_id` INT NOT NULL,
  `dificultad_id` INT NOT NULL,
  `nombre` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `tipo` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `inicio` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `fin` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ejercicios_grupos_musculares1_idx` (`grupos_musculares_id` ASC) VISIBLE,
  INDEX `fk_ejercicios_dificultad1_idx` (`dificultad_id` ASC) VISIBLE,
  CONSTRAINT `fk_ejercicios_grupos_musculares1`
    FOREIGN KEY (`grupos_musculares_id`)
    REFERENCES `rutina_go`.`grupos_musculares` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ejercicios_dificultad1`
    FOREIGN KEY (`dificultad_id`)
    REFERENCES `rutina_go`.`dificultad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`metodos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`metodos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dificultad_id` INT NOT NULL,
  `nombre` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `tiempo_anaerobicos` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `tiempo_aerobicos` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `observaciones` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `descanso` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_metodos_dificultad1_idx` (`dificultad_id` ASC) VISIBLE,
  CONSTRAINT `fk_metodos_dificultad1`
    FOREIGN KEY (`dificultad_id`)
    REFERENCES `rutina_go`.`dificultad` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`objetivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`objetivos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_metodos` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_metodos` (`id_metodos` ASC) VISIBLE,
  CONSTRAINT `objetivos_ibfk_1`
    FOREIGN KEY (`id_metodos`)
    REFERENCES `rutina_go`.`metodos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rutina_go`.`rutinas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`rutinas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `objetivos_id` INT NOT NULL,
  `dificultad_id` INT NOT NULL,
  `metodos_id` INT NOT NULL,
  `nombre` VARCHAR(255) CHARACTER SET 'utf8mb3' NOT NULL,
  `observaciones` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `realizada` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_id` (`id` ASC) VISIBLE,
  INDEX `fk_rutinas_objetivos1_idx` (`objetivos_id` ASC) VISIBLE,
  INDEX `fk_rutinas_metodos1_idx` (`metodos_id` ASC) VISIBLE,
  INDEX `fk_rutinas_dificultad1_idx` (`dificultad_id` ASC) VISIBLE,
  CONSTRAINT `fk_rutinas_objetivos1`
    FOREIGN KEY (`objetivos_id`)
    REFERENCES `rutina_go`.`objetivos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rutinas_metodos1`
    FOREIGN KEY (`metodos_id`)
    REFERENCES `rutina_go`.`metodos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rutinas_dificultad1`
    FOREIGN KEY (`dificultad_id`)
    REFERENCES `rutina_go`.`dificultad` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2006681955
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`ejercicios_rutinas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`ejercicios_rutinas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ejercicios_id` INT NOT NULL,
  `rutinas_id` INT NOT NULL,
  `series` TINYINT NULL DEFAULT NULL,
  `repeticiones` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `dia` VARCHAR(255) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `orden` TINYINT NULL DEFAULT NULL,
  `comentario` VARCHAR(255) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ejercicios_rutinas_ejercicios1_idx` (`ejercicios_id` ASC) VISIBLE,
  INDEX `fk_ejercicios_rutinas_rutinas1_idx` (`rutinas_id` ASC) VISIBLE,
  CONSTRAINT `fk_ejercicios_rutinas_ejercicios1`
    FOREIGN KEY (`ejercicios_id`)
    REFERENCES `rutina_go`.`ejercicios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ejercicios_rutinas_rutinas1`
    FOREIGN KEY (`rutinas_id`)
    REFERENCES `rutina_go`.`rutinas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2132754044
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(255) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `password` VARCHAR(4000) NOT NULL,
  `fecha_alta` DATETIME NULL DEFAULT current_timestamp(),
  `verificado` TINYINT NULL DEFAULT 0,
  `reset_token` VARCHAR(4000) NULL,
  `fecha_nacimiento` DATE NULL,
  `sexo` TINYINT NULL DEFAULT 3,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rutina_go`.`rutinas_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`rutinas_usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rutinas_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  `inicio` DATE NULL,
  `fin` DATE NULL,
  `compartida` TINYINT NULL DEFAULT 0,
  `dia` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rutinas_usuarios_rutinas1_idx` (`rutinas_id` ASC) VISIBLE,
  INDEX `fk_rutinas_usuarios_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_rutinas_usuarios_rutinas1`
    FOREIGN KEY (`rutinas_id`)
    REFERENCES `rutina_go`.`rutinas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rutinas_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `rutina_go`.`usuarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2407
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`ejercicios_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`ejercicios_usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ejercicios_id` INT NOT NULL,
  `rutinas_usuarios_id` INT NOT NULL,
  `series` TINYINT NULL DEFAULT NULL,
  `repeticiones` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `orden` INT NULL DEFAULT '1',
  `comentario` VARCHAR(255) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ejercicios_usuarios_ejercicios1_idx` (`ejercicios_id` ASC) VISIBLE,
  INDEX `fk_ejercicios_usuarios_rutinas_usuarios1_idx` (`rutinas_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_ejercicios_usuarios_ejercicios1`
    FOREIGN KEY (`ejercicios_id`)
    REFERENCES `rutina_go`.`ejercicios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ejercicios_usuarios_rutinas_usuarios1`
    FOREIGN KEY (`rutinas_usuarios_id`)
    REFERENCES `rutina_go`.`rutinas_usuarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 67116
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `rutina_go`.`medidas_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`medidas_usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `peso` INT NOT NULL,
  `altura` INT NOT NULL,
  `fecha` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `imc` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `medidas_usuarios_ibfk_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `rutina_go`.`usuarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rutina_go`.`objetivos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`objetivos_usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_usuarios` INT NOT NULL,
  `id_objetivos` INT NOT NULL,
  `fecha` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_usuarios` (`id_usuarios` ASC) VISIBLE,
  INDEX `id_objetivos` (`id_objetivos` ASC) VISIBLE,
  CONSTRAINT `objetivos_usuarios_ibfk_1`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `rutina_go`.`usuarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `objetivos_usuarios_ibfk_2`
    FOREIGN KEY (`id_objetivos`)
    REFERENCES `rutina_go`.`objetivos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rutina_go`.`autogenerated_routine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rutina_go`.`autogenerated_routine` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `idrutina` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `fecha` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_autogenerated_routine_rutinas1_idx` (`idrutina` ASC) VISIBLE,
  INDEX `fk_autogenerated_routine_usuarios1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_autogenerated_routine_rutinas1`
    FOREIGN KEY (`idrutina`)
    REFERENCES `rutina_go`.`rutinas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autogenerated_routine_usuarios1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `rutina_go`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
