-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: giggearme2
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address_country`
--

DROP TABLE IF EXISTS `address_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_country` (
  `iso_3166_1_a2` varchar(2) NOT NULL,
  `iso_3166_1_a3` varchar(3) NOT NULL,
  `iso_3166_1_numeric` varchar(3) NOT NULL,
  `printable_name` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `display_order` smallint(5) unsigned NOT NULL,
  `is_shipping_country` tinyint(1) NOT NULL,
  PRIMARY KEY (`iso_3166_1_a2`),
  KEY `address_country_010c8bce` (`display_order`),
  KEY `address_country_0b3676f8` (`is_shipping_country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_country`
--

LOCK TABLES `address_country` WRITE;
/*!40000 ALTER TABLE `address_country` DISABLE KEYS */;
INSERT INTO `address_country` VALUES ('UM','UMI','581','The United States Minor Outlying Islands','UNITED STATES MINOR OUTLYING ISLANDS',0,0),('US','USA','840','The United States of America','UNITED STATES',0,1);
/*!40000 ALTER TABLE `address_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_useraddress`
--

DROP TABLE IF EXISTS `address_useraddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_useraddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `line1` varchar(255) NOT NULL,
  `line2` varchar(255) NOT NULL,
  `line3` varchar(255) NOT NULL,
  `line4` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postcode` varchar(64) NOT NULL,
  `search_text` longtext NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `notes` longtext NOT NULL,
  `is_default_for_shipping` tinyint(1) NOT NULL,
  `is_default_for_billing` tinyint(1) NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `hash` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `country_id` varchar(2) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_useraddress_user_id_733690a214958def_uniq` (`user_id`,`hash`),
  KEY `address_useraddress_0800fc57` (`hash`),
  KEY `address_useraddress_93bfec8a` (`country_id`),
  KEY `address_useraddress_e8701ad4` (`user_id`),
  CONSTRAINT `address_useraddress_user_id_243fe927c5df790e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `add_country_id_2b88c9a59bb9e5a6_fk_address_country_iso_3166_1_a2` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_useraddress`
--

