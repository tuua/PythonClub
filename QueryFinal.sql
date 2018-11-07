-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PythonClub
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PythonClub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PythonClub` DEFAULT CHARACTER SET utf8 ;
USE `PythonClub` ;

-- -----------------------------------------------------
-- Table `PythonClub`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`Person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NULL,
  `Lastname` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idPerson`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`Member` (
  `idMember` INT NOT NULL,
  `Person_idPerson` INT NOT NULL,
  `JoinDate` DATE NOT NULL,
  `MemberRole` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMember`),
  INDEX `fk_Member_Person_idx` (`Person_idPerson` ASC) VISIBLE,
  CONSTRAINT `fk_Member_Person`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `PythonClub`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`Location` (
  `idLocation` INT NOT NULL AUTO_INCREMENT,
  `RoomName` VARCHAR(255) NULL,
  `StreetAddress` VARCHAR(255) NOT NULL,
  `City` VARCHAR(255) NULL DEFAULT 'Seattle',
  `State` CHAR(2) NULL DEFAULT 'WA',
  `Zipcode` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLocation`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`Presentation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`Presentation` (
  `idPresentation` INT NOT NULL AUTO_INCREMENT,
  `PresentationDate` DATE NOT NULL,
  `PresentationTime` TIME(6) NOT NULL,
  `Topic` VARCHAR(255) NOT NULL,
  `Location_idLocation` INT NOT NULL,
  PRIMARY KEY (`idPresentation`),
  INDEX `fk_Presentation_Location1_idx` (`Location_idLocation` ASC) VISIBLE,
  CONSTRAINT `fk_Presentation_Location1`
    FOREIGN KEY (`Location_idLocation`)
    REFERENCES `PythonClub`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`Speaker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`Speaker` (
  `idSpeaker` INT NOT NULL AUTO_INCREMENT,
  `Person_idPerson` INT NOT NULL,
  `idPresentation` INT NOT NULL,
  PRIMARY KEY (`idSpeaker`),
  INDEX `fk_Speaker_Person1_idx` (`Person_idPerson` ASC) VISIBLE,
  INDEX `fk_Presentation_idx` (`idPresentation` ASC) VISIBLE,
  CONSTRAINT `fk_Speaker_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `PythonClub`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Presentation`
    FOREIGN KEY (`idPresentation`)
    REFERENCES `PythonClub`.`Presentation` (`idPresentation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`Meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`Meeting` (
  `idMeeting` INT NOT NULL AUTO_INCREMENT,
  `MeetingDate` DATE NOT NULL,
  `MeetingTime` TIME(6) NOT NULL,
  `Topic` VARCHAR(45) NOT NULL,
  `Location_idLocation` INT NOT NULL,
  PRIMARY KEY (`idMeeting`),
  INDEX `fk_Meeting_Location1_idx` (`Location_idLocation` ASC) VISIBLE,
  CONSTRAINT `fk_Meeting_Location1`
    FOREIGN KEY (`Location_idLocation`)
    REFERENCES `PythonClub`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`MeetingMinutes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`MeetingMinutes` (
  `idMeetingMinutes` INT NOT NULL AUTO_INCREMENT,
  `MeetingNotes` MEDIUMTEXT NOT NULL,
  `Actions` VARCHAR(255) NULL,
  `Summary` VARCHAR(255) NULL,
  `Meeting_idMeeting` INT NOT NULL,
  PRIMARY KEY (`idMeetingMinutes`),
  INDEX `fk_MeetingMinutes_Meeting1_idx` (`Meeting_idMeeting` ASC) VISIBLE,
  CONSTRAINT `fk_MeetingMinutes_Meeting1`
    FOREIGN KEY (`Meeting_idMeeting`)
    REFERENCES `PythonClub`.`Meeting` (`idMeeting`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`MeetingAttendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`MeetingAttendance` (
  `Member_idMember` INT NOT NULL,
  `MeetingMinutes_idMeetingMinutes` INT NOT NULL,
  INDEX `fk_MeetingAttendance_Member1_idx` (`Member_idMember` ASC) VISIBLE,
  INDEX `fk_MeetingAttendance_MeetingMinutes1_idx` (`MeetingMinutes_idMeetingMinutes` ASC) VISIBLE,
  CONSTRAINT `fk_MeetingAttendance_Member1`
    FOREIGN KEY (`Member_idMember`)
    REFERENCES `PythonClub`.`Member` (`idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MeetingAttendance_MeetingMinutes1`
    FOREIGN KEY (`MeetingMinutes_idMeetingMinutes`)
    REFERENCES `PythonClub`.`MeetingMinutes` (`idMeetingMinutes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`Resources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`Resources` (
  `idResources` INT NOT NULL AUTO_INCREMENT,
  `idMember` INT NOT NULL,
  `ResourceType` VARCHAR(45) NOT NULL,
  `ResourceName` VARCHAR(45) NOT NULL,
  `ResourceLink` VARCHAR(45) NULL,
  `ResourceLocation` VARCHAR(45) NULL,
  PRIMARY KEY (`idResources`),
  INDEX `Fk_Member_Resource_idx` (`idMember` ASC) VISIBLE,
  CONSTRAINT `Fk_Member_Resource`
    FOREIGN KEY (`idMember`)
    REFERENCES `PythonClub`.`Member` (`idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PythonClub`.`ResourceComments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PythonClub`.`ResourceComments` (
  `idResourceComments` INT NOT NULL AUTO_INCREMENT,
  `Rating` INT NOT NULL,
  `Comment` MEDIUMTEXT NULL,
  `Resources_idResources` INT NOT NULL,
  `Member_idMember` INT NOT NULL,
  PRIMARY KEY (`idResourceComments`),
  INDEX `fk_ResourceComments_Resources1_idx` (`Resources_idResources` ASC) VISIBLE,
  INDEX `fk_ResourceComments_Member1_idx` (`Member_idMember` ASC) VISIBLE,
  CONSTRAINT `fk_ResourceComments_Resources1`
    FOREIGN KEY (`Resources_idResources`)
    REFERENCES `PythonClub`.`Resources` (`idResources`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ResourceComments_Member1`
    FOREIGN KEY (`Member_idMember`)
    REFERENCES `PythonClub`.`Member` (`idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
