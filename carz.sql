-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: carz2
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuration` (
  `Configuration_ID` varchar(255) NOT NULL,
  `VehID` varchar(255) DEFAULT NULL,
  `FeatureName` varchar(100) NOT NULL,
  `FeatureDescription` text,
  `AdditionalCost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Configuration_ID`),
  UNIQUE KEY `FeatureName` (`FeatureName`),
  KEY `VehID` (`VehID`),
  CONSTRAINT `configuration_ibfk_1` FOREIGN KEY (`VehID`) REFERENCES `vehicle` (`Veh_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES ('C1','V1','Advanced Safety Package','Includes collision avoidance and lane departure warning',2000.00),('C2','V1','Premium Sound System','High-quality speakers and subwoofer',1500.00),('C3','V2','Panoramic Sunroof','Enjoy natural light and fresh air',1200.00),('C4','V2','Leather Interior','Luxurious leather seats and interior',1800.00),('C5','V3','Off-road Package','Enhanced suspension and terrain management system',2500.00);
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Custm_ID` varchar(255) NOT NULL,
  `Fname` varchar(255) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone_number` varchar(10) NOT NULL,
  `Password` varchar(64) NOT NULL,
  `Street_Name_And_area` varchar(255) NOT NULL,
  `State` char(255) NOT NULL,
  `City` char(255) NOT NULL,
  `Pincode` varchar(6) NOT NULL,
  `PaymentDetails` varchar(255) DEFAULT NULL,
  `OrdersHistory` varchar(255) DEFAULT NULL,
  `TestRidesHistory` varchar(255) DEFAULT NULL,
  `Interests` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Custm_ID`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Phone_number` (`Phone_number`),
  UNIQUE KEY `Password` (`Password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('1','John','Doe','john.doe@email.com','1234567890','hashed_password_1','123 Main St','California','Los Angeles','90001',NULL,NULL,NULL,NULL),('2','Jane','Smith','jane.smith@email.com','9876543210','hashed_password_2','456 Oak St','Texas','Houston','77001',NULL,NULL,NULL,NULL),('3','Bob','Johnson','bob.johnson@email.com','1112223333','hashed_password_3','789 Pine St','New York','New York City','10001',NULL,NULL,NULL,NULL),('8337ae46-f9c7-44fc-b78d-277008437cf9','bharat ','s','bah@gmail.com','696633','36db3423c1cfefd1c2bed2daaf2ae6aef461daad10ab675a47a3e94dfd4cba98','bng','karnataka','bengaluru','582471',NULL,NULL,NULL,NULL),('8c01c1d3-a7d0-4adc-b395-3acdeadfd506','dsudfhb','dsajfn','dsadh@gmail.com','55689566','65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5','fdkvnda','dsfkn','sddsfsDF','852963',NULL,NULL,NULL,NULL),('adeeb2d9-0067-4dfb-b8a7-8e7041b83709','dadsbf','dsfkjnsdf','dvkvjnsd@gmail.com','52156165','6f31fda0a26975397d7d661b34c8d117a2d574bd7d45cc3c5b7d43b7f3bf2f72','SKJDFN','dfkNF','SDKFN','123456',NULL,NULL,NULL,NULL),('b51041d2-1d78-4b07-880e-921bba099e23','Darshan','Babu T R','darshan@gmail.com','9876543201','64a0377aaaa910f39fe3b80aa4635340ed6d901433a4c132f519f5263c93179a','Dwaraka nagara Banashankari ','Karnataka','Bengaluru','566002',NULL,NULL,NULL,NULL),('c5e74146-7900-47b9-965e-f2f9a279e9f1','DARSHAN','BABU T R','darshantr@gmail.com','7439628513','08fa299aecc0c034e037033e3b0bbfaef26b78c742f16cf88ac3194502d6c394','100 feet road','karnataka','bengaluru','639651',NULL,NULL,NULL,NULL),('e7b67691-affa-4d92-a132-c2e1c2b60035','saddfkd','lgbgfjgf','gafddil@gmail.com','5685656','9e5199c2d025feae4359d0c8772b5667029baf4a36d6bdd234827935d1edc36e','sddJDSJ','dajfndsa','dsaff','357159',NULL,NULL,NULL,NULL),('f4523698-a28e-49ed-8eda-f3f2891e86f5','Bharat','Subedar','bharat@gmail.com','9874650123','b736100361ded8976e400f768df86e0b8a384ddaed59f07da9b4dbe9f56fa91b','Banashankari','Karnataka','Bengaluru','563302',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_customer` BEFORE INSERT ON `customer` FOR EACH ROW BEGIN
    
    IF LENGTH(NEW.Password) < 8 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password must be at least 8 characters long';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dealer`
--

DROP TABLE IF EXISTS `dealer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dealer` (
  `Dealer_ID` varchar(255) NOT NULL,
  `DealerName` varchar(100) NOT NULL,
  `Phone_Number` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `ShowroomID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Dealer_ID`),
  UNIQUE KEY `DealerName` (`DealerName`),
  UNIQUE KEY `Phone_Number` (`Phone_Number`),
  UNIQUE KEY `Email` (`Email`),
  KEY `ShowroomID` (`ShowroomID`),
  CONSTRAINT `dealer_ibfk_1` FOREIGN KEY (`ShowroomID`) REFERENCES `showroom` (`Showroom_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dealer`
--

LOCK TABLES `dealer` WRITE;
/*!40000 ALTER TABLE `dealer` DISABLE KEYS */;
/*!40000 ALTER TABLE `dealer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ebook`
--

DROP TABLE IF EXISTS `ebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ebook` (
  `EBookID` varchar(255) NOT NULL,
  `DeliveryAddress` varchar(255) NOT NULL,
  `PaymentMethod` varchar(50) NOT NULL,
  `PaymentStatus` varchar(50) NOT NULL,
  `VehID` varchar(255) DEFAULT NULL,
  `CustmID` varchar(255) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL,
  PRIMARY KEY (`EBookID`),
  UNIQUE KEY `DeliveryAddress` (`DeliveryAddress`),
  KEY `VehID` (`VehID`),
  KEY `CustmID` (`CustmID`),
  CONSTRAINT `ebook_ibfk_1` FOREIGN KEY (`VehID`) REFERENCES `vehicle` (`Veh_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ebook_ibfk_2` FOREIGN KEY (`CustmID`) REFERENCES `customer` (`Custm_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ebook`
--

LOCK TABLES `ebook` WRITE;
/*!40000 ALTER TABLE `ebook` DISABLE KEYS */;
INSERT INTO `ebook` VALUES ('06151646-83e2-11ee-a281-005056c00001','dwaraka nagara','Online Transfer','Pending','V3','b51041d2-1d78-4b07-880e-921bba099e23','2023-11-15'),('11296bb8-8157-11ee-89f2-005056c00001','bengaluru','Online Transfer','Pending','V2','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','2023-11-12'),('1eba96c8-8448-11ee-a281-005056c00001','davanagere','Online Transfer','Pending','V3','f4523698-a28e-49ed-8eda-f3f2891e86f5','2023-11-16'),('3cc14216-8449-11ee-a281-005056c00001','vijayanagara','Debit Card','Pending','V1','f4523698-a28e-49ed-8eda-f3f2891e86f5','2023-11-16'),('80890ce6-80a9-11ee-89f2-005056c00001','hubli','Credit Card','Pending','V1','8c01c1d3-a7d0-4adc-b395-3acdeadfd506',NULL),('b57aa18f-80ac-11ee-89f2-005056c00001','koppal','Credit Card','Pending','V3','8c01c1d3-a7d0-4adc-b395-3acdeadfd506',NULL),('c275a75e-83e1-11ee-a281-005056c00001','Pes university','Credit Card','Pending','V1','b51041d2-1d78-4b07-880e-921bba099e23','2023-11-15'),('d21c43c2-891a-11ee-baf7-005056c00001','banshankaroi','Online Transfer','Pending','V2','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','2023-11-22'),('d3dd236a-83e1-11ee-a281-005056c00001','Banashankari','Debit Card','Pending','V2','b51041d2-1d78-4b07-880e-921bba099e23','2023-11-15'),('EB1','123 Main St, Apartment 4B, California','Credit Card','Paid','V1','1',NULL),('EB2','456 Oak St, House 2, Texas','PayPal','Pending','V2','2',NULL),('EB3','789 Pine St, Penthouse, New York','Credit Card','Paid','V3','3',NULL);
/*!40000 ALTER TABLE `ebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanapplication`
--

DROP TABLE IF EXISTS `loanapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loanapplication` (
  `LoanApplicationID` varchar(255) NOT NULL,
  `CustmID` varchar(255) DEFAULT NULL,
  `VehID` varchar(255) DEFAULT NULL,
  `LoanAmount` decimal(10,2) NOT NULL,
  `ApplicationDate` date NOT NULL,
  `ApprovalStatus` varchar(50) NOT NULL,
  PRIMARY KEY (`LoanApplicationID`),
  KEY `CustmID` (`CustmID`),
  KEY `VehID` (`VehID`),
  CONSTRAINT `loanapplication_ibfk_1` FOREIGN KEY (`CustmID`) REFERENCES `customer` (`Custm_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `loanapplication_ibfk_2` FOREIGN KEY (`VehID`) REFERENCES `vehicle` (`Veh_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanapplication`
--

LOCK TABLES `loanapplication` WRITE;
/*!40000 ALTER TABLE `loanapplication` DISABLE KEYS */;
INSERT INTO `loanapplication` VALUES ('85ed09b4-891b-11ee-baf7-005056c00001','c5e74146-7900-47b9-965e-f2f9a279e9f1','V2',2000.00,'2023-11-22','Pending'),('c15c4b0e-83e2-11ee-a281-005056c00001','b51041d2-1d78-4b07-880e-921bba099e23','V2',2500.00,'2023-11-15','Approved'),('eb2a13d4-83bd-11ee-a281-005056c00001','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V2',2500.00,'2023-11-15','Approved'),('fb8a4b4c-845b-11ee-a281-005056c00001','f4523698-a28e-49ed-8eda-f3f2891e86f5','V3',49999.99,'2023-11-16','Approved');
/*!40000 ALTER TABLE `loanapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanoffer`
--

DROP TABLE IF EXISTS `loanoffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loanoffer` (
  `LoanOffer_ID` varchar(255) NOT NULL,
  `OfferDetailsAndEligibility` text,
  `ApprovalDate` date DEFAULT NULL,
  `ValidUntil` date NOT NULL,
  `CustmID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LoanOffer_ID`),
  UNIQUE KEY `ValidUntil` (`ValidUntil`),
  KEY `CustmID` (`CustmID`),
  CONSTRAINT `loanoffer_ibfk_1` FOREIGN KEY (`CustmID`) REFERENCES `customer` (`Custm_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanoffer`
--

LOCK TABLES `loanoffer` WRITE;
/*!40000 ALTER TABLE `loanoffer` DISABLE KEYS */;
INSERT INTO `loanoffer` VALUES ('LO1','Low-interest rate for credit score above 700','2023-03-15','2023-04-15','1'),('LO2','Special offer for first-time car buyers','2023-03-20','2023-04-20','2'),('LO3','Exclusive offer for loyalty program members','2023-03-25','2023-04-25','3'),('LO4','Special offer for loyal customers with multiple purchases','2023-03-30','2023-12-30','8c01c1d3-a7d0-4adc-b395-3acdeadfd506'),('LO5','Diwali offer','2023-11-01','2023-12-31','c5e74146-7900-47b9-965e-f2f9a279e9f1');
/*!40000 ALTER TABLE `loanoffer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `SaleID` varchar(255) NOT NULL,
  `DeliveryDate` date NOT NULL,
  `Cost` decimal(10,2) DEFAULT NULL,
  `CustmID` varchar(255) DEFAULT NULL,
  `VehID` varchar(255) DEFAULT NULL,
  `ShowroomID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SaleID`),
  KEY `CustmID` (`CustmID`),
  KEY `VehID` (`VehID`),
  KEY `ShowroomID` (`ShowroomID`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`CustmID`) REFERENCES `customer` (`Custm_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`VehID`) REFERENCES `vehicle` (`Veh_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`ShowroomID`) REFERENCES `showroom` (`Showroom_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES ('06151646-83e2-11ee-a281-005056c00001','2023-11-15',45000.00,'f4523698-a28e-49ed-8eda-f3f2891e86f5','V3','S3'),('06151646-83e2-11ee-a281-005056c00011','2023-11-15',500000.00,'f4523698-a28e-49ed-8eda-f3f2891e86f5','V1','S1'),('11296bb8-8157-11ee-89f2-005056c00001','2023-11-12',0.00,'8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V2','S2'),('11296bb8-8157-11ee-89f2-005056c00005','2023-11-16',22000.00,'1','V3','S1'),('11296bb8-8157-11ee-89f2-005056c00006','2023-11-17',28000.00,'2','V1','S3'),('11296bb8-8157-11ee-89f2-005056c00007','2023-11-18',19500.00,'3','V2','S2'),('11296bb8-8157-11ee-89f2-005056c00008','2023-11-19',32000.00,'8337ae46-f9c7-44fc-b78d-277008437cf9','V3','S1'),('11296bb8-8157-11ee-89f2-005056c00009','2023-11-20',15000.00,'8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V2','S2'),('11296bb8-8157-11ee-89f2-005056c00010','2023-11-21',26000.00,'adeeb2d9-0067-4dfb-b8a7-8e7041b83709','V1','S3'),('11296bb8-8157-11ee-89f2-005056c00011','2023-11-22',18000.00,'e7b67691-affa-4d92-a132-c2e1c2b60035','V2','S2');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showroom`
--

DROP TABLE IF EXISTS `showroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showroom` (
  `Showroom_ID` varchar(255) NOT NULL,
  `ShowroomName` varchar(100) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Phone_Number` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `OperatingHours` varchar(50) DEFAULT NULL,
  `AvailableServices` varchar(255) DEFAULT NULL,
  `location_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Showroom_ID`),
  UNIQUE KEY `ShowroomName` (`ShowroomName`),
  UNIQUE KEY `Phone_Number` (`Phone_Number`),
  UNIQUE KEY `Email` (`Email`),
  KEY `FK_sl_sm` (`location_id`),
  CONSTRAINT `FK_sl_sm` FOREIGN KEY (`location_id`) REFERENCES `showroomlocator` (`LocationID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showroom`
--

LOCK TABLES `showroom` WRITE;
/*!40000 ALTER TABLE `showroom` DISABLE KEYS */;
INSERT INTO `showroom` VALUES ('S1','Luxury Cars Showroom','789 Broadway St','5551112222','info@luxurycars.com','9 AM - 6 PM','Maintenance, Financing',NULL),('S2','Family Cars Showroom','456 Main St','5553334444','info@familycars.com','10 AM - 7 PM','Test Drives, Financing',NULL),('S3','SUVs Showroom','123 Oak St','5555556666','info@suvscars.com','8 AM - 5 PM','Service Center, Insurance',NULL);
/*!40000 ALTER TABLE `showroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showroomlocator`
--

DROP TABLE IF EXISTS `showroomlocator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showroomlocator` (
  `LocationID` varchar(255) NOT NULL,
  `State` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Pincode` varchar(20) NOT NULL,
  `ShowroomID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LocationID`),
  UNIQUE KEY `Address` (`Address`),
  KEY `fk_ShowroomLocator_Showroom` (`ShowroomID`),
  CONSTRAINT `fk_ShowroomLocator_Showroom` FOREIGN KEY (`ShowroomID`) REFERENCES `showroom` (`Showroom_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `showroomlocator_ibfk_1` FOREIGN KEY (`ShowroomID`) REFERENCES `showroom` (`Showroom_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showroomlocator`
--

LOCK TABLES `showroomlocator` WRITE;
/*!40000 ALTER TABLE `showroomlocator` DISABLE KEYS */;
INSERT INTO `showroomlocator` VALUES ('L1','California','Los Angeles','789 Broadway St','90001','S1'),('L2','Texas','Houston','456 Main St','77001','S2'),('L3','New York','New York City','123 Oak St','10001','S3');
/*!40000 ALTER TABLE `showroomlocator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showsintereston`
--

DROP TABLE IF EXISTS `showsintereston`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showsintereston` (
  `CustmID` varchar(255) NOT NULL,
  `VehID` varchar(255) NOT NULL,
  `InterestRating` int DEFAULT NULL,
  PRIMARY KEY (`CustmID`,`VehID`),
  KEY `VehID` (`VehID`),
  CONSTRAINT `showsintereston_ibfk_1` FOREIGN KEY (`CustmID`) REFERENCES `customer` (`Custm_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `showsintereston_ibfk_2` FOREIGN KEY (`VehID`) REFERENCES `vehicle` (`Veh_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showsintereston`
--

LOCK TABLES `showsintereston` WRITE;
/*!40000 ALTER TABLE `showsintereston` DISABLE KEYS */;
INSERT INTO `showsintereston` VALUES ('1','V2',4),('2','V3',5),('3','V1',3),('8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V1',NULL),('8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V2',4),('8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V3',5),('b51041d2-1d78-4b07-880e-921bba099e23','V1',4),('b51041d2-1d78-4b07-880e-921bba099e23','V2',4),('b51041d2-1d78-4b07-880e-921bba099e23','V3',4),('f4523698-a28e-49ed-8eda-f3f2891e86f5','V1',3);
/*!40000 ALTER TABLE `showsintereston` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testride`
--

DROP TABLE IF EXISTS `testride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testride` (
  `TestRide_ID` varchar(255) NOT NULL,
  `CustmID` varchar(255) DEFAULT NULL,
  `VehID` varchar(255) DEFAULT NULL,
  `ScheduledDate` date NOT NULL,
  `ScheduledTime` time NOT NULL,
  `Durationoftestride` int NOT NULL,
  PRIMARY KEY (`TestRide_ID`),
  UNIQUE KEY `ScheduledTime` (`ScheduledTime`),
  KEY `CustmID` (`CustmID`),
  KEY `VehID` (`VehID`),
  CONSTRAINT `testride_ibfk_1` FOREIGN KEY (`CustmID`) REFERENCES `customer` (`Custm_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `testride_ibfk_2` FOREIGN KEY (`VehID`) REFERENCES `vehicle` (`Veh_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testride`
--

LOCK TABLES `testride` WRITE;
/*!40000 ALTER TABLE `testride` DISABLE KEYS */;
INSERT INTO `testride` VALUES ('0fd91681-891b-11ee-baf7-005056c00001','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V1','2023-11-22','16:00:00',65),('1d5100e7-891b-11ee-baf7-005056c00001','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V1','2023-11-22','17:30:00',65),('2128d707-83e2-11ee-a281-005056c00001','b51041d2-1d78-4b07-880e-921bba099e23','V1','2023-11-23','11:45:00',50),('2d049b49-83e2-11ee-a281-005056c00001','b51041d2-1d78-4b07-880e-921bba099e23','V2','2023-11-23','12:30:00',50),('a25e2cbf-8378-11ee-a281-005056c00001','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V2','2023-11-15','11:03:00',30),('af9cf805-837a-11ee-a281-005056c00001','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V1','2023-12-15','17:00:00',60),('d533b2c5-80ad-11ee-89f2-005056c00001','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V1','2023-11-11','21:47:00',35),('f31778e1-8378-11ee-a281-005056c00001','8c01c1d3-a7d0-4adc-b395-3acdeadfd506','V2','2023-11-15','00:30:00',60),('TR1','1','V1','2023-04-01','10:00:00',30),('TR2','2','V2','2023-04-02','14:00:00',45),('TR3','3','V3','2023-04-03','11:30:00',60);
/*!40000 ALTER TABLE `testride` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_testride_duration` BEFORE INSERT ON `testride` FOR EACH ROW BEGIN
    IF NEW.Durationoftestride < 30 OR NEW.Durationoftestride > 120 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Test ride duration must be between 30 minutes and 2 hours.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_duplicate_testride` BEFORE INSERT ON `testride` FOR EACH ROW BEGIN
    DECLARE existing_testride INT;

    SELECT COUNT(*) INTO existing_testride
    FROM testride
    WHERE CustmID = NEW.CustmID
    AND ScheduledDate = NEW.ScheduledDate
    AND ScheduledTime = NEW.ScheduledTime;

    IF existing_testride > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The customer has already booked a test ride at the same date and time.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_testride` BEFORE INSERT ON `testride` FOR EACH ROW BEGIN
    IF HOUR(NEW.ScheduledTime) < 9 OR HOUR(NEW.ScheduledTime) > 17 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Test rides are only allowed between 9 AM and 5 PM';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `Veh_ID` varchar(255) NOT NULL,
  `VehName` varchar(50) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `VehDescription` varchar(50) NOT NULL,
  `Manufactured_date` date NOT NULL,
  `Cost` decimal(10,2) NOT NULL,
  `Imagepath` varchar(255) DEFAULT NULL,
  `ShowroomID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Veh_ID`),
  UNIQUE KEY `VehName` (`VehName`),
  UNIQUE KEY `Model` (`Model`),
  KEY `fk_Vehicle_Showroom` (`ShowroomID`),
  CONSTRAINT `fk_Vehicle_Showroom` FOREIGN KEY (`ShowroomID`) REFERENCES `showroom` (`Showroom_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('V1','Luxury Sedan','LS2023','Premium sedan with advanced features','2023-01-01',50000.00,'images2/Car-1-image.jpg','S1'),('V2','Family Hatchback','FH2023','Spacious hatchback for family trips','2023-02-01',30000.00,'images2/Car-2-image.jpg','S2'),('V3','SUV Adventure','SUV2023','Off-road SUV for adventurous journeys','2023-03-01',45000.00,'images2/Car-3-image.jpg','S3');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-30 23:17:10
