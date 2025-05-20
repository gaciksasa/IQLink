-- MySQL dump 10.13  Distrib 9.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: lipodoc_data
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currentdevicestatuses`
--

DROP TABLE IF EXISTS `currentdevicestatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currentdevicestatuses` (
  `DeviceId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `Status` int NOT NULL,
  `AvailableData` int NOT NULL,
  `IPAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Port` int NOT NULL,
  `CheckSum` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `StatusUpdateCount` int NOT NULL,
  PRIMARY KEY (`DeviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `SerialNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `LastConnectionTime` datetime(6) DEFAULT NULL,
  `RegisteredDate` datetime(6) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `Notes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devicesetups`
--

DROP TABLE IF EXISTS `devicesetups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devicesetups` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DeviceId` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `SoftwareVersion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `HardwareVersion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ServerAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `DeviceIpAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `SubnetMask` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `RemotePort` int NOT NULL,
  `LocalPort` int NOT NULL,
  `LipemicIndex1` int NOT NULL,
  `LipemicIndex2` int NOT NULL,
  `LipemicIndex3` int NOT NULL,
  `TransferMode` tinyint(1) NOT NULL,
  `BarcodesMode` tinyint(1) NOT NULL,
  `OperatorIdEnabled` tinyint(1) NOT NULL,
  `LotNumberEnabled` tinyint(1) NOT NULL,
  `NetworkName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `WifiMode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `SecurityType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `WifiPassword` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `RawResponse` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ProfilesJson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `BarcodesJson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devicestatuses`
--

DROP TABLE IF EXISTS `devicestatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devicestatuses` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DeviceId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `DeviceTimestamp` datetime(6) NOT NULL,
  `Status` int NOT NULL,
  `AvailableData` int NOT NULL,
  `RawPayload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IPAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Port` int NOT NULL,
  `CheckSum` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_DeviceStatuses_DeviceId` (`DeviceId`),
  KEY `IX_DeviceStatuses_Timestamp` (`Timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `donationsdata`
--

DROP TABLE IF EXISTS `donationsdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donationsdata` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DeviceId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `MessageType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RawPayload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IPAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Port` int NOT NULL,
  `DeviceStatus` int DEFAULT NULL,
  `AvailableData` int DEFAULT NULL,
  `IsBarcodeMode` tinyint(1) NOT NULL,
  `RefCode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `DonationIdBarcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `OperatorIdBarcode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `LotNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `LipemicValue` int DEFAULT NULL,
  `LipemicGroup` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `LipemicStatus` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CheckSum` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Exported` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_DonationsData_DeviceId` (`DeviceId`),
  KEY `IX_DonationsData_DonationIdBarcode` (`DonationIdBarcode`),
  KEY `IX_DonationsData_Timestamp` (`Timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exportsettingsconfigs`
--

DROP TABLE IF EXISTS `exportsettingsconfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exportsettingsconfigs` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsDefault` tinyint(1) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `LastUsedAt` datetime(6) DEFAULT NULL,
  `SelectedColumnsJson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ColumnOrderJson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `EmptyColumnsCount` int NOT NULL,
  `Delimiter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CustomSeparator` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `DateFormat` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `TimeFormat` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IncludeHeaders` tinyint(1) NOT NULL,
  `CreatedBy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `StartDate` datetime(6) DEFAULT NULL,
  `EndDate` datetime(6) DEFAULT NULL,
  `DeviceId` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ExportFolderPath` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AutoExportEnabled` tinyint(1) NOT NULL,
  `AutoExportMode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CustomFileName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemnotifications`
--

DROP TABLE IF EXISTS `systemnotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemnotifications` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(255) NOT NULL,
  `Message` longtext NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `Read` tinyint(1) NOT NULL,
  `RelatedEntityId` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20 14:44:22
