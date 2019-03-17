-- MySQL Script generated by MySQL Workbench
-- Sun Mar 17 22:39:19 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lab_assistant
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `lab_assistant` ;

-- -----------------------------------------------------
-- Schema lab_assistant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lab_assistant` DEFAULT CHARACTER SET utf8 ;
USE `lab_assistant` ;

-- -----------------------------------------------------
-- Table `lab_assistant`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`course` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`course` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` VARCHAR(32) NOT NULL COMMENT '名前',
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'コース';


-- -----------------------------------------------------
-- Table `lab_assistant`.`gender`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`gender` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`gender` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` VARCHAR(32) NOT NULL COMMENT '名前',
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '性別';


-- -----------------------------------------------------
-- Table `lab_assistant`.`lesson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`lesson` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`lesson` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `course_id` INT NOT NULL,
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lesson_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `lab_assistant`.`course` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '授業';


-- -----------------------------------------------------
-- Table `lab_assistant`.`lesson_participant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`lesson_participant` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`lesson_participant` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT NOT NULL,
  `lesson_id` INT NOT NULL,
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lesson_participant_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `lab_assistant`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_lesson_participant_lesson1`
    FOREIGN KEY (`lesson_id`)
    REFERENCES `lab_assistant`.`lesson` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = '授業スタッフ';


-- -----------------------------------------------------
-- Table `lab_assistant`.`lesson_schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`lesson_schedule` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`lesson_schedule` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lesson_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lesson_schedule_lesson1`
    FOREIGN KEY (`lesson_id`)
    REFERENCES `lab_assistant`.`lesson` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_lesson_schedule_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `lab_assistant`.`schedule` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = '授業スケジュール';


-- -----------------------------------------------------
-- Table `lab_assistant`.`lesson_staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`lesson_staff` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`lesson_staff` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT NOT NULL,
  `lesson_id` INT NOT NULL,
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lesson_staff_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `lab_assistant`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_lesson_staff_lesson1`
    FOREIGN KEY (`lesson_id`)
    REFERENCES `lab_assistant`.`lesson` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = '授業スタッフ';


-- -----------------------------------------------------
-- Table `lab_assistant`.`schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`schedule` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`schedule` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `from_datetime` DATETIME NOT NULL COMMENT 'FORM日時',
  `to_datetime` DATETIME NOT NULL COMMENT 'TO日時',
  `schedule_group_id` INT NOT NULL,
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_schedule_schedule_group1`
    FOREIGN KEY (`schedule_group_id`)
    REFERENCES `lab_assistant`.`schedule_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'スケジュール';


-- -----------------------------------------------------
-- Table `lab_assistant`.`schedule_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`schedule_group` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`schedule_group` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'スケジュールグループ';


-- -----------------------------------------------------
-- Table `lab_assistant`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`user` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `last_name` VARCHAR(32) NULL DEFAULT NULL COMMENT '名字',
  `first_name` VARCHAR(32) NULL DEFAULT NULL COMMENT '名前',
  `last_name_kana` VARCHAR(32) NULL DEFAULT NULL COMMENT '名字カナ',
  `first_name_kana` VARCHAR(32) NULL DEFAULT NULL COMMENT '名前カナ',
  `birth_date` DATE NULL DEFAULT NULL COMMENT '生年月日',
  `phone_number` VARCHAR(16) NULL DEFAULT NULL COMMENT '電話番号',
  `mail_address` VARCHAR(256) NULL DEFAULT NULL COMMENT 'メールアドレス',
  `gender_id` INT NOT NULL,
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_gender1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `lab_assistant`.`gender` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'ユーザ';


-- -----------------------------------------------------
-- Table `lab_assistant`.`user_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`user_type` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`user_type` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` VARCHAR(32) NOT NULL COMMENT '名前',
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'ユーザ種別';


-- -----------------------------------------------------
-- Table `lab_assistant`.`user_user_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lab_assistant`.`user_user_type` ;

CREATE TABLE IF NOT EXISTS `lab_assistant`.`user_user_type` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT NOT NULL,
  `user_type_id` INT NOT NULL,
  `del_flg` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '削除フラグ',
  `create_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '作成者',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '作成日時',
  `update_by` INT(8) NOT NULL DEFAULT 99999999 COMMENT '更新者',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT '更新日時',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_user_type_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `lab_assistant`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_user_type_user_type1`
    FOREIGN KEY (`user_type_id`)
    REFERENCES `lab_assistant`.`user_type` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = 'ユーザユーザ種別';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
