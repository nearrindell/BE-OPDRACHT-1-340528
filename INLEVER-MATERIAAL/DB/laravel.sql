-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 02, 2025 at 10:05 PM
-- Server version: 9.0.1
-- PHP Version: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_CreateAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CreateAllergeen` (IN `p_name` VARCHAR(50), IN `p_description` VARCHAR(255))   BEGIN
    INSERT INTO Allergeen (
        naam,
        omschrijving)
    VALUES (p_name, p_description);

    SELECT LAST_INSERT_ID() AS new_id;
END$$

DROP PROCEDURE IF EXISTS `sp_DeleteAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DeleteAllergeen` (IN `p_id` INT)   BEGIN
    -- Verwijder het record in de tabel allergeen
    DELETE FROM Allergeen 
    WHERE Id = p_id;

    -- Bepaal hoeveel rijen verwijdert zijn (0 of 1)
    SELECT ROW_COUNT() AS affected;

END$$

DROP PROCEDURE IF EXISTS `Sp_GetAllAllergenen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_GetAllAllergenen` ()   BEGIN

    SELECT ALGE.Id
          ,ALGE.Naam
          ,ALGE.Omschrijving
    FROM  Allergeen AS ALGE;


END$$

DROP PROCEDURE IF EXISTS `Sp_GetAllergeenById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_GetAllergeenById` (IN `p_id` INT)   BEGIN

    SELECT ALGE.Id
          ,ALGE.Naam
          ,ALGE.Omschrijving
    FROM  Allergeen AS ALGE
    WHERE ALGE.Id = p_id;


END$$

DROP PROCEDURE IF EXISTS `sp_GetAllProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllProducts` ()   BEGIN
	
    SELECT PROD.Id
		  ,PROD.Naam
          ,PROD.Barcode
          ,MAGA.VerpakkingsEenheid
          ,MAGA.AantalAanwezig
          
	FROM Product AS PROD
    
    INNER JOIN Magazijn AS MAGA
    
    ON PROD.Id = MAGA.ProductId
    ORDER BY PROD.Barcode ASC;


END$$

DROP PROCEDURE IF EXISTS `sp_GetLeverancierInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetLeverancierInfo` (IN `p_productId` INT)   BEGIN

    SELECT PROD.Naam
          ,PPLE.DatumLevering
          ,PPLE.Aantal
          ,PPLE.DatumEerstVolgendeLevering
          ,MAGA.AantalAanwezig

    FROM Product AS PROD

    INNER JOIN ProductPerLeverancier AS PPLE
    ON PPLE.ProductId = PROD.Id

    INNER JOIN Magazijn AS MAGA
    ON MAGA.ProductId = PROD.Id
    WHERE PROD.Id = p_productId
    ORDER BY PPLE.DatumEerstVolgendeLevering ASC;
    
END$$

DROP PROCEDURE IF EXISTS `sp_GetLeverantieInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetLeverantieInfo` (IN `p_Id` INT)   BEGIN

    SELECT DISTINCT LEVE.Id
				   ,LEVE.Naam
				   ,LEVE.Contactpersoon
				   ,LEVE.Leveranciernummer
				   ,LEVE.Mobiel

    FROM   			Leverancier AS LEVE
    
    INNER JOIN 		ProductPerLeverancier AS PPLE
    ON 				LEVE.Id = PPLE.LeverancierId
    
    WHERE		    PPLE.ProductId = p_Id;

END$$

DROP PROCEDURE IF EXISTS `sp_GetProductAllergenen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetProductAllergenen` (IN `p_productId` INT)   BEGIN
    SELECT PROD.Naam AS ProductNaam
          ,PROD.Barcode
          ,ALGE.Naam
          ,ALGE.Omschrijving
    FROM Product AS PROD
    INNER JOIN ProductPerAllergeen AS PPAL
        ON PROD.Id = PPAL.ProductId
    INNER JOIN Allergeen AS ALGE
        ON PPAL.AllergeenId = ALGE.Id
    WHERE PROD.Id = p_productId
    ORDER BY ALGE.Naam ASC;
END$$

DROP PROCEDURE IF EXISTS `sp_UpdateAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateAllergeen` (IN `p_id` INT, IN `p_naam` VARCHAR(50), IN `p_omschrijving` VARCHAR(255))   BEGIN

    UPDATE   Allergeen
    SET      Naam = p_naam
            ,Omschrijving = p_omschrijving
            ,DatumGewijzigd = SYSDATE(6) 
    WHERE   Id = p_id;

    SELECT ROW_COUNT() as affected;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(30) NOT NULL,
  `Omschrijving` varchar(100) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `allergeen`
--

INSERT INTO `allergeen` (`Id`, `Naam`, `Omschrijving`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Gluten', 'Dit product bevat gluten', b'1', NULL, '2025-11-02 18:37:54.225716', '2025-11-02 18:37:54.225716'),
(2, 'Gelatine', 'Dit product bevat gelatine', b'1', NULL, '2025-11-02 18:37:54.225716', '2025-11-02 18:37:54.225716'),
(3, 'AZO-kleurstof', 'Dit product bevat AZO-kleurstof', b'1', NULL, '2025-11-02 18:37:54.225716', '2025-11-02 18:37:54.225716'),
(4, 'Lactose', 'Dit product bevat lactose', b'1', NULL, '2025-11-02 18:37:54.225716', '2025-11-02 18:37:54.225716'),
(5, 'Soja', 'Dit product bevat soja', b'1', NULL, '2025-11-02 18:37:54.225716', '2025-11-02 18:37:54.225716'),
(7, '2', '1', b'1', NULL, '2025-11-02 18:38:17.279700', '2025-11-02 18:38:22.998836');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(60) NOT NULL,
  `Contactpersoon` varchar(60) NOT NULL,
  `Leveranciernummer` varchar(11) NOT NULL,
  `Mobiel` varchar(11) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `Contactpersoon`, `Leveranciernummer`, `Mobiel`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', b'1', NULL, '2025-11-02 18:37:54.365875', '2025-11-02 18:37:54.365875'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734', b'1', NULL, '2025-11-02 18:37:54.365875', '2025-11-02 18:37:54.365875'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2025-11-02 18:37:54.365875', '2025-11-02 18:37:54.365875'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2025-11-02 18:37:54.365875', '2025-11-02 18:37:54.365875'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', b'1', NULL, '2025-11-02 18:37:54.365875', '2025-11-02 18:37:54.365875'),
(6, 'Quality Street', 'Johan Nooij', 'L1029234586', '06-23458456', b'1', NULL, '2025-11-02 18:37:54.365875', '2025-11-02 18:37:54.365875');

-- --------------------------------------------------------

--
-- Table structure for table `magazijn`
--

DROP TABLE IF EXISTS `magazijn`;
CREATE TABLE IF NOT EXISTS `magazijn` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `VerpakkingsEenheid` decimal(4,1) NOT NULL,
  `AantalAanwezig` smallint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_Magazijn_ProductId_Product_Id` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakkingsEenheid`, `AantalAanwezig`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 5.0, 453, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(2, 2, 2.5, 400, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(3, 3, 5.0, 1, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(4, 4, 1.0, 800, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(5, 5, 3.0, 234, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(6, 6, 2.0, 345, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(7, 7, 1.0, 795, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(8, 8, 10.0, 233, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(9, 9, 2.5, 123, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(10, 10, 3.0, 0, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(11, 11, 2.0, 367, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(12, 12, 1.0, 467, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892'),
(13, 13, 5.0, 20, b'1', NULL, '2025-11-02 18:37:54.329892', '2025-11-02 18:37:54.329892');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(255) NOT NULL,
  `Barcode` varchar(13) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(2, 'Schoolkrijt', '8719587326713', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(3, 'Honingdrop', '8719587327836', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(4, 'Zure Beren', '8719587321441', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(5, 'Cola Flesjes', '8719587321237', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(6, 'Turtles', '8719587322245', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(7, 'Witte Muizen', '8719587328256', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(8, 'Reuzen Slangen', '8719587325641', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(9, 'Zoute Rijen', '8719587322739', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(10, 'Winegums', '8719587327527', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(11, 'Drop Munten', '8719587322345', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(12, 'Kruis Drop', '8719587322265', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596'),
(13, 'Zoute Ruitjes', '8719587323256', b'1', NULL, '2025-11-02 18:37:54.262596', '2025-11-02 18:37:54.262596');

-- --------------------------------------------------------

--
-- Table structure for table `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `AllergeenId` smallint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerAllergeen_ProductId_Product_Id` (`ProductId`),
  KEY `FK_ProductPerAllergeen_AllergeenId_Allergeen_Id` (`AllergeenId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 2, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(2, 1, 1, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(3, 1, 3, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(4, 3, 4, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(5, 6, 5, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(6, 9, 2, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(7, 9, 5, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(8, 10, 2, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(9, 12, 4, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(10, 13, 1, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(11, 13, 4, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016'),
(12, 13, 5, b'1', NULL, '2025-11-02 18:37:54.499016', '2025-11-02 18:37:54.499016');

-- --------------------------------------------------------

--
-- Table structure for table `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `LeverancierId` smallint UNSIGNED NOT NULL,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `DatumLevering` date NOT NULL,
  `Aantal` int UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` date DEFAULT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerLeverancier_LeverancierId_Leverancier_Id` (`LeverancierId`),
  KEY `FK_ProductPerLeverancier_ProductId_Product_Id` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `LeverancierId`, `ProductId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2024-10-09', 23, '2024-10-16', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(2, 1, 1, '2024-10-18', 21, '2024-10-25', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(3, 1, 2, '2024-10-09', 12, '2024-10-16', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(4, 1, 3, '2024-10-10', 11, '2024-10-17', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(5, 2, 4, '2024-10-14', 16, '2024-10-21', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(6, 2, 4, '2024-10-21', 23, '2024-10-28', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(7, 2, 5, '2024-10-14', 45, '2024-10-21', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(8, 2, 6, '2024-10-14', 30, '2024-10-21', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(9, 3, 7, '2024-10-12', 12, '2024-10-19', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(10, 3, 7, '2024-10-19', 23, '2024-10-26', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(11, 3, 8, '2024-10-10', 12, '2024-10-17', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(12, 3, 9, '2024-10-11', 1, '2024-10-18', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(13, 4, 10, '2024-10-16', 24, '2024-10-30', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(14, 5, 11, '2024-10-10', 47, '2024-10-17', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(15, 5, 11, '2024-10-19', 60, '2024-10-26', b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(16, 5, 12, '2024-10-11', 45, NULL, b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979'),
(17, 5, 13, '2024-10-12', 23, NULL, b'1', NULL, '2025-11-02 18:37:54.435979', '2025-11-02 18:37:54.435979');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('bAes4y2pqGhOx6Mi3zMCAr3zDKB22oC2fz9PJj2p', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMEJxTTQzS1BHdFVMV3ZVdGhDSVd0bVhkUHpTcFVHV1F4TEZuZ0t3VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1762120492);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `magazijn`
--
ALTER TABLE `magazijn`
  ADD CONSTRAINT `FK_Magazijn_ProductId_Product_Id` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);

--
-- Constraints for table `productperallergeen`
--
ALTER TABLE `productperallergeen`
  ADD CONSTRAINT `FK_ProductPerAllergeen_AllergeenId_Allergeen_Id` FOREIGN KEY (`AllergeenId`) REFERENCES `allergeen` (`Id`),
  ADD CONSTRAINT `FK_ProductPerAllergeen_ProductId_Product_Id` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);

--
-- Constraints for table `productperleverancier`
--
ALTER TABLE `productperleverancier`
  ADD CONSTRAINT `FK_ProductPerLeverancier_LeverancierId_Leverancier_Id` FOREIGN KEY (`LeverancierId`) REFERENCES `leverancier` (`Id`),
  ADD CONSTRAINT `FK_ProductPerLeverancier_ProductId_Product_Id` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
