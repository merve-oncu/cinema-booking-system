CREATE DATABASE  IF NOT EXISTS `database_project` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `database_project`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: database_project
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `seat_id` int DEFAULT NULL,
  `show_id` int DEFAULT NULL,
  `booking_date` datetime DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `extra_price` decimal(10,2) DEFAULT NULL,
  `b_status` enum('confirmed','pending','cancelled') DEFAULT 'pending',
  `ticket_count` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`booking_id`),
  KEY `seat_id` (`seat_id`),
  KEY `fk_booking_showtime` (`show_id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`),
  CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`show_id`) REFERENCES `showtime` (`show_id`),
  CONSTRAINT `fk_booking_show` FOREIGN KEY (`show_id`) REFERENCES `showtime` (`show_id`),
  CONSTRAINT `fk_booking_showtime` FOREIGN KEY (`show_id`) REFERENCES `showtime` (`show_id`),
  CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (21,1,1,114,'2025-01-03 01:27:13',40.00,5.00,'cancelled',2),(22,18,1,171,'2025-01-03 11:24:35',20.00,5.00,'confirmed',1),(23,1,1,159,'2025-01-03 11:26:44',20.00,5.00,'confirmed',1),(24,1,1,159,'2025-01-03 11:58:33',40.00,5.00,'confirmed',2),(25,19,1,177,'2025-01-03 12:03:27',40.00,5.00,'confirmed',2),(26,20,1,213,'2025-01-03 12:04:21',60.00,5.00,'confirmed',3),(27,21,1,114,'2025-01-03 12:05:45',40.00,5.00,'confirmed',2),(28,10,1,120,'2025-01-03 12:06:59',40.00,5.00,'cancelled',2),(29,22,1,159,'2025-01-03 12:16:22',20.00,5.00,'cancelled',1),(30,23,1,102,'2025-01-03 12:20:45',20.00,5.00,'cancelled',1),(31,24,1,121,'2025-01-03 12:24:44',40.00,5.00,'cancelled',2),(32,25,1,200,'2025-01-03 12:26:56',60.00,5.00,'cancelled',3),(33,26,1,164,'2025-01-03 12:35:37',40.00,5.00,'cancelled',2),(34,27,1,171,'2025-01-03 12:54:51',20.00,5.00,'cancelled',1),(35,28,1,102,'2025-01-04 14:16:24',20.00,5.00,'confirmed',1),(36,10,1,168,'2025-01-04 18:56:44',20.00,5.00,'confirmed',1),(37,29,1,217,'2025-01-04 19:59:01',100.00,5.00,'confirmed',5);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_seats`
--

DROP TABLE IF EXISTS `booking_seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_seats` (
  `booking_seat_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `seat_id` int DEFAULT NULL,
  PRIMARY KEY (`booking_seat_id`),
  KEY `fk_booking_seat_booking` (`booking_id`),
  KEY `fk_booking_seat_seat` (`seat_id`),
  CONSTRAINT `booking_seats_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  CONSTRAINT `booking_seats_ibfk_2` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`),
  CONSTRAINT `fk_booking_seat_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  CONSTRAINT `fk_booking_seat_seat` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_seats`
--

