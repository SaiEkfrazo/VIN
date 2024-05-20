-- MySQL dump 10.13  Distrib 8.3.0, for Linux (x86_64)
--
-- Host: localhost    Database: vin
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_customuser'),(22,'Can change user',6,'change_customuser'),(23,'Can delete user',6,'delete_customuser'),(24,'Can view user',6,'view_customuser'),(25,'Can add alerts',7,'add_alerts'),(26,'Can change alerts',7,'change_alerts'),(27,'Can delete alerts',7,'delete_alerts'),(28,'Can view alerts',7,'view_alerts'),(29,'Can add defects',8,'add_defects'),(30,'Can change defects',8,'change_defects'),(31,'Can delete defects',8,'delete_defects'),(32,'Can view defects',8,'view_defects'),(33,'Can add department',9,'add_department'),(34,'Can change department',9,'change_department'),(35,'Can delete department',9,'delete_department'),(36,'Can view department',9,'view_department'),(37,'Can add machines',10,'add_machines'),(38,'Can change machines',10,'change_machines'),(39,'Can delete machines',10,'delete_machines'),(40,'Can view machines',10,'view_machines'),(41,'Can add reports',11,'add_reports'),(42,'Can change reports',11,'change_reports'),(43,'Can delete reports',11,'delete_reports'),(44,'Can view reports',11,'view_reports');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_alerts`
--

DROP TABLE IF EXISTS `dashboard_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_alerts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_alerts`
--

