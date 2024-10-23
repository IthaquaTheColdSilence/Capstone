-- Adminer 4.8.1 MySQL 10.4.34-MariaDB-1:10.4.34+maria~ubu2004 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `Inventory`;
CREATE TABLE `Inventory` (
  `ItemID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemName` varchar(150) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Status` enum('In Stock','Out of Stock') DEFAULT 'In Stock',
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `Inventory` (`ItemID`, `ItemName`, `Price`, `Quantity`, `Status`) VALUES
(1,	'Soft Drink',	20.00,	50,	'In Stock'),
(2,	'Chips',	15.00,	30,	'In Stock'),
(3,	'Bread',	10.00,	0,	'Out of Stock');

DROP TABLE IF EXISTS `Role`;
CREATE TABLE `Role` (
  `RoleID` int(11) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `Role` (`RoleID`, `RoleName`) VALUES
(1,	'Admin'),
(2,	'Employee');

DROP TABLE IF EXISTS `Sales`;
CREATE TABLE `Sales` (
  `SaleID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Description` varchar(0) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `TotalCost` decimal(10,2) NOT NULL,
  `SaleDateTime` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`SaleID`),
  KEY `ItemID` (`ItemID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Sales_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `Inventory` (`ItemID`),
  CONSTRAINT `Sales_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `Sales` (`SaleID`, `ItemID`, `UserID`, `Description`, `Quantity`, `TotalCost`, `SaleDateTime`) VALUES
(1,	1,	2,	'',	3,	60.00,	'2024-10-23 03:27:41');

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `IsConfirmed` tinyint(1) DEFAULT 1,
  `RoleID` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `Role` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `User` (`UserID`, `Username`, `Password`, `Email`, `IsConfirmed`, `RoleID`) VALUES
(1,	'admin_user',	'hashed_password',	'admin@example.com',	1,	1),
(2,	'employee_user',	'hashed_password',	'employee@example.com',	1,	2);

-- 2024-10-23 03:44:32