-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: tomsbakery
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `custom_product`
--

DROP TABLE IF EXISTS `custom_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `custom_key` varchar(255) DEFAULT NULL,
  `custom_price_key` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `unit_price` decimal(19,2) NOT NULL,
  `image_file` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `FK1duu2nscpj6y3ssyhtbl8qtmn` (`category_id`),
  CONSTRAINT `FK1duu2nscpj6y3ssyhtbl8qtmn` FOREIGN KEY (`category_id`) REFERENCES `custom_product_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_product`
--

LOCK TABLES `custom_product` WRITE;
/*!40000 ALTER TABLE `custom_product` DISABLE KEYS */;
INSERT INTO `custom_product` VALUES (8,'prod_Kv2j97gfAsLgyT','price_1KFCeDHEUlhmshphc9cGzAex','Redbean Bread',2.99,'redbean.jpg','Bread with redbean-paste filling',_binary '',NULL,NULL,1),(9,'prod_Kv2kdP15mT20y9','price_1KFCecHEUlhmshphlWgmk3py','Taro Bread',2.99,'turtle.jpg','Bread with taro-paste filling',_binary '',NULL,NULL,1),(10,'prod_KvHjOpWNU0hBAA','price_1KFRABHEUlhmshphsjtcafUW','Matcha Bread',2.99,'matcha.jpg','Bread with matcha-paste filling',_binary '',NULL,NULL,1),(11,NULL,NULL,'Custard Bread',1.99,'custardbread.jpg','Bread with custard filling',_binary '',NULL,NULL,1),(12,NULL,NULL,'Chocolate Bread',2.99,'chocolatebread.jpg',NULL,_binary '',NULL,NULL,1);
/*!40000 ALTER TABLE `custom_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_product_category`
--

DROP TABLE IF EXISTS `custom_product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_product_category`
--

LOCK TABLES `custom_product_category` WRITE;
/*!40000 ALTER TABLE `custom_product_category` DISABLE KEYS */;
INSERT INTO `custom_product_category` VALUES (1,'Bread and Pastries','Bread'),(2,'Cakes','Cake'),(3,'Coffee beverages','Coffee');
/*!40000 ALTER TABLE `custom_product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_product_category_custom_product`
--

DROP TABLE IF EXISTS `custom_product_category_custom_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_product_category_custom_product` (
  `custom_product_category_id` bigint NOT NULL,
  `custom_product_id` bigint NOT NULL,
  UNIQUE KEY `UK_rnm1tu6tra2xr93t3sdh0k2y1` (`custom_product_id`),
  KEY `FKd98p05l7e70vc7ev3fg4epybr` (`custom_product_category_id`),
  CONSTRAINT `FKd98p05l7e70vc7ev3fg4epybr` FOREIGN KEY (`custom_product_category_id`) REFERENCES `custom_product_category` (`id`),
  CONSTRAINT `FKipikvl0me95t0hdutfy77t25l` FOREIGN KEY (`custom_product_id`) REFERENCES `custom_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_product_category_custom_product`
--

LOCK TABLES `custom_product_category_custom_product` WRITE;
/*!40000 ALTER TABLE `custom_product_category_custom_product` DISABLE KEYS */;
INSERT INTO `custom_product_category_custom_product` VALUES (1,8),(1,9),(1,10),(1,11),(1,12);
/*!40000 ALTER TABLE `custom_product_category_custom_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'2022-04-02 16:15:39.370000','bobby.hill@test.com','Bobby Hill','123-456-7891','2022-04-02 16:15:39.370000'),(2,'2022-04-02 16:33:01.845000','giyuu.tomioka@test.com','Giyuu Tomioka','123-456-7891','2022-04-02 16:33:01.845000'),(3,'2022-04-02 16:41:38.048000','tengen.uzui@test.com','Tengen Uzui','123-456-7891','2022-04-02 16:41:38.048000'),(4,'2022-04-02 16:58:53.560000','tanjirou.kamado@test.com','Tanjirou Kamado','123-456-7891','2022-04-02 16:58:53.560000'),(5,'2022-04-02 17:00:23.539000','hank.hill@test.com','Hank Hill','123-456-7891','2022-04-02 17:00:23.539000'),(6,'2022-04-02 17:10:21.780000','hank.hill@test.com','Hank Hill','123-456-7891','2022-04-02 17:10:21.780000'),(7,'2022-04-03 00:22:43.784000','zenitsu.agatsuma@test.com','Zenitsu Agatsuma','123-456-7891','2022-04-03 00:22:43.784000'),(8,'2022-04-10 15:24:37.138000','peggy.hill@test.com','Peggy Hill','123-456-7891','2022-04-10 15:24:37.138000'),(9,'2022-04-10 15:25:40.471000','samus.aran@test.com','Samus Aran','123-456-7891','2022-04-10 15:25:40.471000'),(10,'2022-06-26 15:27:04.686000','raven.beak@test.com','Raven Beak','123-456-7891','2022-06-26 15:27:04.686000');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(19,2) DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK46tfr1wckkn3wcp197jdikr2d` (`product_id`),
  KEY `FKt4dc2r9nbvbujrljv3e23iibt` (`order_id`),
  CONSTRAINT `FK46tfr1wckkn3wcp197jdikr2d` FOREIGN KEY (`product_id`) REFERENCES `custom_product` (`id`),
  CONSTRAINT `FKt4dc2r9nbvbujrljv3e23iibt` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,NULL,1,NULL),(2,1,NULL,1,NULL),(3,1,1.99,2,NULL),(4,1,2.99,2,NULL),(5,1,2.99,3,NULL),(6,1,2.99,3,NULL),(7,1,2.99,4,NULL),(8,1,1.99,4,NULL),(9,1,2.99,4,NULL),(10,1,1.99,5,NULL),(11,1,2.99,5,NULL),(12,1,1.99,6,11),(13,2,2.99,6,10),(14,1,2.99,7,9),(15,1,2.99,7,8),(16,1,2.99,8,10),(17,1,2.99,8,9),(18,1,2.99,9,10),(19,1,2.99,9,9),(20,1,1.99,10,11),(21,2,2.99,10,10);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `total_price` decimal(19,2) DEFAULT NULL,
  `tracking_number` varchar(255) DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK624gtjin3po807j3vix093tlf` (`customer_id`),
  CONSTRAINT `FK624gtjin3po807j3vix093tlf` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2022-04-02 16:15:39.378000',498.00,'e89d5fd9-b536-45a4-9a19-2fabc4508eda','2022-04-02 16:15:39.378000',1),(2,'2022-04-02 16:33:01.852000',498.00,'1a23e4e7-d4c6-49de-8dc0-298a268cbc73','2022-04-02 16:33:01.852000',2),(3,'2022-04-02 16:41:38.051000',598.00,'f7ed0139-d3a6-48ae-a3f1-54cbe6ffae85','2022-04-02 16:41:38.051000',3),(4,'2022-04-02 16:58:53.567000',797.00,'45b4e944-f3f2-48c3-b169-c81bd40a6e97','2022-04-02 16:58:53.567000',4),(5,'2022-04-02 17:00:23.541000',498.00,'fc165637-6e36-4382-8072-c5ba8399bf63','2022-04-02 17:00:23.541000',5),(6,'2022-04-02 17:10:21.782000',797.00,'737c792d-ee95-472b-966b-81053e24b3ab','2022-04-02 17:10:21.782000',6),(7,'2022-04-03 00:22:43.799000',598.00,'0db2856c-e2cc-4339-b709-565f88af76c5','2022-04-03 00:22:43.799000',7),(8,'2022-04-09 23:09:02.697000',598.00,'487c1230-4789-469e-a2da-e4548a1805c9','2022-04-09 23:09:02.697000',2),(9,'2022-04-10 15:24:37.145000',598.00,'1cd5b544-193a-45a6-91de-68b4894fb587','2022-04-10 15:24:37.145000',8),(10,'2022-04-10 15:25:40.473000',797.00,'5875d3bd-9ce3-4e5d-ac3e-e8dd68e87e04','2022-04-10 15:25:40.473000',9),(11,'2022-06-26 15:27:04.701000',1234.00,'4d962a7a-0c33-4089-9bc6-9f14a59d936a','2022-06-26 15:27:04.701000',10),(12,'2022-06-26 15:28:47.354000',1234.00,'6483d9c5-36e0-4956-b53d-586e78a9351e','2022-06-26 15:28:47.354000',10),(13,'2022-06-26 15:34:58.743000',1234.00,'b1b18aac-c7e5-43e2-b73b-b266d31a8cdf','2022-06-26 15:34:58.743000',10),(14,'2022-06-26 15:54:08.581000',1234.00,'7358d769-25dc-4778-9766-00c07be9a12f','2022-06-26 15:54:08.581000',10),(15,'2022-06-26 16:36:39.665000',1234.00,'8de4857b-b140-441b-8654-96fd649f2f1c','2022-06-26 16:36:39.665000',10),(16,'2022-06-26 16:38:07.116000',1234.00,'2525312f-7ba4-4b9d-8188-30fcad8c0c02','2022-06-26 16:38:07.116000',10),(17,'2022-06-26 16:38:28.840000',1234.00,'25d86ae0-ea3d-4b56-8588-8ae40aebdb94','2022-06-26 16:38:28.840000',10),(18,'2022-06-26 16:39:25.827000',1234.00,'75ce5076-a1f1-4f69-aa8c-bb4e6fa90f2a','2022-06-26 16:39:25.827000',10);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-28 17:21:50