LOCK TABLES `address_useraddress` WRITE;
/*!40000 ALTER TABLE `address_useraddress` DISABLE KEYS */;
INSERT INTO `address_useraddress` VALUES (1,'','Test','Buyer','1 Main St','','','San Jose','CA','95131','Test Buyer 1 Main St San Jose CA 95131 UNITED STATES','','',0,0,1,'1385409740','2014-11-12 23:06:22','US',1);
/*!40000 ALTER TABLE `address_useraddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_productrecord`
--

DROP TABLE IF EXISTS `analytics_productrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_productrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_views` int(10) unsigned NOT NULL,
  `num_basket_additions` int(10) unsigned NOT NULL,
  `num_purchases` int(10) unsigned NOT NULL,
  `score` double NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  KEY `analytics_productrecord_81a5c7b1` (`num_purchases`),
  CONSTRAINT `analytics_pr_product_id_6a783f9d2ad3b0b8_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_productrecord`
--

LOCK TABLES `analytics_productrecord` WRITE;
/*!40000 ALTER TABLE `analytics_productrecord` DISABLE KEYS */;
INSERT INTO `analytics_productrecord` VALUES (1,2,0,0,0,1),(2,5,0,0,0,238),(3,3,0,0,0,133),(4,0,2,0,0,240),(5,2,0,0,0,217),(6,0,1,0,0,218),(7,1,0,0,0,235),(8,1,0,0,0,210),(9,0,1,1,0,212);
/*!40000 ALTER TABLE `analytics_productrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_userproductview`
--

DROP TABLE IF EXISTS `analytics_userproductview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_userproductview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `analytics_userproductview_9bea82de` (`product_id`),
  KEY `analytics_userproductview_e8701ad4` (`user_id`),
  CONSTRAINT `analytics_userproductvi_user_id_4087a6b710f8c4b6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `analytics_us_product_id_4069af89b2f55c13_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_userproductview`
--

LOCK TABLES `analytics_userproductview` WRITE;
/*!40000 ALTER TABLE `analytics_userproductview` DISABLE KEYS */;
INSERT INTO `analytics_userproductview` VALUES (1,'2014-11-11 23:05:10',1,1),(2,'2014-11-12 05:24:16',1,1),(3,'2014-11-12 05:26:32',238,1),(4,'2014-11-12 05:41:28',133,1),(5,'2014-11-12 05:56:40',133,1),(6,'2014-11-12 05:59:31',238,1),(7,'2014-11-12 06:00:53',238,1),(8,'2014-11-12 08:24:48',133,1),(9,'2014-11-12 18:32:25',217,1),(10,'2014-11-12 19:37:26',217,1),(11,'2014-11-12 21:22:27',238,1),(12,'2014-11-12 21:45:59',238,1),(13,'2014-11-12 23:02:22',235,1),(14,'2014-11-12 23:02:28',210,1);
/*!40000 ALTER TABLE `analytics_userproductview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_userrecord`
--

DROP TABLE IF EXISTS `analytics_userrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_userrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_product_views` int(10) unsigned NOT NULL,
  `num_basket_additions` int(10) unsigned NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `num_order_lines` int(10) unsigned NOT NULL,
  `num_order_items` int(10) unsigned NOT NULL,
  `total_spent` decimal(12,2) NOT NULL,
  `date_last_order` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `analytics_userrecord_29bdb5ea` (`num_orders`),
  KEY `analytics_userrecord_89bb6879` (`num_order_lines`),
  KEY `analytics_userrecord_25cd4b4a` (`num_order_items`),
  CONSTRAINT `analytics_userrecord_user_id_cae614d9855117a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_userrecord`
--

LOCK TABLES `analytics_userrecord` WRITE;
/*!40000 ALTER TABLE `analytics_userrecord` DISABLE KEYS */;
INSERT INTO `analytics_userrecord` VALUES (1,14,4,1,1,1,22.04,'2014-11-12 23:06:22',1);
/*!40000 ALTER TABLE `analytics_userrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_usersearch`
--

DROP TABLE IF EXISTS `analytics_usersearch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_usersearch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `query` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `analytics_usersearch_1b1cc7f0` (`query`),
  KEY `analytics_usersearch_e8701ad4` (`user_id`),
  CONSTRAINT `analytics_usersearch_user_id_7e760309211b811b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_usersearch`
--

LOCK TABLES `analytics_usersearch` WRITE;
/*!40000 ALTER TABLE `analytics_usersearch` DISABLE KEYS */;
/*!40000 ALTER TABLE `analytics_usersearch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_group_permission_group_id_689710a9a73b7457_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`),
  CONSTRAINT `auth__content_type_id_508cf46651277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=293 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add flat page',8,'add_flatpage'),(23,'Can change flat page',8,'change_flatpage'),(24,'Can delete flat page',8,'delete_flatpage'),(25,'Can add Product record',9,'add_productrecord'),(26,'Can change Product record',9,'change_productrecord'),(27,'Can delete Product record',9,'delete_productrecord'),(28,'Can add User record',10,'add_userrecord'),(29,'Can change User record',10,'change_userrecord'),(30,'Can delete User record',10,'delete_userrecord'),(31,'Can add User product view',11,'add_userproductview'),(32,'Can change User product view',11,'change_userproductview'),(33,'Can delete User product view',11,'delete_userproductview'),(34,'Can add User search query',12,'add_usersearch'),(35,'Can change User search query',12,'change_usersearch'),(36,'Can delete User search query',12,'delete_usersearch'),(37,'Can add User address',13,'add_useraddress'),(38,'Can change User address',13,'change_useraddress'),(39,'Can delete User address',13,'delete_useraddress'),(40,'Can add Country',14,'add_country'),(41,'Can change Country',14,'change_country'),(42,'Can delete Country',14,'delete_country'),(43,'Can add Order and Item Charge',15,'add_orderanditemcharges'),(44,'Can change Order and Item Charge',15,'change_orderanditemcharges'),(45,'Can delete Order and Item Charge',15,'delete_orderanditemcharges'),(46,'Can add Weight-based Shipping Method',16,'add_weightbased'),(47,'Can change Weight-based Shipping Method',16,'change_weightbased'),(48,'Can delete Weight-based Shipping Method',16,'delete_weightbased'),(49,'Can add Weight Band',17,'add_weightband'),(50,'Can change Weight Band',17,'change_weightband'),(51,'Can delete Weight Band',17,'delete_weightband'),(52,'Can add Product class',18,'add_productclass'),(53,'Can change Product class',18,'change_productclass'),(54,'Can delete Product class',18,'delete_productclass'),(55,'Can add Category',19,'add_category'),(56,'Can change Category',19,'change_category'),(57,'Can delete Category',19,'delete_category'),(58,'Can add Product category',20,'add_productcategory'),(59,'Can change Product category',20,'change_productcategory'),(60,'Can delete Product category',20,'delete_productcategory'),(61,'Can add Product',21,'add_product'),(62,'Can change Product',21,'change_product'),(63,'Can delete Product',21,'delete_product'),(64,'Can add Product recommendation',22,'add_productrecommendation'),(65,'Can change Product recommendation',22,'change_productrecommendation'),(66,'Can delete Product recommendation',22,'delete_productrecommendation'),(67,'Can add Product attribute',23,'add_productattribute'),(68,'Can change Product attribute',23,'change_productattribute'),(69,'Can delete Product attribute',23,'delete_productattribute'),(70,'Can add Product attribute value',24,'add_productattributevalue'),(71,'Can change Product attribute value',24,'change_productattributevalue'),(72,'Can delete Product attribute value',24,'delete_productattributevalue'),(73,'Can add Attribute option group',25,'add_attributeoptiongroup'),(74,'Can change Attribute option group',25,'change_attributeoptiongroup'),(75,'Can delete Attribute option group',25,'delete_attributeoptiongroup'),(76,'Can add Attribute option',26,'add_attributeoption'),(77,'Can change Attribute option',26,'change_attributeoption'),(78,'Can delete Attribute option',26,'delete_attributeoption'),(79,'Can add Option',27,'add_option'),(80,'Can change Option',27,'change_option'),(81,'Can delete Option',27,'delete_option'),(82,'Can add Product image',28,'add_productimage'),(83,'Can change Product image',28,'change_productimage'),(84,'Can delete Product image',28,'delete_productimage'),(85,'Can add Product review',29,'add_productreview'),(86,'Can change Product review',29,'change_productreview'),(87,'Can delete Product review',29,'delete_productreview'),(88,'Can add Vote',30,'add_vote'),(89,'Can change Vote',30,'change_vote'),(90,'Can delete Vote',30,'delete_vote'),(91,'Can add Fulfillment partner',31,'add_partner'),(92,'Can change Fulfillment partner',31,'change_partner'),(93,'Can delete Fulfillment partner',31,'delete_partner'),(94,'Can access dashboard',31,'dashboard_access'),(95,'Can add Partner address',32,'add_partneraddress'),(96,'Can change Partner address',32,'change_partneraddress'),(97,'Can delete Partner address',32,'delete_partneraddress'),(98,'Can add Stock record',33,'add_stockrecord'),(99,'Can change Stock record',33,'change_stockrecord'),(100,'Can delete Stock record',33,'delete_stockrecord'),(101,'Can add Stock alert',34,'add_stockalert'),(102,'Can change Stock alert',34,'change_stockalert'),(103,'Can delete Stock alert',34,'delete_stockalert'),(104,'Can add Basket',35,'add_basket'),(105,'Can change Basket',35,'change_basket'),(106,'Can delete Basket',35,'delete_basket'),(107,'Can add Basket line',36,'add_line'),(108,'Can change Basket line',36,'change_line'),(109,'Can delete Basket line',36,'delete_line'),(110,'Can add Line attribute',37,'add_lineattribute'),(111,'Can change Line attribute',37,'change_lineattribute'),(112,'Can delete Line attribute',37,'delete_lineattribute'),(113,'Can add Transaction',38,'add_transaction'),(114,'Can change Transaction',38,'change_transaction'),(115,'Can delete Transaction',38,'delete_transaction'),(116,'Can add Source',39,'add_source'),(117,'Can change Source',39,'change_source'),(118,'Can delete Source',39,'delete_source'),(119,'Can add Source Type',40,'add_sourcetype'),(120,'Can change Source Type',40,'change_sourcetype'),(121,'Can delete Source Type',40,'delete_sourcetype'),(122,'Can add Bankcard',41,'add_bankcard'),(123,'Can change Bankcard',41,'change_bankcard'),(124,'Can delete Bankcard',41,'delete_bankcard'),(125,'Can add Conditional offer',42,'add_conditionaloffer'),(126,'Can change Conditional offer',42,'change_conditionaloffer'),(127,'Can delete Conditional offer',42,'delete_conditionaloffer'),(128,'Can add Condition',43,'add_condition'),(129,'Can change Condition',43,'change_condition'),(130,'Can delete Condition',43,'delete_condition'),(131,'Can add Benefit',44,'add_benefit'),(132,'Can change Benefit',44,'change_benefit'),(133,'Can delete Benefit',44,'delete_benefit'),(134,'Can add Range',45,'add_range'),(135,'Can change Range',45,'change_range'),(136,'Can delete Range',45,'delete_range'),(137,'Can add range product',46,'add_rangeproduct'),(138,'Can change range product',46,'change_rangeproduct'),(139,'Can delete range product',46,'delete_rangeproduct'),(140,'Can add Count condition',43,'add_countcondition'),(141,'Can change Count condition',43,'change_countcondition'),(142,'Can delete Count condition',43,'delete_countcondition'),(143,'Can add Coverage Condition',43,'add_coveragecondition'),(144,'Can change Coverage Condition',43,'change_coveragecondition'),(145,'Can delete Coverage Condition',43,'delete_coveragecondition'),(146,'Can add Value condition',43,'add_valuecondition'),(147,'Can change Value condition',43,'change_valuecondition'),(148,'Can delete Value condition',43,'delete_valuecondition'),(149,'Can add Percentage discount benefit',44,'add_percentagediscountbenefit'),(150,'Can change Percentage discount benefit',44,'change_percentagediscountbenefit'),(151,'Can delete Percentage discount benefit',44,'delete_percentagediscountbenefit'),(152,'Can add Absolute discount benefit',44,'add_absolutediscountbenefit'),(153,'Can change Absolute discount benefit',44,'change_absolutediscountbenefit'),(154,'Can delete Absolute discount benefit',44,'delete_absolutediscountbenefit'),(155,'Can add Fixed price benefit',44,'add_fixedpricebenefit'),(156,'Can change Fixed price benefit',44,'change_fixedpricebenefit'),(157,'Can delete Fixed price benefit',44,'delete_fixedpricebenefit'),(158,'Can add Multibuy discount benefit',44,'add_multibuydiscountbenefit'),(159,'Can change Multibuy discount benefit',44,'change_multibuydiscountbenefit'),(160,'Can delete Multibuy discount benefit',44,'delete_multibuydiscountbenefit'),(161,'Can add shipping benefit',44,'add_shippingbenefit'),(162,'Can change shipping benefit',44,'change_shippingbenefit'),(163,'Can delete shipping benefit',44,'delete_shippingbenefit'),(164,'Can add Shipping absolute discount benefit',44,'add_shippingabsolutediscountbenefit'),(165,'Can change Shipping absolute discount benefit',44,'change_shippingabsolutediscountbenefit'),(166,'Can delete Shipping absolute discount benefit',44,'delete_shippingabsolutediscountbenefit'),(167,'Can add Fixed price shipping benefit',44,'add_shippingfixedpricebenefit'),(168,'Can change Fixed price shipping benefit',44,'change_shippingfixedpricebenefit'),(169,'Can delete Fixed price shipping benefit',44,'delete_shippingfixedpricebenefit'),(170,'Can add Shipping percentage discount benefit',44,'add_shippingpercentagediscountbenefit'),(171,'Can change Shipping percentage discount benefit',44,'change_shippingpercentagediscountbenefit'),(172,'Can delete Shipping percentage discount benefit',44,'delete_shippingpercentagediscountbenefit'),(173,'Can add Range Product Uploaded File',47,'add_rangeproductfileupload'),(174,'Can change Range Product Uploaded File',47,'change_rangeproductfileupload'),(175,'Can delete Range Product Uploaded File',47,'delete_rangeproductfileupload'),(176,'Can add Payment Event Quantity',59,'add_paymenteventquantity'),(177,'Can change Payment Event Quantity',59,'change_paymenteventquantity'),(178,'Can delete Payment Event Quantity',59,'delete_paymenteventquantity'),(179,'Can add Shipping Event Quantity',60,'add_shippingeventquantity'),(180,'Can change Shipping Event Quantity',60,'change_shippingeventquantity'),(181,'Can delete Shipping Event Quantity',60,'delete_shippingeventquantity'),(182,'Can add Order',61,'add_order'),(183,'Can change Order',61,'change_order'),(184,'Can delete Order',61,'delete_order'),(185,'Can add Order Note',62,'add_ordernote'),(186,'Can change Order Note',62,'change_ordernote'),(187,'Can delete Order Note',62,'delete_ordernote'),(188,'Can add Communication Event',63,'add_communicationevent'),(189,'Can change Communication Event',63,'change_communicationevent'),(190,'Can delete Communication Event',63,'delete_communicationevent'),(191,'Can add Shipping address',64,'add_shippingaddress'),(192,'Can change Shipping address',64,'change_shippingaddress'),(193,'Can delete Shipping address',64,'delete_shippingaddress'),(194,'Can add Billing address',65,'add_billingaddress'),(195,'Can change Billing address',65,'change_billingaddress'),(196,'Can delete Billing address',65,'delete_billingaddress'),(197,'Can add Order Line',66,'add_line'),(198,'Can change Order Line',66,'change_line'),(199,'Can delete Order Line',66,'delete_line'),(200,'Can add Line Price',67,'add_lineprice'),(201,'Can change Line Price',67,'change_lineprice'),(202,'Can delete Line Price',67,'delete_lineprice'),(203,'Can add Line Attribute',68,'add_lineattribute'),(204,'Can change Line Attribute',68,'change_lineattribute'),(205,'Can delete Line Attribute',68,'delete_lineattribute'),(206,'Can add Shipping Event',69,'add_shippingevent'),(207,'Can change Shipping Event',69,'change_shippingevent'),(208,'Can delete Shipping Event',69,'delete_shippingevent'),(209,'Can add Shipping Event Type',70,'add_shippingeventtype'),(210,'Can change Shipping Event Type',70,'change_shippingeventtype'),(211,'Can delete Shipping Event Type',70,'delete_shippingeventtype'),(212,'Can add Payment Event',71,'add_paymentevent'),(213,'Can change Payment Event',71,'change_paymentevent'),(214,'Can delete Payment Event',71,'delete_paymentevent'),(215,'Can add Payment Event Type',72,'add_paymenteventtype'),(216,'Can change Payment Event Type',72,'change_paymenteventtype'),(217,'Can delete Payment Event Type',72,'delete_paymenteventtype'),(218,'Can add Order Discount',73,'add_orderdiscount'),(219,'Can change Order Discount',73,'change_orderdiscount'),(220,'Can delete Order Discount',73,'delete_orderdiscount'),(221,'Can add Email',74,'add_email'),(222,'Can change Email',74,'change_email'),(223,'Can delete Email',74,'delete_email'),(224,'Can add Communication event type',75,'add_communicationeventtype'),(225,'Can change Communication event type',75,'change_communicationeventtype'),(226,'Can delete Communication event type',75,'delete_communicationeventtype'),(227,'Can add Notification',76,'add_notification'),(228,'Can change Notification',76,'change_notification'),(229,'Can delete Notification',76,'delete_notification'),(230,'Can add Product alert',77,'add_productalert'),(231,'Can change Product alert',77,'change_productalert'),(232,'Can delete Product alert',77,'delete_productalert'),(233,'Can add Page Promotion',78,'add_pagepromotion'),(234,'Can change Page Promotion',78,'change_pagepromotion'),(235,'Can delete Page Promotion',78,'delete_pagepromotion'),(236,'Can add Keyword Promotion',79,'add_keywordpromotion'),(237,'Can change Keyword Promotion',79,'change_keywordpromotion'),(238,'Can delete Keyword Promotion',79,'delete_keywordpromotion'),(239,'Can add Raw HTML',80,'add_rawhtml'),(240,'Can change Raw HTML',80,'change_rawhtml'),(241,'Can delete Raw HTML',80,'delete_rawhtml'),(242,'Can add Image',81,'add_image'),(243,'Can change Image',81,'change_image'),(244,'Can delete Image',81,'delete_image'),(245,'Can add Multi Image',82,'add_multiimage'),(246,'Can change Multi Image',82,'change_multiimage'),(247,'Can delete Multi Image',82,'delete_multiimage'),(248,'Can add Single product',83,'add_singleproduct'),(249,'Can change Single product',83,'change_singleproduct'),(250,'Can delete Single product',83,'delete_singleproduct'),(251,'Can add Hand Picked Product List',84,'add_handpickedproductlist'),(252,'Can change Hand Picked Product List',84,'change_handpickedproductlist'),(253,'Can delete Hand Picked Product List',84,'delete_handpickedproductlist'),(254,'Can add Ordered product',85,'add_orderedproduct'),(255,'Can change Ordered product',85,'change_orderedproduct'),(256,'Can delete Ordered product',85,'delete_orderedproduct'),(257,'Can add Automatic product list',86,'add_automaticproductlist'),(258,'Can change Automatic product list',86,'change_automaticproductlist'),(259,'Can delete Automatic product list',86,'delete_automaticproductlist'),(260,'Can add Ordered Product List',87,'add_orderedproductlist'),(261,'Can change Ordered Product List',87,'change_orderedproductlist'),(262,'Can delete Ordered Product List',87,'delete_orderedproductlist'),(263,'Can add Tabbed Block',88,'add_tabbedblock'),(264,'Can change Tabbed Block',88,'change_tabbedblock'),(265,'Can delete Tabbed Block',88,'delete_tabbedblock'),(266,'Can add Voucher',89,'add_voucher'),(267,'Can change Voucher',89,'change_voucher'),(268,'Can delete Voucher',89,'delete_voucher'),(269,'Can add Voucher Application',90,'add_voucherapplication'),(270,'Can change Voucher Application',90,'change_voucherapplication'),(271,'Can delete Voucher Application',90,'delete_voucherapplication'),(272,'Can add Wish List',91,'add_wishlist'),(273,'Can change Wish List',91,'change_wishlist'),(274,'Can delete Wish List',91,'delete_wishlist'),(275,'Can add Wish list line',92,'add_line'),(276,'Can change Wish list line',92,'change_line'),(277,'Can delete Wish list line',92,'delete_line'),(278,'Can add kv store',93,'add_kvstore'),(279,'Can change kv store',93,'change_kvstore'),(280,'Can delete kv store',93,'delete_kvstore'),(281,'Can add product brand',94,'add_productbrand'),(282,'Can change product brand',94,'change_productbrand'),(283,'Can delete product brand',94,'delete_productbrand'),(284,'Can add product activity',95,'add_productactivity'),(285,'Can change product activity',95,'change_productactivity'),(286,'Can delete product activity',95,'delete_productactivity'),(287,'Can add express transaction',96,'add_expresstransaction'),(288,'Can change express transaction',96,'change_expresstransaction'),(289,'Can delete express transaction',96,'delete_expresstransaction'),(290,'Can add payflow transaction',97,'add_payflowtransaction'),(291,'Can change payflow transaction',97,'change_payflowtransaction'),(292,'Can delete payflow transaction',97,'delete_payflowtransaction');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$0a5CKYwO8jdM$TRFypkoqfq63h+4hguGKrHi1SdonYM1jjFHC7ArO8Ko=','2014-11-11 21:36:29',1,'josh@halfnibble.com','','','josh@halfnibble.com',1,1,'2014-11-11 21:36:17');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_user_user_permissi_user_id_7f0938558328534a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_u_permission_id_384b62483d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basket_basket`
--

DROP TABLE IF EXISTS `basket_basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basket_basket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_merged` datetime DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `owner_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basket_basket_5e7b1936` (`owner_id`),
  CONSTRAINT `basket_basket_owner_id_74ddb970811da304_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_basket`
--

LOCK TABLES `basket_basket` WRITE;
/*!40000 ALTER TABLE `basket_basket` DISABLE KEYS */;
INSERT INTO `basket_basket` VALUES (1,'Frozen','2014-11-11 22:59:30',NULL,NULL,1),(2,'Frozen','2014-11-12 19:59:34',NULL,NULL,1),(3,'Submitted','2014-11-12 21:44:17',NULL,'2014-11-12 23:06:22',1),(4,'Open','2014-11-12 23:06:33',NULL,NULL,1);
/*!40000 ALTER TABLE `basket_basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basket_basket_vouchers`
--

DROP TABLE IF EXISTS `basket_basket_vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basket_basket_vouchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basket_id` int(11) NOT NULL,
  `voucher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `basket_id` (`basket_id`,`voucher_id`),
  KEY `basket_basket_vouchers_afdeaea9` (`basket_id`),
  KEY `basket_basket_vouchers_3e8639ee` (`voucher_id`),
  CONSTRAINT `basket_basket_vou_basket_id_46809860fe0f2349_fk_basket_basket_id` FOREIGN KEY (`basket_id`) REFERENCES `basket_basket` (`id`),
  CONSTRAINT `basket_basket__voucher_id_19c9200c130f453a_fk_voucher_voucher_id` FOREIGN KEY (`voucher_id`) REFERENCES `voucher_voucher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_basket_vouchers`
--

LOCK TABLES `basket_basket_vouchers` WRITE;
/*!40000 ALTER TABLE `basket_basket_vouchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `basket_basket_vouchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basket_line`
--

DROP TABLE IF EXISTS `basket_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basket_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_reference` varchar(128) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `price_currency` varchar(12) NOT NULL,
  `price_excl_tax` decimal(12,2) DEFAULT NULL,
  `price_incl_tax` decimal(12,2) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `basket_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `stockrecord_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `basket_line_basket_id_7d0d707a7fd92c45_uniq` (`basket_id`,`line_reference`),
  KEY `basket_line_767217f5` (`line_reference`),
  KEY `basket_line_afdeaea9` (`basket_id`),
  KEY `basket_line_9bea82de` (`product_id`),
  KEY `basket_line_271c5733` (`stockrecord_id`),
  CONSTRAINT `basket_line_basket_id_33f070119c0cd86_fk_basket_basket_id` FOREIGN KEY (`basket_id`) REFERENCES `basket_basket` (`id`),
  CONSTRAINT `basket_line_product_id_283cae99af410be8_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `basket_stockrecord_id_7335383654703c38_fk_partner_stockrecord_id` FOREIGN KEY (`stockrecord_id`) REFERENCES `partner_stockrecord` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_line`
--

LOCK TABLES `basket_line` WRITE;
/*!40000 ALTER TABLE `basket_line` DISABLE KEYS */;
INSERT INTO `basket_line` VALUES (1,'240_184',1,'USD',19.44,19.44,'2014-11-12 06:01:04',1,240,184),(2,'218_166',1,'USD',31.14,31.14,'2014-11-12 19:37:30',1,218,166),(3,'240_184',1,'USD',19.44,19.44,'2014-11-12 21:22:31',2,240,184),(4,'212_163',1,'USD',22.04,22.04,'2014-11-12 23:02:32',3,212,163);
/*!40000 ALTER TABLE `basket_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basket_lineattribute`
--

DROP TABLE IF EXISTS `basket_lineattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basket_lineattribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) NOT NULL,
  `line_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basket_lineattribute_b3ae486a` (`line_id`),
  KEY `basket_lineattribute_28df3725` (`option_id`),
  CONSTRAINT `basket_lineattribute_line_id_7342a1870e7f4e05_fk_basket_line_id` FOREIGN KEY (`line_id`) REFERENCES `basket_line` (`id`),
  CONSTRAINT `basket_lineatt_option_id_61a93d0109cbadce_fk_catalogue_option_id` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_lineattribute`
--

LOCK TABLES `basket_lineattribute` WRITE;
/*!40000 ALTER TABLE `basket_lineattribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `basket_lineattribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_attributeoption`
--

DROP TABLE IF EXISTS `catalogue_attributeoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_attributeoption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_attributeoption_0e939a4f` (`group_id`),
  CONSTRAINT `c_group_id_15d15061b9ea4562_fk_catalogue_attributeoptiongroup_id` FOREIGN KEY (`group_id`) REFERENCES `catalogue_attributeoptiongroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_attributeoption`
--

LOCK TABLES `catalogue_attributeoption` WRITE;
/*!40000 ALTER TABLE `catalogue_attributeoption` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_attributeoption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_attributeoptiongroup`
--

DROP TABLE IF EXISTS `catalogue_attributeoptiongroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_attributeoptiongroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_attributeoptiongroup`
--

LOCK TABLES `catalogue_attributeoptiongroup` WRITE;
/*!40000 ALTER TABLE `catalogue_attributeoptiongroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_attributeoptiongroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_category`
--

DROP TABLE IF EXISTS `catalogue_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `depth` int(10) unsigned NOT NULL,
  `numchild` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`),
  KEY `catalogue_category_b068931c` (`name`),
  KEY `catalogue_category_2dbcba41` (`slug`),
  KEY `catalogue_category_73037e23` (`full_name`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_category`
--

LOCK TABLES `catalogue_category` WRITE;
/*!40000 ALTER TABLE `catalogue_category` DISABLE KEYS */;
INSERT INTO `catalogue_category` VALUES (1,'0001',1,3,'Clothing','','','clothing','Clothing'),(2,'00010001',2,8,'Men\'s Clothing','','','clothing/mens-clothing','Clothing > Men\'s Clothing'),(3,'000100010001',3,0,'Accessories','','','clothing/mens-clothing/accessories','Clothing > Men\'s Clothing > Accessories'),(4,'000100010002',3,3,'Shirts','','','clothing/mens-clothing/shirts','Clothing > Men\'s Clothing > Shirts'),(5,'0001000100020001',4,0,'T-Shirt','','','clothing/mens-clothing/shirts/t-shirt','Clothing > Men\'s Clothing > Shirts > T-Shirt'),(6,'0001000100020002',4,0,'Longshirt','','','clothing/mens-clothing/shirts/longshirt','Clothing > Men\'s Clothing > Shirts > Longshirt'),(7,'0001000100020003',4,0,'Tanktop','','','clothing/mens-clothing/shirts/tanktop','Clothing > Men\'s Clothing > Shirts > Tanktop'),(8,'000100010003',3,0,'Shorts','','','clothing/mens-clothing/shorts','Clothing > Men\'s Clothing > Shorts'),(9,'000100010004',3,0,'Pants','','','clothing/mens-clothing/pants','Clothing > Men\'s Clothing > Pants'),(10,'000100010005',3,0,'Jackets & Coats','','','clothing/mens-clothing/jackets-coats','Clothing > Men\'s Clothing > Jackets & Coats'),(11,'000100010006',3,0,'Swimwear','','','clothing/mens-clothing/swimwear','Clothing > Men\'s Clothing > Swimwear'),(12,'000100010007',3,0,'Base Layer','','','clothing/mens-clothing/base-layer','Clothing > Men\'s Clothing > Base Layer'),(13,'000100010008',3,0,'Sweathirts','','','clothing/mens-clothing/sweathirts','Clothing > Men\'s Clothing > Sweathirts'),(14,'00010002',2,9,'Women\'s Clothing','','','clothing/womens-clothing','Clothing > Women\'s Clothing'),(15,'000100020001',3,0,'Accessories','','','clothing/womens-clothing/accessories','Clothing > Women\'s Clothing > Accessories'),(16,'000100020002',3,3,'Shirts & Tops','','','clothing/womens-clothing/shirts-tops','Clothing > Women\'s Clothing > Shirts & Tops'),(17,'0001000200020001',4,0,'T-Shirt','','','clothing/womens-clothing/shirts-tops/t-shirt','Clothing > Women\'s Clothing > Shirts & Tops > T-Shirt'),(18,'0001000200020002',4,0,'Longshirt','','','clothing/womens-clothing/shirts-tops/longshirt','Clothing > Women\'s Clothing > Shirts & Tops > Longshirt'),(19,'0001000200020003',4,0,'Tanktop','','','clothing/womens-clothing/shirts-tops/tanktop','Clothing > Women\'s Clothing > Shirts & Tops > Tanktop'),(20,'000100020003',3,0,'Shorts','','','clothing/womens-clothing/shorts','Clothing > Women\'s Clothing > Shorts'),(21,'000100020004',3,0,'Pants','','','clothing/womens-clothing/pants','Clothing > Women\'s Clothing > Pants'),(22,'000100020005',3,0,'Jackets & Coats','','','clothing/womens-clothing/jackets-coats','Clothing > Women\'s Clothing > Jackets & Coats'),(23,'000100020006',3,0,'Swimsuits','','','clothing/womens-clothing/swimsuits','Clothing > Women\'s Clothing > Swimsuits'),(24,'000100020007',3,0,'Base Layer','','','clothing/womens-clothing/base-layer','Clothing > Women\'s Clothing > Base Layer'),(25,'000100020008',3,0,'Sweathirts','','','clothing/womens-clothing/sweathirts','Clothing > Women\'s Clothing > Sweathirts'),(26,'000100020009',3,0,'Dresses & Skirts','','','clothing/womens-clothing/dresses-skirts','Clothing > Women\'s Clothing > Dresses & Skirts'),(27,'00010003',2,10,'Kid\'s Clothing','','','clothing/kids-clothing','Clothing > Kid\'s Clothing'),(28,'000100030001',3,0,'Accessories','','','clothing/kids-clothing/accessories','Clothing > Kid\'s Clothing > Accessories'),(29,'000100030002',3,3,'Boy\'s Shirts','','','clothing/kids-clothing/boys-shirts','Clothing > Kid\'s Clothing > Boy\'s Shirts'),(30,'0001000300020001',4,0,'T-Shirt','','','clothing/kids-clothing/boys-shirts/t-shirt','Clothing > Kid\'s Clothing > Boy\'s Shirts > T-Shirt'),(31,'0001000300020002',4,0,'Longshirt','','','clothing/kids-clothing/boys-shirts/longshirt','Clothing > Kid\'s Clothing > Boy\'s Shirts > Longshirt'),(32,'0001000300020003',4,0,'Tanktop','','','clothing/kids-clothing/boys-shirts/tanktop','Clothing > Kid\'s Clothing > Boy\'s Shirts > Tanktop'),(33,'000100030003',3,0,'Boy\'s Pants & Shorts','','','clothing/kids-clothing/boys-pants-shorts','Clothing > Kid\'s Clothing > Boy\'s Pants & Shorts'),(34,'000100030004',3,0,'Boy\'s Jackets & Coats','','','clothing/kids-clothing/boys-jackets-coats','Clothing > Kid\'s Clothing > Boy\'s Jackets & Coats'),(35,'000100030005',3,0,'Boy\'s Swimwear','','','clothing/kids-clothing/boys-swimwear','Clothing > Kid\'s Clothing > Boy\'s Swimwear'),(36,'000100030006',3,3,'Girl\'s Shirts','','','clothing/kids-clothing/girls-shirts','Clothing > Kid\'s Clothing > Girl\'s Shirts'),(37,'0001000300060001',4,0,'T-Shirt','','','clothing/kids-clothing/girls-shirts/t-shirt','Clothing > Kid\'s Clothing > Girl\'s Shirts > T-Shirt'),(38,'0001000300060002',4,0,'Longshirt','','','clothing/kids-clothing/girls-shirts/longshirt','Clothing > Kid\'s Clothing > Girl\'s Shirts > Longshirt'),(39,'0001000300060003',4,0,'Tanktop','','','clothing/kids-clothing/girls-shirts/tanktop','Clothing > Kid\'s Clothing > Girl\'s Shirts > Tanktop'),(40,'000100030007',3,0,'Girl\'s Pants & Shorts','','','clothing/kids-clothing/girls-pants-shorts','Clothing > Kid\'s Clothing > Girl\'s Pants & Shorts'),(41,'000100030008',3,0,'Girl\'s Dresses & Skirts','','','clothing/kids-clothing/girls-dresses-skirts','Clothing > Kid\'s Clothing > Girl\'s Dresses & Skirts'),(42,'000100030009',3,0,'Girl\'s Jackets & Coats','','','clothing/kids-clothing/girls-jackets-coats','Clothing > Kid\'s Clothing > Girl\'s Jackets & Coats'),(43,'00010003000A',3,0,'Girl\'s Swimwear','','','clothing/kids-clothing/girls-swimwear','Clothing > Kid\'s Clothing > Girl\'s Swimwear'),(44,'0002',1,3,'Shoes','','','shoes','Shoes'),(45,'00020001',2,4,'Men\'s Footwear','','','shoes/mens-footwear','Shoes > Men\'s Footwear'),(46,'000200010001',3,0,'Sandals','','','shoes/mens-footwear/sandals','Shoes > Men\'s Footwear > Sandals'),(47,'000200010002',3,0,'Shoes','','','shoes/mens-footwear/shoes','Shoes > Men\'s Footwear > Shoes'),(48,'000200010003',3,0,'Boots','','','shoes/mens-footwear/boots','Shoes > Men\'s Footwear > Boots'),(49,'000200010004',3,0,'Socks','','','shoes/mens-footwear/socks','Shoes > Men\'s Footwear > Socks'),(50,'00020002',2,4,'Women\'s Footwear','','','shoes/womens-footwear','Shoes > Women\'s Footwear'),(51,'000200020001',3,0,'Sandals','','','shoes/womens-footwear/sandals','Shoes > Women\'s Footwear > Sandals'),(52,'000200020002',3,0,'Shoes','','','shoes/womens-footwear/shoes','Shoes > Women\'s Footwear > Shoes'),(53,'000200020003',3,0,'Boots','','','shoes/womens-footwear/boots','Shoes > Women\'s Footwear > Boots'),(54,'000200020004',3,0,'Socks','','','shoes/womens-footwear/socks','Shoes > Women\'s Footwear > Socks'),(55,'00020003',2,3,'Kid\'s Footwear','','','shoes/kids-footwear','Shoes > Kid\'s Footwear'),(56,'000200030001',3,0,'Kid\'s Shoes','','','shoes/kids-footwear/kids-shoes','Shoes > Kid\'s Footwear > Kid\'s Shoes'),(57,'000200030002',3,0,'Kid\'s Boots','','','shoes/kids-footwear/kids-boots','Shoes > Kid\'s Footwear > Kid\'s Boots'),(58,'000200030003',3,0,'Kid\'s Socks','','','shoes/kids-footwear/kids-socks','Shoes > Kid\'s Footwear > Kid\'s Socks');
/*!40000 ALTER TABLE `catalogue_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_option`
--

DROP TABLE IF EXISTS `catalogue_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` varchar(128) NOT NULL,
  `type` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_option`
--

LOCK TABLES `catalogue_option` WRITE;
/*!40000 ALTER TABLE `catalogue_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_product`
--

DROP TABLE IF EXISTS `catalogue_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structure` varchar(10) NOT NULL,
  `upc` varchar(64) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `rating` double DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `is_discountable` tinyint(1) NOT NULL,
  `parent_id` int(11),
  `product_class_id` int(11),
  `activity_id` int(11),
  `brand_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `upc` (`upc`),
  KEY `catalogue_product_2dbcba41` (`slug`),
  KEY `catalogue_product_9474e4b5` (`date_updated`),
  KEY `catalogue_product_6be37982` (`parent_id`),
  KEY `catalogue_product_c6619e6f` (`product_class_id`),
  KEY `catalogue_product_f8a3193a` (`activity_id`),
  KEY `catalogue_product_521b20f5` (`brand_id`),
  CONSTRAINT `catalogue_brand_id_4352e4092efa048e_fk_catalogue_productbrand_id` FOREIGN KEY (`brand_id`) REFERENCES `catalogue_productbrand` (`id`),
  CONSTRAINT `catalogue_pro_parent_id_3513f469b6da50ee_fk_catalogue_product_id` FOREIGN KEY (`parent_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `cat_activity_id_41051722e973a6b9_fk_catalogue_productactivity_id` FOREIGN KEY (`activity_id`) REFERENCES `catalogue_productactivity` (`id`),
  CONSTRAINT `c_product_class_id_423660034e393d81_fk_catalogue_productclass_id` FOREIGN KEY (`product_class_id`) REFERENCES `catalogue_productclass` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_product`
--

LOCK TABLES `catalogue_product` WRITE;
/*!40000 ALTER TABLE `catalogue_product` DISABLE KEYS */;
INSERT INTO `catalogue_product` VALUES (1,'parent','98777','Test Title','test-title','<p>Description</p>',NULL,'2014-11-11 23:01:47','2014-11-12 05:20:25',1,NULL,1,2,1),(2,'child','98777-W36-L32','','test-title','',NULL,'2014-11-11 23:04:18','2014-11-11 23:04:18',1,1,NULL,NULL,NULL),(3,'child','98777-W38-L32','','test-title','',NULL,'2014-11-11 23:04:59','2014-11-12 05:21:18',1,1,NULL,NULL,NULL),(4,'parent','20-1008-7','Cycling Boxer sewn upholstery Woman ','cycling-boxer-sewn-upholstery-woman','Cycling Boxer sewn upholstery Woman ',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,NULL,1,1,4),(5,'child','20-1008-7-1-0002','','cycling-boxer-sewn-upholstery-woman','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,4,1,NULL,NULL),(6,'child','20-1008-7-2-0002','','cycling-boxer-sewn-upholstery-woman','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,4,1,NULL,NULL),(7,'child','20-1008-7-3-0002','','cycling-boxer-sewn-upholstery-woman','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,4,1,NULL,NULL),(8,'parent','20-1008-8','Cycling Boxer sewn upholstery Man ','cycling-boxer-sewn-upholstery-man','Cycling Boxer sewn upholstery Man ',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,NULL,1,1,4),(9,'child','20-1008-8-1-0002','','cycling-boxer-sewn-upholstery-man','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,8,1,NULL,NULL),(10,'child','20-1008-8-2-0002','','cycling-boxer-sewn-upholstery-man','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,8,1,NULL,NULL),(11,'child','20-1008-8-3-0002','','cycling-boxer-sewn-upholstery-man','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,8,1,NULL,NULL),(12,'parent','39-6023-0','Mittens (Flap) Gloves ','mittens-flap-gloves','Mittens (Flap) Gloves ',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,NULL,1,NULL,4),(13,'child','39-6023-0-1-0002','','mittens-flap-gloves','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,12,1,NULL,NULL),(14,'child','39-6023-0-2-0002','','mittens-flap-gloves','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,12,1,NULL,NULL),(15,'child','39-6023-0-4-0002','','mittens-flap-gloves','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,12,1,NULL,NULL),(16,'child','39-6023-0-5-0002','','mittens-flap-gloves','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,12,1,NULL,NULL),(17,'parent','12-1800-7','Organic Bamboo T-Shirt Woman ','organic-bamboo-t-shirt-woman','Organic Bamboo T-Shirt Woman ',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,NULL,1,NULL,4),(18,'child','12-1800-7-2-0002','','organic-bamboo-t-shirt-woman','',NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,17,1,NULL,NULL),(19,'child','12-1800-7-3-0002','','organic-bamboo-t-shirt-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,17,1,NULL,NULL),(20,'parent','13-1802-7','Organic Bamboo Tanktop Woman ','organic-bamboo-tanktop-woman','Organic Bamboo Tanktop Woman ',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,NULL,1,NULL,4),(21,'child','13-1802-7-2-0002','','organic-bamboo-tanktop-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,20,1,NULL,NULL),(22,'child','13-1802-7-3-0002','','organic-bamboo-tanktop-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,20,1,NULL,NULL),(23,'parent','12-1800-8','Organic Bamboo T-Shirt Man ','organic-bamboo-t-shirt-man','Organic Bamboo T-Shirt Man ',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,NULL,1,NULL,4),(24,'child','12-1800-8-3-0002','','organic-bamboo-t-shirt-man','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,23,1,NULL,NULL),(25,'parent','13-1072-7','Megalight 140 Singlet Berry Woman ','megalight-140-singlet-berry-woman','Megalight 140 Singlet Berry Woman ',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,NULL,1,NULL,4),(26,'child','13-1072-7-1-0229','','megalight-140-singlet-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,25,1,NULL,NULL),(27,'child','13-1072-7-2-0229','','megalight-140-singlet-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,25,1,NULL,NULL),(28,'child','13-1072-7-3-0229','','megalight-140-singlet-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,25,1,NULL,NULL),(29,'parent','14-1073-7','Megalight 140 Longtight Berry Woman ','megalight-140-longtight-berry-woman','Megalight 140 Longtight Berry Woman ',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,NULL,1,NULL,4),(30,'child','14-1073-7-1-0227','','megalight-140-longtight-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,29,1,NULL,NULL),(31,'child','14-1073-7-2-0227','','megalight-140-longtight-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,29,1,NULL,NULL),(32,'child','14-1073-7-3-0227','','megalight-140-longtight-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,29,1,NULL,NULL),(33,'parent','12-1079-7','Megalight 140 T-Shirt Berry Woman ','megalight-140-t-shirt-berry-woman','Megalight 140 T-Shirt Berry Woman ',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,NULL,1,NULL,4),(34,'child','12-1079-7-2-0227','','megalight-140-t-shirt-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,33,1,NULL,NULL),(35,'child','12-1079-7-3-0227','','megalight-140-t-shirt-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,33,1,NULL,NULL),(36,'parent','15-1070-7','Megalight 140 Longshirt Berry Woman ','megalight-140-longshirt-berry-woman','Megalight 140 Longshirt Berry Woman ',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,NULL,1,NULL,4),(37,'child','15-1070-7-2-0227','','megalight-140-longshirt-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,36,1,NULL,NULL),(38,'child','15-1070-7-3-0227','','megalight-140-longshirt-berry-woman','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,36,1,NULL,NULL),(39,'parent','19-1076-8','Megalight 140 1','megalight-140-1','Megalight 140 1',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,NULL,1,NULL,4),(40,'child','19-1076-8-1-0002','','megalight-140-1','',NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,39,1,NULL,NULL),(41,'child','19-1076-8-2-0002','','megalight-140-1','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,39,1,NULL,NULL),(42,'child','19-1076-8-3-0002','','megalight-140-1','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,39,1,NULL,NULL),(43,'parent','15-1070-8','Megalight 140 Longshirt Lime Man ','megalight-140-longshirt-lime-man','Megalight 140 Longshirt Lime Man ',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,NULL,1,NULL,4),(44,'child','15-1070-8-2-0017','','megalight-140-longshirt-lime-man','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,43,1,NULL,NULL),(45,'child','15-1070-8-3-0017','','megalight-140-longshirt-lime-man','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,43,1,NULL,NULL),(46,'parent','12-1079-8','Megalight 140 T-Shirt Lime Man ','megalight-140-t-shirt-lime-man','Megalight 140 T-Shirt Lime Man ',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,NULL,1,NULL,4),(47,'child','12-1079-8-2-0017','','megalight-140-t-shirt-lime-man','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,46,1,NULL,NULL),(48,'child','12-1079-8-3-0017','','megalight-140-t-shirt-lime-man','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,46,1,NULL,NULL),(49,'parent','15-1060-7','Megalight 140 Longshirt Woman ','megalight-140-longshirt-woman','Megalight 140 Longshirt Woman ',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,NULL,1,NULL,4),(50,'child','15-1060-7-1-0002','','megalight-140-longshirt-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,49,1,NULL,NULL),(51,'child','15-1060-7-2-0002','','megalight-140-longshirt-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,49,1,NULL,NULL),(52,'child','15-1060-7-3-0002','','megalight-140-longshirt-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,49,1,NULL,NULL),(53,'child','15-1060-7-4-0002','','megalight-140-longshirt-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,49,1,NULL,NULL),(54,'parent','13-1061-7','Megalight 140 Tanktop Woman ','megalight-140-tanktop-woman','Megalight 140 Tanktop Woman ',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,NULL,1,NULL,4),(55,'child','13-1061-7-1-0002','','megalight-140-tanktop-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,54,1,NULL,NULL),(56,'child','13-1061-7-2-0002','','megalight-140-tanktop-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,54,1,NULL,NULL),(57,'child','13-1061-7-3-0002','','megalight-140-tanktop-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,54,1,NULL,NULL),(58,'child','13-1061-7-4-0002','','megalight-140-tanktop-woman','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,54,1,NULL,NULL),(59,'parent','12-1059-8','Megalight 140 T-Shirt Man ','megalight-140-t-shirt-man','Megalight 140 T-Shirt Man ',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,NULL,1,NULL,4),(60,'child','12-1059-8-1-0002','','megalight-140-t-shirt-man','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,59,1,NULL,NULL),(61,'child','12-1059-8-2-0002','','megalight-140-t-shirt-man','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,59,1,NULL,NULL),(62,'child','12-1059-8-3-0002','','megalight-140-t-shirt-man','',NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,59,1,NULL,NULL),(63,'parent','14-1053-8','Megalight 140 Longtight Man ','megalight-140-longtight-man','Megalight 140 Longtight Man ',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,NULL,1,NULL,4),(64,'child','14-1053-8-1-0002','','megalight-140-longtight-man','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,63,1,NULL,NULL),(65,'child','14-1053-8-2-0002','','megalight-140-longtight-man','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,63,1,NULL,NULL),(66,'child','14-1053-8-3-0002','','megalight-140-longtight-man','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,63,1,NULL,NULL),(67,'parent','16-1054-8','Megalight 140 3','megalight-140-3','Megalight 140 3',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,NULL,1,NULL,4),(68,'child','16-1054-8-1-0002','','megalight-140-3','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,67,1,NULL,NULL),(69,'child','16-1054-8-2-0002','','megalight-140-3','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,67,1,NULL,NULL),(70,'child','16-1054-8-3-0002','','megalight-140-3','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,67,1,NULL,NULL),(71,'parent','11-1056-8','Megalight 140 Boxer Man ','megalight-140-boxer-man','Megalight 140 Boxer Man ',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,NULL,1,NULL,4),(72,'child','11-1056-8-1-0002','','megalight-140-boxer-man','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,71,1,NULL,NULL),(73,'child','11-1056-8-2-0002','','megalight-140-boxer-man','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,71,1,NULL,NULL),(74,'child','11-1056-8-3-0002','','megalight-140-boxer-man','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,71,1,NULL,NULL),(75,'parent','12-1000-9','KIDS Megalight 140 T-Shirt Unisex ','kids-megalight-140-t-shirt-unisex','KIDS Megalight 140 T-Shirt Unisex ',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,NULL,1,NULL,4),(76,'child','12-1000-9-1-0002','','kids-megalight-140-t-shirt-unisex','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,75,1,NULL,NULL),(77,'child','12-1000-9-2-0002','','kids-megalight-140-t-shirt-unisex','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,75,1,NULL,NULL),(78,'child','12-1000-9-3-0002','','kids-megalight-140-t-shirt-unisex','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,75,1,NULL,NULL),(79,'parent','11-1007-9','KIDS Megalight 140 Boxer Unisex ','kids-megalight-140-boxer-unisex','KIDS Megalight 140 Boxer Unisex ',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,NULL,1,NULL,4),(80,'child','11-1007-9-1-0002','','kids-megalight-140-boxer-unisex','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,79,1,NULL,NULL),(81,'child','11-1007-9-2-0002','','kids-megalight-140-boxer-unisex','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,79,1,NULL,NULL),(82,'child','11-1007-9-3-0002','','kids-megalight-140-boxer-unisex','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,79,1,NULL,NULL),(83,'parent','12-1250-8','Megalight 200 T-Shirt Man ','megalight-200-t-shirt-man','Megalight 200 T-Shirt Man ',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,NULL,1,NULL,4),(84,'child','12-1250-8-2-0002','','megalight-200-t-shirt-man','',NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,83,1,NULL,NULL),(85,'child','12-1250-8-3-0002','','megalight-200-t-shirt-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,83,1,NULL,NULL),(86,'parent','15-1251-8','Megalight 200 Longshirt Man ','megalight-200-longshirt-man','Megalight 200 Longshirt Man ',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,NULL,1,NULL,4),(87,'child','15-1251-8-2-0002','','megalight-200-longshirt-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,86,1,NULL,NULL),(88,'child','15-1251-8-3-0002','','megalight-200-longshirt-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,86,1,NULL,NULL),(89,'parent','14-1253-8','Megalight 200 Longtight Man ','megalight-200-longtight-man','Megalight 200 Longtight Man ',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,NULL,1,NULL,4),(90,'child','14-1253-8-1-0002','','megalight-200-longtight-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,89,1,NULL,NULL),(91,'child','14-1253-8-2-0002','','megalight-200-longtight-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,89,1,NULL,NULL),(92,'child','14-1253-8-3-0002','','megalight-200-longtight-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,89,1,NULL,NULL),(93,'parent','12-1417-8','Merino T-Shirt Man ','merino-t-shirt-man','Merino T-Shirt Man ',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,NULL,1,NULL,4),(94,'child','12-1417-8-2-0002','','merino-t-shirt-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,93,1,NULL,NULL),(95,'parent','15-2201-7','Merino TEC 240 Longshirt Zipper Woman ','merino-tec-240-longshirt-zipper-woman','Merino TEC 240 Longshirt Zipper Woman ',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,NULL,1,NULL,4),(96,'child','15-2201-7-1-0002','','merino-tec-240-longshirt-zipper-woman','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,95,1,NULL,NULL),(97,'child','15-2201-7-2-0002','','merino-tec-240-longshirt-zipper-woman','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,95,1,NULL,NULL),(98,'child','15-2201-7-3-0002','','merino-tec-240-longshirt-zipper-woman','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,95,1,NULL,NULL),(99,'parent','14-2202-8','Merino TEC 240 Longtight Man ','merino-tec-240-longtight-man','Merino TEC 240 Longtight Man ',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,NULL,1,NULL,4),(100,'child','14-2202-8-1-0002','','merino-tec-240-longtight-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,99,1,NULL,NULL),(101,'child','14-2202-8-2-0002','','merino-tec-240-longtight-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,99,1,NULL,NULL),(102,'child','14-2202-8-3-0002','','merino-tec-240-longtight-man','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,99,1,NULL,NULL),(103,'parent','28-4810-0','Sporting Allround 300 ','sporting-allround-300','Sporting Allround 300 ',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,NULL,1,NULL,4),(104,'child','28-4810-0-2-0001','','sporting-allround-300','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,103,1,NULL,NULL),(105,'child','28-4810-0-4-0001','','sporting-allround-300','',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,103,1,NULL,NULL),(106,'parent','23-4622-0','Trekking A 100 ','trekking-a-100','Trekking A 100 ',NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,NULL,1,3,4),(107,'child','23-4622-0-1-0193','','trekking-a-100','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,106,1,NULL,NULL),(108,'child','23-4622-0-2-0193','','trekking-a-100','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,106,1,NULL,NULL),(109,'child','23-4622-0-3-0198','','trekking-a-100','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,106,1,NULL,NULL),(110,'child','23-4622-0-4-0198','','trekking-a-100','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,106,1,NULL,NULL),(111,'parent','21-4010-7','Running Short Woman ','running-short-woman','Running Short Woman ',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,NULL,1,2,4),(112,'child','21-4010-7-1-0184','','running-short-woman','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,111,1,NULL,NULL),(113,'child','21-4010-7-2-0184','','running-short-woman','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,111,1,NULL,NULL),(114,'parent','21-4012-8','Running High Man ','running-high-man','Running High Man ',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,NULL,1,2,4),(115,'child','21-4012-8-2-0184','','running-high-man','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,114,1,NULL,NULL),(116,'child','21-4012-8-3-0184','','running-high-man','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,114,1,NULL,NULL),(117,'child','21-4012-8-4-0184','','running-high-man','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,114,1,NULL,NULL),(118,'parent','21-4020-7','Running Mid Woman ','running-mid-woman','Running Mid Woman ',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,NULL,1,2,4),(119,'child','21-4020-7-1-0233','','running-mid-woman','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,118,1,NULL,NULL),(120,'child','21-4020-7-2-0233','','running-mid-woman','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,118,1,NULL,NULL),(121,'parent','21-4020-8','Running Mid Man ','running-mid-man','Running Mid Man ',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,NULL,1,2,4),(122,'child','21-4020-8-2-0232','','running-mid-man','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,121,1,NULL,NULL),(123,'child','21-4020-8-3-0232','','running-mid-man','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,121,1,NULL,NULL),(124,'parent','12-2110-7','Ultralight 70 T-Shirt Woman ','ultralight-70-t-shirt-woman','Ultralight 70 T-Shirt Woman ',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,NULL,1,NULL,4),(125,'child','12-2110-7-3-0002','','ultralight-70-t-shirt-woman','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,124,1,NULL,NULL),(126,'child','12-2110-7-2-0002','','ultralight-70-t-shirt-woman','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,124,1,NULL,NULL),(127,'child','12-2110-7-1-0002','','ultralight-70-t-shirt-woman','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,124,1,NULL,NULL),(128,'parent','13-2112-8','Ultralight 70 Tanktop Man ','ultralight-70-tanktop-man','Ultralight 70 Tanktop Man ',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,NULL,1,NULL,4),(129,'child','13-2112-8-2-0002','','ultralight-70-tanktop-man','',NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,128,1,NULL,NULL),(130,'child','13-2112-8-3-0002','','ultralight-70-tanktop-man','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,128,1,NULL,NULL),(131,'parent','11-2111-7','Ultralight 70 Panty Woman ','ultralight-70-panty-woman','Ultralight 70 Panty Woman ',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,NULL,1,NULL,4),(132,'child','11-2111-7-3-0002','','ultralight-70-panty-woman','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,131,1,NULL,NULL),(133,'parent','12-2110-8','Ultralight 70 T-Shirt Man ','ultralight-70-t-shirt-man','Ultralight 70 T-Shirt Man ',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,NULL,1,NULL,4),(134,'child','12-2110-8-3-0002','','ultralight-70-t-shirt-man','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,133,1,NULL,NULL),(135,'parent','27-4711-7','Skiing NT P 100 Woman ','skiing-nt-p-100-woman','Skiing NT P 100 Woman ',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,NULL,1,4,4),(136,'child','27-4711-7-2-0202','','skiing-nt-p-100-woman','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,135,1,NULL,NULL),(137,'parent','27-4711-8','Skiing NT P 100 Man ','skiing-nt-p-100-man','Skiing NT P 100 Man ',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,NULL,1,4,4),(138,'child','27-4711-8-4-0202','','skiing-nt-p-100-man','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,137,1,NULL,NULL),(139,'parent','27-4724-0','Skiing Lite ','skiing-lite','Skiing Lite ',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,NULL,1,4,4),(140,'child','27-4724-0-2-0071','','skiing-lite','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,139,1,NULL,NULL),(141,'child','27-4724-0-3-0071','','skiing-lite','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,139,1,NULL,NULL),(142,'parent','460','HAD Merino ','had-merino','HAD Merino ',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,NULL,1,NULL,5),(143,'child','HA460-0006','','had-merino','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,142,1,NULL,NULL),(144,'child','HA460-0015','','had-merino','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,142,1,NULL,NULL),(145,'child','HA460-0018','','had-merino','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,142,1,NULL,NULL),(146,'child','HA460-0442','','had-merino','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,142,1,NULL,NULL),(147,'child','HA460-0443','','had-merino','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,142,1,NULL,NULL),(148,'child','HA460-0445','','had-merino','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,142,1,NULL,NULL),(149,'parent','620','HAD Neckwarmer Fleece ','had-neckwarmer-fleece','HAD Neckwarmer Fleece ',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,NULL,1,NULL,5),(150,'child','HA620-0XXX','','had-neckwarmer-fleece','',NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,149,1,NULL,NULL),(151,'parent','110','HAD Junior ','had-junior','HAD Junior ',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,NULL,1,NULL,5),(152,'child','HA110-0285','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(153,'child','HA110-0390','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(154,'parent','621','HAD Neckwarmer Fleece Kids ','had-neckwarmer-fleece-kids','HAD Neckwarmer Fleece Kids ',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,NULL,1,NULL,5),(155,'child','HA621-0224','','had-neckwarmer-fleece-kids','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,154,1,NULL,NULL),(156,'child','HA110-0477','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(157,'child','HA110-0475','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(158,'child','HA110-0470','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(159,'child','HA110-0472','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(160,'child','HA110-0219','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(161,'child','HA110-0220','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(162,'child','HA110-0252','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(163,'parent','100','HAD Solid colours ','had-solid-colours','HAD Solid colours ',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,NULL,1,NULL,5),(164,'child','HA100-0001','','had-solid-colours','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,163,1,NULL,NULL),(165,'child','HA100-0004','','had-solid-colours','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,163,1,NULL,NULL),(166,'child','HA100-0015','','had-solid-colours','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,163,1,NULL,NULL),(167,'child','HA100-0018','','had-solid-colours','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,163,1,NULL,NULL),(168,'child','HA110-0415','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(169,'child','HA110-0436','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(170,'child','HA110-0419','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(171,'child','HA110-0425','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(172,'child','HA110-0438','','had-junior','',NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,151,1,NULL,NULL),(173,'child','HA110-0346','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(174,'child','HA110-0349','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(175,'child','HA110-0413','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(176,'child','HA110-0143','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(177,'child','HA110-0133','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(178,'child','HA110-0158','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(179,'child','HA110-0169','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(180,'child','HA110-0154','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(181,'child','HA110-0162','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(182,'child','HA110-0234','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(183,'child','HA110-0155','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(184,'child','HA110-0264','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(185,'child','HA110-0258','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(186,'child','HA110-0242','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(187,'child','HA110-0317','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(188,'child','HA110-0385','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(189,'child','HA110-0387','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(190,'child','HA110-0171','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(191,'child','HA110-0362','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(192,'child','HA110-0388','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(193,'child','HA110-0400','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(194,'child','HA110-0410','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(195,'child','HA110-0406','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(196,'child','HA110-0407','','had-junior','',NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,151,1,NULL,NULL),(197,'child','HA110-0271 ','','had-junior','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,151,1,NULL,NULL),(198,'child','HA110-0275','','had-junior','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,151,1,NULL,NULL),(199,'child','HA110-0135','','had-junior','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,151,1,NULL,NULL),(200,'parent','450','HAD Coolmax ','had-coolmax','HAD Coolmax ',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,NULL,1,NULL,5),(201,'child','HA450-0002','','had-coolmax','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,200,1,NULL,NULL),(202,'child','HA450-0465','','had-coolmax','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,200,1,NULL,NULL),(203,'child','HA450-0466','','had-coolmax','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,200,1,NULL,NULL),(204,'parent','651','HAD Hadband ','had-hadband','HAD Hadband ',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,NULL,1,NULL,5),(205,'child','HA651-0002','','had-hadband','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,204,1,NULL,NULL),(206,'child','HA651-0463','','had-hadband','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,204,1,NULL,NULL),(207,'child','HA651-0464','','had-hadband','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,204,1,NULL,NULL),(208,'child','HA460-0002','','had-merino','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,142,1,NULL,NULL),(209,'child','HA460-0444','','had-merino','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,142,1,NULL,NULL),(210,'parent','660','HAD Primaloft ','had-primaloft','HAD Primaloft ',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,NULL,1,NULL,5),(211,'child','HA660-0377','','had-primaloft','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,210,1,NULL,NULL),(212,'child','HA660-0452','','had-primaloft','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,210,1,NULL,NULL),(213,'parent','640','HAD Triangle ','had-triangle','HAD Triangle ',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,NULL,1,NULL,5),(214,'child','HA640-0122','','had-triangle','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,213,1,NULL,NULL),(215,'parent','630','HAD Beanie ','had-beanie','HAD Beanie ',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,NULL,1,NULL,5),(216,'child','HA630-0252','','had-beanie','',NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,215,1,NULL,NULL),(217,'parent','610','HAD Hadmask ','had-hadmask','HAD Hadmask ',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,NULL,1,NULL,5),(218,'child','HA610-0002','','had-hadmask','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,217,1,NULL,NULL),(219,'parent','210','HAD Original Fleece ','had-original-fleece','HAD Original Fleece ',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,NULL,1,NULL,5),(220,'child','HA210-0347','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(221,'child','HA210-0432','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(222,'child','HA210-0416','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(223,'child','HA210-0418','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(224,'child','HA210-0411','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(225,'child','HA210-0405','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(226,'child','HA200-0029','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(227,'child','HA210-0125','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(228,'child','HA210-0147','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(229,'parent','200','HAD Solid Fleece ','had-solid-fleece','HAD Solid Fleece ',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,NULL,1,NULL,5),(230,'child','HA200-0002','','had-solid-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,229,1,NULL,NULL),(231,'child','HA200-0006','','had-solid-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,229,1,NULL,NULL),(232,'child','HA200-0020','','had-solid-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,229,1,NULL,NULL),(233,'child','HA620-0233','','had-neckwarmer-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,149,1,NULL,NULL),(234,'child','HA620-0436','','had-neckwarmer-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,149,1,NULL,NULL),(235,'parent','410','HAD Reflectives ','had-reflectives','HAD Reflectives ',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,NULL,1,NULL,5),(236,'child','HA410-0489','','had-reflectives','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,235,1,NULL,NULL),(237,'child','HA210-0368','','had-original-fleece','',NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,219,1,NULL,NULL),(238,'parent','120','HAD Kids ','had-kids','HAD Kids ',NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,NULL,1,NULL,5),(239,'child','HA120-0371','','had-kids','',NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,238,1,NULL,NULL),(240,'child','HA120-0392','','had-kids','',NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,238,1,NULL,NULL),(241,'child','HA120-0202','','had-kids','',NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,238,1,NULL,NULL),(242,'child','HA621-0328','','had-neckwarmer-fleece-kids','',NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,154,1,NULL,NULL),(243,'parent','220','HAD Kids Fleece ','had-kids-fleece','HAD Kids Fleece ',NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,NULL,1,NULL,5),(244,'child','HA220-0298','','had-kids-fleece','',NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,243,1,NULL,NULL);
/*!40000 ALTER TABLE `catalogue_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_product_product_options`
--

DROP TABLE IF EXISTS `catalogue_product_product_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_product_product_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`option_id`),
  KEY `catalogue_product_product_options_9bea82de` (`product_id`),
  KEY `catalogue_product_product_options_28df3725` (`option_id`),
  CONSTRAINT `catalogue_prod_option_id_3c86d91145e1eda2_fk_catalogue_option_id` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`),
  CONSTRAINT `catalogue_pr_product_id_36290bcd1abb306d_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_product_product_options`
--

LOCK TABLES `catalogue_product_product_options` WRITE;
/*!40000 ALTER TABLE `catalogue_product_product_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_product_product_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productactivity`
--

DROP TABLE IF EXISTS `catalogue_productactivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productactivity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `slug` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_productactivity_2dbcba41` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productactivity`
--

LOCK TABLES `catalogue_productactivity` WRITE;
/*!40000 ALTER TABLE `catalogue_productactivity` DISABLE KEYS */;
INSERT INTO `catalogue_productactivity` VALUES (1,'Cycling','Cycling'),(2,'Running','Running'),(3,'Trekking','Trekking'),(4,'Skiing','Skiing'),(5,'Rock Climbing','Rock-Climbing');
/*!40000 ALTER TABLE `catalogue_productactivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productattribute`
--

DROP TABLE IF EXISTS `catalogue_productattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productattribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` varchar(128) NOT NULL,
  `type` varchar(20) NOT NULL,
  `required` tinyint(1) NOT NULL,
  `option_group_id` int(11) DEFAULT NULL,
  `product_class_id` int(11),
  PRIMARY KEY (`id`),
  KEY `catalogue_productattribute_c1336794` (`code`),
  KEY `catalogue_productattribute_2f493fea` (`option_group_id`),
  KEY `catalogue_productattribute_c6619e6f` (`product_class_id`),
  CONSTRAINT `c_product_class_id_1362a591cb94a410_fk_catalogue_productclass_id` FOREIGN KEY (`product_class_id`) REFERENCES `catalogue_productclass` (`id`),
  CONSTRAINT `ee81dd8e018daf46989580657aa2c5f2` FOREIGN KEY (`option_group_id`) REFERENCES `catalogue_attributeoptiongroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productattribute`
--

LOCK TABLES `catalogue_productattribute` WRITE;
/*!40000 ALTER TABLE `catalogue_productattribute` DISABLE KEYS */;
INSERT INTO `catalogue_productattribute` VALUES (1,'Size','size','text',0,NULL,1),(2,'Color','color','text',0,NULL,1),(3,'Material','material','text',0,NULL,1);
/*!40000 ALTER TABLE `catalogue_productattribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productattributevalue`
--

DROP TABLE IF EXISTS `catalogue_productattributevalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productattributevalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value_text` longtext,
  `value_integer` int(11) DEFAULT NULL,
  `value_boolean` tinyint(1) DEFAULT NULL,
  `value_float` double DEFAULT NULL,
  `value_richtext` longtext,
  `value_date` date DEFAULT NULL,
  `value_file` varchar(255) DEFAULT NULL,
  `value_image` varchar(255) DEFAULT NULL,
  `entity_object_id` int(10) unsigned DEFAULT NULL,
  `attribute_id` int(11) NOT NULL,
  `entity_content_type_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `value_option_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogue_productattributeval_attribute_id_2577af51bd9ad6d8_uniq` (`attribute_id`,`product_id`),
  KEY `catalogue_productattributevalue_e582ed73` (`attribute_id`),
  KEY `catalogue_productattributevalue_ed18ba79` (`entity_content_type_id`),
  KEY `catalogue_productattributevalue_9bea82de` (`product_id`),
  KEY `catalogue_productattributevalue_314d12bc` (`value_option_id`),
  CONSTRAINT `catalogue_pr_product_id_627870505f32fefb_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `c_attribute_id_52017edc0eb6d798_fk_catalogue_productattribute_id` FOREIGN KEY (`attribute_id`) REFERENCES `catalogue_productattribute` (`id`),
  CONSTRAINT `D0e0df13f5db7d43bdbab175073e15d0` FOREIGN KEY (`entity_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `df82639e31ada55e647d697296f3915a` FOREIGN KEY (`value_option_id`) REFERENCES `catalogue_attributeoption` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productattributevalue`
--

LOCK TABLES `catalogue_productattributevalue` WRITE;
/*!40000 ALTER TABLE `catalogue_productattributevalue` DISABLE KEYS */;
INSERT INTO `catalogue_productattributevalue` VALUES (1,'Blue',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,1,NULL),(2,'100% Cotton',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,1,NULL),(3,'W36 L32',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,2,NULL),(4,'W38 L32',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,3,NULL),(5,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,4,NULL),(6,'Polyamid 85% Polyester 15%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,4,NULL),(7,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,5,NULL),(8,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,6,NULL),(9,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,7,NULL),(10,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,8,NULL),(11,'Polyamid 85% Polyester 15%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,8,NULL),(12,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,9,NULL),(13,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,10,NULL),(14,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,11,NULL),(15,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,12,NULL),(16,'Polyester 100%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,12,NULL),(17,'XS',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,13,NULL),(18,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,14,NULL),(19,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,15,NULL),(20,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,16,NULL),(21,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,17,NULL),(22,'Bamboo 81% Polyamide 15% Elastane 4%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,17,NULL),(23,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,18,NULL),(24,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,19,NULL),(25,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,20,NULL),(26,'Bamboo 81% Polyamide 15% Elastane 4%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,20,NULL),(27,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,21,NULL),(28,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,22,NULL),(29,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,23,NULL),(30,'Bamboo 81% Polyamide 15% Elastane 4%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,23,NULL),(31,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,24,NULL),(32,'Pink/Orange',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,25,NULL),(33,'Polyamide 94% Elastane 6%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,25,NULL),(34,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,26,NULL),(35,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,27,NULL),(36,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,28,NULL),(37,'Black/Pink',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,29,NULL),(38,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,29,NULL),(39,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,30,NULL),(40,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,31,NULL),(41,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,32,NULL),(42,'Black/Pink',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,33,NULL),(43,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,33,NULL),(44,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,34,NULL),(45,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,35,NULL),(46,'Black/Pink',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,36,NULL),(47,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,36,NULL),(48,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,37,NULL),(49,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,38,NULL),(50,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,39,NULL),(51,'Polyamide 72% Polyester 21% Elastane 7%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,39,NULL),(52,'2 Short Man /M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,40,NULL),(53,'2 Short Man /L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,41,NULL),(54,'2 Short Man /XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,42,NULL),(55,'Black/Green',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,43,NULL),(56,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,43,NULL),(57,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,44,NULL),(58,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,45,NULL),(59,'Black/Green',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,46,NULL),(60,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,46,NULL),(61,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,47,NULL),(62,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,48,NULL),(63,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,49,NULL),(64,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,49,NULL),(65,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,50,NULL),(66,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,51,NULL),(67,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,52,NULL),(68,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,53,NULL),(69,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,54,NULL),(70,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,54,NULL),(71,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,55,NULL),(72,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,56,NULL),(73,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,57,NULL),(74,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,58,NULL),(75,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,59,NULL),(76,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,59,NULL),(77,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,60,NULL),(78,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,61,NULL),(79,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,62,NULL),(80,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,63,NULL),(81,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,63,NULL),(82,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,64,NULL),(83,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,65,NULL),(84,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,66,NULL),(85,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,67,NULL),(86,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,67,NULL),(87,'4 Tight Man /M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,68,NULL),(88,'4 Tight Man /L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,69,NULL),(89,'4 Tight Man /XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,70,NULL),(90,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,71,NULL),(91,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,71,NULL),(92,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,72,NULL),(93,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,73,NULL),(94,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,74,NULL),(95,'Black ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,75,NULL),(96,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,75,NULL),(97,'104-116',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,76,NULL),(98,'128-140',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,77,NULL),(99,'152-164',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,78,NULL),(100,'Black ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,79,NULL),(101,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,79,NULL),(102,'104-116',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,80,NULL),(103,'128-140',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,81,NULL),(104,'152-164',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,82,NULL),(105,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,83,NULL),(106,'Polyamide 88% Polyester 12%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,83,NULL),(107,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,84,NULL),(108,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,85,NULL),(109,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,86,NULL),(110,'Polyamide 88% Polyester 12%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,86,NULL),(111,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,87,NULL),(112,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,88,NULL),(113,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,89,NULL),(114,'Polyamide 88% Polyester 12%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,89,NULL),(115,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,90,NULL),(116,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,91,NULL),(117,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,92,NULL),(118,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,93,NULL),(119,'Wool 76% Polypropylene 12% Polyamide 10% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,93,NULL),(120,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,94,NULL),(121,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,95,NULL),(122,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,96,NULL),(123,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,97,NULL),(124,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,98,NULL),(125,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,99,NULL),(126,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,100,NULL),(127,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,101,NULL),(128,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,102,NULL),(129,'White',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,103,NULL),(130,'Polyester 54% Polyester Coolmax 30% Polyamide 14% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,103,NULL),(131,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,104,NULL),(132,'47-49',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,105,NULL),(133,'Black/Orange',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,106,NULL),(134,'Polyamide 47% Polypropylene 26% Polyamide Microlon 25% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,106,NULL),(135,'35-38',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,107,NULL),(136,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,108,NULL),(137,'43-46',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,109,NULL),(138,'47-49',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,110,NULL),(139,'Black/Light Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,111,NULL),(140,'Polyamide 65% Polyamide Microlon 20% Polyproyplene 13% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,111,NULL),(141,'35-38',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,112,NULL),(142,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,113,NULL),(143,'Black/Light Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,114,NULL),(144,'Polyamide 65% Polyamide Microlon 23% Polyproplene 10% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,114,NULL),(145,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,115,NULL),(146,'43-46',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,116,NULL),(147,'47-49',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,117,NULL),(148,'Neon Orange/Pink',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,118,NULL),(149,'Polypropylene 56% Polyamide 41% Elastane 3%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,118,NULL),(150,'35-38',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,119,NULL),(151,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,120,NULL),(152,'Neon Green/Yellow',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,121,NULL),(153,'Polypropylene 56% Polyamide 41% Elastane 3%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,121,NULL),(154,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,122,NULL),(155,'43-46',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,123,NULL),(156,'Deep Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,124,NULL),(157,'Polypropylene 76% Polyamide 22% Carbon 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,124,NULL),(158,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,125,NULL),(159,'M',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,126,NULL),(160,'S',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,127,NULL),(161,'Deep Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,128,NULL),(162,'Polypropylene 76% Polyamide 22% Carbon 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,128,NULL),(163,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,129,NULL),(164,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,130,NULL),(165,'Deep Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,131,NULL),(166,'Polypropylene 74% Polyamide 21% Elastane 3% Carbon 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,131,NULL),(167,'L',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,132,NULL),(168,'Deep Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,133,NULL),(169,'Polypropylene 76% Polyamide 22% Carbon 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,133,NULL),(170,'XL',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,134,NULL),(171,'Mid Grey/Light Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,135,NULL),(172,'Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,135,NULL),(173,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,136,NULL),(174,'Mid Grey/Light Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,137,NULL),(175,'Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,137,NULL),(176,'47-49',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,138,NULL),(177,'Yellow',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,139,NULL),(178,'THERMOLITE 70% Polyamide 13% Cotton 15% Elastane 2%',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,139,NULL),(179,'39-42',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,140,NULL),(180,'43-46',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,141,NULL),(181,'100%Merino',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,142,NULL),(182,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,142,NULL),(183,'Sky',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,143,NULL),(184,'Berry',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,144,NULL),(185,'Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,145,NULL),(186,'India Paisley Black ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,146,NULL),(187,'Woodcut Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,147,NULL),(188,'India Paisley Berry',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,148,NULL),(189,'100% Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,149,NULL),(190,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,149,NULL),(191,'Any Available Style',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,150,NULL),(192,'100%Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,151,NULL),(193,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,151,NULL),(194,'Go Hard',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,152,NULL),(195,'Had Shards ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,153,NULL),(196,'100% Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,154,NULL),(197,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,154,NULL),(198,'Kindazimma - Fleece: Darkblue ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,155,NULL),(199,'Bear - Bm',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,156,NULL),(200,'Badaboom - Junior - Jm',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,157,NULL),(201,'Mountain\'S Calling - Om',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,158,NULL),(202,'Howdy - Um',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,159,NULL),(203,'Japo',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,160,NULL),(204,'Ml-Barrel King',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,161,NULL),(205,'Patrick Seabase ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,162,NULL),(206,'100%Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,163,NULL),(207,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,163,NULL),(208,'White',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,164,NULL),(209,'Grass',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,165,NULL),(210,'Berry ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,166,NULL),(211,'Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,167,NULL),(212,'Twister ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,168,NULL),(213,'Water Colour Pink ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,169,NULL),(214,'Mali ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,170,NULL),(215,'Nebula',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,171,NULL),(216,'Water Colour Black ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,172,NULL),(217,'Lost Blue',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,173,NULL),(218,'Smoke',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,174,NULL),(219,'Dragon Pink',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,175,NULL),(220,'Mosaik Atari Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,176,NULL),(221,'Lines Longway Lilac',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,177,NULL),(222,'Urban Camouflage',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,178,NULL),(223,'Woodcut Blanc ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,179,NULL),(224,'Crazy Flowers Berry',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,180,NULL),(225,'Fox Flower Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,181,NULL),(226,'Comb Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,182,NULL),(227,'Crazy Flowers Cloud',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,183,NULL),(228,'Moto Tears Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,184,NULL),(229,'Identity Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,185,NULL),(230,'Chinese Dragon Blue',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,186,NULL),(231,'Moto Tears Red',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,187,NULL),(232,'Rusties',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,188,NULL),(233,'Chains ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,189,NULL),(234,'Pirate',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,190,NULL),(235,'The Mexican',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,191,NULL),(236,'Pinions ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,192,NULL),(237,'Nimmaland ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,193,NULL),(238,'Nautilus ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,194,NULL),(239,'Arborg ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,195,NULL),(240,'Buds ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,196,NULL),(241,'Heidi',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,197,NULL),(242,'Sepp',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,198,NULL),(243,'Single Karo Mint',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,199,NULL),(244,'100% Coolmax',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,200,NULL),(245,'one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,200,NULL),(246,'Black Eyes Reflective- Bm ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,201,NULL),(247,'Falcon Eye - Bm',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,202,NULL),(248,'Tricolo - Bm',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,203,NULL),(249,'100% Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,204,NULL),(250,'one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,204,NULL),(251,'Coolmax Black Eyes Reflective',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,205,NULL),(252,'Coolmax Sunset ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,206,NULL),(253,'Coolmax Temple ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,207,NULL),(254,'Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,208,NULL),(255,'Woodcut Sky',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,209,NULL),(256,'100% Primaloft',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,210,NULL),(257,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,210,NULL),(258,'Mt. Everest',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,211,NULL),(259,'Gulf Stream ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,212,NULL),(260,'100% Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,213,NULL),(261,'one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,213,NULL),(262,'Kaleidoscope Layers',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,214,NULL),(263,'100% Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,215,NULL),(264,'one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,215,NULL),(265,'Seabase ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,216,NULL),(266,'100% Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,217,NULL),(267,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,217,NULL),(268,'Black Eyes',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,218,NULL),(269,'100%Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,219,NULL),(270,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,219,NULL),(271,'Fading Pink - Fleece: Lightblue',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,220,NULL),(272,'Peer - Fleece: Camel',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,221,NULL),(273,'Babylon - Fleece: Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,222,NULL),(274,'Marvin - Fleece: Black ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,223,NULL),(275,'Chico - Fleece: Camel',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,224,NULL),(276,'Arabesk - Fleece: Camel',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,225,NULL),(277,'Neon Green - Fleece: Black ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,226,NULL),(278,'Dot Grass - Fleece: Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,227,NULL),(279,'Rb Confetti Mint - Fleece: Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,228,NULL),(280,'100%Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,229,NULL),(281,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,229,NULL),(282,'Black Eyes - Fleece: Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,230,NULL),(283,'Sky - Fleece: Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,231,NULL),(284,'Red - Fleece: Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,232,NULL),(285,'Skal Deer Black - Fleece: Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,233,NULL),(286,'Water Colour Pink - Fleece: Fluffy Black',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,234,NULL),(287,'100%Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,235,NULL),(288,'one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,235,NULL),(289,'Go Hard Reflective - Jm',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,236,NULL),(290,'Drift - Fleece: Red ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,237,NULL),(291,'100%Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,238,NULL),(292,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,238,NULL),(293,'Bugz Blue',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,239,NULL),(294,'TräCker ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,240,NULL),(295,'Giraffe ',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,241,NULL),(296,'Eskimo - Fleece: Darkblue',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,242,NULL),(297,'100%Polyester',NULL,NULL,NULL,NULL,NULL,'','',NULL,3,NULL,243,NULL),(298,' one size',NULL,NULL,NULL,NULL,NULL,'','',NULL,1,NULL,243,NULL),(299,'Stripe Beige Blue - Fleece: Grey',NULL,NULL,NULL,NULL,NULL,'','',NULL,2,NULL,244,NULL);
/*!40000 ALTER TABLE `catalogue_productattributevalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productbrand`
--

DROP TABLE IF EXISTS `catalogue_productbrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productbrand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `slug` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_productbrand_2dbcba41` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productbrand`
--

LOCK TABLES `catalogue_productbrand` WRITE;
/*!40000 ALTER TABLE `catalogue_productbrand` DISABLE KEYS */;
INSERT INTO `catalogue_productbrand` VALUES (1,'8BPlus','8BPlus'),(2,'Bourge-de-Peage','Bourge-de-Peage'),(3,'Charko','Charko'),(4,'F-Lite','F-Lite'),(5,'H.A.D.','H-A-D'),(6,'Makak','Makak');
/*!40000 ALTER TABLE `catalogue_productbrand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productcategory`
--

DROP TABLE IF EXISTS `catalogue_productcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogue_productcategory_product_id_5010e6207ddeddfe_uniq` (`product_id`,`category_id`),
  KEY `catalogue_productcategory_b583a629` (`category_id`),
  KEY `catalogue_productcategory_9bea82de` (`product_id`),
  CONSTRAINT `catalogue_pr_product_id_6615a148819eab3a_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `catalogue__category_id_62892d4b1ea04730_fk_catalogue_category_id` FOREIGN KEY (`category_id`) REFERENCES `catalogue_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productcategory`
--

LOCK TABLES `catalogue_productcategory` WRITE;
/*!40000 ALTER TABLE `catalogue_productcategory` DISABLE KEYS */;
INSERT INTO `catalogue_productcategory` VALUES (1,9,1),(2,15,4),(3,3,8),(4,3,12),(5,15,12),(6,17,17),(7,19,20),(8,5,23),(9,15,25),(10,15,29),(11,17,33),(12,18,36),(13,3,39),(14,15,39),(15,6,43),(16,5,46),(17,18,49),(18,19,54),(19,5,59),(20,3,63),(21,3,67),(22,15,67),(23,3,71),(24,30,75),(25,37,75),(26,28,79),(27,5,83),(28,6,86),(29,3,89),(30,5,93),(31,18,95),(32,3,99),(33,3,103),(34,15,103),(35,3,106),(36,15,106),(37,15,111),(38,3,114),(39,15,118),(40,3,121),(41,17,124),(42,7,128),(43,15,131),(44,5,133),(45,15,135),(46,3,137),(47,3,139),(48,15,139),(49,3,142),(50,15,142),(51,3,149),(52,15,149),(53,28,151),(54,28,154),(55,3,163),(56,15,163),(57,3,200),(58,15,200),(59,3,204),(60,15,204),(61,3,210),(62,15,210),(63,3,213),(64,15,213),(65,3,215),(66,15,215),(67,3,217),(68,15,217),(69,3,219),(70,15,219),(71,3,229),(72,15,229),(73,3,235),(74,15,235),(75,28,238),(76,28,243);
/*!40000 ALTER TABLE `catalogue_productcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productclass`
--

DROP TABLE IF EXISTS `catalogue_productclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `slug` varchar(128) NOT NULL,
  `requires_shipping` tinyint(1) NOT NULL,
  `track_stock` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productclass`
--

LOCK TABLES `catalogue_productclass` WRITE;
/*!40000 ALTER TABLE `catalogue_productclass` DISABLE KEYS */;
INSERT INTO `catalogue_productclass` VALUES (1,'Clothing','clothing',1,1);
/*!40000 ALTER TABLE `catalogue_productclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productclass_options`
--

DROP TABLE IF EXISTS `catalogue_productclass_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productclass_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productclass_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productclass_id` (`productclass_id`,`option_id`),
  KEY `catalogue_productclass_options_ebf7b0c6` (`productclass_id`),
  KEY `catalogue_productclass_options_28df3725` (`option_id`),
  CONSTRAINT `catalogue_prod_option_id_53b23c145a0e7ae1_fk_catalogue_option_id` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`),
  CONSTRAINT `ca_productclass_id_19b3f6278fef360d_fk_catalogue_productclass_id` FOREIGN KEY (`productclass_id`) REFERENCES `catalogue_productclass` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productclass_options`
--

LOCK TABLES `catalogue_productclass_options` WRITE;
/*!40000 ALTER TABLE `catalogue_productclass_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_productclass_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productimage`
--

DROP TABLE IF EXISTS `catalogue_productimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `original` varchar(255) NOT NULL,
  `caption` varchar(200) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogue_productimage_product_id_13868d064d886d95_uniq` (`product_id`,`display_order`),
  KEY `catalogue_productimage_9bea82de` (`product_id`),
  CONSTRAINT `catalogue_pr_product_id_139fa42825e67bb0_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productimage`
--

LOCK TABLES `catalogue_productimage` WRITE;
/*!40000 ALTER TABLE `catalogue_productimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_productimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_productrecommendation`
--

DROP TABLE IF EXISTS `catalogue_productrecommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_productrecommendation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ranking` smallint(5) unsigned NOT NULL,
  `primary_id` int(11) NOT NULL,
  `recommendation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogue_productrecommendation_primary_id_7bcb067d85969ce3_uniq` (`primary_id`,`recommendation_id`),
  KEY `catalogue_productrecommendation_095f2624` (`primary_id`),
  KEY `catalogue_productrecommendation_c65d5c4d` (`recommendation_id`),
  CONSTRAINT `catalogue_pr_primary_id_3ca4b79abcaac002_fk_catalogue_product_id` FOREIGN KEY (`primary_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `catal_recommendation_id_238400b019a404e0_fk_catalogue_product_id` FOREIGN KEY (`recommendation_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productrecommendation`
--

LOCK TABLES `catalogue_productrecommendation` WRITE;
/*!40000 ALTER TABLE `catalogue_productrecommendation` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_productrecommendation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_communicationeventtype`
--

DROP TABLE IF EXISTS `customer_communicationeventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_communicationeventtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `email_subject_template` varchar(255) DEFAULT NULL,
  `email_body_template` longtext,
  `email_body_html_template` longtext,
  `sms_template` varchar(170) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_communicationeventtype`
--

LOCK TABLES `customer_communicationeventtype` WRITE;
/*!40000 ALTER TABLE `customer_communicationeventtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_communicationeventtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_email`
--

DROP TABLE IF EXISTS `customer_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` longtext NOT NULL,
  `body_text` longtext NOT NULL,
  `body_html` longtext NOT NULL,
  `date_sent` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_email_e8701ad4` (`user_id`),
  CONSTRAINT `customer_email_user_id_8eeb3a31aa9371c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_email`
--

LOCK TABLES `customer_email` WRITE;
/*!40000 ALTER TABLE `customer_email` DISABLE KEYS */;
INSERT INTO `customer_email` VALUES (1,'Confirmation of order 100003','Hello,\n\nWe are pleased to confirm your order 100003 has been received and\nwill be processed shortly.\n\nYour order contains:\n\n * HAD Primaloft  - quantity: 1 - price: $22.04\n\nBasket total: $22.04\nShipping: $0.00\nOrder Total: $22.04\n\nShipping address:\n\n  Test Buyer\n  1 Main St\n  San Jose\n  CA\n  95131\n  UNITED STATES\n\n\n\n\nThe team\n','\n<p xmlns=\"http://www.w3.org/1999/html\">Hello,</p>\n\n<p>We are pleased to confirm your order 100003 has been received and\nwill be processed shortly.</p>\n\n<p>Your order contains:</p>\n\n<ul>\n    \n    <li>HAD Primaloft  - quantity: 1 - price: $22.04</li>\n    \n</ul>\n<p>\nBasket total: $22.04</br>\nShipping: $0.00</br>\nOrder Total: $22.04\n</p>\n\n<p>Shipping address:</p>\n<p>  Test Buyer<br/>\n  1 Main St<br/>\n  San Jose<br/>\n  CA<br/>\n  95131<br/>\n  UNITED STATES<br/>\n</p>\n\n\n\n\n<p>Thanks for using our site!</p>\n<p>The example.com team</p>\n','2014-11-12 23:06:22',1);
/*!40000 ALTER TABLE `customer_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_notification`
--

DROP TABLE IF EXISTS `customer_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `category` varchar(255) NOT NULL,
  `location` varchar(32) NOT NULL,
  `date_sent` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `recipient_id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_notification_8b938c66` (`recipient_id`),
  KEY `customer_notification_924b1846` (`sender_id`),
  CONSTRAINT `customer_notification_sender_id_327cbc8fe9128da8_fk_auth_user_id` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `customer_notificat_recipient_id_2a3e81b6f1125b41_fk_auth_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_notification`
--

LOCK TABLES `customer_notification` WRITE;
/*!40000 ALTER TABLE `customer_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_productalert`
--

DROP TABLE IF EXISTS `customer_productalert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_productalert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(75) NOT NULL,
  `key` varchar(128) NOT NULL,
  `status` varchar(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_confirmed` datetime DEFAULT NULL,
  `date_cancelled` datetime DEFAULT NULL,
  `date_closed` datetime DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_productalert_0c83f57c` (`email`),
  KEY `customer_productalert_3c6e0b8a` (`key`),
  KEY `customer_productalert_9bea82de` (`product_id`),
  KEY `customer_productalert_e8701ad4` (`user_id`),
  CONSTRAINT `customer_productalert_user_id_6fc3d0dd9c8130b4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `customer_pro_product_id_76d688fb01b70d57_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_productalert`
--

LOCK TABLES `customer_productalert` WRITE;
/*!40000 ALTER TABLE `customer_productalert` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_productalert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_417f1b1c` (`content_type_id`),
  KEY `django_admin_log_e8701ad4` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `djang_content_type_id_697914295151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-11-12 23:04:28','US','The United States of America',2,'Changed is_shipping_country.',14,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_45f3b1d93ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'flat page','flatpages','flatpage'),(9,'Product record','analytics','productrecord'),(10,'User record','analytics','userrecord'),(11,'User product view','analytics','userproductview'),(12,'User search query','analytics','usersearch'),(13,'User address','address','useraddress'),(14,'Country','address','country'),(15,'Order and Item Charge','shipping','orderanditemcharges'),(16,'Weight-based Shipping Method','shipping','weightbased'),(17,'Weight Band','shipping','weightband'),(18,'Product class','catalogue','productclass'),(19,'Category','catalogue','category'),(20,'Product category','catalogue','productcategory'),(21,'Product','catalogue','product'),(22,'Product recommendation','catalogue','productrecommendation'),(23,'Product attribute','catalogue','productattribute'),(24,'Product attribute value','catalogue','productattributevalue'),(25,'Attribute option group','catalogue','attributeoptiongroup'),(26,'Attribute option','catalogue','attributeoption'),(27,'Option','catalogue','option'),(28,'Product image','catalogue','productimage'),(29,'Product review','reviews','productreview'),(30,'Vote','reviews','vote'),(31,'Fulfillment partner','partner','partner'),(32,'Partner address','partner','partneraddress'),(33,'Stock record','partner','stockrecord'),(34,'Stock alert','partner','stockalert'),(35,'Basket','basket','basket'),(36,'Basket line','basket','line'),(37,'Line attribute','basket','lineattribute'),(38,'Transaction','payment','transaction'),(39,'Source','payment','source'),(40,'Source Type','payment','sourcetype'),(41,'Bankcard','payment','bankcard'),(42,'Conditional offer','offer','conditionaloffer'),(43,'Condition','offer','condition'),(44,'Benefit','offer','benefit'),(45,'Range','offer','range'),(46,'range product','offer','rangeproduct'),(47,'Range Product Uploaded File','offer','rangeproductfileupload'),(48,'Fixed price shipping benefit','offer','shippingfixedpricebenefit'),(49,'Coverage Condition','offer','coveragecondition'),(50,'Count condition','offer','countcondition'),(51,'Value condition','offer','valuecondition'),(52,'Multibuy discount benefit','offer','multibuydiscountbenefit'),(53,'Shipping percentage discount benefit','offer','shippingpercentagediscountbenefit'),(54,'Absolute discount benefit','offer','absolutediscountbenefit'),(55,'shipping benefit','offer','shippingbenefit'),(56,'Shipping absolute discount benefit','offer','shippingabsolutediscountbenefit'),(57,'Percentage discount benefit','offer','percentagediscountbenefit'),(58,'Fixed price benefit','offer','fixedpricebenefit'),(59,'Payment Event Quantity','order','paymenteventquantity'),(60,'Shipping Event Quantity','order','shippingeventquantity'),(61,'Order','order','order'),(62,'Order Note','order','ordernote'),(63,'Communication Event','order','communicationevent'),(64,'Shipping address','order','shippingaddress'),(65,'Billing address','order','billingaddress'),(66,'Order Line','order','line'),(67,'Line Price','order','lineprice'),(68,'Line Attribute','order','lineattribute'),(69,'Shipping Event','order','shippingevent'),(70,'Shipping Event Type','order','shippingeventtype'),(71,'Payment Event','order','paymentevent'),(72,'Payment Event Type','order','paymenteventtype'),(73,'Order Discount','order','orderdiscount'),(74,'Email','customer','email'),(75,'Communication event type','customer','communicationeventtype'),(76,'Notification','customer','notification'),(77,'Product alert','customer','productalert'),(78,'Page Promotion','promotions','pagepromotion'),(79,'Keyword Promotion','promotions','keywordpromotion'),(80,'Raw HTML','promotions','rawhtml'),(81,'Image','promotions','image'),(82,'Multi Image','promotions','multiimage'),(83,'Single product','promotions','singleproduct'),(84,'Hand Picked Product List','promotions','handpickedproductlist'),(85,'Ordered product','promotions','orderedproduct'),(86,'Automatic product list','promotions','automaticproductlist'),(87,'Ordered Product List','promotions','orderedproductlist'),(88,'Tabbed Block','promotions','tabbedblock'),(89,'Voucher','voucher','voucher'),(90,'Voucher Application','voucher','voucherapplication'),(91,'Wish List','wishlists','wishlist'),(92,'Wish list line','wishlists','line'),(93,'kv store','thumbnail','kvstore'),(94,'product brand','catalogue','productbrand'),(95,'product activity','catalogue','productactivity'),(96,'express transaction','paypal','expresstransaction'),(97,'payflow transaction','paypal','payflowtransaction');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_flatpage`
--

DROP TABLE IF EXISTS `django_flatpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_flatpage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `enable_comments` tinyint(1) NOT NULL,
  `template_name` varchar(70) NOT NULL,
  `registration_required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_flatpage_572d4e42` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_flatpage`
--

LOCK TABLES `django_flatpage` WRITE;
/*!40000 ALTER TABLE `django_flatpage` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_flatpage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_flatpage_sites`
--

DROP TABLE IF EXISTS `django_flatpage_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_flatpage_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flatpage_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flatpage_id` (`flatpage_id`,`site_id`),
  KEY `django_flatpage_sites_c3368d3a` (`flatpage_id`),
  KEY `django_flatpage_sites_9365d6e7` (`site_id`),
  CONSTRAINT `django_flatpage_sites_site_id_481dafa7c6e850d9_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `django_flatpa_flatpage_id_7b4e76c0a3a9d13a_fk_django_flatpage_id` FOREIGN KEY (`flatpage_id`) REFERENCES `django_flatpage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_flatpage_sites`
--

LOCK TABLES `django_flatpage_sites` WRITE;
/*!40000 ALTER TABLE `django_flatpage_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_flatpage_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2014-11-11 21:33:02'),(2,'auth','0001_initial','2014-11-11 21:33:02'),(3,'address','0001_initial','2014-11-11 21:33:03'),(4,'admin','0001_initial','2014-11-11 21:33:03'),(5,'catalogue','0001_initial','2014-11-11 21:33:05'),(6,'analytics','0001_initial','2014-11-11 21:33:06'),(7,'analytics','0002_auto_20140827_1705','2014-11-11 21:33:06'),(8,'sites','0001_initial','2014-11-11 21:33:06'),(9,'partner','0001_initial','2014-11-11 21:33:07'),(10,'customer','0001_initial','2014-11-11 21:33:08'),(11,'basket','0001_initial','2014-11-11 21:33:08'),(12,'basket','0002_auto_20140827_1705','2014-11-11 21:33:10'),(13,'order','0001_initial','2014-11-11 21:33:17'),(14,'offer','0001_initial','2014-11-11 21:33:19'),(15,'voucher','0001_initial','2014-11-11 21:33:20'),(16,'basket','0003_basket_vouchers','2014-11-11 21:33:22'),(17,'basket','0004_auto_20141007_2032','2014-11-11 21:33:23'),(18,'flatpages','0001_initial','2014-11-11 21:33:24'),(19,'order','0002_auto_20141007_2032','2014-11-11 21:33:24'),(20,'partner','0002_auto_20141007_2032','2014-11-11 21:33:24'),(21,'payment','0001_initial','2014-11-11 21:33:26'),(22,'payment','0002_auto_20141007_2032','2014-11-11 21:33:26'),(23,'promotions','0001_initial','2014-11-11 21:33:29'),(24,'reviews','0001_initial','2014-11-11 21:33:30'),(25,'sessions','0001_initial','2014-11-11 21:33:30'),(26,'shipping','0001_initial','2014-11-11 21:33:30'),(27,'wishlists','0001_initial','2014-11-11 21:33:31'),(28,'catalogue','0002_auto_20141111_1653','2014-11-11 22:53:44');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('7nl7u1rs09s2x66lm6mzw559gj15b2xp','ZmQwZTc5YTc1ZjQ2M2Y5OTQ1MGEyZTQ2NzJkODRhMThmNDI1N2RjZjp7ImNoZWNrb3V0X29yZGVyX2lkIjoxLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJvc2Nhci5hcHBzLmN1c3RvbWVyLmF1dGhfYmFja2VuZHMuRW1haWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTgxYjExNWQ1ZTk5MGU0MzcyZGEyMzYwMTEwZWEzMmM2OWViOTRjZSIsIl9hdXRoX3VzZXJfaWQiOjEsImNoZWNrb3V0X2RhdGEiOnt9fQ==','2014-11-26 23:06:22');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_benefit`
--

DROP TABLE IF EXISTS `offer_benefit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_benefit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  `value` decimal(12,2) DEFAULT NULL,
  `max_affected_items` int(10) unsigned DEFAULT NULL,
  `proxy_class` varchar(255) DEFAULT NULL,
  `range_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `proxy_class` (`proxy_class`),
  KEY `offer_benefit_ee6537b7` (`range_id`),
  CONSTRAINT `offer_benefit_range_id_449c339162094d2d_fk_offer_range_id` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_benefit`
--

LOCK TABLES `offer_benefit` WRITE;
/*!40000 ALTER TABLE `offer_benefit` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_benefit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_condition`
--

DROP TABLE IF EXISTS `offer_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_condition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  `value` decimal(12,2) DEFAULT NULL,
  `proxy_class` varchar(255) DEFAULT NULL,
  `range_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `proxy_class` (`proxy_class`),
  KEY `offer_condition_ee6537b7` (`range_id`),
  CONSTRAINT `offer_condition_range_id_33cd055e7a47188b_fk_offer_range_id` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_condition`
--

LOCK TABLES `offer_condition` WRITE;
/*!40000 ALTER TABLE `offer_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_conditionaloffer`
--

DROP TABLE IF EXISTS `offer_conditionaloffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_conditionaloffer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `slug` varchar(128) NOT NULL,
  `description` longtext NOT NULL,
  `offer_type` varchar(128) NOT NULL,
  `status` varchar(64) NOT NULL,
  `priority` int(11) NOT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `max_global_applications` int(10) unsigned DEFAULT NULL,
  `max_user_applications` int(10) unsigned DEFAULT NULL,
  `max_basket_applications` int(10) unsigned DEFAULT NULL,
  `max_discount` decimal(12,2) DEFAULT NULL,
  `total_discount` decimal(12,2) NOT NULL,
  `num_applications` int(10) unsigned NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `redirect_url` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL,
  `benefit_id` int(11) NOT NULL,
  `condition_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `offer_conditionaloffer_326fa416` (`benefit_id`),
  KEY `offer_conditionaloffer_bb531585` (`condition_id`),
  CONSTRAINT `offer_conditiona_benefit_id_4c6a38cd195b8af3_fk_offer_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `offer_benefit` (`id`),
  CONSTRAINT `offer_condit_condition_id_542cc60fe002425b_fk_offer_condition_id` FOREIGN KEY (`condition_id`) REFERENCES `offer_condition` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_conditionaloffer`
--

LOCK TABLES `offer_conditionaloffer` WRITE;
/*!40000 ALTER TABLE `offer_conditionaloffer` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_conditionaloffer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_range`
--

DROP TABLE IF EXISTS `offer_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_range` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `slug` varchar(128) NOT NULL,
  `description` longtext NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `includes_all_products` tinyint(1) NOT NULL,
  `proxy_class` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `proxy_class` (`proxy_class`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_range`
--

LOCK TABLES `offer_range` WRITE;
/*!40000 ALTER TABLE `offer_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_range_classes`
--

DROP TABLE IF EXISTS `offer_range_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_range_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `range_id` int(11) NOT NULL,
  `productclass_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `range_id` (`range_id`,`productclass_id`),
  KEY `offer_range_classes_ee6537b7` (`range_id`),
  KEY `offer_range_classes_ebf7b0c6` (`productclass_id`),
  CONSTRAINT `offer_range_classes_range_id_5495157c5dba3c7e_fk_offer_range_id` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`),
  CONSTRAINT `of_productclass_id_65f7da29711eeec3_fk_catalogue_productclass_id` FOREIGN KEY (`productclass_id`) REFERENCES `catalogue_productclass` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_range_classes`
--

LOCK TABLES `offer_range_classes` WRITE;
/*!40000 ALTER TABLE `offer_range_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_range_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_range_excluded_products`
--

DROP TABLE IF EXISTS `offer_range_excluded_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_range_excluded_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `range_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `range_id` (`range_id`,`product_id`),
  KEY `offer_range_excluded_products_ee6537b7` (`range_id`),
  KEY `offer_range_excluded_products_9bea82de` (`product_id`),
  CONSTRAINT `offer_range_excluded_range_id_5abba188eab514d5_fk_offer_range_id` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`),
  CONSTRAINT `offer_range__product_id_2f40e4200a81b141_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_range_excluded_products`
--

LOCK TABLES `offer_range_excluded_products` WRITE;
/*!40000 ALTER TABLE `offer_range_excluded_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_range_excluded_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_range_included_categories`
--

DROP TABLE IF EXISTS `offer_range_included_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_range_included_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `range_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `range_id` (`range_id`,`category_id`),
  KEY `offer_range_included_categories_ee6537b7` (`range_id`),
  KEY `offer_range_included_categories_b583a629` (`category_id`),
  CONSTRAINT `offer_range_included__range_id_1b1a361d9d238ad_fk_offer_range_id` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`),
  CONSTRAINT `offer_rang_category_id_19d122d4c8545b33_fk_catalogue_category_id` FOREIGN KEY (`category_id`) REFERENCES `catalogue_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_range_included_categories`
--

LOCK TABLES `offer_range_included_categories` WRITE;
/*!40000 ALTER TABLE `offer_range_included_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_range_included_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_rangeproduct`
--

DROP TABLE IF EXISTS `offer_rangeproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_rangeproduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_order` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `range_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offer_rangeproduct_range_id_5c42c8babf2c26b_uniq` (`range_id`,`product_id`),
  KEY `offer_rangeproduct_9bea82de` (`product_id`),
  KEY `offer_rangeproduct_ee6537b7` (`range_id`),
  CONSTRAINT `offer_rangeproduct_range_id_3bd65d61f6fb09df_fk_offer_range_id` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`),
  CONSTRAINT `offer_rangep_product_id_6adb31809117d5c3_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_rangeproduct`
--

LOCK TABLES `offer_rangeproduct` WRITE;
/*!40000 ALTER TABLE `offer_rangeproduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_rangeproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_rangeproductfileupload`
--

DROP TABLE IF EXISTS `offer_rangeproductfileupload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_rangeproductfileupload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filepath` varchar(255) NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `date_uploaded` datetime NOT NULL,
  `status` varchar(32) NOT NULL,
  `error_message` varchar(255) NOT NULL,
  `date_processed` datetime DEFAULT NULL,
  `num_new_skus` int(10) unsigned DEFAULT NULL,
  `num_unknown_skus` int(10) unsigned DEFAULT NULL,
  `num_duplicate_skus` int(10) unsigned DEFAULT NULL,
  `range_id` int(11) NOT NULL,
  `uploaded_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `offer_rangeproductfileupload_ee6537b7` (`range_id`),
  KEY `offer_rangeproductfileupload_4095e96b` (`uploaded_by_id`),
  CONSTRAINT `offer_rangeproductfi_range_id_50ea275ceeecc99c_fk_offer_range_id` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`),
  CONSTRAINT `offer_rangeprodu_uploaded_by_id_7e7a62fa1b3f0c59_fk_auth_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_rangeproductfileupload`
--

LOCK TABLES `offer_rangeproductfileupload` WRITE;
/*!40000 ALTER TABLE `offer_rangeproductfileupload` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_rangeproductfileupload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_billingaddress`
--

DROP TABLE IF EXISTS `order_billingaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_billingaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `line1` varchar(255) NOT NULL,
  `line2` varchar(255) NOT NULL,
  `line3` varchar(255) NOT NULL,
  `line4` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postcode` varchar(64) NOT NULL,
  `search_text` longtext NOT NULL,
  `country_id` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_billingaddress_93bfec8a` (`country_id`),
  CONSTRAINT `ord_country_id_3748ef9a5677c2c1_fk_address_country_iso_3166_1_a2` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_billingaddress`
--

LOCK TABLES `order_billingaddress` WRITE;
/*!40000 ALTER TABLE `order_billingaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_billingaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_communicationevent`
--

DROP TABLE IF EXISTS `order_communicationevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_communicationevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_communicationevent_5e891baf` (`event_type_id`),
  KEY `order_communicationevent_69dfcb07` (`order_id`),
  CONSTRAINT `f3c44c0cdb976b5625481f2fdede8f57` FOREIGN KEY (`event_type_id`) REFERENCES `customer_communicationeventtype` (`id`),
  CONSTRAINT `order_communicatione_order_id_500bca2fc2baacb0_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_communicationevent`
--

LOCK TABLES `order_communicationevent` WRITE;
/*!40000 ALTER TABLE `order_communicationevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_communicationevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_line`
--

DROP TABLE IF EXISTS `order_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner_name` varchar(128) NOT NULL,
  `partner_sku` varchar(128) NOT NULL,
  `partner_line_reference` varchar(128) NOT NULL,
  `partner_line_notes` longtext NOT NULL,
  `title` varchar(255) NOT NULL,
  `upc` varchar(128) DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `line_price_incl_tax` decimal(12,2) NOT NULL,
  `line_price_excl_tax` decimal(12,2) NOT NULL,
  `line_price_before_discounts_incl_tax` decimal(12,2) NOT NULL,
  `line_price_before_discounts_excl_tax` decimal(12,2) NOT NULL,
  `unit_cost_price` decimal(12,2) DEFAULT NULL,
  `unit_price_incl_tax` decimal(12,2) DEFAULT NULL,
  `unit_price_excl_tax` decimal(12,2) DEFAULT NULL,
  `unit_retail_price` decimal(12,2) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `est_dispatch_date` date DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `partner_id` int(11),
  `product_id` int(11),
  `stockrecord_id` int(11),
  PRIMARY KEY (`id`),
  KEY `order_line_69dfcb07` (`order_id`),
  KEY `order_line_4e98b6eb` (`partner_id`),
  KEY `order_line_9bea82de` (`product_id`),
  KEY `order_line_271c5733` (`stockrecord_id`),
  CONSTRAINT `order_line_order_id_419b4779ab1b2c44_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `order_line_partner_id_4f32db65ffdc9bc8_fk_partner_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`),
  CONSTRAINT `order_line_product_id_7ac413b808fdbe0d_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `order__stockrecord_id_3d43d2c9d3c4cead_fk_partner_stockrecord_id` FOREIGN KEY (`stockrecord_id`) REFERENCES `partner_stockrecord` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_line`
--

LOCK TABLES `order_line` WRITE;
/*!40000 ALTER TABLE `order_line` DISABLE KEYS */;
INSERT INTO `order_line` VALUES (1,'Reno Warehouse','HA660-0452','','','HAD Primaloft ','HA660-0452',1,22.04,22.04,22.04,22.04,8.19,22.04,22.04,22.04,'Pending',NULL,1,1,212,163);
/*!40000 ALTER TABLE `order_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_lineattribute`
--

DROP TABLE IF EXISTS `order_lineattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_lineattribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  `value` varchar(255) NOT NULL,
  `line_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_lineattribute_b3ae486a` (`line_id`),
  KEY `order_lineattribute_28df3725` (`option_id`),
  CONSTRAINT `order_lineattribute_line_id_361105dcc9876c7c_fk_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `order_lineattr_option_id_4a223782d95984a5_fk_catalogue_option_id` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_lineattribute`
--

LOCK TABLES `order_lineattribute` WRITE;
/*!40000 ALTER TABLE `order_lineattribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_lineattribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_lineprice`
--

DROP TABLE IF EXISTS `order_lineprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_lineprice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL,
  `price_incl_tax` decimal(12,2) NOT NULL,
  `price_excl_tax` decimal(12,2) NOT NULL,
  `shipping_incl_tax` decimal(12,2) NOT NULL,
  `shipping_excl_tax` decimal(12,2) NOT NULL,
  `line_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_lineprice_b3ae486a` (`line_id`),
  KEY `order_lineprice_69dfcb07` (`order_id`),
  CONSTRAINT `order_lineprice_line_id_42df16f62bd792af_fk_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `order_lineprice_order_id_6a6e2d71fc788284_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_lineprice`
--

LOCK TABLES `order_lineprice` WRITE;
/*!40000 ALTER TABLE `order_lineprice` DISABLE KEYS */;
INSERT INTO `order_lineprice` VALUES (1,1,22.04,22.04,0.00,0.00,1,1);
/*!40000 ALTER TABLE `order_lineprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_order`
--

DROP TABLE IF EXISTS `order_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(128) NOT NULL,
  `currency` varchar(12) NOT NULL,
  `total_incl_tax` decimal(12,2) NOT NULL,
  `total_excl_tax` decimal(12,2) NOT NULL,
  `shipping_incl_tax` decimal(12,2) NOT NULL,
  `shipping_excl_tax` decimal(12,2) NOT NULL,
  `shipping_method` varchar(128) NOT NULL,
  `shipping_code` varchar(128) NOT NULL,
  `status` varchar(100) NOT NULL,
  `guest_email` varchar(75) NOT NULL,
  `date_placed` datetime NOT NULL,
  `basket_id` int(11) DEFAULT NULL,
  `billing_address_id` int(11) DEFAULT NULL,
  `shipping_address_id` int(11),
  `site_id` int(11),
  `user_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `order_order_90e84921` (`date_placed`),
  KEY `order_order_afdeaea9` (`basket_id`),
  KEY `order_order_e9192ced` (`billing_address_id`),
  KEY `order_order_8fb9ffec` (`shipping_address_id`),
  KEY `order_order_9365d6e7` (`site_id`),
  KEY `order_order_e8701ad4` (`user_id`),
  CONSTRAINT `D94ae911c3671773e2202bbfca3ffb8e` FOREIGN KEY (`shipping_address_id`) REFERENCES `order_shippingaddress` (`id`),
  CONSTRAINT `order_order_basket_id_3fdb3912d02cb39c_fk_basket_basket_id` FOREIGN KEY (`basket_id`) REFERENCES `basket_basket` (`id`),
  CONSTRAINT `order_order_site_id_7c5b367997322009_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `order_order_user_id_350d9d363b4b7f2f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `o_billing_address_id_413696bbd40ac2ff_fk_order_billingaddress_id` FOREIGN KEY (`billing_address_id`) REFERENCES `order_billingaddress` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_order`
--

LOCK TABLES `order_order` WRITE;
/*!40000 ALTER TABLE `order_order` DISABLE KEYS */;
INSERT INTO `order_order` VALUES (1,'100003','USD',22.04,22.04,0.00,0.00,'Free shipping','fixed-price-shipping','Pending','dr.joshuaw-buyer@gmail.com','2014-11-12 23:06:22',3,NULL,1,1,1);
/*!40000 ALTER TABLE `order_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_orderdiscount`
--

DROP TABLE IF EXISTS `order_orderdiscount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_orderdiscount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(64) NOT NULL,
  `offer_id` int(10) unsigned DEFAULT NULL,
  `offer_name` varchar(128) NOT NULL,
  `voucher_id` int(10) unsigned DEFAULT NULL,
  `voucher_code` varchar(128) NOT NULL,
  `frequency` int(10) unsigned DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `message` longtext NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_orderdiscount_9eeed246` (`offer_name`),
  KEY `order_orderdiscount_08e4f7cd` (`voucher_code`),
  KEY `order_orderdiscount_69dfcb07` (`order_id`),
  CONSTRAINT `order_orderdiscount_order_id_74eee63bc9b32980_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_orderdiscount`
--

LOCK TABLES `order_orderdiscount` WRITE;
/*!40000 ALTER TABLE `order_orderdiscount` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_orderdiscount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_ordernote`
--

DROP TABLE IF EXISTS `order_ordernote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_ordernote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note_type` varchar(128) NOT NULL,
  `message` longtext NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_ordernote_69dfcb07` (`order_id`),
  KEY `order_ordernote_e8701ad4` (`user_id`),
  CONSTRAINT `order_ordernote_order_id_65637e2418771857_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `order_ordernote_user_id_86a59b68ba6447d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_ordernote`
--

LOCK TABLES `order_ordernote` WRITE;
/*!40000 ALTER TABLE `order_ordernote` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_ordernote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_paymentevent`
--

DROP TABLE IF EXISTS `order_paymentevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_paymentevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(12,2) NOT NULL,
  `reference` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `shipping_event_id` int(11),
  PRIMARY KEY (`id`),
  KEY `order_paymentevent_5e891baf` (`event_type_id`),
  KEY `order_paymentevent_69dfcb07` (`order_id`),
  KEY `order_paymentevent_78cafb71` (`shipping_event_id`),
  CONSTRAINT `order_paymentevent_order_id_42d3803ca07e2418_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `orde_event_type_id_30d2e580e1d682f4_fk_order_paymenteventtype_id` FOREIGN KEY (`event_type_id`) REFERENCES `order_paymenteventtype` (`id`),
  CONSTRAINT `ord_shipping_event_id_2387ec9d4c55ca00_fk_order_shippingevent_id` FOREIGN KEY (`shipping_event_id`) REFERENCES `order_shippingevent` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_paymentevent`
--

LOCK TABLES `order_paymentevent` WRITE;
/*!40000 ALTER TABLE `order_paymentevent` DISABLE KEYS */;
INSERT INTO `order_paymentevent` VALUES (1,22.04,'e379c38650322','2014-11-12 23:06:22',1,1,NULL);
/*!40000 ALTER TABLE `order_paymentevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_paymenteventquantity`
--

DROP TABLE IF EXISTS `order_paymenteventquantity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_paymenteventquantity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL,
  `event_id` int(11) NOT NULL,
  `line_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_paymenteventquantity_event_id_71c85d21cf10e2a9_uniq` (`event_id`,`line_id`),
  KEY `order_paymenteventquantity_4437cfac` (`event_id`),
  KEY `order_paymenteventquantity_b3ae486a` (`line_id`),
  CONSTRAINT `order_paymenteventquan_line_id_2641216f31e00d64_fk_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `order_paymente_event_id_1fd0b26db2b9e09_fk_order_paymentevent_id` FOREIGN KEY (`event_id`) REFERENCES `order_paymentevent` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_paymenteventquantity`
--

LOCK TABLES `order_paymenteventquantity` WRITE;
/*!40000 ALTER TABLE `order_paymenteventquantity` DISABLE KEYS */;
INSERT INTO `order_paymenteventquantity` VALUES (1,1,1,1);
/*!40000 ALTER TABLE `order_paymenteventquantity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_paymenteventtype`
--

DROP TABLE IF EXISTS `order_paymenteventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_paymenteventtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_paymenteventtype`
--

LOCK TABLES `order_paymenteventtype` WRITE;
/*!40000 ALTER TABLE `order_paymenteventtype` DISABLE KEYS */;
INSERT INTO `order_paymenteventtype` VALUES (1,'Settled','settled');
/*!40000 ALTER TABLE `order_paymenteventtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_shippingaddress`
--

DROP TABLE IF EXISTS `order_shippingaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_shippingaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `line1` varchar(255) NOT NULL,
  `line2` varchar(255) NOT NULL,
  `line3` varchar(255) NOT NULL,
  `line4` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postcode` varchar(64) NOT NULL,
  `search_text` longtext NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `notes` longtext NOT NULL,
  `country_id` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_shippingaddress_93bfec8a` (`country_id`),
  CONSTRAINT `ord_country_id_7c66bd4e282d4fcf_fk_address_country_iso_3166_1_a2` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_shippingaddress`
--

LOCK TABLES `order_shippingaddress` WRITE;
/*!40000 ALTER TABLE `order_shippingaddress` DISABLE KEYS */;
INSERT INTO `order_shippingaddress` VALUES (1,'','Test','Buyer','1 Main St','','','San Jose','CA','95131','Test Buyer 1 Main St San Jose CA 95131 UNITED STATES','','','US');
/*!40000 ALTER TABLE `order_shippingaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_shippingevent`
--

DROP TABLE IF EXISTS `order_shippingevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_shippingevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  `date_created` datetime NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_shippingevent_5e891baf` (`event_type_id`),
  KEY `order_shippingevent_69dfcb07` (`order_id`),
  CONSTRAINT `order_shippingevent_order_id_68b1b0f1be0500e3_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `ord_event_type_id_71e47410f9647141_fk_order_shippingeventtype_id` FOREIGN KEY (`event_type_id`) REFERENCES `order_shippingeventtype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_shippingevent`
--

LOCK TABLES `order_shippingevent` WRITE;
/*!40000 ALTER TABLE `order_shippingevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_shippingevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_shippingeventquantity`
--

DROP TABLE IF EXISTS `order_shippingeventquantity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_shippingeventquantity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL,
  `event_id` int(11) NOT NULL,
  `line_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_shippingeventquantity_event_id_7d8b3647671b075e_uniq` (`event_id`,`line_id`),
  KEY `order_shippingeventquantity_4437cfac` (`event_id`),
  KEY `order_shippingeventquantity_b3ae486a` (`line_id`),
  CONSTRAINT `order_shippingeventqua_line_id_391505a0fa0abef7_fk_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `order_shippi_event_id_7765e7fe70caea64_fk_order_shippingevent_id` FOREIGN KEY (`event_id`) REFERENCES `order_shippingevent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_shippingeventquantity`
--

LOCK TABLES `order_shippingeventquantity` WRITE;
/*!40000 ALTER TABLE `order_shippingeventquantity` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_shippingeventquantity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_shippingeventtype`
--

DROP TABLE IF EXISTS `order_shippingeventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_shippingeventtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_shippingeventtype`
--

LOCK TABLES `order_shippingeventtype` WRITE;
/*!40000 ALTER TABLE `order_shippingeventtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_shippingeventtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_partner`
--

DROP TABLE IF EXISTS `partner_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_partner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_partner`
--

LOCK TABLES `partner_partner` WRITE;
/*!40000 ALTER TABLE `partner_partner` DISABLE KEYS */;
INSERT INTO `partner_partner` VALUES (1,'reno-warehouse','Reno Warehouse');
/*!40000 ALTER TABLE `partner_partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_partner_users`
--

DROP TABLE IF EXISTS `partner_partner_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_partner_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partner_id` (`partner_id`,`user_id`),
  KEY `partner_partner_users_4e98b6eb` (`partner_id`),
  KEY `partner_partner_users_e8701ad4` (`user_id`),
  CONSTRAINT `partner_partner_users_user_id_216882a7741d5a52_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `partner_partne_partner_id_63b121e5c6d97f4a_fk_partner_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_partner_users`
--

LOCK TABLES `partner_partner_users` WRITE;
/*!40000 ALTER TABLE `partner_partner_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_partner_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_partneraddress`
--

DROP TABLE IF EXISTS `partner_partneraddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_partneraddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `line1` varchar(255) NOT NULL,
  `line2` varchar(255) NOT NULL,
  `line3` varchar(255) NOT NULL,
  `line4` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postcode` varchar(64) NOT NULL,
  `search_text` longtext NOT NULL,
  `country_id` varchar(2) NOT NULL,
  `partner_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_partneraddress_93bfec8a` (`country_id`),
  KEY `partner_partneraddress_4e98b6eb` (`partner_id`),
  CONSTRAINT `partner_partner_partner_id_54787daca128952_fk_partner_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`),
  CONSTRAINT `par_country_id_781c73d5cc70eb3e_fk_address_country_iso_3166_1_a2` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_partneraddress`
--

LOCK TABLES `partner_partneraddress` WRITE;
/*!40000 ALTER TABLE `partner_partneraddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_partneraddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_stockalert`
--

DROP TABLE IF EXISTS `partner_stockalert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_stockalert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `threshold` int(10) unsigned NOT NULL,
  `status` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_closed` datetime DEFAULT NULL,
  `stockrecord_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_stockalert_271c5733` (`stockrecord_id`),
  CONSTRAINT `partner_stockrecord_id_c1298620d4e8adb_fk_partner_stockrecord_id` FOREIGN KEY (`stockrecord_id`) REFERENCES `partner_stockrecord` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_stockalert`
--

LOCK TABLES `partner_stockalert` WRITE;
/*!40000 ALTER TABLE `partner_stockalert` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_stockalert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_stockrecord`
--

DROP TABLE IF EXISTS `partner_stockrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_stockrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner_sku` varchar(128) NOT NULL,
  `price_currency` varchar(12) NOT NULL,
  `price_excl_tax` decimal(12,2) DEFAULT NULL,
  `price_retail` decimal(12,2) DEFAULT NULL,
  `cost_price` decimal(12,2) DEFAULT NULL,
  `num_in_stock` int(10) unsigned DEFAULT NULL,
  `num_allocated` int(11) DEFAULT NULL,
  `low_stock_threshold` int(10) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `partner_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partner_stockrecord_partner_id_4faf51cd0ce15682_uniq` (`partner_id`,`partner_sku`),
  KEY `partner_stockrecord_9474e4b5` (`date_updated`),
  KEY `partner_stockrecord_4e98b6eb` (`partner_id`),
  KEY `partner_stockrecord_9bea82de` (`product_id`),
  CONSTRAINT `partner_stockr_partner_id_6dc7a684b7bf6856_fk_partner_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`),
  CONSTRAINT `partner_stoc_product_id_3aa87eeff9d8a80b_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_stockrecord`
--

LOCK TABLES `partner_stockrecord` WRITE;
/*!40000 ALTER TABLE `partner_stockrecord` DISABLE KEYS */;
INSERT INTO `partner_stockrecord` VALUES (1,'98777-W36-L32','USD',39.99,39.99,9.00,400,NULL,10,'2014-11-11 23:04:18','2014-11-11 23:04:18',1,2),(2,'98777-W38-L32','USD',39.99,39.99,9.00,250,NULL,10,'2014-11-11 23:04:59','2014-11-11 23:04:59',1,3),(3,'20-1008-7-1-0002','USD',38.94,38.94,12.94,1,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,5),(4,'20-1008-7-2-0002','USD',38.94,38.94,12.94,0,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,6),(5,'20-1008-7-3-0002','USD',38.94,38.94,12.94,1,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,7),(6,'20-1008-8-1-0002','USD',38.94,38.94,12.94,0,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,9),(7,'20-1008-8-2-0002','USD',38.94,38.94,12.94,0,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,10),(8,'20-1008-8-3-0002','USD',38.94,38.94,12.94,0,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,11),(9,'39-6023-0-1-0002','USD',19.44,19.44,5.92,1,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,13),(10,'39-6023-0-2-0002','USD',19.44,19.44,5.92,1,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,14),(11,'39-6023-0-4-0002','USD',19.44,19.44,5.92,1,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,15),(12,'39-6023-0-5-0002','USD',19.44,19.44,5.92,1,NULL,NULL,'2014-11-12 05:25:31','2014-11-12 05:25:31',1,16),(13,'12-1800-7-2-0002','USD',51.94,51.94,16.84,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,18),(14,'12-1800-7-3-0002','USD',51.94,51.94,16.84,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,19),(15,'13-1802-7-2-0002','USD',45.44,45.44,14.24,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,21),(16,'13-1802-7-3-0002','USD',45.44,45.44,14.24,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,22),(17,'12-1800-8-3-0002','USD',51.94,51.94,16.84,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,24),(18,'13-1072-7-1-0229','USD',51.94,51.94,16.51,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,26),(19,'13-1072-7-2-0229','USD',51.94,51.94,16.51,2,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,27),(20,'13-1072-7-3-0229','USD',51.94,51.94,16.51,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,28),(21,'14-1073-7-1-0227','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,30),(22,'14-1073-7-2-0227','USD',45.44,45.44,12.70,2,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,31),(23,'14-1073-7-3-0227','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,32),(24,'12-1079-7-2-0227','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,34),(25,'12-1079-7-3-0227','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,35),(26,'15-1070-7-2-0227','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,37),(27,'15-1070-7-3-0227','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:32','2014-11-12 05:25:32',1,38),(28,'19-1076-8-1-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,40),(29,'19-1076-8-2-0002','USD',38.94,38.94,10.88,2,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,41),(30,'19-1076-8-3-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,42),(31,'15-1070-8-2-0017','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,44),(32,'15-1070-8-3-0017','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,45),(33,'12-1079-8-2-0017','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,47),(34,'12-1079-8-3-0017','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,48),(35,'15-1060-7-1-0002','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,50),(36,'15-1060-7-2-0002','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,51),(37,'15-1060-7-3-0002','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,52),(38,'15-1060-7-4-0002','USD',51.94,51.94,14.98,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,53),(39,'13-1061-7-1-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,55),(40,'13-1061-7-2-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,56),(41,'13-1061-7-3-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,57),(42,'13-1061-7-4-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,58),(43,'12-1059-8-1-0002','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,60),(44,'12-1059-8-2-0002','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:33','2014-11-12 05:25:33',1,61),(45,'12-1059-8-3-0002','USD',45.44,45.44,12.70,2,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,62),(46,'14-1053-8-1-0002','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,64),(47,'14-1053-8-2-0002','USD',45.44,45.44,12.70,2,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,65),(48,'14-1053-8-3-0002','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,66),(49,'16-1054-8-1-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,68),(50,'16-1054-8-2-0002','USD',38.94,38.94,10.88,2,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,69),(51,'16-1054-8-3-0002','USD',38.94,38.94,10.88,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,70),(52,'11-1056-8-1-0002','USD',23.34,23.34,6.83,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,72),(53,'11-1056-8-2-0002','USD',23.34,23.34,6.83,2,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,73),(54,'11-1056-8-3-0002','USD',23.34,23.34,6.83,2,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,74),(55,'12-1000-9-1-0002','USD',12.94,12.94,4.29,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,76),(56,'12-1000-9-2-0002','USD',12.94,12.94,4.29,2,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,77),(57,'12-1000-9-3-0002','USD',12.94,12.94,4.29,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,78),(58,'11-1007-9-1-0002','USD',6.44,6.44,1.81,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,80),(59,'11-1007-9-2-0002','USD',6.44,6.44,1.81,2,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,81),(60,'11-1007-9-3-0002','USD',6.44,6.44,1.81,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,82),(61,'12-1250-8-2-0002','USD',51.94,51.94,16.34,1,NULL,NULL,'2014-11-12 05:25:34','2014-11-12 05:25:34',1,84),(62,'12-1250-8-3-0002','USD',51.94,51.94,16.34,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,85),(63,'15-1251-8-2-0002','USD',64.94,64.94,18.16,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,87),(64,'15-1251-8-3-0002','USD',64.94,64.94,18.16,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,88),(65,'14-1253-8-1-0002','USD',51.94,51.94,14.52,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,90),(66,'14-1253-8-2-0002','USD',51.94,51.94,14.52,2,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,91),(67,'14-1253-8-3-0002','USD',51.94,51.94,14.52,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,92),(68,'12-1417-8-2-0002','USD',77.94,77.94,24.25,0,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,94),(69,'15-2201-7-1-0002','USD',116.94,116.94,34.45,0,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,96),(70,'15-2201-7-2-0002','USD',116.94,116.94,34.45,0,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,97),(71,'15-2201-7-3-0002','USD',116.94,116.94,34.45,0,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,98),(72,'14-2202-8-1-0002','USD',84.44,84.44,25.70,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,100),(73,'14-2202-8-2-0002','USD',84.44,84.44,25.70,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,101),(74,'14-2202-8-3-0002','USD',84.44,84.44,25.70,2,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,102),(75,'28-4810-0-2-0001','USD',10.34,10.34,3.91,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,104),(76,'28-4810-0-4-0001','USD',10.34,10.34,3.91,1,NULL,NULL,'2014-11-12 05:25:35','2014-11-12 05:25:35',1,105),(77,'23-4622-0-1-0193','USD',18.14,18.14,5.36,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,107),(78,'23-4622-0-2-0193','USD',18.14,18.14,5.36,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,108),(79,'23-4622-0-3-0198','USD',18.14,18.14,5.36,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,109),(80,'23-4622-0-4-0198','USD',18.14,18.14,5.36,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,110),(81,'21-4010-7-1-0184','USD',12.94,12.94,3.60,2,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,112),(82,'21-4010-7-2-0184','USD',12.94,12.94,3.60,2,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,113),(83,'21-4012-8-2-0184','USD',18.14,18.14,5.10,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,115),(84,'21-4012-8-3-0184','USD',18.14,18.14,5.10,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,116),(85,'21-4012-8-4-0184','USD',18.14,18.14,5.10,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,117),(86,'21-4020-7-1-0233','USD',15.54,15.54,4.33,0,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,119),(87,'21-4020-7-2-0233','USD',15.54,15.54,4.33,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,120),(88,'21-4020-8-2-0232','USD',15.54,15.54,4.33,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,122),(89,'21-4020-8-3-0232','USD',15.54,15.54,4.33,0,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,123),(90,'12-2110-7-3-0002','USD',51.94,51.94,15.43,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,125),(91,'12-2110-7-2-0002','USD',51.94,51.94,15.43,2,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,126),(92,'12-2110-7-1-0002','USD',51.94,51.94,15.43,1,NULL,NULL,'2014-11-12 05:25:36','2014-11-12 05:25:36',1,127),(93,'13-2112-8-2-0002','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,129),(94,'13-2112-8-3-0002','USD',45.44,45.44,12.70,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,130),(95,'11-2111-7-3-0002','USD',25.94,25.94,7.70,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,132),(96,'12-2110-8-3-0002','USD',51.94,51.94,15.43,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,134),(97,'27-4711-7-2-0202','USD',25.94,25.94,8.45,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,136),(98,'27-4711-8-4-0202','USD',25.94,25.94,8.45,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,138),(99,'27-4724-0-2-0071','USD',12.94,12.94,4.29,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,140),(100,'27-4724-0-3-0071','USD',12.94,12.94,4.29,1,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,141),(101,'HA460-0006','USD',25.94,25.94,10.88,0,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,143),(102,'HA460-0015','USD',25.94,25.94,10.88,0,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,144),(103,'HA460-0018','USD',25.94,25.94,10.88,0,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,145),(104,'HA460-0442','USD',25.94,25.94,10.88,8,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:40',1,146),(105,'HA460-0443','USD',25.94,25.94,10.88,0,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,147),(106,'HA460-0445','USD',25.94,25.94,10.88,32,NULL,NULL,'2014-11-12 05:25:37','2014-11-12 05:25:37',1,148),(107,'HA620-0XXX','USD',22.04,22.04,6.79,16,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,150),(108,'HA110-0285','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,152),(109,'HA110-0390','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,153),(110,'HA621-0224','USD',22.04,22.04,6.79,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,155),(111,'HA110-0477','USD',19.44,19.44,6.33,0,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,156),(112,'HA110-0475','USD',19.44,19.44,6.33,0,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,157),(113,'HA110-0470','USD',19.44,19.44,6.33,0,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,158),(114,'HA110-0472','USD',19.44,19.44,6.33,0,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,159),(115,'HA110-0219','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,160),(116,'HA110-0220','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,161),(117,'HA110-0252','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,162),(118,'HA100-0001','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,164),(119,'HA100-0004','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,165),(120,'HA100-0015','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,166),(121,'HA100-0018','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,167),(122,'HA110-0415','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,168),(123,'HA110-0436','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,169),(124,'HA110-0419','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,170),(125,'HA110-0425','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,171),(126,'HA110-0438','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:38','2014-11-12 05:25:38',1,172),(127,'HA110-0346','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,173),(128,'HA110-0349','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,174),(129,'HA110-0413','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,175),(130,'HA110-0143','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,176),(131,'HA110-0133','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,177),(132,'HA110-0158','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,178),(133,'HA110-0169','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,179),(134,'HA110-0154','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,180),(135,'HA110-0162','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,181),(136,'HA110-0234','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,182),(137,'HA110-0155','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,183),(138,'HA110-0264','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,184),(139,'HA110-0258','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,185),(140,'HA110-0242','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,186),(141,'HA110-0317','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,187),(142,'HA110-0385','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,188),(143,'HA110-0387','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,189),(144,'HA110-0171','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,190),(145,'HA110-0362','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,191),(146,'HA110-0388','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,192),(147,'HA110-0400','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,193),(148,'HA110-0410','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,194),(149,'HA110-0406','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:39','2014-11-12 05:25:39',1,195),(150,'HA110-0407','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,196),(151,'HA110-0271 ','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,197),(152,'HA110-0275','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,198),(153,'HA110-0135','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,199),(154,'HA450-0002','USD',20.74,20.74,6.57,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,201),(155,'HA450-0465','USD',20.74,20.74,6.57,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,202),(156,'HA450-0466','USD',20.74,20.74,6.57,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,203),(157,'HA651-0002','USD',12.94,12.94,4.23,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,205),(158,'HA651-0463','USD',12.94,12.94,4.23,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,206),(159,'HA651-0464','USD',12.94,12.94,4.23,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,207),(160,'HA460-0002','USD',25.94,25.94,10.88,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,208),(161,'HA460-0444','USD',25.94,25.94,10.88,0,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,209),(162,'HA660-0377','USD',22.04,22.04,8.19,8,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,211),(163,'HA660-0452','USD',22.04,22.04,8.19,8,1,NULL,'2014-11-12 05:25:40','2014-11-12 23:06:22',1,212),(164,'HA640-0122','USD',19.44,19.44,5.42,8,NULL,NULL,'2014-11-12 05:25:40','2014-11-12 05:25:40',1,214),(165,'HA630-0252','USD',12.94,12.94,4.29,0,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,216),(166,'HA610-0002','USD',31.14,31.14,10.88,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,218),(167,'HA210-0347','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,220),(168,'HA210-0432','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,221),(169,'HA210-0416','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,222),(170,'HA210-0418','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,223),(171,'HA210-0411','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,224),(172,'HA210-0405','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,225),(173,'HA200-0029','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,226),(174,'HA210-0125','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,227),(175,'HA210-0147','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,228),(176,'HA200-0002','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,230),(177,'HA200-0006','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,231),(178,'HA200-0020','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,232),(179,'HA620-0233','USD',22.04,22.04,6.79,0,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,233),(180,'HA620-0436','USD',22.04,22.04,6.79,0,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,234),(181,'HA410-0489','USD',22.04,22.04,6.79,0,NULL,NULL,'2014-11-12 05:25:41','2014-11-12 05:25:41',1,236),(182,'HA210-0368','USD',31.14,31.14,9.97,8,NULL,NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,237),(183,'HA120-0371','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,239),(184,'HA120-0392','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,240),(185,'HA120-0202','USD',19.44,19.44,6.33,8,NULL,NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,241),(186,'HA621-0328','USD',22.04,22.04,6.79,0,NULL,NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,242),(187,'HA220-0298','USD',28.54,28.54,9.97,8,NULL,NULL,'2014-11-12 05:25:42','2014-11-12 05:25:42',1,244);
/*!40000 ALTER TABLE `partner_stockrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_bankcard`
--

DROP TABLE IF EXISTS `payment_bankcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_bankcard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_type` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(32) NOT NULL,
  `expiry_date` date NOT NULL,
  `partner_reference` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_bankcard_e8701ad4` (`user_id`),
  CONSTRAINT `payment_bankcard_user_id_2fbace85ccaf6406_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_bankcard`
--

LOCK TABLES `payment_bankcard` WRITE;
/*!40000 ALTER TABLE `payment_bankcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_bankcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_source`
--

DROP TABLE IF EXISTS `payment_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency` varchar(12) NOT NULL,
  `amount_allocated` decimal(12,2) NOT NULL,
  `amount_debited` decimal(12,2) NOT NULL,
  `amount_refunded` decimal(12,2) NOT NULL,
  `reference` varchar(128) NOT NULL,
  `label` varchar(128) NOT NULL,
  `order_id` int(11) NOT NULL,
  `source_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_source_69dfcb07` (`order_id`),
  KEY `payment_source_ed5cb66b` (`source_type_id`),
  CONSTRAINT `payment_source_order_id_7b79e8c352550a9f_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `payment_source_type_id_7c2576fef8fe5b73_fk_payment_sourcetype_id` FOREIGN KEY (`source_type_id`) REFERENCES `payment_sourcetype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_source`
--

LOCK TABLES `payment_source` WRITE;
/*!40000 ALTER TABLE `payment_source` DISABLE KEYS */;
INSERT INTO `payment_source` VALUES (1,'USD',22.04,22.04,0.00,'','',1,1);
/*!40000 ALTER TABLE `payment_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_sourcetype`
--

DROP TABLE IF EXISTS `payment_sourcetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_sourcetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_sourcetype`
--

LOCK TABLES `payment_sourcetype` WRITE;
/*!40000 ALTER TABLE `payment_sourcetype` DISABLE KEYS */;
INSERT INTO `payment_sourcetype` VALUES (1,'PayPal','paypal');
/*!40000 ALTER TABLE `payment_sourcetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_transaction`
--

DROP TABLE IF EXISTS `payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `txn_type` varchar(128) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `reference` varchar(128) NOT NULL,
  `status` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  `source_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_transaction_0afd9202` (`source_id`),
  CONSTRAINT `payment_transact_source_id_62a77f3472114bb9_fk_payment_source_id` FOREIGN KEY (`source_id`) REFERENCES `payment_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transaction`
--

LOCK TABLES `payment_transaction` WRITE;
/*!40000 ALTER TABLE `payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paypal_expresstransaction`
--

DROP TABLE IF EXISTS `paypal_expresstransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_expresstransaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raw_request` longtext NOT NULL,
  `raw_response` longtext NOT NULL,
  `response_time` double NOT NULL,
  `date_created` datetime NOT NULL,
  `method` varchar(32) NOT NULL,
  `version` varchar(8) NOT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `currency` varchar(8) DEFAULT NULL,
  `ack` varchar(32) NOT NULL,
  `correlation_id` varchar(32) DEFAULT NULL,
  `token` varchar(32) DEFAULT NULL,
  `error_code` varchar(32) DEFAULT NULL,
  `error_message` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paypal_expresstransaction`
--

LOCK TABLES `paypal_expresstransaction` WRITE;
/*!40000 ALTER TABLE `paypal_expresstransaction` DISABLE KEYS */;
INSERT INTO `paypal_expresstransaction` VALUES (1,'L_PAYMENTREQUEST_0_QTY1=1&L_PAYMENTREQUEST_0_QTY0=1&MAXAMT=50.58&L_SHIPPINGOPTIONNAME0=Free+shipping&L_PAYMENTREQUEST_0_DESC1=&L_PAYMENTREQUEST_0_DESC0=&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&L_SHIPPINGOPTIONISDEFAULT0=true&EMAIL=josh%40halfnibble.com&ALLOWNOTE=1&CALLBACKTIMEOUT=3&PAYMENTREQUEST_0_AMT=50.58&L_SHIPPINGOPTIONAMOUNT0=0.00&PAYMENTREQUEST_0_HANDLINGAMT=0.00&PAYMENTREQUEST_0_TAXAMT=0.00&METHOD=SetExpressCheckout&PAYMENTREQUEST_0_ITEMAMT=50.58&RETURNURL=https%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fpreview%2F1%2F&L_PAYMENTREQUEST_0_NAME0=HAD+Hadmask+&PAYMENTREQUEST_0_CURRENCYCODE=GBP&L_PAYMENTREQUEST_0_NAME1=HAD+Kids+&VERSION=88.0&PAYMENTREQUEST_0_MAXAMT=50.58&L_PAYMENTREQUEST_0_AMT1=19.44&L_PAYMENTREQUEST_0_AMT0=31.14&L_PAYMENTREQUEST_0_NUMBER1=HA120-0392&L_PAYMENTREQUEST_0_NUMBER0=HA610-0002&CALLBACK=https%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fshipping-options%2F1%2F&PWD=VUHY7BUTHYGPQH77&PAYMENTREQUEST_0_PAYMENTACTION=Sale&PAYMENTREQUEST_0_SHIPPINGAMT=0.00&CANCELURL=https%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fcancel%2F1%2F','TOKEN=EC%2d3G669714KF631044A&TIMESTAMP=2014%2d11%2d12T19%3a37%3a41Z&CORRELATIONID=36dc4e0210f2d&ACK=Success&VERSION=88%2e0&BUILD=13630372',795.689105987549,'2014-11-12 19:37:41','SetExpressCheckout','88.0',50.58,'GBP','Success','36dc4e0210f2d','EC-3G669714KF631044A',NULL,NULL),(2,'PAYMENTREQUEST_0_ITEMAMT=19.44&L_PAYMENTREQUEST_0_QTY0=1&MAXAMT=19.44&RETURNURL=http%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fpreview%2F2%2F&L_PAYMENTREQUEST_0_NAME0=HAD+Kids+&L_PAYMENTREQUEST_0_DESC0=&PAYMENTREQUEST_0_CURRENCYCODE=USD&VERSION=88.0&USER=josh_api1.halfnibble.com&PAYMENTREQUEST_0_TAXAMT=0.00&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&PAYMENTREQUEST_0_MAXAMT=19.44&L_SHIPPINGOPTIONISDEFAULT0=true&L_PAYMENTREQUEST_0_AMT0=19.44&EMAIL=josh%40halfnibble.com&L_SHIPPINGOPTIONNAME0=Free+shipping&L_PAYMENTREQUEST_0_NUMBER0=HA120-0392&CALLBACK=http%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fshipping-options%2F2%2F&ALLOWNOTE=1&CALLBACKTIMEOUT=3&PAYMENTREQUEST_0_AMT=19.44&L_SHIPPINGOPTIONAMOUNT0=0.00&PWD=VUHY7BUTHYGPQH77&PAYMENTREQUEST_0_PAYMENTACTION=Sale&PAYMENTREQUEST_0_SHIPPINGAMT=0.00&CANCELURL=http%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fcancel%2F2%2F&PAYMENTREQUEST_0_HANDLINGAMT=0.00&METHOD=SetExpressCheckout','TOKEN=EC%2d77U300349T7285030&TIMESTAMP=2014%2d11%2d12T21%3a22%3a38Z&CORRELATIONID=ceb201b87721c&ACK=Success&VERSION=88%2e0&BUILD=13630372',562.246799468994,'2014-11-12 21:22:39','SetExpressCheckout','88.0',19.44,'USD','Success','ceb201b87721c','EC-77U300349T7285030',NULL,NULL),(3,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-77U300349T7285030&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d77U300349T7285030&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T21%3a23%3a21Z&CORRELATIONID=b9feabac9f9d5&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=19%2e44&ITEMAMT=19%2e44&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Kids%20&L_NUMBER0=HA120%2d0392&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=19%2e44&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=19%2e44&PAYMENTREQUEST_0_ITEMAMT=19%2e44&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Kids%20&L_PAYMENTREQUEST_0_NUMBER0=HA120%2d0392&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=19%2e44&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',333.794116973877,'2014-11-12 21:23:22','GetExpressCheckoutDetails','88.0',19.44,'USD','Success','b9feabac9f9d5','EC-77U300349T7285030',NULL,NULL),(4,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-77U300349T7285030&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d77U300349T7285030&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T21%3a28%3a34Z&CORRELATIONID=a18ee9716a88d&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=19%2e44&ITEMAMT=19%2e44&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Kids%20&L_NUMBER0=HA120%2d0392&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=19%2e44&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=19%2e44&PAYMENTREQUEST_0_ITEMAMT=19%2e44&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Kids%20&L_PAYMENTREQUEST_0_NUMBER0=HA120%2d0392&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=19%2e44&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',408.192157745361,'2014-11-12 21:28:34','GetExpressCheckoutDetails','88.0',19.44,'USD','Success','a18ee9716a88d','EC-77U300349T7285030',NULL,NULL),(5,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-77U300349T7285030&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d77U300349T7285030&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T21%3a36%3a53Z&CORRELATIONID=e2ec7a7890dfa&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=19%2e44&ITEMAMT=19%2e44&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Kids%20&L_NUMBER0=HA120%2d0392&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=19%2e44&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=19%2e44&PAYMENTREQUEST_0_ITEMAMT=19%2e44&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Kids%20&L_PAYMENTREQUEST_0_NUMBER0=HA120%2d0392&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=19%2e44&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',435.472011566162,'2014-11-12 21:36:54','GetExpressCheckoutDetails','88.0',19.44,'USD','Success','e2ec7a7890dfa','EC-77U300349T7285030',NULL,NULL),(6,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-77U300349T7285030&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d77U300349T7285030&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T21%3a36%3a54Z&CORRELATIONID=b20e25a7e7d4f&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=19%2e44&ITEMAMT=19%2e44&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Kids%20&L_NUMBER0=HA120%2d0392&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=19%2e44&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=19%2e44&PAYMENTREQUEST_0_ITEMAMT=19%2e44&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Kids%20&L_PAYMENTREQUEST_0_NUMBER0=HA120%2d0392&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=19%2e44&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',369.136095046997,'2014-11-12 21:36:54','GetExpressCheckoutDetails','88.0',19.44,'USD','Success','b20e25a7e7d4f','EC-77U300349T7285030',NULL,NULL),(7,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-77U300349T7285030&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d77U300349T7285030&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T21%3a39%3a16Z&CORRELATIONID=baac0cdf8b4df&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=19%2e44&ITEMAMT=19%2e44&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Kids%20&L_NUMBER0=HA120%2d0392&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=19%2e44&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=19%2e44&PAYMENTREQUEST_0_ITEMAMT=19%2e44&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Kids%20&L_PAYMENTREQUEST_0_NUMBER0=HA120%2d0392&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=19%2e44&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',390.780925750732,'2014-11-12 21:39:17','GetExpressCheckoutDetails','88.0',19.44,'USD','Success','baac0cdf8b4df','EC-77U300349T7285030',NULL,NULL),(8,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-77U300349T7285030&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d77U300349T7285030&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T21%3a43%3a45Z&CORRELATIONID=2d8a7745267d9&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=19%2e44&ITEMAMT=19%2e44&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Kids%20&L_NUMBER0=HA120%2d0392&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=19%2e44&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=19%2e44&PAYMENTREQUEST_0_ITEMAMT=19%2e44&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Kids%20&L_PAYMENTREQUEST_0_NUMBER0=HA120%2d0392&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=19%2e44&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',434.531927108765,'2014-11-12 21:43:45','GetExpressCheckoutDetails','88.0',19.44,'USD','Success','2d8a7745267d9','EC-77U300349T7285030',NULL,NULL),(9,'PAYMENTREQUEST_0_ITEMAMT=22.04&L_PAYMENTREQUEST_0_QTY0=1&MAXAMT=22.04&RETURNURL=http%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fpreview%2F3%2F&L_PAYMENTREQUEST_0_NAME0=HAD+Primaloft+&L_PAYMENTREQUEST_0_DESC0=&PAYMENTREQUEST_0_CURRENCYCODE=USD&VERSION=88.0&USER=josh_api1.halfnibble.com&PAYMENTREQUEST_0_TAXAMT=0.00&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&PAYMENTREQUEST_0_MAXAMT=22.04&L_SHIPPINGOPTIONISDEFAULT0=true&L_PAYMENTREQUEST_0_AMT0=22.04&EMAIL=josh%40halfnibble.com&L_SHIPPINGOPTIONNAME0=Free+shipping&L_PAYMENTREQUEST_0_NUMBER0=HA660-0452&CALLBACK=http%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fshipping-options%2F3%2F&ALLOWNOTE=1&CALLBACKTIMEOUT=3&PAYMENTREQUEST_0_AMT=22.04&L_SHIPPINGOPTIONAMOUNT0=0.00&PWD=VUHY7BUTHYGPQH77&PAYMENTREQUEST_0_PAYMENTACTION=Sale&PAYMENTREQUEST_0_SHIPPINGAMT=0.00&CANCELURL=http%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fcancel%2F3%2F&PAYMENTREQUEST_0_HANDLINGAMT=0.00&METHOD=SetExpressCheckout','TOKEN=EC%2d44A0774911417601F&TIMESTAMP=2014%2d11%2d12T23%3a05%3a22Z&CORRELATIONID=decdc353cc07&ACK=Success&VERSION=88%2e0&BUILD=13630372',622.985124588013,'2014-11-12 23:05:22','SetExpressCheckout','88.0',22.04,'USD','Success','decdc353cc07','EC-44A0774911417601F',NULL,NULL),(10,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-44A0774911417601F&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d44A0774911417601F&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T23%3a06%3a09Z&CORRELATIONID=94d03b13bcdf2&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=22%2e04&ITEMAMT=22%2e04&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Primaloft%20&L_NUMBER0=HA660%2d0452&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=22%2e04&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=22%2e04&PAYMENTREQUEST_0_ITEMAMT=22%2e04&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Primaloft%20&L_PAYMENTREQUEST_0_NUMBER0=HA660%2d0452&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=22%2e04&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',381.886959075928,'2014-11-12 23:06:10','GetExpressCheckoutDetails','88.0',22.04,'USD','Success','94d03b13bcdf2','EC-44A0774911417601F',NULL,NULL),(11,'PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&TOKEN=EC-44A0774911417601F&METHOD=GetExpressCheckoutDetails','TOKEN=EC%2d44A0774911417601F&BILLINGAGREEMENTACCEPTEDSTATUS=0&CHECKOUTSTATUS=PaymentActionNotInitiated&TIMESTAMP=2014%2d11%2d12T23%3a06%3a20Z&CORRELATIONID=69869712deca8&ACK=Success&VERSION=88%2e0&BUILD=13630372&EMAIL=dr%2ejoshuaw%2dbuyer%40gmail%2ecom&PAYERID=8MD4B4CQASRRQ&PAYERSTATUS=verified&FIRSTNAME=Test&LASTNAME=Buyer&COUNTRYCODE=US&SHIPTONAME=Test%20Buyer&SHIPTOSTREET=1%20Main%20St&SHIPTOCITY=San%20Jose&SHIPTOSTATE=CA&SHIPTOZIP=95131&SHIPTOCOUNTRYCODE=US&SHIPTOCOUNTRYNAME=United%20States&ADDRESSSTATUS=Confirmed&CURRENCYCODE=USD&AMT=22%2e04&ITEMAMT=22%2e04&SHIPPINGAMT=0%2e00&HANDLINGAMT=0%2e00&TAXAMT=0%2e00&INSURANCEAMT=0%2e00&SHIPDISCAMT=0%2e00&INSURANCEOPTIONOFFERED=false&L_NAME0=HAD%20Primaloft%20&L_NUMBER0=HA660%2d0452&L_QTY0=1&L_TAXAMT0=0%2e00&L_AMT0=22%2e04&L_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_ITEMHEIGHTVALUE0=%20%20%200%2e00000&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTREQUEST_0_CURRENCYCODE=USD&PAYMENTREQUEST_0_AMT=22%2e04&PAYMENTREQUEST_0_ITEMAMT=22%2e04&PAYMENTREQUEST_0_SHIPPINGAMT=0%2e00&PAYMENTREQUEST_0_HANDLINGAMT=0%2e00&PAYMENTREQUEST_0_TAXAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEAMT=0%2e00&PAYMENTREQUEST_0_SHIPDISCAMT=0%2e00&PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED=false&PAYMENTREQUEST_0_SHIPTONAME=Test%20Buyer&PAYMENTREQUEST_0_SHIPTOSTREET=1%20Main%20St&PAYMENTREQUEST_0_SHIPTOCITY=San%20Jose&PAYMENTREQUEST_0_SHIPTOSTATE=CA&PAYMENTREQUEST_0_SHIPTOZIP=95131&PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE=US&PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME=United%20States&PAYMENTREQUEST_0_ADDRESSSTATUS=Confirmed&L_PAYMENTREQUEST_0_NAME0=HAD%20Primaloft%20&L_PAYMENTREQUEST_0_NUMBER0=HA660%2d0452&L_PAYMENTREQUEST_0_QTY0=1&L_PAYMENTREQUEST_0_TAXAMT0=0%2e00&L_PAYMENTREQUEST_0_AMT0=22%2e04&L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0=%20%20%200%2e00000&L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0=%20%20%200%2e00000&PAYMENTREQUESTINFO_0_ERRORCODE=0',359.246969223022,'2014-11-12 23:06:20','GetExpressCheckoutDetails','88.0',22.04,'USD','Success','69869712deca8','EC-44A0774911417601F',NULL,NULL),(12,'PAYMENTREQUEST_0_PAYMENTACTION=Sale&PAYERID=8MD4B4CQASRRQ&PAYMENTREQUEST_0_CURRENCYCODE=USD&TOKEN=EC-44A0774911417601F&PAYMENTREQUEST_0_AMT=22.04&PWD=VUHY7BUTHYGPQH77&VERSION=88.0&USER=josh_api1.halfnibble.com&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AsV9PvABMKmre1LfhEbx3OZNtvI4&METHOD=DoExpressCheckoutPayment','TOKEN=EC%2d44A0774911417601F&SUCCESSPAGEREDIRECTREQUESTED=false&TIMESTAMP=2014%2d11%2d12T23%3a06%3a21Z&CORRELATIONID=e379c38650322&ACK=Success&VERSION=88%2e0&BUILD=13630372&SHIPPINGCALCULATIONMODE=FlatRate&INSURANCEOPTIONSELECTED=false&SHIPPINGOPTIONISDEFAULT=true&SHIPPINGOPTIONAMOUNT=0%2e00&SHIPPINGOPTIONNAME=Free%20shipping&PAYMENTINFO_0_TRANSACTIONID=4HL63891311080215&PAYMENTINFO_0_TRANSACTIONTYPE=expresscheckout&PAYMENTINFO_0_PAYMENTTYPE=instant&PAYMENTINFO_0_ORDERTIME=2014%2d11%2d12T23%3a06%3a21Z&PAYMENTINFO_0_AMT=22%2e04&PAYMENTINFO_0_FEEAMT=0%2e94&PAYMENTINFO_0_TAXAMT=0%2e00&PAYMENTINFO_0_CURRENCYCODE=USD&PAYMENTINFO_0_PAYMENTSTATUS=Completed&PAYMENTINFO_0_PENDINGREASON=None&PAYMENTINFO_0_REASONCODE=None&PAYMENTINFO_0_PROTECTIONELIGIBILITY=Eligible&PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE=ItemNotReceivedEligible%2cUnauthorizedPaymentEligible&PAYMENTINFO_0_SECUREMERCHANTACCOUNTID=ZRPRTRJE6YMRY&PAYMENTINFO_0_ERRORCODE=0&PAYMENTINFO_0_ACK=Success',1478.55091094971,'2014-11-12 23:06:22','DoExpressCheckoutPayment','88.0',22.04,'USD','Success','e379c38650322','EC-44A0774911417601F',NULL,NULL);
/*!40000 ALTER TABLE `paypal_expresstransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paypal_payflowtransaction`
--

DROP TABLE IF EXISTS `paypal_payflowtransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_payflowtransaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raw_request` longtext NOT NULL,
  `raw_response` longtext NOT NULL,
  `response_time` double NOT NULL,
  `date_created` datetime NOT NULL,
  `comment1` varchar(128) NOT NULL,
  `trxtype` varchar(12) NOT NULL,
  `tender` varchar(12) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `pnref` varchar(32) DEFAULT NULL,
  `ppref` varchar(32) DEFAULT NULL,
  `result` varchar(32) DEFAULT NULL,
  `respmsg` varchar(512) NOT NULL,
  `authcode` varchar(32) DEFAULT NULL,
  `cvv2match` varchar(12) DEFAULT NULL,
  `avsaddr` varchar(1) DEFAULT NULL,
  `avszip` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ppref` (`ppref`),
  KEY `paypal_payflowtransaction_58331255` (`comment1`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paypal_payflowtransaction`
--

LOCK TABLES `paypal_payflowtransaction` WRITE;
/*!40000 ALTER TABLE `paypal_payflowtransaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `paypal_payflowtransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_automaticproductlist`
--

DROP TABLE IF EXISTS `promotions_automaticproductlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_automaticproductlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `link_url` varchar(200) NOT NULL,
  `link_text` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `method` varchar(128) NOT NULL,
  `num_products` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_automaticproductlist`
--

LOCK TABLES `promotions_automaticproductlist` WRITE;
/*!40000 ALTER TABLE `promotions_automaticproductlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_automaticproductlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_handpickedproductlist`
--

DROP TABLE IF EXISTS `promotions_handpickedproductlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_handpickedproductlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `link_url` varchar(200) NOT NULL,
  `link_text` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_handpickedproductlist`
--

LOCK TABLES `promotions_handpickedproductlist` WRITE;
/*!40000 ALTER TABLE `promotions_handpickedproductlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_handpickedproductlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_image`
--

DROP TABLE IF EXISTS `promotions_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `link_url` varchar(200) NOT NULL,
  `image` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_image`
--

LOCK TABLES `promotions_image` WRITE;
/*!40000 ALTER TABLE `promotions_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_keywordpromotion`
--

DROP TABLE IF EXISTS `promotions_keywordpromotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_keywordpromotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `position` varchar(100) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `clicks` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `keyword` varchar(200) NOT NULL,
  `filter` varchar(200) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_keywordpromotion_417f1b1c` (`content_type_id`),
  CONSTRAINT `promo_content_type_id_5263f43817f7f542_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_keywordpromotion`
--

LOCK TABLES `promotions_keywordpromotion` WRITE;
/*!40000 ALTER TABLE `promotions_keywordpromotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_keywordpromotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_multiimage`
--

DROP TABLE IF EXISTS `promotions_multiimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_multiimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_multiimage`
--

LOCK TABLES `promotions_multiimage` WRITE;
/*!40000 ALTER TABLE `promotions_multiimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_multiimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_multiimage_images`
--

DROP TABLE IF EXISTS `promotions_multiimage_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_multiimage_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `multiimage_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `multiimage_id` (`multiimage_id`,`image_id`),
  KEY `promotions_multiimage_images_8f22ac31` (`multiimage_id`),
  KEY `promotions_multiimage_images_f33175e6` (`image_id`),
  CONSTRAINT `promotions_mult_image_id_43db841908b2f050_fk_promotions_image_id` FOREIGN KEY (`image_id`) REFERENCES `promotions_image` (`id`),
  CONSTRAINT `promo_multiimage_id_5c121d63478f73ce_fk_promotions_multiimage_id` FOREIGN KEY (`multiimage_id`) REFERENCES `promotions_multiimage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_multiimage_images`
--

LOCK TABLES `promotions_multiimage_images` WRITE;
/*!40000 ALTER TABLE `promotions_multiimage_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_multiimage_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_orderedproduct`
--

DROP TABLE IF EXISTS `promotions_orderedproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_orderedproduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_order` int(10) unsigned NOT NULL,
  `list_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `promotions_orderedproduct_list_id_37d6675dc717b620_uniq` (`list_id`,`product_id`),
  KEY `promotions_orderedproduct_4da3e820` (`list_id`),
  KEY `promotions_orderedproduct_9bea82de` (`product_id`),
  CONSTRAINT `list_id_444fecc458ce046a_fk_promotions_handpickedproductlist_id` FOREIGN KEY (`list_id`) REFERENCES `promotions_handpickedproductlist` (`id`),
  CONSTRAINT `promotions_or_product_id_cd28624cf774b34_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_orderedproduct`
--

LOCK TABLES `promotions_orderedproduct` WRITE;
/*!40000 ALTER TABLE `promotions_orderedproduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_orderedproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_orderedproductlist`
--

DROP TABLE IF EXISTS `promotions_orderedproductlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_orderedproductlist` (
  `handpickedproductlist_ptr_id` int(11) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `tabbed_block_id` int(11) NOT NULL,
  PRIMARY KEY (`handpickedproductlist_ptr_id`),
  KEY `promotions_orderedproductlist_1f46f425` (`tabbed_block_id`),
  CONSTRAINT `D7dc95a31fc510889dbe6b78d6be9adc` FOREIGN KEY (`handpickedproductlist_ptr_id`) REFERENCES `promotions_handpickedproductlist` (`id`),
  CONSTRAINT `pr_tabbed_block_id_161cbac03ca7677a_fk_promotions_tabbedblock_id` FOREIGN KEY (`tabbed_block_id`) REFERENCES `promotions_tabbedblock` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_orderedproductlist`
--

LOCK TABLES `promotions_orderedproductlist` WRITE;
/*!40000 ALTER TABLE `promotions_orderedproductlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_orderedproductlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_pagepromotion`
--

DROP TABLE IF EXISTS `promotions_pagepromotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_pagepromotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `position` varchar(100) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `clicks` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `page_url` varchar(128) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_pagepromotion_072c6e88` (`page_url`),
  KEY `promotions_pagepromotion_417f1b1c` (`content_type_id`),
  CONSTRAINT `promot_content_type_id_543b3d3d3af6caf_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_pagepromotion`
--

LOCK TABLES `promotions_pagepromotion` WRITE;
/*!40000 ALTER TABLE `promotions_pagepromotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_pagepromotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_rawhtml`
--

DROP TABLE IF EXISTS `promotions_rawhtml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_rawhtml` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `display_type` varchar(128) NOT NULL,
  `body` longtext NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_rawhtml`
--

LOCK TABLES `promotions_rawhtml` WRITE;
/*!40000 ALTER TABLE `promotions_rawhtml` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_rawhtml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_singleproduct`
--

DROP TABLE IF EXISTS `promotions_singleproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_singleproduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` longtext NOT NULL,
  `date_created` datetime NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_singleproduct_9bea82de` (`product_id`),
  CONSTRAINT `promotions_s_product_id_7ecad2f2be6785d6_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_singleproduct`
--

LOCK TABLES `promotions_singleproduct` WRITE;
/*!40000 ALTER TABLE `promotions_singleproduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_singleproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions_tabbedblock`
--

DROP TABLE IF EXISTS `promotions_tabbedblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions_tabbedblock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions_tabbedblock`
--

LOCK TABLES `promotions_tabbedblock` WRITE;
/*!40000 ALTER TABLE `promotions_tabbedblock` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions_tabbedblock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_productreview`
--

DROP TABLE IF EXISTS `reviews_productreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews_productreview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` smallint(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(75) NOT NULL,
  `homepage` varchar(200) NOT NULL,
  `status` smallint(6) NOT NULL,
  `total_votes` int(11) NOT NULL,
  `delta_votes` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reviews_productreview_product_id_2dbdd3287f68dc33_uniq` (`product_id`,`user_id`),
  KEY `reviews_productreview_979acfd1` (`delta_votes`),
  KEY `reviews_productreview_9bea82de` (`product_id`),
  KEY `reviews_productreview_e8701ad4` (`user_id`),
  CONSTRAINT `reviews_productreview_user_id_706f739ddcd1e789_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `reviews_prod_product_id_3d87cf5f0f9d099a_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_productreview`
--

LOCK TABLES `reviews_productreview` WRITE;
/*!40000 ALTER TABLE `reviews_productreview` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews_productreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_vote`
--

DROP TABLE IF EXISTS `reviews_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delta` smallint(6) NOT NULL,
  `date_created` datetime NOT NULL,
  `review_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reviews_vote_user_id_75acca213178559b_uniq` (`user_id`,`review_id`),
  KEY `reviews_vote_5bd2a989` (`review_id`),
  KEY `reviews_vote_e8701ad4` (`user_id`),
  CONSTRAINT `reviews_vote_user_id_67d2dce94046a805_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `reviews_vo_review_id_2924a65bdf9b082_fk_reviews_productreview_id` FOREIGN KEY (`review_id`) REFERENCES `reviews_productreview` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_vote`
--

LOCK TABLES `reviews_vote` WRITE;
/*!40000 ALTER TABLE `reviews_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_orderanditemcharges`
--

DROP TABLE IF EXISTS `shipping_orderanditemcharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_orderanditemcharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` longtext NOT NULL,
  `price_per_order` decimal(12,2) NOT NULL,
  `price_per_item` decimal(12,2) NOT NULL,
  `free_shipping_threshold` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_orderanditemcharges`
--

LOCK TABLES `shipping_orderanditemcharges` WRITE;
/*!40000 ALTER TABLE `shipping_orderanditemcharges` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_orderanditemcharges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_orderanditemcharges_countries`
--

DROP TABLE IF EXISTS `shipping_orderanditemcharges_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_orderanditemcharges_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderanditemcharges_id` int(11) NOT NULL,
  `country_id` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderanditemcharges_id` (`orderanditemcharges_id`,`country_id`),
  KEY `shipping_orderanditemcharges_countries_2e9e2d8d` (`orderanditemcharges_id`),
  KEY `shipping_orderanditemcharges_countries_93bfec8a` (`country_id`),
  CONSTRAINT `D4781fcfcea3dae82b272c91a62b305e` FOREIGN KEY (`orderanditemcharges_id`) REFERENCES `shipping_orderanditemcharges` (`id`),
  CONSTRAINT `shi_country_id_6427960716333ddc_fk_address_country_iso_3166_1_a2` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_orderanditemcharges_countries`
--

LOCK TABLES `shipping_orderanditemcharges_countries` WRITE;
/*!40000 ALTER TABLE `shipping_orderanditemcharges_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_orderanditemcharges_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_weightband`
--

DROP TABLE IF EXISTS `shipping_weightband`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_weightband` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upper_limit` decimal(12,3) NOT NULL,
  `charge` decimal(12,2) NOT NULL,
  `method_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_weightband_836f12fb` (`method_id`),
  CONSTRAINT `shipping_w_method_id_4ad1280fd58ce538_fk_shipping_weightbased_id` FOREIGN KEY (`method_id`) REFERENCES `shipping_weightbased` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_weightband`
--

LOCK TABLES `shipping_weightband` WRITE;
/*!40000 ALTER TABLE `shipping_weightband` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_weightband` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_weightbased`
--

DROP TABLE IF EXISTS `shipping_weightbased`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_weightbased` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` longtext NOT NULL,
  `default_weight` decimal(12,3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_weightbased`
--

LOCK TABLES `shipping_weightbased` WRITE;
/*!40000 ALTER TABLE `shipping_weightbased` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_weightbased` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_weightbased_countries`
--

DROP TABLE IF EXISTS `shipping_weightbased_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_weightbased_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weightbased_id` int(11) NOT NULL,
  `country_id` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `weightbased_id` (`weightbased_id`,`country_id`),
  KEY `shipping_weightbased_countries_30de71ed` (`weightbased_id`),
  KEY `shipping_weightbased_countries_93bfec8a` (`country_id`),
  CONSTRAINT `shipp_weightbased_id_584cd63ef43d6c55_fk_shipping_weightbased_id` FOREIGN KEY (`weightbased_id`) REFERENCES `shipping_weightbased` (`id`),
  CONSTRAINT `shi_country_id_357014e9a25eac38_fk_address_country_iso_3166_1_a2` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_weightbased_countries`
--

LOCK TABLES `shipping_weightbased_countries` WRITE;
/*!40000 ALTER TABLE `shipping_weightbased_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_weightbased_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumbnail_kvstore`
--

DROP TABLE IF EXISTS `thumbnail_kvstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbnail_kvstore` (
  `key` varchar(200) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumbnail_kvstore`
--

LOCK TABLES `thumbnail_kvstore` WRITE;
/*!40000 ALTER TABLE `thumbnail_kvstore` DISABLE KEYS */;
INSERT INTO `thumbnail_kvstore` VALUES ('sorl-thumbnail||image||0e5da9f33a76f2f4424548c9b4b1cdc4','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/bf/b6/bfb63579402f7e806f753f1dea2adc42.jpg\", \"size\": [200, 150]}'),('sorl-thumbnail||image||333d9bc5d06398a67bb04eb910e0936c','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"image_not_found.jpg\", \"size\": [400, 300]}'),('sorl-thumbnail||image||703902d69ceadbcc077fe481ec2060f4','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/17/d5/17d59725435216b0e455fcb9659a84f3.jpg\", \"size\": [100, 75]}'),('sorl-thumbnail||image||82d86649c337485d7ce16762750e524c','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ee/d6/eed6bcfd8732ca981f2d25a20233226c.jpg\", \"size\": [207, 155]}'),('sorl-thumbnail||image||8c49628853bc32a76a137c9ee14e9593','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/59/d3/59d3d8c74e03cbba3aed4051c18d6a8c.jpg\", \"size\": [400, 300]}'),('sorl-thumbnail||thumbnails||333d9bc5d06398a67bb04eb910e0936c','[\"82d86649c337485d7ce16762750e524c\"]');
/*!40000 ALTER TABLE `thumbnail_kvstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_voucher`
--

DROP TABLE IF EXISTS `voucher_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voucher_voucher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` varchar(128) NOT NULL,
  `usage` varchar(128) NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `num_basket_additions` int(10) unsigned NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `total_discount` decimal(12,2) NOT NULL,
  `date_created` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_voucher`
--

LOCK TABLES `voucher_voucher` WRITE;
/*!40000 ALTER TABLE `voucher_voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_voucher_offers`
--

DROP TABLE IF EXISTS `voucher_voucher_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voucher_voucher_offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucher_id` int(11) NOT NULL,
  `conditionaloffer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voucher_id` (`voucher_id`,`conditionaloffer_id`),
  KEY `voucher_voucher_offers_3e8639ee` (`voucher_id`),
  KEY `voucher_voucher_offers_a8841877` (`conditionaloffer_id`),
  CONSTRAINT `f0962885ad9ea319b17d8a3ab65b1bc0` FOREIGN KEY (`conditionaloffer_id`) REFERENCES `offer_conditionaloffer` (`id`),
  CONSTRAINT `voucher_vouche_voucher_id_18996085b5c7192c_fk_voucher_voucher_id` FOREIGN KEY (`voucher_id`) REFERENCES `voucher_voucher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_voucher_offers`
--

LOCK TABLES `voucher_voucher_offers` WRITE;
/*!40000 ALTER TABLE `voucher_voucher_offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher_voucher_offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_voucherapplication`
--

DROP TABLE IF EXISTS `voucher_voucherapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voucher_voucherapplication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` date NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `voucher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_voucherapplication_69dfcb07` (`order_id`),
  KEY `voucher_voucherapplication_e8701ad4` (`user_id`),
  KEY `voucher_voucherapplication_3e8639ee` (`voucher_id`),
  CONSTRAINT `voucher_voucherapplicat_user_id_6ab9212ced39aaa4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `voucher_voucherappli_order_id_5dcb3ce35f8e76d0_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `voucher_vouche_voucher_id_298aa75cf02a99a0_fk_voucher_voucher_id` FOREIGN KEY (`voucher_id`) REFERENCES `voucher_voucher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_voucherapplication`
--

LOCK TABLES `voucher_voucherapplication` WRITE;
/*!40000 ALTER TABLE `voucher_voucherapplication` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher_voucherapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists_line`
--

DROP TABLE IF EXISTS `wishlists_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlists_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `wishlist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wishlists_line_wishlist_id_53bbce7b453dfacc_uniq` (`wishlist_id`,`product_id`),
  KEY `wishlists_line_9bea82de` (`product_id`),
  KEY `wishlists_line_e2f8e270` (`wishlist_id`),
  CONSTRAINT `wishlists_li_product_id_470a9463fc5f5b83_fk_catalogue_product_id` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `wishlists__wishlist_id_6632a3c6e1ec8370_fk_wishlists_wishlist_id` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlists_wishlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists_line`
--

LOCK TABLES `wishlists_line` WRITE;
/*!40000 ALTER TABLE `wishlists_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlists_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists_wishlist`
--

DROP TABLE IF EXISTS `wishlists_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlists_wishlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` varchar(6) NOT NULL,
  `visibility` varchar(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `owner_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `wishlists_wishlist_5e7b1936` (`owner_id`),
  CONSTRAINT `wishlists_wishlist_owner_id_3033ec0075490f56_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists_wishlist`
--

LOCK TABLES `wishlists_wishlist` WRITE;
/*!40000 ALTER TABLE `wishlists_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlists_wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-12 15:44:14
