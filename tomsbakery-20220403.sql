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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKknbo7awec05w5icrdimwt00f9` (`user_id`),
  CONSTRAINT `FKknbo7awec05w5icrdimwt00f9` FOREIGN KEY (`user_id`) REFERENCES `custom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_products`
--

DROP TABLE IF EXISTS `cart_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_products` (
  `cart_id` bigint NOT NULL,
  `products_id` bigint NOT NULL,
  UNIQUE KEY `UK_3kg5kx19f8oy0lo76hdhc1uw1` (`products_id`),
  KEY `FKnlhjc091rdu9k5c8u9xwp280w` (`cart_id`),
  CONSTRAINT `FKhyifooelo1uarpoiahick7hon` FOREIGN KEY (`products_id`) REFERENCES `custom_product` (`id`),
  CONSTRAINT `FKnlhjc091rdu9k5c8u9xwp280w` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_products`
--

LOCK TABLES `cart_products` WRITE;
/*!40000 ALTER TABLE `cart_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_products` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Table structure for table `custom_product_carts`
--

DROP TABLE IF EXISTS `custom_product_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_product_carts` (
  `custom_product_id` bigint NOT NULL,
  `carts_id` bigint NOT NULL,
  KEY `FKp7c3thqjuqk4cv6ar45c0v9mr` (`carts_id`),
  KEY `FKmngd0ux4oeyi1fl6fi9aq7wfm` (`custom_product_id`),
  CONSTRAINT `FKmngd0ux4oeyi1fl6fi9aq7wfm` FOREIGN KEY (`custom_product_id`) REFERENCES `custom_product` (`id`),
  CONSTRAINT `FKp7c3thqjuqk4cv6ar45c0v9mr` FOREIGN KEY (`carts_id`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_product_carts`
--

LOCK TABLES `custom_product_carts` WRITE;
/*!40000 ALTER TABLE `custom_product_carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_product_carts` ENABLE KEYS */;
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
-- Table structure for table `custom_user`
--

DROP TABLE IF EXISTS `custom_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_user`
--

LOCK TABLES `custom_user` WRITE;
/*!40000 ALTER TABLE `custom_user` DISABLE KEYS */;
INSERT INTO `custom_user` VALUES (1,'2022-01-08 16:40:37.459000','john.doe@test.com','John Doe','$2a$10$dRkPEMhVgTw3XceC0jtRzucPzOXiPoaJic74k9pk23G3ViZWC2SiC','2022-01-08 16:40:37.459000');
/*!40000 ALTER TABLE `custom_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_user_carts`
--

DROP TABLE IF EXISTS `custom_user_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_user_carts` (
  `user_id` bigint NOT NULL,
  `carts_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`carts_id`),
  UNIQUE KEY `UK_5viqixptkpue6ns8yfxloy4rq` (`carts_id`),
  CONSTRAINT `FK4jd5sads6qahvri5doc8rivrk` FOREIGN KEY (`carts_id`) REFERENCES `cart` (`id`),
  CONSTRAINT `FKj15frx9qwcf9jetydw5evkrej` FOREIGN KEY (`user_id`) REFERENCES `custom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_user_carts`
--

LOCK TABLES `custom_user_carts` WRITE;
/*!40000 ALTER TABLE `custom_user_carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_user_carts` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'2022-04-02 16:15:39.370000','bobby.hill@test.com','Bobby Hill','123-456-7891','2022-04-02 16:15:39.370000'),(2,'2022-04-02 16:33:01.845000','giyuu.tomioka@test.com','Giyuu Tomioka','123-456-7891','2022-04-02 16:33:01.845000'),(3,'2022-04-02 16:41:38.048000','tengen.uzui@test.com','Tengen Uzui','123-456-7891','2022-04-02 16:41:38.048000'),(4,'2022-04-02 16:58:53.560000','tanjirou.kamado@test.com','Tanjirou Kamado','123-456-7891','2022-04-02 16:58:53.560000'),(5,'2022-04-02 17:00:23.539000','hank.hill@test.com','Hank Hill','123-456-7891','2022-04-02 17:00:23.539000'),(6,'2022-04-02 17:10:21.780000','hank.hill@test.com','Hank Hill','123-456-7891','2022-04-02 17:10:21.780000'),(7,'2022-04-03 00:22:43.784000','zenitsu.agatsuma@test.com','Zenitsu Agatsuma','123-456-7891','2022-04-03 00:22:43.784000');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,NULL,1,NULL),(2,1,NULL,1,NULL),(3,1,1.99,2,NULL),(4,1,2.99,2,NULL),(5,1,2.99,3,NULL),(6,1,2.99,3,NULL),(7,1,2.99,4,NULL),(8,1,1.99,4,NULL),(9,1,2.99,4,NULL),(10,1,1.99,5,NULL),(11,1,2.99,5,NULL),(12,1,1.99,6,11),(13,2,2.99,6,10),(14,1,2.99,7,9),(15,1,2.99,7,8);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2022-04-02 16:15:39.378000',498.00,'e89d5fd9-b536-45a4-9a19-2fabc4508eda','2022-04-02 16:15:39.378000',1),(2,'2022-04-02 16:33:01.852000',498.00,'1a23e4e7-d4c6-49de-8dc0-298a268cbc73','2022-04-02 16:33:01.852000',2),(3,'2022-04-02 16:41:38.051000',598.00,'f7ed0139-d3a6-48ae-a3f1-54cbe6ffae85','2022-04-02 16:41:38.051000',3),(4,'2022-04-02 16:58:53.567000',797.00,'45b4e944-f3f2-48c3-b169-c81bd40a6e97','2022-04-02 16:58:53.567000',4),(5,'2022-04-02 17:00:23.541000',498.00,'fc165637-6e36-4382-8072-c5ba8399bf63','2022-04-02 17:00:23.541000',5),(6,'2022-04-02 17:10:21.782000',797.00,'737c792d-ee95-472b-966b-81053e24b3ab','2022-04-02 17:10:21.782000',6),(7,'2022-04-03 00:22:43.799000',598.00,'0db2856c-e2cc-4339-b709-565f88af76c5','2022-04-03 00:22:43.799000',7);
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

-- Dump completed on 2022-04-03  0:26:22