LOCK TABLES `dashboard_alerts` WRITE;
/*!40000 ALTER TABLE `dashboard_alerts` DISABLE KEYS */;
INSERT INTO `dashboard_alerts` VALUES (1,'Temperature'),(2,'Teeth'),(3,'violation');
/*!40000 ALTER TABLE `dashboard_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_customuser`
--

DROP TABLE IF EXISTS `dashboard_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `dashboard_customuser_phone_number_3de8b39c_uniq` (`phone_number`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_customuser`
--

LOCK TABLES `dashboard_customuser` WRITE;
/*!40000 ALTER TABLE `dashboard_customuser` DISABLE KEYS */;
INSERT INTO `dashboard_customuser` VALUES (1,'2024-04-17 13:23:22.325392',1,'hul',1,1,'2024-04-17 13:20:09.376489','','','pbkdf2_sha256$600000$SOJtRQijciyyfNiGUPJKwN$48eB1hAKVmYk5+wFERA4sEMZ2TkRGZgZIWod7AKrDy8=','hul@hul.com',NULL);
/*!40000 ALTER TABLE `dashboard_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_customuser_groups`
--

DROP TABLE IF EXISTS `dashboard_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dashboard_customuser_groups_customuser_id_group_id_32c771a4_uniq` (`customuser_id`,`group_id`),
  KEY `dashboard_customuser_groups_group_id_f09075a7_fk_auth_group_id` (`group_id`),
  CONSTRAINT `dashboard_customuser_customuser_id_8a1e4ac5_fk_dashboard` FOREIGN KEY (`customuser_id`) REFERENCES `dashboard_customuser` (`id`),
  CONSTRAINT `dashboard_customuser_groups_group_id_f09075a7_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_customuser_groups`
--

LOCK TABLES `dashboard_customuser_groups` WRITE;
/*!40000 ALTER TABLE `dashboard_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_customuser_user_permissions`
--

DROP TABLE IF EXISTS `dashboard_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dashboard_customuser_use_customuser_id_permission_892075b3_uniq` (`customuser_id`,`permission_id`),
  KEY `dashboard_customuser_permission_id_88cd1b25_fk_auth_perm` (`permission_id`),
  CONSTRAINT `dashboard_customuser_customuser_id_5e9700d5_fk_dashboard` FOREIGN KEY (`customuser_id`) REFERENCES `dashboard_customuser` (`id`),
  CONSTRAINT `dashboard_customuser_permission_id_88cd1b25_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_customuser_user_permissions`
--

LOCK TABLES `dashboard_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `dashboard_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_defects`
--

DROP TABLE IF EXISTS `dashboard_defects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_defects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `color_code` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_defects`
--

LOCK TABLES `dashboard_defects` WRITE;
/*!40000 ALTER TABLE `dashboard_defects` DISABLE KEYS */;
INSERT INTO `dashboard_defects` VALUES (1,'Air Packet','#fbdfd9'),(2,'Perforation/Burn/Damage','#f88f78'),(3,'Seal - Align','#f7421b'),(4,'Seal-Join/Tear','#f5cda9'),(5,'Soil/Dirt/Grease','#f6a55e'),(6,'Wrapper','#f2e4d7'),(7,'Crush/Dent/Tear/Leakage','#f18220'),(8,'Product Code','#6f5239');
/*!40000 ALTER TABLE `dashboard_defects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_department`
--

DROP TABLE IF EXISTS `dashboard_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_department` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_department`
--

LOCK TABLES `dashboard_department` WRITE;
/*!40000 ALTER TABLE `dashboard_department` DISABLE KEYS */;
INSERT INTO `dashboard_department` VALUES (1,'Quality'),(2,'Admin');
/*!40000 ALTER TABLE `dashboard_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_machines`
--

DROP TABLE IF EXISTS `dashboard_machines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_machines` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_machines`
--

LOCK TABLES `dashboard_machines` WRITE;
/*!40000 ALTER TABLE `dashboard_machines` DISABLE KEYS */;
INSERT INTO `dashboard_machines` VALUES (1,'Machine 1'),(2,'Machine 2'),(3,'Machine 3'),(4,'Machine 4'),(5,'Machine 5'),(6,'Machine 6'),(7,'Machine 7'),(8,'Machine 8'),(9,'Machine 9'),(10,'Machine 10'),(11,'Machine 11'),(12,'Machine 12'),(13,'Machine 13'),(14,'Machine 14'),(15,'Machine 15'),(16,'Machine 16'),(17,'Machine 17');
/*!40000 ALTER TABLE `dashboard_machines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_reports`
--

DROP TABLE IF EXISTS `dashboard_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_reports` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `recorded_date_time` datetime(6) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `image_b64` varchar(100) DEFAULT NULL,
  `alert_id` bigint DEFAULT NULL,
  `defect_id` bigint DEFAULT NULL,
  `department_id` bigint DEFAULT NULL,
  `machine_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_reports_alert_id_e63875d7_fk_dashboard_alerts_id` (`alert_id`),
  KEY `dashboard_reports_defect_id_3802c157_fk_dashboard_defects_id` (`defect_id`),
  KEY `dashboard_reports_department_id_62ff2290_fk_dashboard` (`department_id`),
  KEY `dashboard_reports_machine_id_702318f4_fk_dashboard_machines_id` (`machine_id`),
  CONSTRAINT `dashboard_reports_alert_id_e63875d7_fk_dashboard_alerts_id` FOREIGN KEY (`alert_id`) REFERENCES `dashboard_alerts` (`id`),
  CONSTRAINT `dashboard_reports_defect_id_3802c157_fk_dashboard_defects_id` FOREIGN KEY (`defect_id`) REFERENCES `dashboard_defects` (`id`),
  CONSTRAINT `dashboard_reports_department_id_62ff2290_fk_dashboard` FOREIGN KEY (`department_id`) REFERENCES `dashboard_department` (`id`),
  CONSTRAINT `dashboard_reports_machine_id_702318f4_fk_dashboard_machines_id` FOREIGN KEY (`machine_id`) REFERENCES `dashboard_machines` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_reports`
--

LOCK TABLES `dashboard_reports` WRITE;
/*!40000 ALTER TABLE `dashboard_reports` DISABLE KEYS */;
INSERT INTO `dashboard_reports` VALUES (1,'2024-04-17 19:06:33.000000','','results/67a29223-74d9-46d1-a36b-4fc0bb772065.jpg',1,3,1,1),(2,'2024-04-17 19:08:41.000000','','results/3e5550ea-d61d-431b-a186-bafd0233f6de.jpg',1,3,1,1),(3,'2024-04-17 19:09:53.000000','','results/398feec0-0fc2-409c-8504-9fc3367723b6.jpg',1,3,1,1),(4,'2024-04-17 19:14:04.000000','','results/7b64b08b-2b95-4005-96c5-55344129c161.jpg',1,3,1,1),(5,'2024-04-17 19:16:21.000000','','results/c35a15ae-2c21-4356-bbd7-a8240491892e.jpg',1,3,1,1),(6,'2024-04-17 19:16:23.000000','','results/40f9642d-7511-47b2-9471-6a326b116ff6.jpg',1,3,1,1),(7,'2024-04-17 19:17:29.000000','','results/f3efdce4-f67f-48b8-aba1-8d54f835410b.jpg',1,3,1,1),(8,'2024-04-17 21:28:13.000000','','results/10699a3e-41a9-4ee1-a1f3-0527520e16af.jpg',3,7,1,1),(9,'2024-04-17 21:28:18.000000','','results/03c83055-0636-4aec-985e-4d64eb5598e2.jpg',3,7,1,1),(10,'2024-04-17 21:28:27.000000','','results/ce4c71dd-2ddb-4cec-8f2e-4c7dc72cef13.jpg',3,7,1,1),(11,'2024-04-17 21:28:35.000000','','results/7995dca1-3d3a-4796-8b4f-9b0f2ca14a93.jpg',3,7,1,1),(12,'2024-04-17 21:28:42.000000','','results/e2e3e8cd-1f9e-4ca9-8397-b094e33934bb.jpg',3,7,1,1),(13,'2024-04-17 21:28:49.000000','','results/48c641d1-082b-4cdd-a3c9-3b7c090675c6.jpg',3,7,1,1),(14,'2024-04-17 21:28:55.000000','','results/039e86f8-dc3c-4a79-8881-677642af5f6e.jpg',3,7,1,1),(15,'2024-04-17 21:28:57.000000','','results/ca7704cf-eb3c-4226-8176-317ffff924e8.jpg',3,7,1,1),(16,'2024-04-17 21:29:06.000000','','results/e4d080b1-1e56-4ef5-b812-b01d7420c948.jpg',3,7,1,1),(17,'2024-04-17 21:29:13.000000','','results/98820d46-e758-47ea-b26c-f4994a199409.jpg',3,7,1,1),(18,'2024-04-17 21:29:18.000000','','results/9e31e298-b7a1-4480-99d4-e58eaa33070a.jpg',3,7,1,1),(19,'2024-04-17 21:29:24.000000','','results/727ef83d-cb5a-443a-a3a1-1042d80c2a57.jpg',3,7,1,1),(20,'2024-04-17 21:29:26.000000','','results/1bb33f08-55f7-4a13-a3ab-2be1adcf53cc.jpg',3,7,1,1),(21,'2024-04-17 21:29:33.000000','','results/021d3efd-7004-483e-8eca-832371fe23c2.jpg',3,7,1,1),(22,'2024-04-17 21:29:36.000000','','results/e0d5046c-4be3-4bb0-902a-1ea3a98d2ff8.jpg',3,7,1,1),(23,'2024-04-17 21:29:43.000000','','results/399f610c-cfcc-4e2a-9925-41a21ca11d69.jpg',3,7,1,1),(24,'2024-04-17 21:31:28.000000','','results/09aae338-fbb7-487d-961d-204747479b0d.jpg',1,3,1,1),(25,'2024-04-17 21:32:34.000000','','results/08fd3d42-c6f3-41ee-9bd6-0d585031157d.jpg',1,3,1,1),(26,'2024-04-17 21:33:04.000000','','results/bed58f12-7df4-44db-a6d4-f1a27c498cdc.jpg',1,3,1,1),(27,'2024-04-17 21:33:28.000000','','results/1dbb4eeb-8703-40c5-9cf5-b2826c4fdf04.jpg',1,3,1,1),(28,'2024-04-17 21:33:47.000000','','results/0d72e168-facc-4a12-bf78-81d6f9f4f0db.jpg',1,3,1,1),(29,'2024-04-17 21:34:05.000000','','results/f44ae3ab-a225-4ac3-a089-6dd7a6b3728a.jpg',1,3,1,1),(30,'2024-04-17 21:34:16.000000','','results/3bcd2285-7683-45b3-9a7a-0fb6e4f19780.jpg',1,3,1,1),(31,'2024-04-17 21:35:47.000000','','results/f952944c-2938-43d0-8687-a616c22bc33e.jpg',1,2,1,1),(32,'2024-04-17 21:35:50.000000','','results/d45dffb9-6142-4fc7-95cb-ae431727409a.jpg',1,2,1,1),(33,'2024-04-17 21:35:52.000000','','results/7c409187-eefe-4642-a67c-3c38b5694ea2.jpg',1,2,1,1),(34,'2024-04-17 21:35:59.000000','','results/01f339ff-f98e-406a-b5fa-d68933028407.jpg',1,2,1,1),(35,'2024-04-17 21:36:02.000000','','results/ca0863b3-8fad-47ba-b940-073aadd15e02.jpg',1,2,1,1),(36,'2024-04-17 21:36:05.000000','','results/27eca9ad-3bc8-4a59-b1cf-368aac310238.jpg',1,2,1,1),(37,'2024-04-17 21:36:08.000000','','results/9c4fdfc7-03c4-4e78-81ac-3bafbd72bc36.jpg',1,2,1,1),(38,'2024-04-17 21:36:10.000000','','results/f10b9b2c-08ba-44b5-9a5b-0a579d0fbf8a.jpg',1,2,1,1),(39,'2024-04-17 21:36:13.000000','','results/872149fe-e73b-44c7-89f6-256048812c92.jpg',1,2,1,1),(40,'2024-04-17 21:36:17.000000','','results/0f35b54c-cf7a-4d1c-b7a2-19ba351ec672.jpg',1,2,1,1),(41,'2024-04-17 21:36:20.000000','','results/9dd33510-05a2-492d-8795-96a0a8285ac9.jpg',1,2,1,1),(42,'2024-04-17 21:36:22.000000','','results/b2c627f3-618c-4101-9adf-a0503e4c99d3.jpg',1,2,1,1),(43,'2024-04-17 21:36:25.000000','','results/7d135b70-04af-4d88-9997-1e9fbfcd8208.jpg',1,2,1,1),(44,'2024-04-17 21:36:26.000000','','results/2bc3be03-13f2-43a2-80d1-24a9fe29deb6.jpg',1,2,1,1),(45,'2024-04-17 21:36:29.000000','','results/892073d0-dcbb-4340-b3a1-896c1d9460db.jpg',1,2,1,1),(46,'2024-04-17 21:36:32.000000','','results/eb4b84ca-848e-43cf-b426-88281c82d6fe.jpg',1,2,1,1),(47,'2024-04-17 21:36:33.000000','','results/73208424-83c8-422d-8ccb-5efe68ddea12.jpg',1,2,1,1),(48,'2024-04-17 21:36:35.000000','','results/da26bfd7-028e-4ca9-9dd5-ceead86d08d4.jpg',1,2,1,1),(49,'2024-04-17 21:36:36.000000','','results/96a17a51-c52d-4830-b7ee-f7989f2f46a1.jpg',1,2,1,1),(50,'2024-04-17 21:36:38.000000','','results/073d8494-ab17-455d-af1b-edb42fcd298d.jpg',1,2,1,1),(51,'2024-04-17 21:36:40.000000','','results/237a21e2-690a-4a77-99c6-12280495e766.jpg',1,2,1,1),(52,'2024-04-17 21:36:41.000000','','results/c08bcad2-f94d-4a1d-bbfe-bff24c6f4bea.jpg',1,2,1,1),(53,'2024-04-17 21:36:44.000000','','results/39e07579-abfd-48f7-b221-87bc51e3cc92.jpg',1,2,1,1),(54,'2024-04-17 21:36:47.000000','','results/b17c2b40-f070-4f65-9f3e-9caa7f9b4559.jpg',1,2,1,1),(55,'2024-04-17 21:38:28.000000','','results/09844bab-85f5-4a2b-94a9-fc27f216eeba.jpg',1,2,1,1),(56,'2024-04-17 21:38:31.000000','','results/6c84aaa9-161e-4441-a657-a8f6dc9564be.jpg',1,2,1,1),(57,'2024-04-17 21:38:34.000000','','results/b2fc9e0f-5685-4372-b646-1bdbf6a751f1.jpg',1,2,1,1),(58,'2024-04-17 21:38:37.000000','','results/e05a1972-5f6a-482f-8418-beffac38ea34.jpg',1,2,1,1),(59,'2024-04-17 21:38:40.000000','','results/450cb4ac-7f47-4fc2-86ad-985caa1a06d2.jpg',1,2,1,1),(60,'2024-04-17 21:38:43.000000','','results/063f211b-ebb6-45bb-974e-a69515bedfa2.jpg',1,2,1,1),(61,'2024-04-17 21:38:45.000000','','results/d928279e-c13a-4400-8d33-0b43720db7e8.jpg',1,2,1,1),(84,'2024-04-18 02:50:47.000000','','results/305d84b0-a218-4c25-8f7a-3a9378f15a94.jpg',1,3,1,1),(85,'2024-04-18 02:51:59.000000','','results/07a8aa8d-e871-45de-ae80-af78073c62ec.jpg',1,3,1,1),(86,'2024-04-18 02:52:07.000000','','results/68fb6ce3-9e48-4b0e-8df7-ca7448d3d6d1.jpg',1,3,1,1),(87,'2024-04-18 02:52:28.000000','','results/bc9248fd-0b04-4602-8343-63e5b1bfb673.jpg',1,3,1,1);
/*!40000 ALTER TABLE `dashboard_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_dashboard_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_dashboard_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `dashboard_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-04-17 13:23:52.410157','1','Temperature',1,'[{\"added\": {}}]',7,1),(2,'2024-04-17 13:24:03.124328','2','Teeth',1,'[{\"added\": {}}]',7,1),(3,'2024-04-17 13:24:18.098133','3','violation',1,'[{\"added\": {}}]',7,1),(4,'2024-04-17 13:26:23.629497','1','Air Packet',1,'[{\"added\": {}}]',8,1),(5,'2024-04-17 13:26:51.191090','2','Perforation/Burn/Damage',1,'[{\"added\": {}}]',8,1),(6,'2024-04-17 13:27:19.121048','3','Seal - Align',1,'[{\"added\": {}}]',8,1),(7,'2024-04-17 13:27:42.863097','4','Seal-Join/Tear',1,'[{\"added\": {}}]',8,1),(8,'2024-04-17 13:28:15.866163','5','Soil/Dirt/Grease',1,'[{\"added\": {}}]',8,1),(9,'2024-04-17 13:28:35.483006','6','Wrapper',1,'[{\"added\": {}}]',8,1),(10,'2024-04-17 13:28:54.405232','7','Crush/Dent/Tear/Leakage',1,'[{\"added\": {}}]',8,1),(11,'2024-04-17 13:29:13.492573','8','Product Code',1,'[{\"added\": {}}]',8,1),(12,'2024-04-17 13:29:25.235684','1','Quality',1,'[{\"added\": {}}]',9,1),(13,'2024-04-17 13:29:31.078719','2','Admin',1,'[{\"added\": {}}]',9,1),(14,'2024-04-17 13:29:38.824537','1','Machine 1',1,'[{\"added\": {}}]',10,1),(15,'2024-04-17 13:29:47.694547','2','Machine 2',1,'[{\"added\": {}}]',10,1),(16,'2024-04-17 13:29:54.064478','3','Machine 3',1,'[{\"added\": {}}]',10,1),(17,'2024-04-17 13:29:59.625843','4','Machine 4',1,'[{\"added\": {}}]',10,1),(18,'2024-04-17 13:30:05.713214','5','Machine 5',1,'[{\"added\": {}}]',10,1),(19,'2024-04-17 13:30:12.870037','6','Machine 6',1,'[{\"added\": {}}]',10,1),(20,'2024-04-17 13:30:21.431678','7','Machine 7',1,'[{\"added\": {}}]',10,1),(21,'2024-04-17 13:30:28.643402','8','Machine 8',1,'[{\"added\": {}}]',10,1),(22,'2024-04-17 13:30:35.968450','9','Machine 9',1,'[{\"added\": {}}]',10,1),(23,'2024-04-17 13:30:43.555442','10','Machine 10',1,'[{\"added\": {}}]',10,1),(24,'2024-04-17 13:30:52.718917','11','Machine 11',1,'[{\"added\": {}}]',10,1),(25,'2024-04-17 13:31:07.384746','12','Machine 12',1,'[{\"added\": {}}]',10,1),(26,'2024-04-17 13:31:17.396923','13','Machine 13',1,'[{\"added\": {}}]',10,1),(27,'2024-04-17 13:31:30.462978','14','Machine 14',1,'[{\"added\": {}}]',10,1),(28,'2024-04-17 13:31:39.120165','15','Machine 15',1,'[{\"added\": {}}]',10,1),(29,'2024-04-17 13:31:50.214761','16','Machine 16',1,'[{\"added\": {}}]',10,1),(30,'2024-04-17 13:31:58.989864','17','Machine 17',1,'[{\"added\": {}}]',10,1),(31,'2024-04-17 16:12:18.143421','83','Reports object (83)',3,'',11,1),(32,'2024-04-17 16:12:18.147898','82','Reports object (82)',3,'',11,1),(33,'2024-04-17 16:12:18.150638','81','Reports object (81)',3,'',11,1),(34,'2024-04-17 16:12:18.152901','80','Reports object (80)',3,'',11,1),(35,'2024-04-17 16:12:18.155817','79','Reports object (79)',3,'',11,1),(36,'2024-04-17 16:12:18.158317','78','Reports object (78)',3,'',11,1),(37,'2024-04-17 16:12:18.160537','77','Reports object (77)',3,'',11,1),(38,'2024-04-17 16:12:18.163202','76','Reports object (76)',3,'',11,1),(39,'2024-04-17 16:12:18.165487','75','Reports object (75)',3,'',11,1),(40,'2024-04-17 16:12:18.167780','74','Reports object (74)',3,'',11,1),(41,'2024-04-17 16:12:18.170401','73','Reports object (73)',3,'',11,1),(42,'2024-04-17 16:12:18.172790','72','Reports object (72)',3,'',11,1),(43,'2024-04-17 16:12:18.175592','71','Reports object (71)',3,'',11,1),(44,'2024-04-17 16:12:18.178300','70','Reports object (70)',3,'',11,1),(45,'2024-04-17 16:12:18.180901','69','Reports object (69)',3,'',11,1),(46,'2024-04-17 16:12:18.183609','68','Reports object (68)',3,'',11,1),(47,'2024-04-17 16:12:18.186114','67','Reports object (67)',3,'',11,1),(48,'2024-04-17 16:12:18.188678','66','Reports object (66)',3,'',11,1),(49,'2024-04-17 16:12:18.191437','65','Reports object (65)',3,'',11,1),(50,'2024-04-17 16:12:18.194001','64','Reports object (64)',3,'',11,1),(51,'2024-04-17 16:12:18.196593','63','Reports object (63)',3,'',11,1),(52,'2024-04-17 16:12:18.199098','62','Reports object (62)',3,'',11,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(7,'dashboard','alerts'),(6,'dashboard','customuser'),(8,'dashboard','defects'),(9,'dashboard','department'),(10,'dashboard','machines'),(11,'dashboard','reports'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-04-17 13:19:26.085662'),(2,'contenttypes','0002_remove_content_type_name','2024-04-17 13:19:26.130721'),(3,'auth','0001_initial','2024-04-17 13:19:26.321709'),(4,'auth','0002_alter_permission_name_max_length','2024-04-17 13:19:26.364020'),(5,'auth','0003_alter_user_email_max_length','2024-04-17 13:19:26.371235'),(6,'auth','0004_alter_user_username_opts','2024-04-17 13:19:26.377291'),(7,'auth','0005_alter_user_last_login_null','2024-04-17 13:19:26.383531'),(8,'auth','0006_require_contenttypes_0002','2024-04-17 13:19:26.386706'),(9,'auth','0007_alter_validators_add_error_messages','2024-04-17 13:19:26.392568'),(10,'auth','0008_alter_user_username_max_length','2024-04-17 13:19:26.398766'),(11,'auth','0009_alter_user_last_name_max_length','2024-04-17 13:19:26.404553'),(12,'auth','0010_alter_group_name_max_length','2024-04-17 13:19:26.417679'),(13,'auth','0011_update_proxy_permissions','2024-04-17 13:19:26.423719'),(14,'auth','0012_alter_user_first_name_max_length','2024-04-17 13:19:26.429758'),(15,'dashboard','0001_initial','2024-04-17 13:19:26.654347'),(16,'admin','0001_initial','2024-04-17 13:19:26.767432'),(17,'admin','0002_logentry_remove_auto_add','2024-04-17 13:19:26.779789'),(18,'admin','0003_logentry_add_action_flag_choices','2024-04-17 13:19:26.787875'),(19,'dashboard','0002_alter_customuser_phone_number','2024-04-17 13:19:26.813205'),(20,'dashboard','0003_alter_customuser_username','2024-04-17 13:19:26.861658'),(21,'dashboard','0004_alerts_defects_department_machines_and_more','2024-04-17 13:19:27.225923'),(22,'dashboard','0005_defects_color_code','2024-04-17 13:19:27.251110'),(23,'sessions','0001_initial','2024-04-17 13:19:27.280429');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ydeeheqc18kprbjkxpz4iifj65ji69wz','.eJxVjDsOwjAQBe_iGllrJ_5R0nMGa9dr4wBypDipEHeHSCmgfTPzXiLitta49bzEicVZKHH63QjTI7cd8B3bbZZpbusykdwVedAurzPn5-Vw_w4q9vqt00hFMxibR_TsvNUIgQ0EBJeUKUgw-KCZXckEZFMBzSVZCmTcAEq8P_KqOFU:1rx5Fy:18XRFgSl2OVkAapPb3h3hFpMq9WnRxgnAoRJDvwsKyk','2024-05-01 13:23:22.329281');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-18  5:54:42
