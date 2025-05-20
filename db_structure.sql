-- MySQL dump 10.13  Distrib 9.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: devicedata
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
  `DeviceId` varchar(255) NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `Status` int NOT NULL,
  `AvailableData` int NOT NULL,
  `IPAddress` longtext,
  `Port` int NOT NULL,
  `CheckSum` longtext,
  `StatusUpdateCount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`DeviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deviceconfigurations`
--

DROP TABLE IF EXISTS `deviceconfigurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deviceconfigurations` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DeviceId` varchar(255) NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `SoftwareVersion` longtext,
  `HardwareVersion` longtext,
  `ServerAddress` longtext,
  `DeviceIPAddress` longtext,
  `SubnetMask` longtext,
  `RemotePort` int NOT NULL,
  `LocalPort` int NOT NULL,
  `LipemicIndex1` int NOT NULL,
  `LipemicIndex2` int NOT NULL,
  `LipemicIndex3` int NOT NULL,
  `TransferModeEnabled` tinyint(1) NOT NULL,
  `BarcodesModeEnabled` tinyint(1) NOT NULL,
  `OperatorIdEnabled` tinyint(1) NOT NULL,
  `LotNumberEnabled` tinyint(1) NOT NULL,
  `NetworkName` longtext,
  `WifiMode` longtext,
  `SecurityType` longtext,
  `WifiPassword` longtext,
  `RawConfiguration` longtext,
  `ProfilesData` longtext,
  `BarcodeConfig` longtext,
  PRIMARY KEY (`Id`),
  KEY `IX_DeviceConfigurations_DeviceId` (`DeviceId`),
  KEY `IX_DeviceConfigurations_Timestamp` (`Timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devicedata`
--

DROP TABLE IF EXISTS `devicedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devicedata` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DeviceId` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Timestamp` datetime(6) NOT NULL,
  `DataPayload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `IPAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Port` int NOT NULL,
  PRIMARY KEY (`Id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `SoftwareVersion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `HardwareVersion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ServerAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DeviceIpAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SubnetMask` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RemotePort` int NOT NULL,
  `LocalPort` int NOT NULL,
  `LipemicIndex1` int NOT NULL,
  `LipemicIndex2` int NOT NULL,
  `LipemicIndex3` int NOT NULL,
  `TransferMode` tinyint(1) NOT NULL,
  `BarcodesMode` tinyint(1) NOT NULL,
  `OperatorIdEnabled` tinyint(1) NOT NULL,
  `LotNumberEnabled` tinyint(1) NOT NULL,
  `NetworkName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `WifiMode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SecurityType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `WifiPassword` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RawResponse` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProfilesJson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BarcodesJson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `Status` int NOT NULL,
  `AvailableData` int NOT NULL,
  `RawPayload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IPAddress` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Port` int NOT NULL,
  `CheckSum` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_DeviceStatuses_DeviceId` (`DeviceId`),
  KEY `IX_DeviceStatuses_Timestamp` (`Timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=9717 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `Exported` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `IX_DonationsData_DeviceId` (`DeviceId`),
  KEY `IX_DonationsData_DonationIdBarcode` (`DonationIdBarcode`),
  KEY `IX_DonationsData_Timestamp` (`Timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exportsettings`
--

DROP TABLE IF EXISTS `exportsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exportsettings` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `UserId` varchar(255) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `LastUsed` datetime(6) DEFAULT NULL,
  `SelectedColumnsJson` longtext,
  `ColumnOrderJson` longtext,
  `StartDate` datetime(6) DEFAULT NULL,
  `EndDate` datetime(6) DEFAULT NULL,
  `DeviceId` varchar(255) DEFAULT NULL,
  `Delimiter` varchar(10) DEFAULT NULL,
  `DateFormat` varchar(20) DEFAULT NULL,
  `TimeFormat` varchar(20) DEFAULT NULL,
  `IncludeHeaders` tinyint(1) NOT NULL,
  `CustomSeparator` varchar(10) DEFAULT NULL,
  `EmptyColumnsCount` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exportsettingsconfigs`
--

DROP TABLE IF EXISTS `exportsettingsconfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exportsettingsconfigs` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Description` text,
  `IsDefault` tinyint(1) NOT NULL DEFAULT '0',
  `CreatedAt` datetime NOT NULL,
  `LastUsedAt` datetime DEFAULT NULL,
  `SelectedColumnsJson` text,
  `ColumnOrderJson` text,
  `EmptyColumnsCount` int NOT NULL DEFAULT '0',
  `Delimiter` varchar(10) DEFAULT ',',
  `CustomSeparator` varchar(10) DEFAULT NULL,
  `DateFormat` varchar(20) DEFAULT 'dd.MM.yyyy',
  `TimeFormat` varchar(20) DEFAULT 'HH:mm:ss',
  `IncludeHeaders` tinyint(1) NOT NULL DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `DeviceId` varchar(100) DEFAULT NULL,
  `ExportFolderPath` varchar(255) DEFAULT NULL,
  `AutoExportEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `AutoExportMode` varchar(50) DEFAULT 'single_file',
  `CustomFileName` varchar(255) DEFAULT 'Donations_Export',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PasswordHash` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Role` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FullName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CreatedAt` datetime(6) NOT NULL,
  `LastLogin` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20  9:00:18
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20  9:00:19