LOCK TABLES `booking_seats` WRITE;
/*!40000 ALTER TABLE `booking_seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `movie_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT NULL,
  `director` varchar(100) DEFAULT NULL,
  `actors` text,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Gladiator II','Action',150,'2024-11-15',6.9,'Ridley Scott','Pedro Pascal, Paul Mescal, Denzel Washington'),(3,'Moana 2','Animation',100,'2024-11-29',7.0,'Dana Ledoux Miller, David G. Derrick Jr.','Ron Clements'),(4,'The Bell Keeper','Horror',92,'2024-12-13',3.8,'Colton Tran','Randy Couture, Kathleen Kenny, Reid Miller'),(5,'Here','Drama',104,'2024-11-29',6.2,'Robert Zemeckis','Kelly Reilly, Robin Wright, Tom Hanks'),(6,'The Last Breath','Thriller',96,'2024-11-29',4.7,'Joachim Hedén','Jack Parr, Kim Spearman, Alexander Arnold'),(7,'Wicked','Fantastic',160,'2024-11-22',8.0,'Jon M. Chu','Jonathan Bailey, Ariana Grande, Cynthia Erivo');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `payment_date` datetime DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_method` enum('credit_card','cash','paypal') DEFAULT 'credit_card',
  `transaction_id` varchar(50) DEFAULT NULL,
  `booking_id` int DEFAULT NULL,
  `p_status` enum('paid','failed','pending') DEFAULT 'pending',
  PRIMARY KEY (`payment_id`),
  KEY `fk_payment_booking` (`booking_id`),
  CONSTRAINT `fk_payment_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_reservations`
--

DROP TABLE IF EXISTS `seat_reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat_reservations` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `show_date` date NOT NULL,
  `show_time` time NOT NULL,
  `row_number` int NOT NULL,
  `col_number` int NOT NULL,
  `reserved_by` varchar(255) NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `seat_reservations_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_reservations`
--

LOCK TABLES `seat_reservations` WRITE;
/*!40000 ALTER TABLE `seat_reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seats` (
  `seat_id` int NOT NULL AUTO_INCREMENT,
  `seat_number` varchar(10) DEFAULT NULL,
  `theatre_id` int DEFAULT NULL,
  `show_id` int DEFAULT NULL,
  `s_status` enum('available','reserved','unavailable') DEFAULT 'available',
  `reserved_by` int DEFAULT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `theatre_id` (`theatre_id`),
  KEY `reserved_by` (`reserved_by`),
  KEY `show_id` (`show_id`),
  CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`theatre_id`) REFERENCES `theatre` (`theatre_id`),
  CONSTRAINT `seats_ibfk_2` FOREIGN KEY (`reserved_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `seats_ibfk_3` FOREIGN KEY (`show_id`) REFERENCES `showtime` (`show_id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
INSERT INTO `seats` VALUES (1,'1',1,NULL,'available',NULL),(2,'2',1,NULL,'available',NULL),(3,'3',1,NULL,'available',NULL),(4,'4',1,NULL,'available',NULL),(5,'5',1,NULL,'available',NULL),(6,'6',1,NULL,'available',NULL),(7,'7',1,NULL,'available',NULL),(8,'8',1,NULL,'available',NULL),(9,'9',1,NULL,'available',NULL),(10,'10',1,NULL,'available',NULL),(11,'11',1,NULL,'available',NULL),(12,'12',1,NULL,'available',NULL),(13,'13',1,NULL,'available',NULL),(14,'14',1,NULL,'available',NULL),(15,'15',1,NULL,'available',NULL),(16,'16',1,NULL,'available',NULL),(17,'17',1,NULL,'available',NULL),(18,'18',1,NULL,'available',NULL),(19,'19',1,NULL,'available',NULL),(20,'20',1,NULL,'available',NULL),(21,'21',1,NULL,'available',NULL),(22,'22',1,NULL,'available',NULL),(23,'23',1,NULL,'available',NULL),(24,'24',1,NULL,'available',NULL),(25,'25',1,NULL,'available',NULL),(26,'26',1,NULL,'available',NULL),(27,'27',1,NULL,'available',NULL),(28,'28',1,NULL,'available',NULL),(29,'29',1,NULL,'available',NULL),(30,'30',1,NULL,'available',NULL),(31,'31',1,NULL,'available',NULL),(32,'32',1,NULL,'available',NULL),(33,'33',1,NULL,'available',NULL),(34,'34',1,NULL,'available',NULL),(35,'35',1,NULL,'available',NULL),(36,'36',1,NULL,'available',NULL),(37,'37',1,NULL,'available',NULL),(38,'38',1,NULL,'available',NULL),(39,'39',1,NULL,'available',NULL),(40,'40',1,NULL,'available',NULL),(41,'41',1,NULL,'available',NULL),(42,'42',1,NULL,'available',NULL),(43,'43',1,NULL,'available',NULL),(44,'44',1,NULL,'available',NULL),(45,'45',1,NULL,'available',NULL),(46,'46',1,NULL,'available',NULL),(47,'47',1,NULL,'available',NULL),(48,'48',1,NULL,'available',NULL),(49,'49',1,NULL,'available',NULL),(50,'50',1,NULL,'available',NULL),(51,'51',1,NULL,'available',NULL),(52,'52',1,NULL,'available',NULL),(53,'53',1,NULL,'available',NULL),(54,'54',1,NULL,'available',NULL),(55,'55',1,NULL,'available',NULL),(56,'56',1,NULL,'available',NULL),(57,'57',1,NULL,'available',NULL),(58,'58',1,NULL,'available',NULL),(59,'59',1,NULL,'available',NULL),(60,'60',1,NULL,'available',NULL),(61,'61',1,NULL,'available',NULL),(62,'62',1,NULL,'available',NULL),(63,'63',1,NULL,'available',NULL),(64,'64',1,NULL,'available',NULL),(65,'65',1,NULL,'available',NULL),(66,'66',1,NULL,'available',NULL),(67,'67',1,NULL,'available',NULL),(68,'68',1,NULL,'available',NULL),(69,'69',1,NULL,'available',NULL),(70,'70',1,NULL,'available',NULL),(71,'71',1,NULL,'available',NULL),(72,'72',1,NULL,'available',NULL),(73,'73',1,NULL,'available',NULL),(74,'74',1,NULL,'available',NULL),(75,'75',1,NULL,'available',NULL),(76,'76',1,NULL,'available',NULL),(77,'77',1,NULL,'available',NULL),(78,'78',1,NULL,'available',NULL),(79,'79',1,NULL,'available',NULL),(80,'80',1,NULL,'available',NULL),(161,'1',3,NULL,'available',NULL),(162,'2',3,NULL,'available',NULL),(163,'3',3,NULL,'available',NULL),(164,'4',3,NULL,'available',NULL),(165,'5',3,NULL,'available',NULL),(166,'6',3,NULL,'available',NULL),(167,'7',3,NULL,'available',NULL),(168,'8',3,NULL,'available',NULL),(169,'9',3,NULL,'available',NULL),(170,'10',3,NULL,'available',NULL),(171,'11',3,NULL,'available',NULL),(172,'12',3,NULL,'available',NULL),(173,'13',3,NULL,'available',NULL),(174,'14',3,NULL,'available',NULL),(175,'15',3,NULL,'available',NULL),(176,'16',3,NULL,'available',NULL),(177,'17',3,NULL,'available',NULL),(178,'18',3,NULL,'available',NULL),(179,'19',3,NULL,'available',NULL),(180,'20',3,NULL,'available',NULL),(181,'21',3,NULL,'available',NULL),(182,'22',3,NULL,'available',NULL),(183,'23',3,NULL,'available',NULL),(184,'24',3,NULL,'available',NULL),(185,'25',3,NULL,'available',NULL),(186,'26',3,NULL,'available',NULL),(187,'27',3,NULL,'available',NULL),(188,'28',3,NULL,'available',NULL),(189,'29',3,NULL,'available',NULL),(190,'30',3,NULL,'available',NULL),(191,'31',3,NULL,'available',NULL),(192,'32',3,NULL,'available',NULL),(193,'33',3,NULL,'available',NULL),(194,'34',3,NULL,'available',NULL),(195,'35',3,NULL,'available',NULL),(196,'36',3,NULL,'available',NULL),(197,'37',3,NULL,'available',NULL),(198,'38',3,NULL,'available',NULL),(199,'39',3,NULL,'available',NULL),(200,'40',3,NULL,'available',NULL),(201,'41',3,NULL,'available',NULL),(202,'42',3,NULL,'available',NULL),(203,'43',3,NULL,'available',NULL),(204,'44',3,NULL,'available',NULL),(205,'45',3,NULL,'available',NULL),(206,'46',3,NULL,'available',NULL),(207,'47',3,NULL,'available',NULL),(208,'48',3,NULL,'available',NULL),(209,'49',3,NULL,'available',NULL),(210,'50',3,NULL,'available',NULL),(211,'51',3,NULL,'available',NULL),(212,'52',3,NULL,'available',NULL),(213,'53',3,NULL,'available',NULL),(214,'54',3,NULL,'available',NULL),(215,'55',3,NULL,'available',NULL),(216,'56',3,NULL,'available',NULL),(217,'57',3,NULL,'available',NULL),(218,'58',3,NULL,'available',NULL),(219,'59',3,NULL,'available',NULL),(220,'60',3,NULL,'available',NULL),(221,'61',3,NULL,'available',NULL),(222,'62',3,NULL,'available',NULL),(223,'63',3,NULL,'available',NULL),(224,'64',3,NULL,'available',NULL),(225,'65',3,NULL,'available',NULL),(226,'66',3,NULL,'available',NULL),(227,'67',3,NULL,'available',NULL),(228,'68',3,NULL,'available',NULL),(229,'69',3,NULL,'available',NULL),(230,'70',3,NULL,'available',NULL),(231,'71',3,NULL,'available',NULL),(232,'72',3,NULL,'available',NULL),(233,'73',3,NULL,'available',NULL),(234,'74',3,NULL,'available',NULL),(235,'75',3,NULL,'available',NULL),(236,'76',3,NULL,'available',NULL),(237,'77',3,NULL,'available',NULL),(238,'78',3,NULL,'available',NULL),(239,'79',3,NULL,'available',NULL),(240,'80',3,NULL,'available',NULL),(241,'1',4,NULL,'available',NULL),(242,'2',4,NULL,'available',NULL),(243,'3',4,NULL,'available',NULL),(244,'4',4,NULL,'available',NULL),(245,'5',4,NULL,'available',NULL),(246,'6',4,NULL,'available',NULL),(247,'7',4,NULL,'available',NULL),(248,'8',4,NULL,'available',NULL),(249,'9',4,NULL,'available',NULL),(250,'10',4,NULL,'available',NULL),(251,'11',4,NULL,'available',NULL),(252,'12',4,NULL,'available',NULL),(253,'13',4,NULL,'available',NULL),(254,'14',4,NULL,'available',NULL),(255,'15',4,NULL,'available',NULL),(256,'16',4,NULL,'available',NULL),(257,'17',4,NULL,'available',NULL),(258,'18',4,NULL,'available',NULL),(259,'19',4,NULL,'available',NULL),(260,'20',4,NULL,'available',NULL),(261,'21',4,NULL,'available',NULL),(262,'22',4,NULL,'available',NULL),(263,'23',4,NULL,'available',NULL),(264,'24',4,NULL,'available',NULL),(265,'25',4,NULL,'available',NULL),(266,'26',4,NULL,'available',NULL),(267,'27',4,NULL,'available',NULL),(268,'28',4,NULL,'available',NULL),(269,'29',4,NULL,'available',NULL),(270,'30',4,NULL,'available',NULL),(271,'31',4,NULL,'available',NULL),(272,'32',4,NULL,'available',NULL),(273,'33',4,NULL,'available',NULL),(274,'34',4,NULL,'available',NULL),(275,'35',4,NULL,'available',NULL),(276,'36',4,NULL,'available',NULL),(277,'37',4,NULL,'available',NULL),(278,'38',4,NULL,'available',NULL),(279,'39',4,NULL,'available',NULL),(280,'40',4,NULL,'available',NULL),(281,'41',4,NULL,'available',NULL),(282,'42',4,NULL,'available',NULL),(283,'43',4,NULL,'available',NULL),(284,'44',4,NULL,'available',NULL),(285,'45',4,NULL,'available',NULL),(286,'46',4,NULL,'available',NULL),(287,'47',4,NULL,'available',NULL),(288,'48',4,NULL,'available',NULL),(289,'49',4,NULL,'available',NULL),(290,'50',4,NULL,'available',NULL),(291,'51',4,NULL,'available',NULL),(292,'52',4,NULL,'available',NULL),(293,'53',4,NULL,'available',NULL),(294,'54',4,NULL,'available',NULL),(295,'55',4,NULL,'available',NULL),(296,'56',4,NULL,'available',NULL),(297,'57',4,NULL,'available',NULL),(298,'58',4,NULL,'available',NULL),(299,'59',4,NULL,'available',NULL),(300,'60',4,NULL,'available',NULL),(301,'61',4,NULL,'available',NULL),(302,'62',4,NULL,'available',NULL),(303,'63',4,NULL,'available',NULL),(304,'64',4,NULL,'available',NULL),(305,'65',4,NULL,'available',NULL),(306,'66',4,NULL,'available',NULL),(307,'67',4,NULL,'available',NULL),(308,'68',4,NULL,'available',NULL),(309,'69',4,NULL,'available',NULL),(310,'70',4,NULL,'available',NULL),(311,'71',4,NULL,'available',NULL),(312,'72',4,NULL,'available',NULL),(313,'73',4,NULL,'available',NULL),(314,'74',4,NULL,'available',NULL),(315,'75',4,NULL,'available',NULL),(316,'76',4,NULL,'available',NULL),(317,'77',4,NULL,'available',NULL),(318,'78',4,NULL,'available',NULL),(319,'79',4,NULL,'available',NULL),(320,'80',4,NULL,'available',NULL),(321,'1',5,NULL,'available',NULL),(322,'2',5,NULL,'available',NULL),(323,'3',5,NULL,'available',NULL),(324,'4',5,NULL,'available',NULL),(325,'5',5,NULL,'available',NULL),(326,'6',5,NULL,'available',NULL),(327,'7',5,NULL,'available',NULL),(328,'8',5,NULL,'available',NULL),(329,'9',5,NULL,'available',NULL),(330,'10',5,NULL,'available',NULL),(331,'11',5,NULL,'available',NULL),(332,'12',5,NULL,'available',NULL),(333,'13',5,NULL,'available',NULL),(334,'14',5,NULL,'available',NULL),(335,'15',5,NULL,'available',NULL),(336,'16',5,NULL,'available',NULL),(337,'17',5,NULL,'available',NULL),(338,'18',5,NULL,'available',NULL),(339,'19',5,NULL,'available',NULL),(340,'20',5,NULL,'available',NULL),(341,'21',5,NULL,'available',NULL),(342,'22',5,NULL,'available',NULL),(343,'23',5,NULL,'available',NULL),(344,'24',5,NULL,'available',NULL),(345,'25',5,NULL,'available',NULL),(346,'26',5,NULL,'available',NULL),(347,'27',5,NULL,'available',NULL),(348,'28',5,NULL,'available',NULL),(349,'29',5,NULL,'available',NULL),(350,'30',5,NULL,'available',NULL),(351,'31',5,NULL,'available',NULL),(352,'32',5,NULL,'available',NULL),(353,'33',5,NULL,'available',NULL),(354,'34',5,NULL,'available',NULL),(355,'35',5,NULL,'available',NULL),(356,'36',5,NULL,'available',NULL),(357,'37',5,NULL,'available',NULL),(358,'38',5,NULL,'available',NULL),(359,'39',5,NULL,'available',NULL),(360,'40',5,NULL,'available',NULL),(361,'41',5,NULL,'available',NULL),(362,'42',5,NULL,'available',NULL),(363,'43',5,NULL,'available',NULL),(364,'44',5,NULL,'available',NULL),(365,'45',5,NULL,'available',NULL),(366,'46',5,NULL,'available',NULL),(367,'47',5,NULL,'available',NULL),(368,'48',5,NULL,'available',NULL),(369,'49',5,NULL,'available',NULL),(370,'50',5,NULL,'available',NULL),(371,'51',5,NULL,'available',NULL),(372,'52',5,NULL,'available',NULL),(373,'53',5,NULL,'available',NULL),(374,'54',5,NULL,'available',NULL),(375,'55',5,NULL,'available',NULL),(376,'56',5,NULL,'available',NULL),(377,'57',5,NULL,'available',NULL),(378,'58',5,NULL,'available',NULL),(379,'59',5,NULL,'available',NULL),(380,'60',5,NULL,'available',NULL),(381,'61',5,NULL,'available',NULL),(382,'62',5,NULL,'available',NULL),(383,'63',5,NULL,'available',NULL),(384,'64',5,NULL,'available',NULL),(385,'65',5,NULL,'available',NULL),(386,'66',5,NULL,'available',NULL),(387,'67',5,NULL,'available',NULL),(388,'68',5,NULL,'available',NULL),(389,'69',5,NULL,'available',NULL),(390,'70',5,NULL,'available',NULL),(391,'71',5,NULL,'available',NULL),(392,'72',5,NULL,'available',NULL),(393,'73',5,NULL,'available',NULL),(394,'74',5,NULL,'available',NULL),(395,'75',5,NULL,'available',NULL),(396,'76',5,NULL,'available',NULL),(397,'77',5,NULL,'available',NULL),(398,'78',5,NULL,'available',NULL),(399,'79',5,NULL,'available',NULL),(400,'80',5,NULL,'available',NULL);
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showtime`
--

DROP TABLE IF EXISTS `showtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showtime` (
  `show_id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int DEFAULT NULL,
  `theatre_id` int DEFAULT NULL,
  `show_datetime` datetime DEFAULT NULL,
  `base_price` decimal(10,2) DEFAULT '0.00',
  `available_seats` int NOT NULL DEFAULT '80',
  PRIMARY KEY (`show_id`),
  KEY `idx_movie_id` (`movie_id`),
  KEY `idx_theatre_id` (`theatre_id`),
  KEY `idx_show_datetime` (`show_datetime`),
  CONSTRAINT `fk_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`),
  CONSTRAINT `fk_theatre_id` FOREIGN KEY (`theatre_id`) REFERENCES `theatre` (`theatre_id`),
  CONSTRAINT `showtime_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`),
  CONSTRAINT `showtime_ibfk_2` FOREIGN KEY (`theatre_id`) REFERENCES `theatre` (`theatre_id`),
  CONSTRAINT `chk_available_seats` CHECK ((`available_seats` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showtime`
--

LOCK TABLES `showtime` WRITE;
/*!40000 ALTER TABLE `showtime` DISABLE KEYS */;
INSERT INTO `showtime` VALUES (81,1,1,'2024-01-06 12:00:00',0.00,76),(82,1,3,'2024-01-06 15:00:00',0.00,75),(83,1,4,'2024-01-06 20:00:00',0.00,78),(84,1,1,'2024-01-07 12:00:00',0.00,78),(85,1,3,'2024-01-07 15:00:00',0.00,78),(86,1,4,'2024-01-07 20:00:00',0.00,78),(87,1,1,'2024-01-08 12:00:00',0.00,78),(88,1,3,'2024-01-08 15:00:00',0.00,78),(89,1,4,'2024-01-08 20:00:00',0.00,78),(102,3,3,'2024-01-06 14:00:00',0.00,68),(103,3,1,'2024-01-06 17:30:00',0.00,78),(104,3,5,'2024-01-06 20:30:00',0.00,78),(105,3,3,'2024-01-07 14:00:00',0.00,78),(106,3,1,'2024-01-07 17:30:00',0.00,78),(107,3,5,'2024-01-07 20:30:00',0.00,78),(108,4,1,'2024-01-06 10:00:00',0.00,77),(109,4,3,'2024-01-06 13:30:00',0.00,78),(110,4,5,'2024-01-06 18:30:00',0.00,78),(111,4,1,'2024-01-07 10:00:00',0.00,78),(112,4,3,'2024-01-07 13:30:00',0.00,78),(113,4,5,'2024-01-07 18:30:00',0.00,78),(114,5,3,'2024-01-06 11:00:00',0.00,74),(115,5,4,'2024-01-06 14:30:00',0.00,78),(116,5,5,'2024-01-06 19:00:00',0.00,78),(117,5,3,'2024-01-07 11:00:00',0.00,78),(118,5,4,'2024-01-07 14:30:00',0.00,78),(119,5,5,'2024-01-07 19:00:00',0.00,78),(120,6,4,'2024-01-06 12:30:00',0.00,78),(121,6,1,'2024-01-06 16:00:00',0.00,78),(122,6,5,'2024-01-06 20:00:00',0.00,78),(123,6,4,'2024-01-07 12:30:00',0.00,78),(124,6,1,'2024-01-07 16:00:00',0.00,78),(125,6,5,'2024-01-07 20:00:00',0.00,78),(126,7,3,'2024-01-06 13:00:00',0.00,78),(127,7,4,'2024-01-06 15:30:00',0.00,78),(128,7,5,'2024-01-06 21:00:00',0.00,78),(129,7,3,'2024-01-07 13:00:00',0.00,78),(130,7,4,'2024-01-07 15:30:00',0.00,78),(131,7,5,'2024-01-07 21:00:00',0.00,78),(148,1,1,'2024-01-09 12:00:00',0.00,78),(149,1,3,'2024-01-09 15:00:00',0.00,76),(150,1,5,'2024-01-09 20:00:00',0.00,78),(151,1,1,'2024-01-10 12:00:00',0.00,78),(152,1,3,'2024-01-10 15:00:00',0.00,78),(153,1,5,'2024-01-10 20:00:00',0.00,78),(154,1,1,'2024-01-11 12:00:00',0.00,78),(155,1,3,'2024-01-11 15:00:00',0.00,78),(156,1,5,'2024-01-11 20:00:00',0.00,78),(157,1,1,'2024-01-12 12:00:00',0.00,78),(158,1,3,'2024-01-12 15:00:00',0.00,78),(159,1,5,'2024-01-12 20:00:00',0.00,75),(160,3,1,'2024-01-09 11:00:00',0.00,78),(161,3,3,'2024-01-09 14:00:00',0.00,78),(162,3,5,'2024-01-09 18:00:00',0.00,78),(163,3,1,'2024-01-10 11:00:00',0.00,78),(164,3,3,'2024-01-10 14:00:00',0.00,78),(165,3,5,'2024-01-10 18:00:00',0.00,73),(166,3,1,'2024-01-11 11:00:00',0.00,78),(167,3,3,'2024-01-11 14:00:00',0.00,78),(168,3,5,'2024-01-11 18:00:00',0.00,77),(169,3,1,'2024-01-12 11:00:00',0.00,78),(170,3,3,'2024-01-12 14:00:00',0.00,78),(171,3,5,'2024-01-12 18:00:00',0.00,77),(172,4,1,'2024-01-09 13:00:00',0.00,78),(173,4,3,'2024-01-09 16:30:00',0.00,78),(174,4,5,'2024-01-09 19:00:00',0.00,78),(175,4,1,'2024-01-10 13:00:00',0.00,78),(176,4,3,'2024-01-10 16:30:00',0.00,78),(177,4,5,'2024-01-10 19:00:00',0.00,76),(178,4,1,'2024-01-11 13:00:00',0.00,78),(179,4,3,'2024-01-11 16:30:00',0.00,78),(180,4,5,'2024-01-11 19:00:00',0.00,78),(181,4,1,'2024-01-12 13:00:00',0.00,78),(182,4,3,'2024-01-12 16:30:00',0.00,78),(183,4,5,'2024-01-12 19:00:00',0.00,77),(184,5,1,'2024-01-09 10:30:00',0.00,78),(185,5,3,'2024-01-09 13:00:00',0.00,78),(186,5,5,'2024-01-09 17:30:00',0.00,78),(187,5,1,'2024-01-10 10:30:00',0.00,78),(188,5,3,'2024-01-10 13:00:00',0.00,78),(189,5,5,'2024-01-10 17:30:00',0.00,78),(190,5,1,'2024-01-11 10:30:00',0.00,78),(191,5,3,'2024-01-11 13:00:00',0.00,78),(192,5,5,'2024-01-11 17:30:00',0.00,78),(193,5,1,'2024-01-12 10:30:00',0.00,78),(194,5,3,'2024-01-12 13:00:00',0.00,78),(195,5,5,'2024-01-12 17:30:00',0.00,78),(196,6,1,'2024-01-09 14:00:00',0.00,78),(197,6,3,'2024-01-09 17:00:00',0.00,78),(198,6,5,'2024-01-09 20:00:00',0.00,78),(199,6,1,'2024-01-10 14:00:00',0.00,78),(200,6,3,'2024-01-10 17:00:00',0.00,78),(201,6,5,'2024-01-10 20:00:00',0.00,78),(202,6,1,'2024-01-11 14:00:00',0.00,78),(203,6,3,'2024-01-11 17:00:00',0.00,78),(204,6,5,'2024-01-11 20:00:00',0.00,78),(205,6,1,'2024-01-12 14:00:00',0.00,78),(206,6,3,'2024-01-12 17:00:00',0.00,78),(207,6,5,'2024-01-12 20:00:00',0.00,77),(208,7,1,'2024-01-09 15:00:00',0.00,78),(209,7,3,'2024-01-09 18:00:00',0.00,78),(210,7,5,'2024-01-09 21:00:00',0.00,78),(211,7,1,'2024-01-10 15:00:00',0.00,78),(212,7,3,'2024-01-10 18:00:00',0.00,78),(213,7,5,'2024-01-10 21:00:00',0.00,75),(214,7,1,'2024-01-11 15:00:00',0.00,78),(215,7,3,'2024-01-11 18:00:00',0.00,78),(216,7,5,'2024-01-11 21:00:00',0.00,78),(217,7,1,'2024-01-12 15:00:00',0.00,73),(218,7,3,'2024-01-12 18:00:00',0.00,78),(219,7,5,'2024-01-12 21:00:00',0.00,77);
/*!40000 ALTER TABLE `showtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theatre`
--

DROP TABLE IF EXISTS `theatre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theatre` (
  `theatre_id` int NOT NULL AUTO_INCREMENT,
  `theatre_name` varchar(100) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `extra_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`theatre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theatre`
--

LOCK TABLES `theatre` WRITE;
/*!40000 ALTER TABLE `theatre` DISABLE KEYS */;
INSERT INTO `theatre` VALUES (1,'Salon 1',80,'STANDARD',0.00),(3,'Salon 2',80,'STANDARD',0.00),(4,'Salon 3',80,'STANDARD',0.00),(5,'VIP Salon',80,'VIP',15.00);
/*!40000 ALTER TABLE `theatre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `seat_id` int DEFAULT NULL,
  `ticket_number` varchar(20) DEFAULT NULL,
  `theatre_name` varchar(100) DEFAULT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `show_id` int DEFAULT NULL,
  `show_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `booking_id` (`booking_id`),
  KEY `seat_id` (`seat_id`),
  KEY `show_id` (`show_id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`),
  CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`show_id`) REFERENCES `showtime` (`show_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT 'default_password',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `unique_user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'dilmer','dilmer@gmail.com','Adgjdilmer8118.','2024-12-30 22:38:33',NULL),(2,'merila','merila@gmail.com','Adgjmerila8118.','2024-12-30 22:38:33',NULL),(7,'mer','mer@gmail.com','mer','2024-12-30 22:38:33',NULL),(8,'dil','dil@gmail.com','dil','2024-12-30 22:38:33',NULL),(9,'lara','lara@gmail.com','lara','2024-12-30 22:38:33',NULL),(10,'x','x@gmail.com','x','2024-12-30 22:38:33',NULL),(11,'anil','anil@gmail.com','anil','2025-01-02 20:40:00',NULL),(12,'a','a@gmail.com','a','2025-01-02 21:01:10',NULL),(13,'c','c@gmail.com','c','2025-01-02 21:17:52',NULL),(14,'d','d','d','2025-01-02 21:29:15',NULL),(15,'f','f','f','2025-01-02 22:17:54',NULL),(16,'t','t','t','2025-01-02 22:24:36',NULL),(17,'sude','sude@gmail.com','sude','2025-01-03 01:36:12',NULL),(18,'i','i','i','2025-01-03 11:24:13',NULL),(19,'ben','ben','ben','2025-01-03 11:57:57',NULL),(20,'ece','ece','ece','2025-01-03 12:03:56',NULL),(21,'mustafa','mustafa','mustafa','2025-01-03 12:05:21',NULL),(22,'chadz','chadz@gmail.com','chadz','2025-01-03 12:15:58',NULL),(23,'busra','busra@gmail.com','busra','2025-01-03 12:20:25',NULL),(24,'finally','finally@gmail.com','finally','2025-01-03 12:24:24',NULL),(25,'final','final@gmail.com','final','2025-01-03 12:26:36',NULL),(26,'simba','simba@gmail.com','simba','2025-01-03 12:35:17',NULL),(27,'mina','mina@gmail.com','mina','2025-01-03 12:54:31',NULL),(28,'h','h','h','2025-01-04 14:16:01',NULL),(29,'sudenur','sudenur@gmail.com','sudenur','2025-01-04 19:57:28',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'database_project'
--

--
-- Dumping routines for database 'database_project'
--
/*!50003 DROP PROCEDURE IF EXISTS `UpdateSeats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSeats`(
    IN ticket_count INT, -- Alınacak bilet sayısı
    IN target_show_id INT -- Hangi gösterimden koltuk düşülecek
)
BEGIN
    -- Mevcut koltuk sayısını kontrol et
    DECLARE current_seats INT;

    SELECT available_seats INTO current_seats
    FROM showtime
    WHERE show_id = target_show_id;

    -- Eğer yeterli koltuk yoksa hata gönder
    IF current_seats < ticket_count THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough seats available.';
    END IF;

    -- Yalnızca belirtilen show_id için koltuk sayısını güncelle
    UPDATE showtime
    SET available_seats = available_seats - ticket_count
    WHERE show_id = target_show_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateSeatsOnCancellation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSeatsOnCancellation`(
    IN cancelled_ticket_count INT,
    IN target_show_id INT
)
BEGIN
    UPDATE showtime
    SET available_seats = available_seats + cancelled_ticket_count
    WHERE show_id = target_show_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-04 20:12:05
