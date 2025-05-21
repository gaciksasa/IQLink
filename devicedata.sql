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
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20250225074347_InitialCreate','8.0.13'),('20250429000000_AddFilterOptionsToExportSettings','6.0.0');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `deviceconfigurations`
--

LOCK TABLES `deviceconfigurations` WRITE;
/*!40000 ALTER TABLE `deviceconfigurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `deviceconfigurations` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `exportsettings`
--

LOCK TABLES `exportsettings` WRITE;
/*!40000 ALTER TABLE `exportsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `exportsettings` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$11$IHQ.gARYa/pPBV/u5MYnAenuKmUVi3dmQg4jXDgquOcd/EXhYeeGW','Admin','Saša','admin@lmbsoft.rs','2025-02-27 12:24:20.361087','2025-05-21 07:49:20.302190'),(2,'user','$2a$11$Y3P72amPUa2Zns6brwvKjOSGLYoDgfgVcbqqAQEW1WMXEbnzIv9G6','User','Regular User','user@lmbsoft.rs','2025-02-27 12:24:20.592338','2025-04-23 12:52:20.860103');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-21  9:26:44
