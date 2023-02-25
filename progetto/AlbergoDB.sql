
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `Albergo`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `Albergo`.`Albergo` (
  `idAlbergo` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `numeroTelefono` VARCHAR(12) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `descrizione` VARCHAR(300) NOT NULL,
  `numeroStanze` INT(11) NOT NULL,
  `Indirizzo` VARCHAR(45) NOT NULL,
  `idRecensione` INT(11) NOT NULL,
  PRIMARY KEY (`idAlbergo`),
  INDEX `index2` (`idRecensione` ASC) VISIBLE,
  CONSTRAINT `IdRecensione`
    FOREIGN KEY (`idRecensione`)
    REFERENCES `Albergo`.`Recensioni` (`idRecensione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`Recensioni` (
  `idRecensione` INT(11) NOT NULL,
  `testo` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idRecensione`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`Impiegati` (
  `idImpiegato` INT(11) NOT NULL,
  `nome` VARCHAR(30) NOT NULL,
  `cognome` VARCHAR(30) NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  `numeroTelefono` INT(12) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `idAlbergo` INT(11) NOT NULL,
  `idCategoriaSala` INT(11) NOT NULL,
  PRIMARY KEY (`idImpiegato`),
  INDEX `idAlbergo_idx` (`idAlbergo` ASC) VISIBLE,
  INDEX `idCategoriaSala_idx` (`idCategoriaSala` ASC) VISIBLE,
  CONSTRAINT `idAlbergo`
    FOREIGN KEY (`idAlbergo`)
    REFERENCES `Albergo`.`Albergo` (`idAlbergo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCategoriaSala`
    FOREIGN KEY (`idCategoriaSala`)
    REFERENCES `Albergo`.`CategoriaSala` (`idCategoriaSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`Ospiti` (
  `idOspite` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `numeroTelefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `tipoPagamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idOspite`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`ServiziAlbergo` (
  `idServizio` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(300) NOT NULL,
  `costo` DECIMAL(10,2) NOT NULL,
  `idAlbergo` INT(11) NOT NULL,
  `idRecensione` INT(11) NOT NULL,
  PRIMARY KEY (`idServizio`),
  INDEX `idRecensione3_idx` (`idRecensione` ASC) VISIBLE,
  INDEX `idAlbergo3_idx` (`idAlbergo` ASC) VISIBLE,
  CONSTRAINT `idAlbergo3`
    FOREIGN KEY (`idAlbergo`)
    REFERENCES `Albergo`.`Albergo` (`idAlbergo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idRecensione3`
    FOREIGN KEY (`idRecensione`)
    REFERENCES `Albergo`.`Recensioni` (`idRecensione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`ServiziUsatiDagliOspiti` (
  `idServiziUsato` INT(11) NOT NULL,
  `ìdServizio` INT(11) NOT NULL,
  `idPrenotazione` INT(11) NOT NULL,
  PRIMARY KEY (`idServiziUsato`),
  INDEX `idServizio_idx` (`ìdServizio` ASC) VISIBLE,
  INDEX `idPrenotazione_idx` (`idPrenotazione` ASC) VISIBLE,
  CONSTRAINT `idServizio`
    FOREIGN KEY (`ìdServizio`)
    REFERENCES `Albergo`.`ServiziAlbergo` (`idServizio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPrenotazione`
    FOREIGN KEY (`idPrenotazione`)
    REFERENCES `Albergo`.`Prenotazione` (`idPrenotazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`CategoriaSala` (
  `idCategoriaSala` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idCategoriaSala`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`Stanze` (
  `idStanza` INT(11) NOT NULL,
  `numero` INT(4) NOT NULL,
  `idAlbergo` INT(11) NOT NULL,
  `idTipoStanza` INT(11) NOT NULL,
  `disponibile` TINYINT(4) NOT NULL,
  PRIMARY KEY (`idStanza`),
  INDEX `idAlbergo_idx` (`idAlbergo` ASC) VISIBLE,
  INDEX `idTipoStanza_idx` (`idTipoStanza` ASC) VISIBLE,
  CONSTRAINT `idAlbergo1`
    FOREIGN KEY (`idAlbergo`)
    REFERENCES `Albergo`.`Albergo` (`idAlbergo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idTipoStanza`
    FOREIGN KEY (`idTipoStanza`)
    REFERENCES `Albergo`.`TipiDiStanze` (`idTipoStanza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`TipiDiStanze` (
  `idTipoStanza` INT(11) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `costo` DECIMAL(10,2) NOT NULL,
  `descrizione` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idTipoStanza`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`StanzePrenotate` (
  `idStanzaPrenotata` INT(11) NOT NULL,
  `idPrenotazione` INT(11) NOT NULL,
  `idStanza` INT(11) NOT NULL,
  PRIMARY KEY (`idStanzaPrenotata`),
  INDEX `idStanza_idx` (`idStanza` ASC) VISIBLE,
  INDEX `idPrenotazione_idx` (`idPrenotazione` ASC) VISIBLE,
  CONSTRAINT `idStanza`
    FOREIGN KEY (`idStanza`)
    REFERENCES `Albergo`.`Stanze` (`idStanza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPrenotazione4`
    FOREIGN KEY (`idPrenotazione`)
    REFERENCES `Albergo`.`Prenotazione` (`idPrenotazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Albergo`.`Prenotazione` (
  `idPrenotazione` INT(11) NOT NULL,
  `dataPrenotazione` DATETIME NOT NULL,
  `durata` VARCHAR(45) NOT NULL,
  `checkIn` DATETIME NOT NULL,
  `checkOut` DATETIME NOT NULL,
  `costoTotale` DECIMAL(10,2) NOT NULL,
  `totaleStanzePrenotate` INT(11) NOT NULL,
  `tipoPagamento` VARCHAR(45) NOT NULL,
  `idAlbergo` INT(11) NOT NULL,
  `idOspite` INT(11) NOT NULL,
  `idImpiegato` INT(11) NOT NULL,
  PRIMARY KEY (`idPrenotazione`),
  INDEX `idAlbergo_idx` (`idAlbergo` ASC) VISIBLE,
  INDEX `idOspite_idx` (`idOspite` ASC) VISIBLE,
  INDEX `idImpiegato_idx` (`idImpiegato` ASC) VISIBLE,
  CONSTRAINT `idAlbergo2`
    FOREIGN KEY (`idAlbergo`)
    REFERENCES `Albergo`.`Albergo` (`idAlbergo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idOspite`
    FOREIGN KEY (`idOspite`)
    REFERENCES `Albergo`.`Ospiti` (`idOspite`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idImpiegato2`
    FOREIGN KEY (`idImpiegato`)
    REFERENCES `Albergo`.`Impiegati` (`idImpiegato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


DELIMITER $$

USE `Albergo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Albergo`.`VerificaPrezzoServizio` BEFORE INSERT ON `ServiziAlbergo` FOR EACH ROW
BEGIN
	IF NEW.costo < 0 THEN
		SET NEW.costo = 0;
	END IF;
END$$

USE `Albergo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Albergo`.`VerificaPrezzoStanza` BEFORE INSERT ON `TipiDiStanze` FOR EACH ROW
BEGIN
IF NEW.costo < 0 THEN
	       SET NEW.costo = 0;
	    END IF;
END$$

USE `Albergo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Albergo`.`VerificaPrezzoPrenotazione` BEFORE INSERT ON `Prenotazione` FOR EACH ROW
BEGIN
		IF NEW.costoTotale < 0 THEN
	       SET NEW.costoTotale = 0;
	    END IF;
END$$

USE `Albergo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Albergo`.`VerificaCheckIn` BEFORE INSERT ON `Prenotazione` FOR EACH ROW
BEGIN
	    IF NEW.checkIn < date(now()) THEN
	       SET NEW.checkIn = date(now());
	    END IF;
END$$

USE `Albergo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Albergo`.`checkDisponibilità` BEFORE INSERT ON `Prenotazione` FOR EACH ROW
BEGIN
DECLARE disponibile INT;
SELECT disponibile INTO disponibile
FROM Stanze;
END$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
