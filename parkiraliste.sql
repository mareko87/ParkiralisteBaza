/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.14-MariaDB : Database - parkiraliste
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`parkiraliste` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `parkiraliste`;

/*Table structure for table `administrator` */

DROP TABLE IF EXISTS `administrator`;

CREATE TABLE `administrator` (
  `AdministratorID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `Ime` VARCHAR(120) DEFAULT NULL,
  `Prezime` VARCHAR(120) DEFAULT NULL,
  `KorisnickoIme` VARCHAR(40) NOT NULL,
  `Lozinka` VARCHAR(40) NOT NULL,
  `GlavniAdministrator` TINYINT(4) NOT NULL,
  `ParkiralisteID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`AdministratorID`),
  KEY `Parkiraliste` (`ParkiralisteID`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`ParkiralisteID`) REFERENCES `parkiraliste` (`ParkiralisteID`) ON DELETE CASCADE
) ENGINE=INNODB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `administrator` */

INSERT  INTO `administrator`(`AdministratorID`,`Ime`,`Prezime`,`KorisnickoIme`,`Lozinka`,`GlavniAdministrator`,`ParkiralisteID`) VALUES 
(1,'Marko','Milosevic','mareko','mareko123',1,1),
(2,'Stefan','Stefanovic','stefi','stefi123',0,2),
(3,'Sara','Saric','sarita','sarita123',0,2),
(4,'Marija','Milosevic','mara','mara123',0,2),
(5,'Jaksa','Jaksic','jaksa_123','jaksa123',0,1),
(7,'Novak','Novak','nole','nole123',0,1);

/*Table structure for table `organizacija` */

DROP TABLE IF EXISTS `organizacija`;

CREATE TABLE `organizacija` (
  `OrganizacijaID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(120) DEFAULT NULL,
  `Adresa` VARCHAR(120) DEFAULT NULL,
  PRIMARY KEY (`OrganizacijaID`)
) ENGINE=INNODB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `organizacija` */

INSERT  INTO `organizacija`(`OrganizacijaID`,`Naziv`,`Adresa`) VALUES 
(1,'Tehnomania','Kneza Milosa 70'),
(2,'Gigatron','Kraljice Marije 20'),
(4,'FON','Jove Ilica 154, Beograd'),
(5,'FPN','Jove Ilica 165'),
(6,'Nordeus','Milutina Milankovica 11, Beograd'),
(7,'Skroz dobra pekara','Gospodar Jovanova 27'),
(8,'Nova organizacija','Ulica nova 123, Novi Beograd'),
(9,'Termodom','Zrenjaninski put 102, Beograd'),
(10,'Donesi','Viline Vode BB, Bepgrad'),
(11,'Nova organizacija 2','Kovilovo BB, Beograd'),
(12,'Nova organizacija 3','Jakova Galusa 22, Beograd'),
(13,'Nova organozacija 4','Bahtijara Vagabzade 44a, Beograd'),
(14,'Nova organizacija 5','Naselje Kotez BB, Beograd');

/*Table structure for table `parkiraliste` */

DROP TABLE IF EXISTS `parkiraliste`;

CREATE TABLE `parkiraliste` (
  `ParkiralisteID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `Adresa` VARCHAR(120) DEFAULT NULL,
  `Kapacitet` INT(11) NOT NULL,
  PRIMARY KEY (`ParkiralisteID`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `parkiraliste` */

INSERT  INTO `parkiraliste`(`ParkiralisteID`,`Adresa`,`Kapacitet`) VALUES 
(1,'Kneza Milosa 65',200),
(2,'Kraljice Marije 15',180);

/*Table structure for table `racun` */

DROP TABLE IF EXISTS `racun`;

CREATE TABLE `racun` (
  `RacunID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `Datum` DATE DEFAULT NULL,
  `BrojRezervisanihMesta` INT(11) NOT NULL,
  `IznosBezPopusta` DECIMAL(10,2) DEFAULT NULL,
  `Popust` DECIMAL(10,2) DEFAULT NULL,
  `IznosSaPopustom` DECIMAL(10,2) DEFAULT NULL,
  `AdministratorID` BIGINT(20) NOT NULL,
  `OrganizacijaID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`RacunID`),
  KEY `AdministratorID` (`AdministratorID`,`OrganizacijaID`),
  KEY `racun_ibfk_2` (`OrganizacijaID`),
  CONSTRAINT `racun_ibfk_1` FOREIGN KEY (`AdministratorID`) REFERENCES `administrator` (`AdministratorID`),
  CONSTRAINT `racun_ibfk_2` FOREIGN KEY (`OrganizacijaID`) REFERENCES `organizacija` (`OrganizacijaID`)
) ENGINE=INNODB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

/*Data for the table `racun` */

INSERT  INTO `racun`(`RacunID`,`Datum`,`BrojRezervisanihMesta`,`IznosBezPopusta`,`Popust`,`IznosSaPopustom`,`AdministratorID`,`OrganizacijaID`) VALUES 
(1,'2021-06-25',2,2000.00,0.10,1800.00,1,1),
(2,'2021-07-03',2,1000.00,0.10,900.00,1,1),
(3,'2021-07-03',1,500.00,0.10,900.00,1,2),
(4,'2021-07-04',2,1000.00,10.00,900.00,1,1),
(5,'2021-07-04',3,1500.00,20.00,1200.00,1,2),
(6,'2021-07-05',2,1000.00,20.00,800.00,1,1),
(7,'2021-07-07',3,1500.00,30.00,1050.00,1,2);

/*Table structure for table `vozilo` */

DROP TABLE IF EXISTS `vozilo`;

CREATE TABLE `vozilo` (
  `OrganizacijaID` BIGINT(20) NOT NULL,
  `RegistarskiBroj` VARCHAR(120) NOT NULL,
  `Marka` VARCHAR(120) DEFAULT NULL,
  PRIMARY KEY (`OrganizacijaID`,`RegistarskiBroj`),
  CONSTRAINT `vozilo_ibfk_1` FOREIGN KEY (`OrganizacijaID`) REFERENCES `organizacija` (`OrganizacijaID`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

/*Data for the table `vozilo` */

INSERT  INTO `vozilo`(`OrganizacijaID`,`RegistarskiBroj`,`Marka`) VALUES 
(1,'BG-123-CD','AUDI A4'),
(1,'BG-456-GG','Volkswagen Caddy'),
(2,'BG-789-UF','BMW M5'),
(2,'NS-123-AA','Renault Kangoo'),
(2,'SD-005-BG','Opel Zafira'),
(2,'SD-741-GG','Fiat Punto'),
(4,'BG-567-IT','Ford Mondeo'),
(5,'BG-101-PR','Seat Leon'),
(5,'CA-333-LL','Skoda Fabia'),
(5,'Ni-445-XZ','BMW X5'),
(5,'SO-777-QW','Zastava 10'),
(6,'BG-001-IT','Tesla Model S'),
(7,'BG-228-DC','Fiat Doblo'),
(8,'BG-555-XX','VW Golf 7'),
(8,'BG-666-ZZ','VW Golf 6'),
(9,'BG-555-FF','Fiat Ducato'),
(10,'BG-334-BG','Fiat Panda'),
(10,'BG-335-BG','Opel Corsa'),
(10,'BG-336-BG','Renault Clio'),
(10,'BG-337-BG','Ford Fiesta'),
(11,'BG-999-CC','Skoda Octavia'),
(12,'BG-882-DF','Zastava 10'),
(13,'BG-002-XX','Tesla Model S'),
(14,'BG-2224-CD','Dacia Logan');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
