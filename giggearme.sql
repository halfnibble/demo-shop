-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: giggearme
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
  `iso_3166_1_numeric` smallint(5) unsigned DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `printable_name` varchar(128) NOT NULL,
  `is_shipping_country` tinyint(1) NOT NULL,
  `display_order` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`iso_3166_1_a2`),
  KEY `address_country_b5e16240` (`iso_3166_1_a3`),
  KEY `address_country_8b6fe3c8` (`iso_3166_1_numeric`),
  KEY `address_country_646b9833` (`is_shipping_country`),
  KEY `address_country_4a111361` (`display_order`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_country`
--

LOCK TABLES `address_country` WRITE;
/*!40000 ALTER TABLE `address_country` DISABLE KEYS */;
INSERT INTO `address_country` VALUES ('CA','CAN',124,'CANADA','Canada',0,0),('UM','UMI',581,'UNITED STATES MINOR OUTLYING ISLANDS','The United States Minor Outlying Islands',0,0),('US','USA',840,'UNITED STATES','The United States of America',0,0);
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
  `country_id` varchar(2) NOT NULL,
  `search_text` varchar(1000) NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `notes` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_default_for_shipping` tinyint(1) NOT NULL,
  `is_default_for_billing` tinyint(1) NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `hash` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_useraddress_hash_5ed42b378a494fa7_uniq` (`hash`,`user_id`),
  KEY `address_useraddress_d860be3c` (`country_id`),
  KEY `address_useraddress_6340c63c` (`user_id`),
  KEY `address_useraddress_a48079cd` (`hash`),
  CONSTRAINT `country_id_refs_iso_3166_1_a2_b6b93e9d` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`),
  CONSTRAINT `user_id_refs_id_90c915e2` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_useraddress`
--

LOCK TABLES `address_useraddress` WRITE;
/*!40000 ALTER TABLE `address_useraddress` DISABLE KEYS */;
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
  `product_id` int(11) NOT NULL,
  `num_views` int(10) unsigned NOT NULL,
  `num_basket_additions` int(10) unsigned NOT NULL,
  `num_purchases` int(10) unsigned NOT NULL,
  `score` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  KEY `analytics_productrecord_17d0e952` (`num_purchases`),
  CONSTRAINT `product_id_refs_id_98bd97db` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_productrecord`
--

LOCK TABLES `analytics_productrecord` WRITE;
/*!40000 ALTER TABLE `analytics_productrecord` DISABLE KEYS */;
INSERT INTO `analytics_productrecord` VALUES (25,1457,1,0,0,0),(26,1578,1,0,0,0),(27,1560,1,0,0,0);
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
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `analytics_userproductview_6340c63c` (`user_id`),
  KEY `analytics_userproductview_7f1b40ad` (`product_id`),
  CONSTRAINT `product_id_refs_id_c6addd6c` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `user_id_refs_id_b039759d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_userproductview`
--

LOCK TABLES `analytics_userproductview` WRITE;
/*!40000 ALTER TABLE `analytics_userproductview` DISABLE KEYS */;
INSERT INTO `analytics_userproductview` VALUES (30,1,1457,'2014-11-03 10:17:23'),(31,1,1578,'2014-11-03 10:17:35'),(32,1,1560,'2014-11-03 10:17:40');
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
  `user_id` int(11) NOT NULL,
  `num_product_views` int(10) unsigned NOT NULL,
  `num_basket_additions` int(10) unsigned NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `num_order_lines` int(10) unsigned NOT NULL,
  `num_order_items` int(10) unsigned NOT NULL,
  `total_spent` decimal(12,2) NOT NULL,
  `date_last_order` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `analytics_userrecord_4ccd916b` (`num_orders`),
  KEY `analytics_userrecord_88674d48` (`num_order_lines`),
  KEY `analytics_userrecord_9417d255` (`num_order_items`),
  CONSTRAINT `user_id_refs_id_eb0dd6ac` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_userrecord`
--

LOCK TABLES `analytics_userrecord` WRITE;
/*!40000 ALTER TABLE `analytics_userrecord` DISABLE KEYS */;
INSERT INTO `analytics_userrecord` VALUES (1,1,37,1,0,0,0,0.00,NULL);
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
  `user_id` int(11) NOT NULL,
  `query` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `analytics_usersearch_6340c63c` (`user_id`),
  KEY `analytics_usersearch_1f3ceafc` (`query`),
  CONSTRAINT `user_id_refs_id_c8789796` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
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
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add flat page',8,'add_flatpage'),(23,'Can change flat page',8,'change_flatpage'),(24,'Can delete flat page',8,'delete_flatpage'),(25,'Can add migration history',9,'add_migrationhistory'),(26,'Can change migration history',9,'change_migrationhistory'),(27,'Can delete migration history',9,'delete_migrationhistory'),(28,'Can add kv store',10,'add_kvstore'),(29,'Can change kv store',10,'change_kvstore'),(30,'Can delete kv store',10,'delete_kvstore'),(31,'Can add Email',11,'add_email'),(32,'Can change Email',11,'change_email'),(33,'Can delete Email',11,'delete_email'),(34,'Can add Communication event type',12,'add_communicationeventtype'),(35,'Can change Communication event type',12,'change_communicationeventtype'),(36,'Can delete Communication event type',12,'delete_communicationeventtype'),(37,'Can add notification',13,'add_notification'),(38,'Can change notification',13,'change_notification'),(39,'Can delete notification',13,'delete_notification'),(40,'Can add product alert',14,'add_productalert'),(41,'Can change product alert',14,'change_productalert'),(42,'Can delete product alert',14,'delete_productalert'),(43,'Can add Product Recommendation',15,'add_productrecommendation'),(44,'Can change Product Recommendation',15,'change_productrecommendation'),(45,'Can delete Product Recommendation',15,'delete_productrecommendation'),(46,'Can add product brand',16,'add_productbrand'),(47,'Can change product brand',16,'change_productbrand'),(48,'Can delete product brand',16,'delete_productbrand'),(49,'Can add product activity',17,'add_productactivity'),(50,'Can change product activity',17,'change_productactivity'),(51,'Can delete product activity',17,'delete_productactivity'),(52,'Can add Product',18,'add_product'),(53,'Can change Product',18,'change_product'),(54,'Can delete Product',18,'delete_product'),(55,'Can add Product Class',19,'add_productclass'),(56,'Can change Product Class',19,'change_productclass'),(57,'Can delete Product Class',19,'delete_productclass'),(58,'Can add Category',20,'add_category'),(59,'Can change Category',20,'change_category'),(60,'Can delete Category',20,'delete_category'),(61,'Can add Product Category',21,'add_productcategory'),(62,'Can change Product Category',21,'change_productcategory'),(63,'Can delete Product Category',21,'delete_productcategory'),(64,'Can add Product Attribute',22,'add_productattribute'),(65,'Can change Product Attribute',22,'change_productattribute'),(66,'Can delete Product Attribute',22,'delete_productattribute'),(67,'Can add Product Attribute Value',23,'add_productattributevalue'),(68,'Can change Product Attribute Value',23,'change_productattributevalue'),(69,'Can delete Product Attribute Value',23,'delete_productattributevalue'),(70,'Can add Attribute Option Group',24,'add_attributeoptiongroup'),(71,'Can change Attribute Option Group',24,'change_attributeoptiongroup'),(72,'Can delete Attribute Option Group',24,'delete_attributeoptiongroup'),(73,'Can add Attribute Option',25,'add_attributeoption'),(74,'Can change Attribute Option',25,'change_attributeoption'),(75,'Can delete Attribute Option',25,'delete_attributeoption'),(76,'Can add Attribute Entity',26,'add_attributeentity'),(77,'Can change Attribute Entity',26,'change_attributeentity'),(78,'Can delete Attribute Entity',26,'delete_attributeentity'),(79,'Can add Attribute Entity Type',27,'add_attributeentitytype'),(80,'Can change Attribute Entity Type',27,'change_attributeentitytype'),(81,'Can delete Attribute Entity Type',27,'delete_attributeentitytype'),(82,'Can add Option',28,'add_option'),(83,'Can change Option',28,'change_option'),(84,'Can delete Option',28,'delete_option'),(85,'Can add Product Image',29,'add_productimage'),(86,'Can change Product Image',29,'change_productimage'),(87,'Can delete Product Image',29,'delete_productimage'),(88,'Can add Product record',30,'add_productrecord'),(89,'Can change Product record',30,'change_productrecord'),(90,'Can delete Product record',30,'delete_productrecord'),(91,'Can add User record',31,'add_userrecord'),(92,'Can change User record',31,'change_userrecord'),(93,'Can delete User record',31,'delete_userrecord'),(94,'Can add User product view',32,'add_userproductview'),(95,'Can change User product view',32,'change_userproductview'),(96,'Can delete User product view',32,'delete_userproductview'),(97,'Can add User search query',33,'add_usersearch'),(98,'Can change User search query',33,'change_usersearch'),(99,'Can delete User search query',33,'delete_usersearch'),(100,'Can add User address',34,'add_useraddress'),(101,'Can change User address',34,'change_useraddress'),(102,'Can delete User address',34,'delete_useraddress'),(103,'Can add Country',35,'add_country'),(104,'Can change Country',35,'change_country'),(105,'Can delete Country',35,'delete_country'),(106,'Can add Order and Item Charge',36,'add_orderanditemcharges'),(107,'Can change Order and Item Charge',36,'change_orderanditemcharges'),(108,'Can delete Order and Item Charge',36,'delete_orderanditemcharges'),(109,'Can add Weight-based Shipping Method',37,'add_weightbased'),(110,'Can change Weight-based Shipping Method',37,'change_weightbased'),(111,'Can delete Weight-based Shipping Method',37,'delete_weightbased'),(112,'Can add Weight Band',38,'add_weightband'),(113,'Can change Weight Band',38,'change_weightband'),(114,'Can delete Weight Band',38,'delete_weightband'),(115,'Can add Product review',39,'add_productreview'),(116,'Can change Product review',39,'change_productreview'),(117,'Can delete Product review',39,'delete_productreview'),(118,'Can add Vote',40,'add_vote'),(119,'Can change Vote',40,'change_vote'),(120,'Can delete Vote',40,'delete_vote'),(121,'Can add Fulfillment partner',41,'add_partner'),(122,'Can change Fulfillment partner',41,'change_partner'),(123,'Can delete Fulfillment partner',41,'delete_partner'),(124,'Can access dashboard',41,'dashboard_access'),(125,'Can add Partner address',42,'add_partneraddress'),(126,'Can change Partner address',42,'change_partneraddress'),(127,'Can delete Partner address',42,'delete_partneraddress'),(128,'Can add Stock record',43,'add_stockrecord'),(129,'Can change Stock record',43,'change_stockrecord'),(130,'Can delete Stock record',43,'delete_stockrecord'),(131,'Can add Stock Alert',44,'add_stockalert'),(132,'Can change Stock Alert',44,'change_stockalert'),(133,'Can delete Stock Alert',44,'delete_stockalert'),(134,'Can add Payment Event Quantity',45,'add_paymenteventquantity'),(135,'Can change Payment Event Quantity',45,'change_paymenteventquantity'),(136,'Can delete Payment Event Quantity',45,'delete_paymenteventquantity'),(137,'Can add Shipping Event Quantity',46,'add_shippingeventquantity'),(138,'Can change Shipping Event Quantity',46,'change_shippingeventquantity'),(139,'Can delete Shipping Event Quantity',46,'delete_shippingeventquantity'),(140,'Can add Order',47,'add_order'),(141,'Can change Order',47,'change_order'),(142,'Can delete Order',47,'delete_order'),(143,'Can add Order Note',48,'add_ordernote'),(144,'Can change Order Note',48,'change_ordernote'),(145,'Can delete Order Note',48,'delete_ordernote'),(146,'Can add Communication Event',49,'add_communicationevent'),(147,'Can change Communication Event',49,'change_communicationevent'),(148,'Can delete Communication Event',49,'delete_communicationevent'),(149,'Can add Shipping address',50,'add_shippingaddress'),(150,'Can change Shipping address',50,'change_shippingaddress'),(151,'Can delete Shipping address',50,'delete_shippingaddress'),(152,'Can add Billing address',51,'add_billingaddress'),(153,'Can change Billing address',51,'change_billingaddress'),(154,'Can delete Billing address',51,'delete_billingaddress'),(155,'Can add Order Line',52,'add_line'),(156,'Can change Order Line',52,'change_line'),(157,'Can delete Order Line',52,'delete_line'),(158,'Can add Line Price',53,'add_lineprice'),(159,'Can change Line Price',53,'change_lineprice'),(160,'Can delete Line Price',53,'delete_lineprice'),(161,'Can add Line Attribute',54,'add_lineattribute'),(162,'Can change Line Attribute',54,'change_lineattribute'),(163,'Can delete Line Attribute',54,'delete_lineattribute'),(164,'Can add Shipping Event',55,'add_shippingevent'),(165,'Can change Shipping Event',55,'change_shippingevent'),(166,'Can delete Shipping Event',55,'delete_shippingevent'),(167,'Can add Shipping Event Type',56,'add_shippingeventtype'),(168,'Can change Shipping Event Type',56,'change_shippingeventtype'),(169,'Can delete Shipping Event Type',56,'delete_shippingeventtype'),(170,'Can add Payment Event',57,'add_paymentevent'),(171,'Can change Payment Event',57,'change_paymentevent'),(172,'Can delete Payment Event',57,'delete_paymentevent'),(173,'Can add Payment Event Type',58,'add_paymenteventtype'),(174,'Can change Payment Event Type',58,'change_paymenteventtype'),(175,'Can delete Payment Event Type',58,'delete_paymenteventtype'),(176,'Can add Order Discount',59,'add_orderdiscount'),(177,'Can change Order Discount',59,'change_orderdiscount'),(178,'Can delete Order Discount',59,'delete_orderdiscount'),(179,'Can add Conditional offer',60,'add_conditionaloffer'),(180,'Can change Conditional offer',60,'change_conditionaloffer'),(181,'Can delete Conditional offer',60,'delete_conditionaloffer'),(182,'Can add Condition',61,'add_condition'),(183,'Can change Condition',61,'change_condition'),(184,'Can delete Condition',61,'delete_condition'),(185,'Can add Benefit',62,'add_benefit'),(186,'Can change Benefit',62,'change_benefit'),(187,'Can delete Benefit',62,'delete_benefit'),(188,'Can add Range',63,'add_range'),(189,'Can change Range',63,'change_range'),(190,'Can delete Range',63,'delete_range'),(191,'Can add range product',64,'add_rangeproduct'),(192,'Can change range product',64,'change_rangeproduct'),(193,'Can delete range product',64,'delete_rangeproduct'),(194,'Can add Count Condition',61,'add_countcondition'),(195,'Can change Count Condition',61,'change_countcondition'),(196,'Can delete Count Condition',61,'delete_countcondition'),(197,'Can add Coverage Condition',61,'add_coveragecondition'),(198,'Can change Coverage Condition',61,'change_coveragecondition'),(199,'Can delete Coverage Condition',61,'delete_coveragecondition'),(200,'Can add Value Condition',61,'add_valuecondition'),(201,'Can change Value Condition',61,'change_valuecondition'),(202,'Can delete Value Condition',61,'delete_valuecondition'),(203,'Can add Percentage discount benefit',62,'add_percentagediscountbenefit'),(204,'Can change Percentage discount benefit',62,'change_percentagediscountbenefit'),(205,'Can delete Percentage discount benefit',62,'delete_percentagediscountbenefit'),(206,'Can add Absolute discount benefit',62,'add_absolutediscountbenefit'),(207,'Can change Absolute discount benefit',62,'change_absolutediscountbenefit'),(208,'Can delete Absolute discount benefit',62,'delete_absolutediscountbenefit'),(209,'Can add Fixed price benefit',62,'add_fixedpricebenefit'),(210,'Can change Fixed price benefit',62,'change_fixedpricebenefit'),(211,'Can delete Fixed price benefit',62,'delete_fixedpricebenefit'),(212,'Can add Multibuy discount benefit',62,'add_multibuydiscountbenefit'),(213,'Can change Multibuy discount benefit',62,'change_multibuydiscountbenefit'),(214,'Can delete Multibuy discount benefit',62,'delete_multibuydiscountbenefit'),(215,'Can add shipping benefit',62,'add_shippingbenefit'),(216,'Can change shipping benefit',62,'change_shippingbenefit'),(217,'Can delete shipping benefit',62,'delete_shippingbenefit'),(218,'Can add Shipping absolute discount benefit',62,'add_shippingabsolutediscountbenefit'),(219,'Can change Shipping absolute discount benefit',62,'change_shippingabsolutediscountbenefit'),(220,'Can delete Shipping absolute discount benefit',62,'delete_shippingabsolutediscountbenefit'),(221,'Can add Fixed price shipping benefit',62,'add_shippingfixedpricebenefit'),(222,'Can change Fixed price shipping benefit',62,'change_shippingfixedpricebenefit'),(223,'Can delete Fixed price shipping benefit',62,'delete_shippingfixedpricebenefit'),(224,'Can add Shipping percentage discount benefit',62,'add_shippingpercentagediscountbenefit'),(225,'Can change Shipping percentage discount benefit',62,'change_shippingpercentagediscountbenefit'),(226,'Can delete Shipping percentage discount benefit',62,'delete_shippingpercentagediscountbenefit'),(227,'Can add Voucher',76,'add_voucher'),(228,'Can change Voucher',76,'change_voucher'),(229,'Can delete Voucher',76,'delete_voucher'),(230,'Can add Voucher Application',77,'add_voucherapplication'),(231,'Can change Voucher Application',77,'change_voucherapplication'),(232,'Can delete Voucher Application',77,'delete_voucherapplication'),(233,'Can add Basket',78,'add_basket'),(234,'Can change Basket',78,'change_basket'),(235,'Can delete Basket',78,'delete_basket'),(236,'Can add Basket line',79,'add_line'),(237,'Can change Basket line',79,'change_line'),(238,'Can delete Basket line',79,'delete_line'),(239,'Can add Line attribute',80,'add_lineattribute'),(240,'Can change Line attribute',80,'change_lineattribute'),(241,'Can delete Line attribute',80,'delete_lineattribute'),(242,'Can add Transaction',81,'add_transaction'),(243,'Can change Transaction',81,'change_transaction'),(244,'Can delete Transaction',81,'delete_transaction'),(245,'Can add Source',82,'add_source'),(246,'Can change Source',82,'change_source'),(247,'Can delete Source',82,'delete_source'),(248,'Can add Source Type',83,'add_sourcetype'),(249,'Can change Source Type',83,'change_sourcetype'),(250,'Can delete Source Type',83,'delete_sourcetype'),(251,'Can add Bankcard',84,'add_bankcard'),(252,'Can change Bankcard',84,'change_bankcard'),(253,'Can delete Bankcard',84,'delete_bankcard'),(254,'Can add Page Promotion',85,'add_pagepromotion'),(255,'Can change Page Promotion',85,'change_pagepromotion'),(256,'Can delete Page Promotion',85,'delete_pagepromotion'),(257,'Can add Keyword Promotion',86,'add_keywordpromotion'),(258,'Can change Keyword Promotion',86,'change_keywordpromotion'),(259,'Can delete Keyword Promotion',86,'delete_keywordpromotion'),(260,'Can add Raw HTML',87,'add_rawhtml'),(261,'Can change Raw HTML',87,'change_rawhtml'),(262,'Can delete Raw HTML',87,'delete_rawhtml'),(263,'Can add Image',88,'add_image'),(264,'Can change Image',88,'change_image'),(265,'Can delete Image',88,'delete_image'),(266,'Can add Multi Image',89,'add_multiimage'),(267,'Can change Multi Image',89,'change_multiimage'),(268,'Can delete Multi Image',89,'delete_multiimage'),(269,'Can add Single Product',90,'add_singleproduct'),(270,'Can change Single Product',90,'change_singleproduct'),(271,'Can delete Single Product',90,'delete_singleproduct'),(272,'Can add Hand Picked Product List',91,'add_handpickedproductlist'),(273,'Can change Hand Picked Product List',91,'change_handpickedproductlist'),(274,'Can delete Hand Picked Product List',91,'delete_handpickedproductlist'),(275,'Can add Ordered Product',92,'add_orderedproduct'),(276,'Can change Ordered Product',92,'change_orderedproduct'),(277,'Can delete Ordered Product',92,'delete_orderedproduct'),(278,'Can add Automatic Product List',93,'add_automaticproductlist'),(279,'Can change Automatic Product List',93,'change_automaticproductlist'),(280,'Can delete Automatic Product List',93,'delete_automaticproductlist'),(281,'Can add Ordered Product List',94,'add_orderedproductlist'),(282,'Can change Ordered Product List',94,'change_orderedproductlist'),(283,'Can delete Ordered Product List',94,'delete_orderedproductlist'),(284,'Can add Tabbed Block',95,'add_tabbedblock'),(285,'Can change Tabbed Block',95,'change_tabbedblock'),(286,'Can delete Tabbed Block',95,'delete_tabbedblock'),(287,'Can add Wish List',96,'add_wishlist'),(288,'Can change Wish List',96,'change_wishlist'),(289,'Can delete Wish List',96,'delete_wishlist'),(290,'Can add Wish list line',97,'add_line'),(291,'Can change Wish list line',97,'change_line'),(292,'Can delete Wish list line',97,'delete_line'),(293,'Can add Range Product Uploaded File',98,'add_rangeproductfileupload'),(294,'Can change Range Product Uploaded File',98,'change_rangeproductfileupload'),(295,'Can delete Range Product Uploaded File',98,'delete_rangeproductfileupload');
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
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$G6siZ0Z6QWJP$U/Y43ntb8XvE7PxIMvpWGLDWBRLrHcCZ3pp+mLMd+3I=','2014-11-02 15:03:42',1,'joshua','','','josh@halfnibble.com',1,1,'2014-10-29 01:51:44');
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
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  `owner_id` int(11) DEFAULT NULL,
  `status` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_merged` datetime DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basket_basket_cb902d83` (`owner_id`),
  CONSTRAINT `owner_id_refs_id_61611934` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_basket`
--

LOCK TABLES `basket_basket` WRITE;
/*!40000 ALTER TABLE `basket_basket` DISABLE KEYS */;
INSERT INTO `basket_basket` VALUES (1,1,'Open','2014-10-29 02:08:06',NULL,NULL);
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
  UNIQUE KEY `basket_basket_vouchers_basket_id_42d9f11e1a94f93a_uniq` (`basket_id`,`voucher_id`),
  KEY `basket_basket_vouchers_4fa7d143` (`basket_id`),
  KEY `basket_basket_vouchers_57a58267` (`voucher_id`),
  CONSTRAINT `basket_id_refs_id_8a2faae3` FOREIGN KEY (`basket_id`) REFERENCES `basket_basket` (`id`),
  CONSTRAINT `voucher_id_refs_id_0156bc2a` FOREIGN KEY (`voucher_id`) REFERENCES `voucher_voucher` (`id`)
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
  `basket_id` int(11) NOT NULL,
  `line_reference` varchar(128) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `price_incl_tax` decimal(12,2),
  `price_excl_tax` decimal(12,2),
  `stockrecord_id` int(11),
  `price_currency` varchar(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `basket_line_basket_id_7d0d707a7fd92c45_uniq` (`basket_id`,`line_reference`),
  KEY `basket_line_4fa7d143` (`basket_id`),
  KEY `basket_line_0ad593cd` (`line_reference`),
  KEY `basket_line_7f1b40ad` (`product_id`),
  KEY `basket_line_e4e4faf8` (`stockrecord_id`),
  CONSTRAINT `basket_id_refs_id_7cb1c39d` FOREIGN KEY (`basket_id`) REFERENCES `basket_basket` (`id`),
  CONSTRAINT `product_id_refs_id_e37ea5df` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `stockrecord_id_refs_id_cc729aef` FOREIGN KEY (`stockrecord_id`) REFERENCES `partner_stockrecord` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_line`
--

LOCK TABLES `basket_line` WRITE;
/*!40000 ALTER TABLE `basket_line` DISABLE KEYS */;
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
  `line_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basket_lineattribute_dc784296` (`line_id`),
  KEY `basket_lineattribute_9c74a4f3` (`option_id`),
  CONSTRAINT `line_id_refs_id_81e8e156` FOREIGN KEY (`line_id`) REFERENCES `basket_line` (`id`),
  CONSTRAINT `option_id_refs_id_b5de7d31` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`)
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
-- Table structure for table `catalogue_attributeentity`
--

DROP TABLE IF EXISTS `catalogue_attributeentity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_attributeentity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_attributeentity_f52cfca0` (`slug`),
  KEY `catalogue_attributeentity_403d8ff3` (`type_id`),
  CONSTRAINT `type_id_refs_id_2159a459` FOREIGN KEY (`type_id`) REFERENCES `catalogue_attributeentitytype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_attributeentity`
--

LOCK TABLES `catalogue_attributeentity` WRITE;
/*!40000 ALTER TABLE `catalogue_attributeentity` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_attributeentity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_attributeentitytype`
--

DROP TABLE IF EXISTS `catalogue_attributeentitytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_attributeentitytype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_attributeentitytype_f52cfca0` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_attributeentitytype`
--

LOCK TABLES `catalogue_attributeentitytype` WRITE;
/*!40000 ALTER TABLE `catalogue_attributeentitytype` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_attributeentitytype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogue_attributeoption`
--

DROP TABLE IF EXISTS `catalogue_attributeoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_attributeoption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `option` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_attributeoption_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_84f4714a` FOREIGN KEY (`group_id`) REFERENCES `catalogue_attributeoptiongroup` (`id`)
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
  `slug` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(255),
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`),
  KEY `catalogue_category_4da47e07` (`name`),
  KEY `catalogue_category_f52cfca0` (`slug`),
  KEY `catalogue_category_01e00a9c` (`full_name`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_category`
--

LOCK TABLES `catalogue_category` WRITE;
/*!40000 ALTER TABLE `catalogue_category` DISABLE KEYS */;
INSERT INTO `catalogue_category` VALUES (71,'0001',1,3,'Clothing','clothing','Clothing','',''),(72,'00010001',2,8,'Men\'s Clothing','clothing/mens-clothing','Clothing > Men\'s Clothing','',''),(73,'000100010001',3,0,'Accessories','clothing/mens-clothing/accessories','Clothing > Men\'s Clothing > Accessories','',''),(74,'000100010002',3,3,'Shirts','clothing/mens-clothing/shirts','Clothing > Men\'s Clothing > Shirts','',''),(75,'0001000100020001',4,0,'T-Shirt','clothing/mens-clothing/shirts/t-shirt','Clothing > Men\'s Clothing > Shirts > T-Shirt','',''),(76,'0001000100020002',4,0,'Longshirt','clothing/mens-clothing/shirts/longshirt','Clothing > Men\'s Clothing > Shirts > Longshirt','',''),(77,'0001000100020003',4,0,'Tanktop','clothing/mens-clothing/shirts/tanktop','Clothing > Men\'s Clothing > Shirts > Tanktop','',''),(78,'000100010003',3,0,'Shorts','clothing/mens-clothing/shorts','Clothing > Men\'s Clothing > Shorts','',''),(79,'000100010004',3,0,'Pants','clothing/mens-clothing/pants','Clothing > Men\'s Clothing > Pants','',''),(80,'000100010005',3,0,'Jackets & Coats','clothing/mens-clothing/jackets-coats','Clothing > Men\'s Clothing > Jackets & Coats','',''),(81,'000100010006',3,0,'Swimwear','clothing/mens-clothing/swimwear','Clothing > Men\'s Clothing > Swimwear','',''),(82,'000100010007',3,0,'Base Layer','clothing/mens-clothing/base-layer','Clothing > Men\'s Clothing > Base Layer','',''),(83,'000100010008',3,0,'Sweathirts','clothing/mens-clothing/sweathirts','Clothing > Men\'s Clothing > Sweathirts','',''),(84,'00010002',2,9,'Women\'s Clothing','clothing/womens-clothing','Clothing > Women\'s Clothing','',''),(85,'000100020001',3,0,'Accessories','clothing/womens-clothing/accessories','Clothing > Women\'s Clothing > Accessories','',''),(86,'000100020002',3,3,'Shirts & Tops','clothing/womens-clothing/shirts-tops','Clothing > Women\'s Clothing > Shirts & Tops','',''),(87,'0001000200020001',4,0,'T-Shirt','clothing/womens-clothing/shirts-tops/t-shirt','Clothing > Women\'s Clothing > Shirts & Tops > T-Shirt','',''),(88,'0001000200020002',4,0,'Longshirt','clothing/womens-clothing/shirts-tops/longshirt','Clothing > Women\'s Clothing > Shirts & Tops > Longshirt','',''),(89,'0001000200020003',4,0,'Tanktop','clothing/womens-clothing/shirts-tops/tanktop','Clothing > Women\'s Clothing > Shirts & Tops > Tanktop','',''),(90,'000100020003',3,0,'Shorts','clothing/womens-clothing/shorts','Clothing > Women\'s Clothing > Shorts','',''),(91,'000100020004',3,0,'Pants','clothing/womens-clothing/pants','Clothing > Women\'s Clothing > Pants','',''),(92,'000100020005',3,0,'Jackets & Coats','clothing/womens-clothing/jackets-coats','Clothing > Women\'s Clothing > Jackets & Coats','',''),(93,'000100020006',3,0,'Swimsuits','clothing/womens-clothing/swimsuits','Clothing > Women\'s Clothing > Swimsuits','',''),(94,'000100020007',3,0,'Base Layer','clothing/womens-clothing/base-layer','Clothing > Women\'s Clothing > Base Layer','',''),(95,'000100020008',3,0,'Sweathirts','clothing/womens-clothing/sweathirts','Clothing > Women\'s Clothing > Sweathirts','',''),(96,'000100020009',3,0,'Dresses & Skirts','clothing/womens-clothing/dresses-skirts','Clothing > Women\'s Clothing > Dresses & Skirts','',''),(97,'00010003',2,10,'Kid\'s Clothing','clothing/kids-clothing','Clothing > Kid\'s Clothing','',''),(98,'000100030001',3,0,'Accessories','clothing/kids-clothing/accessories','Clothing > Kid\'s Clothing > Accessories','',''),(99,'000100030002',3,3,'Boy\'s Shirts','clothing/kids-clothing/boys-shirts','Clothing > Kid\'s Clothing > Boy\'s Shirts','',''),(100,'0001000300020001',4,0,'T-Shirt','clothing/kids-clothing/boys-shirts/t-shirt','Clothing > Kid\'s Clothing > Boy\'s Shirts > T-Shirt','',''),(101,'0001000300020002',4,0,'Longshirt','clothing/kids-clothing/boys-shirts/longshirt','Clothing > Kid\'s Clothing > Boy\'s Shirts > Longshirt','',''),(102,'0001000300020003',4,0,'Tanktop','clothing/kids-clothing/boys-shirts/tanktop','Clothing > Kid\'s Clothing > Boy\'s Shirts > Tanktop','',''),(103,'000100030003',3,0,'Boy\'s Pants & Shorts','clothing/kids-clothing/boys-pants-shorts','Clothing > Kid\'s Clothing > Boy\'s Pants & Shorts','',''),(104,'000100030004',3,0,'Boy\'s Jackets & Coats','clothing/kids-clothing/boys-jackets-coats','Clothing > Kid\'s Clothing > Boy\'s Jackets & Coats','',''),(105,'000100030005',3,0,'Boy\'s Swimwear','clothing/kids-clothing/boys-swimwear','Clothing > Kid\'s Clothing > Boy\'s Swimwear','',''),(106,'000100030006',3,3,'Girl\'s Shirts','clothing/kids-clothing/girls-shirts','Clothing > Kid\'s Clothing > Girl\'s Shirts','',''),(107,'0001000300060001',4,0,'T-Shirt','clothing/kids-clothing/girls-shirts/t-shirt','Clothing > Kid\'s Clothing > Girl\'s Shirts > T-Shirt','',''),(108,'0001000300060002',4,0,'Longshirt','clothing/kids-clothing/girls-shirts/longshirt','Clothing > Kid\'s Clothing > Girl\'s Shirts > Longshirt','',''),(109,'0001000300060003',4,0,'Tanktop','clothing/kids-clothing/girls-shirts/tanktop','Clothing > Kid\'s Clothing > Girl\'s Shirts > Tanktop','',''),(110,'000100030007',3,0,'Girl\'s Pants & Shorts','clothing/kids-clothing/girls-pants-shorts','Clothing > Kid\'s Clothing > Girl\'s Pants & Shorts','',''),(111,'000100030008',3,0,'Girl\'s Dresses & Skirts','clothing/kids-clothing/girls-dresses-skirts','Clothing > Kid\'s Clothing > Girl\'s Dresses & Skirts','',''),(112,'000100030009',3,0,'Girl\'s Jackets & Coats','clothing/kids-clothing/girls-jackets-coats','Clothing > Kid\'s Clothing > Girl\'s Jackets & Coats','',''),(113,'00010003000A',3,0,'Girl\'s Swimwear','clothing/kids-clothing/girls-swimwear','Clothing > Kid\'s Clothing > Girl\'s Swimwear','',''),(114,'0002',1,3,'Shoes','shoes','Shoes','',''),(115,'00020001',2,4,'Men\'s Footwear','shoes/mens-footwear','Shoes > Men\'s Footwear','',''),(116,'000200010001',3,0,'Sandals','shoes/mens-footwear/sandals','Shoes > Men\'s Footwear > Sandals','',''),(117,'000200010002',3,0,'Shoes','shoes/mens-footwear/shoes','Shoes > Men\'s Footwear > Shoes','',''),(118,'000200010003',3,0,'Boots','shoes/mens-footwear/boots','Shoes > Men\'s Footwear > Boots','',''),(119,'000200010004',3,0,'Socks','shoes/mens-footwear/socks','Shoes > Men\'s Footwear > Socks','',''),(120,'00020002',2,4,'Women\'s Footwear','shoes/womens-footwear','Shoes > Women\'s Footwear','',''),(121,'000200020001',3,0,'Sandals','shoes/womens-footwear/sandals','Shoes > Women\'s Footwear > Sandals','',''),(122,'000200020002',3,0,'Shoes','shoes/womens-footwear/shoes','Shoes > Women\'s Footwear > Shoes','',''),(123,'000200020003',3,0,'Boots','shoes/womens-footwear/boots','Shoes > Women\'s Footwear > Boots','',''),(124,'000200020004',3,0,'Socks','shoes/womens-footwear/socks','Shoes > Women\'s Footwear > Socks','',''),(125,'00020003',2,3,'Kid\'s Footwear','shoes/kids-footwear','Shoes > Kid\'s Footwear','',''),(126,'000200030001',3,0,'Kid\'s Shoes','shoes/kids-footwear/kids-shoes','Shoes > Kid\'s Footwear > Kid\'s Shoes','',''),(127,'000200030002',3,0,'Kid\'s Boots','shoes/kids-footwear/kids-boots','Shoes > Kid\'s Footwear > Kid\'s Boots','',''),(128,'000200030003',3,0,'Kid\'s Socks','shoes/kids-footwear/kids-socks','Shoes > Kid\'s Footwear > Kid\'s Socks','','');
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
  UNIQUE KEY `catalogue_option_code_1687c916225230f1_uniq` (`code`),
  KEY `catalogue_option_09bb5fb3` (`code`)
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
  `upc` varchar(64),
  `parent_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `product_class_id` int(11),
  `score` double NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `is_discountable` tinyint(1) NOT NULL,
  `rating` double,
  `brand_id` int(11),
  `activity_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogue_product_upc_47091a7974ee95de_uniq` (`upc`),
  KEY `catalogue_product_1037f587` (`upc`),
  KEY `catalogue_product_410d0aac` (`parent_id`),
  KEY `catalogue_product_f52cfca0` (`slug`),
  KEY `catalogue_product_887ff274` (`product_class_id`),
  KEY `catalogue_product_7c5c8902` (`score`),
  KEY `catalogue_product_68d861dd` (`date_updated`),
  KEY `catalogue_product_5afadb1e` (`brand_id`),
  KEY `catalogue_product_8005e431` (`activity_id`),
  CONSTRAINT `activity_id_refs_id_583f5f39` FOREIGN KEY (`activity_id`) REFERENCES `catalogue_productactivity` (`id`),
  CONSTRAINT `brand_id_refs_id_27b81598` FOREIGN KEY (`brand_id`) REFERENCES `catalogue_productbrand` (`id`),
  CONSTRAINT `parent_id_refs_id_79124e9b` FOREIGN KEY (`parent_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `product_class_id_refs_id_e52aa69a` FOREIGN KEY (`product_class_id`) REFERENCES `catalogue_productclass` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1588 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_product`
--

LOCK TABLES `catalogue_product` WRITE;
/*!40000 ALTER TABLE `catalogue_product` DISABLE KEYS */;
INSERT INTO `catalogue_product` VALUES (1347,'20-1008-7',NULL,'Cycling Boxer sewn upholstery Woman ','cycling-boxer-sewn-upholstery-woman','Cycling Boxer sewn upholstery Woman ',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,4,1),(1348,'20-1008-7-1-0002',1347,'','cycling-boxer-sewn-upholstery-woman','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1349,'20-1008-7-2-0002',1347,'','cycling-boxer-sewn-upholstery-woman','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1350,'20-1008-7-3-0002',1347,'','cycling-boxer-sewn-upholstery-woman','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1351,'20-1008-8',NULL,'Cycling Boxer sewn upholstery Man ','cycling-boxer-sewn-upholstery-man','Cycling Boxer sewn upholstery Man ',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,4,1),(1352,'20-1008-8-1-0002',1351,'','cycling-boxer-sewn-upholstery-man','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1353,'20-1008-8-2-0002',1351,'','cycling-boxer-sewn-upholstery-man','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1354,'20-1008-8-3-0002',1351,'','cycling-boxer-sewn-upholstery-man','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1355,'39-6023-0',NULL,'Mittens (Flap) Gloves ','mittens-flap-gloves','Mittens (Flap) Gloves ',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,4,NULL),(1356,'39-6023-0-1-0002',1355,'','mittens-flap-gloves','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1357,'39-6023-0-2-0002',1355,'','mittens-flap-gloves','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1358,'39-6023-0-4-0002',1355,'','mittens-flap-gloves','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1359,'39-6023-0-5-0002',1355,'','mittens-flap-gloves','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1360,'12-1800-7',NULL,'Organic Bamboo T-Shirt Woman ','organic-bamboo-t-shirt-woman','Organic Bamboo T-Shirt Woman ',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,4,NULL),(1361,'12-1800-7-2-0002',1360,'','organic-bamboo-t-shirt-woman','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1362,'12-1800-7-3-0002',1360,'','organic-bamboo-t-shirt-woman','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1363,'13-1802-7',NULL,'Organic Bamboo Tanktop Woman ','organic-bamboo-tanktop-woman','Organic Bamboo Tanktop Woman ',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,4,NULL),(1364,'13-1802-7-2-0002',1363,'','organic-bamboo-tanktop-woman','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1365,'13-1802-7-3-0002',1363,'','organic-bamboo-tanktop-woman','',1,0,'2014-11-03 10:16:00','2014-11-03 10:16:00',1,NULL,NULL,NULL),(1366,'12-1800-8',NULL,'Organic Bamboo T-Shirt Man ','organic-bamboo-t-shirt-man','Organic Bamboo T-Shirt Man ',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,4,NULL),(1367,'12-1800-8-3-0002',1366,'','organic-bamboo-t-shirt-man','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1368,'13-1072-7',NULL,'Megalight 140 Singlet Berry Woman ','megalight-140-singlet-berry-woman','Megalight 140 Singlet Berry Woman ',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,4,NULL),(1369,'13-1072-7-1-0229',1368,'','megalight-140-singlet-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1370,'13-1072-7-2-0229',1368,'','megalight-140-singlet-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1371,'13-1072-7-3-0229',1368,'','megalight-140-singlet-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1372,'14-1073-7',NULL,'Megalight 140 Longtight Berry Woman ','megalight-140-longtight-berry-woman','Megalight 140 Longtight Berry Woman ',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,4,NULL),(1373,'14-1073-7-1-0227',1372,'','megalight-140-longtight-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1374,'14-1073-7-2-0227',1372,'','megalight-140-longtight-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1375,'14-1073-7-3-0227',1372,'','megalight-140-longtight-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1376,'12-1079-7',NULL,'Megalight 140 T-Shirt Berry Woman ','megalight-140-t-shirt-berry-woman','Megalight 140 T-Shirt Berry Woman ',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,4,NULL),(1377,'12-1079-7-2-0227',1376,'','megalight-140-t-shirt-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1378,'12-1079-7-3-0227',1376,'','megalight-140-t-shirt-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1379,'15-1070-7',NULL,'Megalight 140 Longshirt Berry Woman ','megalight-140-longshirt-berry-woman','Megalight 140 Longshirt Berry Woman ',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,4,NULL),(1380,'15-1070-7-2-0227',1379,'','megalight-140-longshirt-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1381,'15-1070-7-3-0227',1379,'','megalight-140-longshirt-berry-woman','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1382,'19-1076-8',NULL,'Megalight 140 1','megalight-140-1','Megalight 140 1',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,4,NULL),(1383,'19-1076-8-1-0002',1382,'','megalight-140-1','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1384,'19-1076-8-2-0002',1382,'','megalight-140-1','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1385,'19-1076-8-3-0002',1382,'','megalight-140-1','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1386,'15-1070-8',NULL,'Megalight 140 Longshirt Lime Man ','megalight-140-longshirt-lime-man','Megalight 140 Longshirt Lime Man ',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,4,NULL),(1387,'15-1070-8-2-0017',1386,'','megalight-140-longshirt-lime-man','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1388,'15-1070-8-3-0017',1386,'','megalight-140-longshirt-lime-man','',1,0,'2014-11-03 10:16:01','2014-11-03 10:16:01',1,NULL,NULL,NULL),(1389,'12-1079-8',NULL,'Megalight 140 T-Shirt Lime Man ','megalight-140-t-shirt-lime-man','Megalight 140 T-Shirt Lime Man ',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,4,NULL),(1390,'12-1079-8-2-0017',1389,'','megalight-140-t-shirt-lime-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1391,'12-1079-8-3-0017',1389,'','megalight-140-t-shirt-lime-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1392,'15-1060-7',NULL,'Megalight 140 Longshirt Woman ','megalight-140-longshirt-woman','Megalight 140 Longshirt Woman ',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,4,NULL),(1393,'15-1060-7-1-0002',1392,'','megalight-140-longshirt-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1394,'15-1060-7-2-0002',1392,'','megalight-140-longshirt-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1395,'15-1060-7-3-0002',1392,'','megalight-140-longshirt-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1396,'15-1060-7-4-0002',1392,'','megalight-140-longshirt-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1397,'13-1061-7',NULL,'Megalight 140 Tanktop Woman ','megalight-140-tanktop-woman','Megalight 140 Tanktop Woman ',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,4,NULL),(1398,'13-1061-7-1-0002',1397,'','megalight-140-tanktop-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1399,'13-1061-7-2-0002',1397,'','megalight-140-tanktop-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1400,'13-1061-7-3-0002',1397,'','megalight-140-tanktop-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1401,'13-1061-7-4-0002',1397,'','megalight-140-tanktop-woman','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1402,'12-1059-8',NULL,'Megalight 140 T-Shirt Man ','megalight-140-t-shirt-man','Megalight 140 T-Shirt Man ',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,4,NULL),(1403,'12-1059-8-1-0002',1402,'','megalight-140-t-shirt-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1404,'12-1059-8-2-0002',1402,'','megalight-140-t-shirt-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1405,'12-1059-8-3-0002',1402,'','megalight-140-t-shirt-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1406,'14-1053-8',NULL,'Megalight 140 Longtight Man ','megalight-140-longtight-man','Megalight 140 Longtight Man ',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,4,NULL),(1407,'14-1053-8-1-0002',1406,'','megalight-140-longtight-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1408,'14-1053-8-2-0002',1406,'','megalight-140-longtight-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1409,'14-1053-8-3-0002',1406,'','megalight-140-longtight-man','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1410,'16-1054-8',NULL,'Megalight 140 3','megalight-140-3','Megalight 140 3',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,4,NULL),(1411,'16-1054-8-1-0002',1410,'','megalight-140-3','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1412,'16-1054-8-2-0002',1410,'','megalight-140-3','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1413,'16-1054-8-3-0002',1410,'','megalight-140-3','',1,0,'2014-11-03 10:16:02','2014-11-03 10:16:02',1,NULL,NULL,NULL),(1414,'11-1056-8',NULL,'Megalight 140 Boxer Man ','megalight-140-boxer-man','Megalight 140 Boxer Man ',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,4,NULL),(1415,'11-1056-8-1-0002',1414,'','megalight-140-boxer-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1416,'11-1056-8-2-0002',1414,'','megalight-140-boxer-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1417,'11-1056-8-3-0002',1414,'','megalight-140-boxer-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1418,'12-1000-9',NULL,'KIDS Megalight 140 T-Shirt Unisex ','kids-megalight-140-t-shirt-unisex','KIDS Megalight 140 T-Shirt Unisex ',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,4,NULL),(1419,'12-1000-9-1-0002',1418,'','kids-megalight-140-t-shirt-unisex','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1420,'12-1000-9-2-0002',1418,'','kids-megalight-140-t-shirt-unisex','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1421,'12-1000-9-3-0002',1418,'','kids-megalight-140-t-shirt-unisex','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1422,'11-1007-9',NULL,'KIDS Megalight 140 Boxer Unisex ','kids-megalight-140-boxer-unisex','KIDS Megalight 140 Boxer Unisex ',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,4,NULL),(1423,'11-1007-9-1-0002',1422,'','kids-megalight-140-boxer-unisex','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1424,'11-1007-9-2-0002',1422,'','kids-megalight-140-boxer-unisex','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1425,'11-1007-9-3-0002',1422,'','kids-megalight-140-boxer-unisex','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1426,'12-1250-8',NULL,'Megalight 200 T-Shirt Man ','megalight-200-t-shirt-man','Megalight 200 T-Shirt Man ',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,4,NULL),(1427,'12-1250-8-2-0002',1426,'','megalight-200-t-shirt-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1428,'12-1250-8-3-0002',1426,'','megalight-200-t-shirt-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1429,'15-1251-8',NULL,'Megalight 200 Longshirt Man ','megalight-200-longshirt-man','Megalight 200 Longshirt Man ',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,4,NULL),(1430,'15-1251-8-2-0002',1429,'','megalight-200-longshirt-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1431,'15-1251-8-3-0002',1429,'','megalight-200-longshirt-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1432,'14-1253-8',NULL,'Megalight 200 Longtight Man ','megalight-200-longtight-man','Megalight 200 Longtight Man ',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,4,NULL),(1433,'14-1253-8-1-0002',1432,'','megalight-200-longtight-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1434,'14-1253-8-2-0002',1432,'','megalight-200-longtight-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1435,'14-1253-8-3-0002',1432,'','megalight-200-longtight-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1436,'12-1417-8',NULL,'Merino T-Shirt Man ','merino-t-shirt-man','Merino T-Shirt Man ',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,4,NULL),(1437,'12-1417-8-2-0002',1436,'','merino-t-shirt-man','',1,0,'2014-11-03 10:16:03','2014-11-03 10:16:03',1,NULL,NULL,NULL),(1438,'15-2201-7',NULL,'Merino TEC 240 Longshirt Zipper Woman ','merino-tec-240-longshirt-zipper-woman','Merino TEC 240 Longshirt Zipper Woman ',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,4,NULL),(1439,'15-2201-7-1-0002',1438,'','merino-tec-240-longshirt-zipper-woman','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1440,'15-2201-7-2-0002',1438,'','merino-tec-240-longshirt-zipper-woman','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1441,'15-2201-7-3-0002',1438,'','merino-tec-240-longshirt-zipper-woman','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1442,'14-2202-8',NULL,'Merino TEC 240 Longtight Man ','merino-tec-240-longtight-man','Merino TEC 240 Longtight Man ',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,4,NULL),(1443,'14-2202-8-1-0002',1442,'','merino-tec-240-longtight-man','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1444,'14-2202-8-2-0002',1442,'','merino-tec-240-longtight-man','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1445,'14-2202-8-3-0002',1442,'','merino-tec-240-longtight-man','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1446,'28-4810-0',NULL,'Sporting Allround 300 ','sporting-allround-300','Sporting Allround 300 ',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,4,NULL),(1447,'28-4810-0-2-0001',1446,'','sporting-allround-300','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1448,'28-4810-0-4-0001',1446,'','sporting-allround-300','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1449,'23-4622-0',NULL,'Trekking A 100 ','trekking-a-100','Trekking A 100 ',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,4,3),(1450,'23-4622-0-1-0193',1449,'','trekking-a-100','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1451,'23-4622-0-2-0193',1449,'','trekking-a-100','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1452,'23-4622-0-3-0198',1449,'','trekking-a-100','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1453,'23-4622-0-4-0198',1449,'','trekking-a-100','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1454,'21-4010-7',NULL,'Running Short Woman ','running-short-woman','Running Short Woman ',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,4,2),(1455,'21-4010-7-1-0184',1454,'','running-short-woman','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1456,'21-4010-7-2-0184',1454,'','running-short-woman','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1457,'21-4012-8',NULL,'Running High Man ','running-high-man','Running High Man ',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,4,2),(1458,'21-4012-8-2-0184',1457,'','running-high-man','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1459,'21-4012-8-3-0184',1457,'','running-high-man','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1460,'21-4012-8-4-0184',1457,'','running-high-man','',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,NULL,NULL),(1461,'21-4020-7',NULL,'Running Mid Woman ','running-mid-woman','Running Mid Woman ',1,0,'2014-11-03 10:16:04','2014-11-03 10:16:04',1,NULL,4,2),(1462,'21-4020-7-1-0233',1461,'','running-mid-woman','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1463,'21-4020-7-2-0233',1461,'','running-mid-woman','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1464,'21-4020-8',NULL,'Running Mid Man ','running-mid-man','Running Mid Man ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,2),(1465,'21-4020-8-2-0232',1464,'','running-mid-man','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1466,'21-4020-8-3-0232',1464,'','running-mid-man','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1467,'12-2110-7',NULL,'Ultralight 70 T-Shirt Woman ','ultralight-70-t-shirt-woman','Ultralight 70 T-Shirt Woman ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,NULL),(1468,'12-2110-7-3-0002',1467,'','ultralight-70-t-shirt-woman','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1469,'12-2110-7-2-0002',1467,'','ultralight-70-t-shirt-woman','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1470,'12-2110-7-1-0002',1467,'','ultralight-70-t-shirt-woman','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1471,'13-2112-8',NULL,'Ultralight 70 Tanktop Man ','ultralight-70-tanktop-man','Ultralight 70 Tanktop Man ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,NULL),(1472,'13-2112-8-2-0002',1471,'','ultralight-70-tanktop-man','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1473,'13-2112-8-3-0002',1471,'','ultralight-70-tanktop-man','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1474,'11-2111-7',NULL,'Ultralight 70 Panty Woman ','ultralight-70-panty-woman','Ultralight 70 Panty Woman ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,NULL),(1475,'11-2111-7-3-0002',1474,'','ultralight-70-panty-woman','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1476,'12-2110-8',NULL,'Ultralight 70 T-Shirt Man ','ultralight-70-t-shirt-man','Ultralight 70 T-Shirt Man ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,NULL),(1477,'12-2110-8-3-0002',1476,'','ultralight-70-t-shirt-man','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1478,'27-4711-7',NULL,'Skiing NT P 100 Woman ','skiing-nt-p-100-woman','Skiing NT P 100 Woman ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,4),(1479,'27-4711-7-2-0202',1478,'','skiing-nt-p-100-woman','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1480,'27-4711-8',NULL,'Skiing NT P 100 Man ','skiing-nt-p-100-man','Skiing NT P 100 Man ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,4),(1481,'27-4711-8-4-0202',1480,'','skiing-nt-p-100-man','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1482,'27-4724-0',NULL,'Skiing Lite ','skiing-lite','Skiing Lite ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,4,4),(1483,'27-4724-0-2-0071',1482,'','skiing-lite','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1484,'27-4724-0-3-0071',1482,'','skiing-lite','',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,NULL,NULL),(1485,'460',NULL,'HAD Merino ','had-merino','HAD Merino ',1,0,'2014-11-03 10:16:05','2014-11-03 10:16:05',1,NULL,5,NULL),(1486,'HA460-0006',1485,'','had-merino','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1487,'HA460-0015',1485,'','had-merino','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1488,'HA460-0018',1485,'','had-merino','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1489,'HA460-0442',1485,'','had-merino','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1490,'HA460-0443',1485,'','had-merino','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1491,'HA460-0445',1485,'','had-merino','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1492,'620',NULL,'HAD Neckwarmer Fleece ','had-neckwarmer-fleece','HAD Neckwarmer Fleece ',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,5,NULL),(1493,'HA620-0XXX',1492,'','had-neckwarmer-fleece','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1494,'110',NULL,'HAD Junior ','had-junior','HAD Junior ',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,5,NULL),(1495,'HA110-0285',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1496,'HA110-0390',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1497,'621',NULL,'HAD Neckwarmer Fleece Kids ','had-neckwarmer-fleece-kids','HAD Neckwarmer Fleece Kids ',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,5,NULL),(1498,'HA621-0224',1497,'','had-neckwarmer-fleece-kids','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1499,'HA110-0477',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1500,'HA110-0475',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1501,'HA110-0470',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1502,'HA110-0472',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1503,'HA110-0219',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1504,'HA110-0220',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1505,'HA110-0252',1494,'','had-junior','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1506,'100',NULL,'HAD Solid colours ','had-solid-colours','HAD Solid colours ',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,5,NULL),(1507,'HA100-0001',1506,'','had-solid-colours','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1508,'HA100-0004',1506,'','had-solid-colours','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1509,'HA100-0015',1506,'','had-solid-colours','',1,0,'2014-11-03 10:16:06','2014-11-03 10:16:06',1,NULL,NULL,NULL),(1510,'HA100-0018',1506,'','had-solid-colours','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1511,'HA110-0415',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1512,'HA110-0436',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1513,'HA110-0419',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1514,'HA110-0425',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1515,'HA110-0438',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1516,'HA110-0346',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1517,'HA110-0349',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1518,'HA110-0413',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1519,'HA110-0143',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1520,'HA110-0133',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1521,'HA110-0158',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1522,'HA110-0169',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1523,'HA110-0154',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1524,'HA110-0162',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1525,'HA110-0234',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1526,'HA110-0155',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1527,'HA110-0264',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1528,'HA110-0258',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1529,'HA110-0242',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1530,'HA110-0317',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1531,'HA110-0385',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1532,'HA110-0387',1494,'','had-junior','',1,0,'2014-11-03 10:16:07','2014-11-03 10:16:07',1,NULL,NULL,NULL),(1533,'HA110-0171',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1534,'HA110-0362',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1535,'HA110-0388',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1536,'HA110-0400',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1537,'HA110-0410',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1538,'HA110-0406',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1539,'HA110-0407',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1540,'HA110-0271 ',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1541,'HA110-0275',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1542,'HA110-0135',1494,'','had-junior','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1543,'450',NULL,'HAD Coolmax ','had-coolmax','HAD Coolmax ',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,5,NULL),(1544,'HA450-0002',1543,'','had-coolmax','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1545,'HA450-0465',1543,'','had-coolmax','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1546,'HA450-0466',1543,'','had-coolmax','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1547,'651',NULL,'HAD Hadband ','had-hadband','HAD Hadband ',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,5,NULL),(1548,'HA651-0002',1547,'','had-hadband','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1549,'HA651-0463',1547,'','had-hadband','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1550,'HA651-0464',1547,'','had-hadband','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1551,'HA460-0002',1485,'','had-merino','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1552,'HA460-0444',1485,'','had-merino','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1553,'660',NULL,'HAD Primaloft ','had-primaloft','HAD Primaloft ',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,5,NULL),(1554,'HA660-0377',1553,'','had-primaloft','',1,0,'2014-11-03 10:16:08','2014-11-03 10:16:08',1,NULL,NULL,NULL),(1555,'HA660-0452',1553,'','had-primaloft','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1556,'640',NULL,'HAD Triangle ','had-triangle','HAD Triangle ',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,5,NULL),(1557,'HA640-0122',1556,'','had-triangle','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1558,'630',NULL,'HAD Beanie ','had-beanie','HAD Beanie ',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,5,NULL),(1559,'HA630-0252',1558,'','had-beanie','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1560,'610',NULL,'HAD Hadmask ','had-hadmask','HAD Hadmask ',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,5,NULL),(1561,'HA610-0002',1560,'','had-hadmask','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1562,'210',NULL,'HAD Original Fleece ','had-original-fleece','HAD Original Fleece ',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,5,NULL),(1563,'HA210-0347',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1564,'HA210-0432',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1565,'HA210-0416',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1566,'HA210-0418',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1567,'HA210-0411',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1568,'HA210-0405',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1569,'HA200-0029',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1570,'HA210-0125',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1571,'HA210-0147',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1572,'200',NULL,'HAD Solid Fleece ','had-solid-fleece','HAD Solid Fleece ',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,5,NULL),(1573,'HA200-0002',1572,'','had-solid-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1574,'HA200-0006',1572,'','had-solid-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1575,'HA200-0020',1572,'','had-solid-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1576,'HA620-0233',1492,'','had-neckwarmer-fleece','',1,0,'2014-11-03 10:16:09','2014-11-03 10:16:09',1,NULL,NULL,NULL),(1577,'HA620-0436',1492,'','had-neckwarmer-fleece','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL),(1578,'410',NULL,'HAD Reflectives ','had-reflectives','HAD Reflectives ',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,5,NULL),(1579,'HA410-0489',1578,'','had-reflectives','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL),(1580,'HA210-0368',1562,'','had-original-fleece','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL),(1581,'120',NULL,'HAD Kids ','had-kids','HAD Kids ',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,5,NULL),(1582,'HA120-0371',1581,'','had-kids','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL),(1583,'HA120-0392',1581,'','had-kids','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL),(1584,'HA120-0202',1581,'','had-kids','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL),(1585,'HA621-0328',1497,'','had-neckwarmer-fleece-kids','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL),(1586,'220',NULL,'HAD Kids Fleece ','had-kids-fleece','HAD Kids Fleece ',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,5,NULL),(1587,'HA220-0298',1586,'','had-kids-fleece','',1,0,'2014-11-03 10:16:10','2014-11-03 10:16:10',1,NULL,NULL,NULL);
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
  UNIQUE KEY `catalogue_product_product_opti_product_id_72c840707f278a98_uniq` (`product_id`,`option_id`),
  KEY `catalogue_product_product_options_7f1b40ad` (`product_id`),
  KEY `catalogue_product_product_options_9c74a4f3` (`option_id`),
  CONSTRAINT `option_id_refs_id_cec28b85` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`),
  CONSTRAINT `product_id_refs_id_64f4bc4f` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
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
-- Table structure for table `catalogue_product_related_products`
--

DROP TABLE IF EXISTS `catalogue_product_related_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogue_product_related_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_product_id` int(11) NOT NULL,
  `to_product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogue_product_related_from_product_id_6dc96f22461ac2e7_uniq` (`from_product_id`,`to_product_id`),
  KEY `catalogue_product_related_products_f8955233` (`from_product_id`),
  KEY `catalogue_product_related_products_61e9a379` (`to_product_id`),
  CONSTRAINT `from_product_id_refs_id_96165fb9` FOREIGN KEY (`from_product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `to_product_id_refs_id_96165fb9` FOREIGN KEY (`to_product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_product_related_products`
--

LOCK TABLES `catalogue_product_related_products` WRITE;
/*!40000 ALTER TABLE `catalogue_product_related_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogue_product_related_products` ENABLE KEYS */;
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
  KEY `catalogue_productactivity_f52cfca0` (`slug`)
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
  `product_class_id` int(11) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `code` varchar(128) NOT NULL,
  `type` varchar(20) NOT NULL,
  `option_group_id` int(11) DEFAULT NULL,
  `entity_type_id` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_productattribute_887ff274` (`product_class_id`),
  KEY `catalogue_productattribute_09bb5fb3` (`code`),
  KEY `catalogue_productattribute_7d82c819` (`option_group_id`),
  KEY `catalogue_productattribute_80abac9b` (`entity_type_id`),
  CONSTRAINT `entity_type_id_refs_id_47a71bd4` FOREIGN KEY (`entity_type_id`) REFERENCES `catalogue_attributeentitytype` (`id`),
  CONSTRAINT `option_group_id_refs_id_cca38a3b` FOREIGN KEY (`option_group_id`) REFERENCES `catalogue_attributeoptiongroup` (`id`),
  CONSTRAINT `product_class_id_refs_id_72cad211` FOREIGN KEY (`product_class_id`) REFERENCES `catalogue_productclass` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productattribute`
--

LOCK TABLES `catalogue_productattribute` WRITE;
/*!40000 ALTER TABLE `catalogue_productattribute` DISABLE KEYS */;
INSERT INTO `catalogue_productattribute` VALUES (1,1,'Size','size','text',NULL,NULL,0),(2,1,'Color','color','text',NULL,NULL,0),(3,1,'Material','material','text',NULL,NULL,0);
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
  `attribute_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `value_text` varchar(255) DEFAULT NULL,
  `value_integer` int(11) DEFAULT NULL,
  `value_boolean` tinyint(1),
  `value_float` double DEFAULT NULL,
  `value_richtext` longtext,
  `value_date` date DEFAULT NULL,
  `value_option_id` int(11) DEFAULT NULL,
  `value_entity_id` int(11) DEFAULT NULL,
  `value_file` varchar(255),
  `value_image` varchar(255),
  PRIMARY KEY (`id`),
  KEY `catalogue_productattributevalue_6761a259` (`attribute_id`),
  KEY `catalogue_productattributevalue_7f1b40ad` (`product_id`),
  KEY `catalogue_productattributevalue_77e289ac` (`value_option_id`),
  KEY `catalogue_productattributevalue_d68918c3` (`value_entity_id`),
  CONSTRAINT `attribute_id_refs_id_a6deeef1` FOREIGN KEY (`attribute_id`) REFERENCES `catalogue_productattribute` (`id`),
  CONSTRAINT `product_id_refs_id_f91f271e` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `value_entity_id_refs_id_f6881669` FOREIGN KEY (`value_entity_id`) REFERENCES `catalogue_attributeentity` (`id`),
  CONSTRAINT `value_option_id_refs_id_068e7fd9` FOREIGN KEY (`value_option_id`) REFERENCES `catalogue_attributeoption` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1976 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productattributevalue`
--

LOCK TABLES `catalogue_productattributevalue` WRITE;
/*!40000 ALTER TABLE `catalogue_productattributevalue` DISABLE KEYS */;
INSERT INTO `catalogue_productattributevalue` VALUES (1681,2,1347,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1682,3,1347,'Polyamid 85% Polyester 15%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1683,1,1348,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1684,1,1349,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1685,1,1350,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1686,2,1351,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1687,3,1351,'Polyamid 85% Polyester 15%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1688,1,1352,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1689,1,1353,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1690,1,1354,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1691,2,1355,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1692,3,1355,'Polyester 100%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1693,1,1356,'XS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1694,1,1357,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1695,1,1358,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1696,1,1359,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1697,2,1360,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1698,3,1360,'Bamboo 81% Polyamide 15% Elastane 4%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1699,1,1361,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1700,1,1362,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1701,2,1363,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1702,3,1363,'Bamboo 81% Polyamide 15% Elastane 4%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1703,1,1364,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1704,1,1365,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1705,2,1366,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1706,3,1366,'Bamboo 81% Polyamide 15% Elastane 4%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1707,1,1367,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1708,2,1368,'Pink/Orange',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1709,3,1368,'Polyamide 94% Elastane 6%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1710,1,1369,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1711,1,1370,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1712,1,1371,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1713,2,1372,'Black/Pink',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1714,3,1372,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1715,1,1373,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1716,1,1374,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1717,1,1375,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1718,2,1376,'Black/Pink',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1719,3,1376,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1720,1,1377,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1721,1,1378,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1722,2,1379,'Black/Pink',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1723,3,1379,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1724,1,1380,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1725,1,1381,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1726,2,1382,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1727,3,1382,'Polyamide 72% Polyester 21% Elastane 7%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1728,1,1383,'2 Short Man /M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1729,1,1384,'2 Short Man /L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1730,1,1385,'2 Short Man /XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1731,2,1386,'Black/Green',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1732,3,1386,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1733,1,1387,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1734,1,1388,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1735,2,1389,'Black/Green',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1736,3,1389,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1737,1,1390,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1738,1,1391,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1739,2,1392,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1740,3,1392,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1741,1,1393,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1742,1,1394,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1743,1,1395,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1744,1,1396,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1745,2,1397,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1746,3,1397,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1747,1,1398,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1748,1,1399,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1749,1,1400,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1750,1,1401,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1751,2,1402,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1752,3,1402,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1753,1,1403,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1754,1,1404,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1755,1,1405,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1756,2,1406,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1757,3,1406,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1758,1,1407,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1759,1,1408,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1760,1,1409,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1761,2,1410,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1762,3,1410,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1763,1,1411,'4 Tight Man /M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1764,1,1412,'4 Tight Man /L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1765,1,1413,'4 Tight Man /XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1766,2,1414,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1767,3,1414,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1768,1,1415,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1769,1,1416,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1770,1,1417,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1771,2,1418,'Black ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1772,3,1418,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1773,1,1419,'104-116',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1774,1,1420,'128-140',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1775,1,1421,'152-164',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1776,2,1422,'Black ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1777,3,1422,'Polyamide 78% Polyester 22%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1778,1,1423,'104-116',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1779,1,1424,'128-140',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1780,1,1425,'152-164',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1781,2,1426,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1782,3,1426,'Polyamide 88% Polyester 12%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1783,1,1427,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1784,1,1428,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1785,2,1429,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1786,3,1429,'Polyamide 88% Polyester 12%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1787,1,1430,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1788,1,1431,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1789,2,1432,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1790,3,1432,'Polyamide 88% Polyester 12%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1791,1,1433,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1792,1,1434,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1793,1,1435,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1794,2,1436,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1795,3,1436,'Wool 76% Polypropylene 12% Polyamide 10% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1796,1,1437,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1797,2,1438,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1798,1,1439,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1799,1,1440,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1800,1,1441,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1801,2,1442,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1802,1,1443,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1803,1,1444,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1804,1,1445,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1805,2,1446,'White',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1806,3,1446,'Polyester 54% Polyester Coolmax 30% Polyamide 14% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1807,1,1447,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1808,1,1448,'47-49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1809,2,1449,'Black/Orange',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1810,3,1449,'Polyamide 47% Polypropylene 26% Polyamide Microlon 25% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1811,1,1450,'35-38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1812,1,1451,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1813,1,1452,'43-46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1814,1,1453,'47-49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1815,2,1454,'Black/Light Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1816,3,1454,'Polyamide 65% Polyamide Microlon 20% Polyproyplene 13% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1817,1,1455,'35-38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1818,1,1456,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1819,2,1457,'Black/Light Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1820,3,1457,'Polyamide 65% Polyamide Microlon 23% Polyproplene 10% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1821,1,1458,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1822,1,1459,'43-46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1823,1,1460,'47-49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1824,2,1461,'Neon Orange/Pink',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1825,3,1461,'Polypropylene 56% Polyamide 41% Elastane 3%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1826,1,1462,'35-38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1827,1,1463,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1828,2,1464,'Neon Green/Yellow',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1829,3,1464,'Polypropylene 56% Polyamide 41% Elastane 3%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1830,1,1465,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1831,1,1466,'43-46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1832,2,1467,'Deep Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1833,3,1467,'Polypropylene 76% Polyamide 22% Carbon 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1834,1,1468,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1835,1,1469,'M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1836,1,1470,'S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1837,2,1471,'Deep Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1838,3,1471,'Polypropylene 76% Polyamide 22% Carbon 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1839,1,1472,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1840,1,1473,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1841,2,1474,'Deep Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1842,3,1474,'Polypropylene 74% Polyamide 21% Elastane 3% Carbon 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1843,1,1475,'L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1844,2,1476,'Deep Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1845,3,1476,'Polypropylene 76% Polyamide 22% Carbon 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1846,1,1477,'XL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1847,2,1478,'Mid Grey/Light Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1848,3,1478,'Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1849,1,1479,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1850,2,1480,'Mid Grey/Light Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1851,3,1480,'Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1852,1,1481,'47-49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1853,2,1482,'Yellow',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1854,3,1482,'THERMOLITE 70% Polyamide 13% Cotton 15% Elastane 2%',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1855,1,1483,'39-42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1856,1,1484,'43-46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1857,3,1485,'100%Merino',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1858,1,1485,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1859,2,1486,'Sky',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1860,2,1487,'Berry',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1861,2,1488,'Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1862,2,1489,'India Paisley Black ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1863,2,1490,'Woodcut Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1864,2,1491,'India Paisley Berry',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1865,3,1492,'100% Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1866,1,1492,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1867,2,1493,'Any Available Style',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1868,3,1494,'100%Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1869,1,1494,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1870,2,1495,'Go Hard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1871,2,1496,'Had Shards ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1872,3,1497,'100% Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1873,1,1497,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1874,2,1498,'Kindazimma - Fleece: Darkblue ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1875,2,1499,'Bear - Bm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1876,2,1500,'Badaboom - Junior - Jm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1877,2,1501,'Mountain\'S Calling - Om',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1878,2,1502,'Howdy - Um',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1879,2,1503,'Japo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1880,2,1504,'Ml-Barrel King',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1881,2,1505,'Patrick Seabase ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1882,3,1506,'100%Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1883,1,1506,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1884,2,1507,'White',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1885,2,1508,'Grass',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1886,2,1509,'Berry ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1887,2,1510,'Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1888,2,1511,'Twister ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1889,2,1512,'Water Colour Pink ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1890,2,1513,'Mali ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1891,2,1514,'Nebula',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1892,2,1515,'Water Colour Black ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1893,2,1516,'Lost Blue',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1894,2,1517,'Smoke',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1895,2,1518,'Dragon Pink',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1896,2,1519,'Mosaik Atari Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1897,2,1520,'Lines Longway Lilac',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1898,2,1521,'Urban Camouflage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1899,2,1522,'Woodcut Blanc ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1900,2,1523,'Crazy Flowers Berry',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1901,2,1524,'Fox Flower Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1902,2,1525,'Comb Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1903,2,1526,'Crazy Flowers Cloud',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1904,2,1527,'Moto Tears Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1905,2,1528,'Identity Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1906,2,1529,'Chinese Dragon Blue',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1907,2,1530,'Moto Tears Red',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1908,2,1531,'Rusties',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1909,2,1532,'Chains ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1910,2,1533,'Pirate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1911,2,1534,'The Mexican',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1912,2,1535,'Pinions ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1913,2,1536,'Nimmaland ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1914,2,1537,'Nautilus ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1915,2,1538,'Arborg ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1916,2,1539,'Buds ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1917,2,1540,'Heidi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1918,2,1541,'Sepp',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1919,2,1542,'Single Karo Mint',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1920,3,1543,'100% Coolmax',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1921,1,1543,'one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1922,2,1544,'Black Eyes Reflective- Bm ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1923,2,1545,'Falcon Eye - Bm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1924,2,1546,'Tricolo - Bm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1925,3,1547,'100% Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1926,1,1547,'one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1927,2,1548,'Coolmax Black Eyes Reflective',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1928,2,1549,'Coolmax Sunset ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1929,2,1550,'Coolmax Temple ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1930,2,1551,'Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1931,2,1552,'Woodcut Sky',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1932,3,1553,'100% Primaloft',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1933,1,1553,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1934,2,1554,'Mt. Everest',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1935,2,1555,'Gulf Stream ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1936,3,1556,'100% Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1937,1,1556,'one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1938,2,1557,'Kaleidoscope Layers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1939,3,1558,'100% Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1940,1,1558,'one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1941,2,1559,'Seabase ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1942,3,1560,'100% Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1943,1,1560,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1944,2,1561,'Black Eyes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1945,3,1562,'100%Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1946,1,1562,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1947,2,1563,'Fading Pink - Fleece: Lightblue',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1948,2,1564,'Peer - Fleece: Camel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1949,2,1565,'Babylon - Fleece: Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1950,2,1566,'Marvin - Fleece: Black ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1951,2,1567,'Chico - Fleece: Camel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1952,2,1568,'Arabesk - Fleece: Camel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1953,2,1569,'Neon Green - Fleece: Black ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1954,2,1570,'Dot Grass - Fleece: Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1955,2,1571,'Rb Confetti Mint - Fleece: Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1956,3,1572,'100%Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1957,1,1572,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1958,2,1573,'Black Eyes - Fleece: Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1959,2,1574,'Sky - Fleece: Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1960,2,1575,'Red - Fleece: Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1961,2,1576,'Skal Deer Black - Fleece: Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1962,2,1577,'Water Colour Pink - Fleece: Fluffy Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1963,3,1578,'100%Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1964,1,1578,'one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1965,2,1579,'Go Hard Reflective - Jm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1966,2,1580,'Drift - Fleece: Red ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1967,3,1581,'100%Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1968,1,1581,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1969,2,1582,'Bugz Blue',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1970,2,1583,'TräCker ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1971,2,1584,'Giraffe ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1972,2,1585,'Eskimo - Fleece: Darkblue',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1973,3,1586,'100%Polyester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1974,1,1586,' one size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',''),(1975,2,1587,'Stripe Beige Blue - Fleece: Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','');
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
  KEY `catalogue_productbrand_f52cfca0` (`slug`)
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
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_productcategory_7f1b40ad` (`product_id`),
  KEY `catalogue_productcategory_6f33f001` (`category_id`),
  CONSTRAINT `category_id_refs_id_3c302fcd` FOREIGN KEY (`category_id`) REFERENCES `catalogue_category` (`id`),
  CONSTRAINT `product_id_refs_id_917d9a41` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogue_productcategory`
--

LOCK TABLES `catalogue_productcategory` WRITE;
/*!40000 ALTER TABLE `catalogue_productcategory` DISABLE KEYS */;
INSERT INTO `catalogue_productcategory` VALUES (413,1347,85),(414,1351,73),(415,1355,73),(416,1355,85),(417,1360,87),(418,1363,89),(419,1366,75),(420,1368,85),(421,1372,85),(422,1376,87),(423,1379,88),(424,1382,73),(425,1382,85),(426,1386,76),(427,1389,75),(428,1392,88),(429,1397,89),(430,1402,75),(431,1406,73),(432,1410,73),(433,1410,85),(434,1414,73),(435,1418,100),(436,1418,107),(437,1422,98),(438,1426,75),(439,1429,76),(440,1432,73),(441,1436,75),(442,1438,88),(443,1442,73),(444,1446,73),(445,1446,85),(446,1449,73),(447,1449,85),(448,1454,85),(449,1457,73),(450,1461,85),(451,1464,73),(452,1467,87),(453,1471,77),(454,1474,85),(455,1476,75),(456,1478,85),(457,1480,73),(458,1482,73),(459,1482,85),(460,1485,73),(461,1485,85),(462,1492,73),(463,1492,85),(464,1494,98),(465,1497,98),(466,1506,73),(467,1506,85),(468,1543,73),(469,1543,85),(470,1547,73),(471,1547,85),(472,1553,73),(473,1553,85),(474,1556,73),(475,1556,85),(476,1558,73),(477,1558,85),(478,1560,73),(479,1560,85),(480,1562,73),(481,1562,85),(482,1572,73),(483,1572,85),(484,1578,73),(485,1578,85),(486,1581,98),(487,1586,98);
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
  UNIQUE KEY `catalogue_productclass_op_productclass_id_415b3580371dcd90_uniq` (`productclass_id`,`option_id`),
  KEY `catalogue_productclass_options_791d7bd9` (`productclass_id`),
  KEY `catalogue_productclass_options_9c74a4f3` (`option_id`),
  CONSTRAINT `option_id_refs_id_75a3ac59` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`),
  CONSTRAINT `productclass_id_refs_id_f7197a0e` FOREIGN KEY (`productclass_id`) REFERENCES `catalogue_productclass` (`id`)
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
  `product_id` int(11) NOT NULL,
  `original` varchar(255) NOT NULL,
  `caption` varchar(200) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogue_productimage_product_id_13868d064d886d95_uniq` (`product_id`,`display_order`),
  KEY `catalogue_productimage_7f1b40ad` (`product_id`),
  CONSTRAINT `product_id_refs_id_f3572348` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
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
  `primary_id` int(11) NOT NULL,
  `recommendation_id` int(11) NOT NULL,
  `ranking` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogue_productrecommendation_07f96664` (`primary_id`),
  KEY `catalogue_productrecommendation_354c84b7` (`recommendation_id`),
  CONSTRAINT `primary_id_refs_id_b3cf0c1f` FOREIGN KEY (`primary_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `recommendation_id_refs_id_b3cf0c1f` FOREIGN KEY (`recommendation_id`) REFERENCES `catalogue_product` (`id`)
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
  `email_subject_template` varchar(255),
  `email_body_template` longtext,
  `email_body_html_template` longtext,
  `sms_template` varchar(170),
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_communicationeventtype_code_1d86b99e1c36eace_uniq` (`code`),
  KEY `customer_communicationeventtype_09bb5fb3` (`code`)
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
  `user_id` int(11) NOT NULL,
  `subject` longtext NOT NULL,
  `body_text` longtext NOT NULL,
  `body_html` longtext NOT NULL,
  `date_sent` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_email_6340c63c` (`user_id`),
  CONSTRAINT `user_id_refs_id_2c2b8797` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_email`
--

LOCK TABLES `customer_email` WRITE;
/*!40000 ALTER TABLE `customer_email` DISABLE KEYS */;
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
  `recipient_id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `category` varchar(255) NOT NULL,
  `location` varchar(32) NOT NULL,
  `date_sent` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_notification_3e31d986` (`recipient_id`),
  KEY `customer_notification_0a681a64` (`sender_id`),
  CONSTRAINT `recipient_id_refs_id_3e5891e5` FOREIGN KEY (`recipient_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `sender_id_refs_id_3e5891e5` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`)
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
  `product_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `key` varchar(128) NOT NULL,
  `status` varchar(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_confirmed` datetime DEFAULT NULL,
  `date_cancelled` datetime DEFAULT NULL,
  `date_closed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_productalert_7f1b40ad` (`product_id`),
  KEY `customer_productalert_6340c63c` (`user_id`),
  KEY `customer_productalert_830a6ccb` (`email`),
  KEY `customer_productalert_c0d4be93` (`key`),
  CONSTRAINT `product_id_refs_id_031af21d` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `user_id_refs_id_e9bed58d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2185 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-10-29 02:12:00',1,16,'1','ProductBrand object',1,''),(2,'2014-10-29 02:12:04',1,16,'2','ProductBrand object',1,''),(3,'2014-10-29 02:12:13',1,16,'2','ProductBrand object',2,'Changed name.'),(4,'2014-10-29 02:12:30',1,17,'1','ProductActivity object',1,''),(5,'2014-10-29 02:12:35',1,17,'2','ProductActivity object',1,''),(6,'2014-10-29 02:13:14',1,17,'3','ProductActivity object',1,''),(7,'2014-10-29 02:13:19',1,17,'4','ProductActivity object',1,''),(8,'2014-10-29 03:04:11',1,16,'3','Charko',1,''),(9,'2014-10-29 03:04:20',1,16,'4','Bourg-de-Peage',1,''),(10,'2014-10-29 03:04:25',1,16,'5','F-Lite',1,''),(11,'2014-10-29 03:04:32',1,16,'6','8BPlus',1,''),(12,'2014-10-29 18:46:40',1,16,'6','8BPlus',2,'Changed slug.'),(13,'2014-10-29 18:46:47',1,16,'5','F-Lite',2,'Changed slug.'),(14,'2014-10-29 18:46:55',1,16,'4','Bourg-de-Peage',2,'Changed slug.'),(15,'2014-10-29 18:46:59',1,16,'4','Bourg-de-Peage',2,'Changed slug.'),(16,'2014-10-29 18:47:03',1,16,'3','Charko',2,'Changed slug.'),(17,'2014-10-29 18:47:07',1,16,'2','Makak',2,'Changed slug.'),(18,'2014-10-29 18:47:12',1,16,'1','H.A.D.',2,'Changed slug.'),(19,'2014-10-29 18:47:21',1,17,'4','Skiing',2,'Changed slug.'),(20,'2014-10-29 18:47:25',1,17,'3','Running',2,'Changed slug.'),(21,'2014-10-29 18:47:31',1,17,'2','Rock Climbing',2,'Changed slug.'),(22,'2014-10-29 18:47:36',1,17,'1','Cycling',2,'Changed slug.'),(23,'2014-10-29 22:16:28',1,20,'55','Brands',3,''),(24,'2014-11-02 12:13:08',1,18,'2','black',3,''),(25,'2014-11-02 12:19:42',1,18,'5','black',3,''),(26,'2014-11-02 12:19:42',1,18,'4','black',3,''),(27,'2014-11-02 12:19:42',1,18,'3','black',3,''),(28,'2014-11-02 12:26:12',1,18,'6','Cycling Boxer sewn upholstery Woman ',3,''),(29,'2014-11-02 13:15:38',1,18,'7','Cycling Boxer sewn upholstery Woman ',3,''),(30,'2014-11-02 13:19:23',1,18,'8','Cycling Boxer Sewn Upholstery Woman ',3,''),(31,'2014-11-02 15:08:25',1,18,'13','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(32,'2014-11-02 15:08:25',1,18,'12','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(33,'2014-11-02 15:08:25',1,18,'11','Cycling Boxer Sewn Upholstery Woman  (Size: S)',3,''),(34,'2014-11-02 15:08:25',1,18,'10','Cycling Boxer Sewn Upholstery Woman ',3,''),(35,'2014-11-02 15:50:12',1,18,'14','Cycling Boxer Sewn Upholstery Woman ',3,''),(36,'2014-11-03 04:11:52',1,18,'148','Skiing Lite  (Size: 43-46)',3,''),(37,'2014-11-03 04:11:52',1,18,'147','Skiing Lite  (Size: 39-42)',3,''),(38,'2014-11-03 04:11:52',1,18,'146','Skiing Lite ',3,''),(39,'2014-11-03 04:11:52',1,18,'145','Skiing Nt P 100 Woman  (Size: 47-49)',3,''),(40,'2014-11-03 04:11:52',1,18,'144','Skiing Nt P 100 Woman  (Size: 39-42)',3,''),(41,'2014-11-03 04:11:52',1,18,'143','Skiing Nt P 100 Woman ',3,''),(42,'2014-11-03 04:11:52',1,18,'142','Ultralight 70 T-Shirt Woman  (Size: XL)',3,''),(43,'2014-11-03 04:11:52',1,18,'141','Ultralight 70 Panty Woman  (Size: L)',3,''),(44,'2014-11-03 04:11:52',1,18,'140','Ultralight 70 Panty Woman ',3,''),(45,'2014-11-03 04:11:52',1,18,'139','Ultralight 70 Tanktop Man  (Size: XL)',3,''),(46,'2014-11-03 04:11:52',1,18,'138','Ultralight 70 Tanktop Man  (Size: L)',3,''),(47,'2014-11-03 04:11:52',1,18,'137','Ultralight 70 Tanktop Man ',3,''),(48,'2014-11-03 04:11:52',1,18,'136','Ultralight 70 T-Shirt Woman  (Size: S)',3,''),(49,'2014-11-03 04:11:52',1,18,'135','Ultralight 70 T-Shirt Woman  (Size: M)',3,''),(50,'2014-11-03 04:11:52',1,18,'134','Ultralight 70 T-Shirt Woman  (Size: L)',3,''),(51,'2014-11-03 04:11:52',1,18,'133','Ultralight 70 T-Shirt Woman ',3,''),(52,'2014-11-03 04:11:52',1,18,'132','Running Mid Woman  (Size: 43-46)',3,''),(53,'2014-11-03 04:11:52',1,18,'131','Running Mid Woman  (Size: 39-42)',3,''),(54,'2014-11-03 04:11:52',1,18,'130','Running Mid Woman  (Size: 39-42)',3,''),(55,'2014-11-03 04:11:52',1,18,'129','Running Mid Woman  (Size: 35-38)',3,''),(56,'2014-11-03 04:11:52',1,18,'128','Running Mid Woman ',3,''),(57,'2014-11-03 04:11:52',1,18,'127','Running High Man  (Size: 47-49)',3,''),(58,'2014-11-03 04:11:52',1,18,'126','Running High Man  (Size: 43-46)',3,''),(59,'2014-11-03 04:11:52',1,18,'125','Running High Man  (Size: 39-42)',3,''),(60,'2014-11-03 04:11:52',1,18,'124','Running High Man ',3,''),(61,'2014-11-03 04:11:52',1,18,'123','Running Short Woman  (Size: 39-42)',3,''),(62,'2014-11-03 04:11:52',1,18,'122','Running Short Woman  (Size: 35-38)',3,''),(63,'2014-11-03 04:11:52',1,18,'121','Running Short Woman ',3,''),(64,'2014-11-03 04:11:52',1,18,'120','Trekking A 100  (Size: 47-49)',3,''),(65,'2014-11-03 04:11:52',1,18,'119','Trekking A 100  (Size: 43-46)',3,''),(66,'2014-11-03 04:11:52',1,18,'118','Trekking A 100  (Size: 39-42)',3,''),(67,'2014-11-03 04:11:52',1,18,'117','Trekking A 100  (Size: 35-38)',3,''),(68,'2014-11-03 04:11:52',1,18,'116','Trekking A 100 ',3,''),(69,'2014-11-03 04:11:52',1,18,'115','Sporting Allround 300  (Size: 47-49)',3,''),(70,'2014-11-03 04:11:52',1,18,'114','Sporting Allround 300  (Size: 39-42)',3,''),(71,'2014-11-03 04:11:52',1,18,'113','Sporting Allround 300 ',3,''),(72,'2014-11-03 04:11:52',1,18,'112','Merino Tec 240 Longtight Man  (Size: XL)',3,''),(73,'2014-11-03 04:11:52',1,18,'111','Merino Tec 240 Longtight Man  (Size: L)',3,''),(74,'2014-11-03 04:11:52',1,18,'110','Merino Tec 240 Longtight Man  (Size: M)',3,''),(75,'2014-11-03 04:11:52',1,18,'109','Merino Tec 240 Longtight Man ',3,''),(76,'2014-11-03 04:11:52',1,18,'108','Merino Tec 240 Longshirt Zipper Woman  (Size: L)',3,''),(77,'2014-11-03 04:11:52',1,18,'107','Merino Tec 240 Longshirt Zipper Woman  (Size: M)',3,''),(78,'2014-11-03 04:11:52',1,18,'106','Merino Tec 240 Longshirt Zipper Woman  (Size: S)',3,''),(79,'2014-11-03 04:11:52',1,18,'105','Merino Tec 240 Longshirt Zipper Woman ',3,''),(80,'2014-11-03 04:11:52',1,18,'104','Merino T-Shirt Man  (Size: L)',3,''),(81,'2014-11-03 04:11:52',1,18,'103','Merino T-Shirt Man ',3,''),(82,'2014-11-03 04:11:52',1,18,'102','Megalight 200 Longtight Man  (Size: XL)',3,''),(83,'2014-11-03 04:11:52',1,18,'101','Megalight 200 Longtight Man  (Size: L)',3,''),(84,'2014-11-03 04:11:52',1,18,'100','Megalight 200 Longtight Man  (Size: M)',3,''),(85,'2014-11-03 04:11:52',1,18,'99','Megalight 200 Longtight Man ',3,''),(86,'2014-11-03 04:11:52',1,18,'98','Megalight 200 Longshirt Man  (Size: XL)',3,''),(87,'2014-11-03 04:11:52',1,18,'97','Megalight 200 Longshirt Man  (Size: L)',3,''),(88,'2014-11-03 04:11:52',1,18,'96','Megalight 200 Longshirt Man ',3,''),(89,'2014-11-03 04:11:52',1,18,'95','Megalight 200 T-Shirt Man  (Size: XL)',3,''),(90,'2014-11-03 04:11:52',1,18,'94','Megalight 200 T-Shirt Man  (Size: L)',3,''),(91,'2014-11-03 04:11:52',1,18,'93','Megalight 200 T-Shirt Man ',3,''),(92,'2014-11-03 04:11:52',1,18,'92','Kids Megalight 140 Boxer Unisex  (Size: 152-164)',3,''),(93,'2014-11-03 04:11:52',1,18,'91','Kids Megalight 140 Boxer Unisex  (Size: 128-140)',3,''),(94,'2014-11-03 04:11:52',1,18,'90','Kids Megalight 140 Boxer Unisex  (Size: 104-116)',3,''),(95,'2014-11-03 04:11:52',1,18,'89','Kids Megalight 140 Boxer Unisex ',3,''),(96,'2014-11-03 04:11:52',1,18,'88','Kids Megalight 140 T-Shirt Unisex  (Size: 152-164)',3,''),(97,'2014-11-03 04:11:52',1,18,'87','Kids Megalight 140 T-Shirt Unisex  (Size: 128-140)',3,''),(98,'2014-11-03 04:11:52',1,18,'86','Kids Megalight 140 T-Shirt Unisex  (Size: 104-116)',3,''),(99,'2014-11-03 04:11:52',1,18,'85','Kids Megalight 140 T-Shirt Unisex ',3,''),(100,'2014-11-03 04:11:52',1,18,'84','Megalight 140 Boxer Man  (Size: XL)',3,''),(101,'2014-11-03 04:11:52',1,18,'83','Megalight 140 Boxer Man  (Size: L)',3,''),(102,'2014-11-03 04:11:52',1,18,'82','Megalight 140 Boxer Man  (Size: M)',3,''),(103,'2014-11-03 04:11:52',1,18,'81','Megalight 140 Boxer Man ',3,''),(104,'2014-11-03 04:11:52',1,18,'80','Megalight 140 3 (Size: 4 Tight Man /XL)',3,''),(105,'2014-11-03 04:11:52',1,18,'79','Megalight 140 3 (Size: 4 Tight Man /L)',3,''),(106,'2014-11-03 04:11:52',1,18,'78','Megalight 140 3 (Size: 4 Tight Man /M)',3,''),(107,'2014-11-03 04:11:52',1,18,'77','Megalight 140 3',3,''),(108,'2014-11-03 04:11:52',1,18,'76','Megalight 140 Longtight Man  (Size: XL)',3,''),(109,'2014-11-03 04:11:52',1,18,'75','Megalight 140 Longtight Man  (Size: L)',3,''),(110,'2014-11-03 04:11:52',1,18,'74','Megalight 140 Longtight Man  (Size: M)',3,''),(111,'2014-11-03 04:11:52',1,18,'73','Megalight 140 Longtight Man ',3,''),(112,'2014-11-03 04:11:52',1,18,'72','Megalight 140 T-Shirt Man  (Size: XL)',3,''),(113,'2014-11-03 04:11:52',1,18,'71','Megalight 140 T-Shirt Man  (Size: L)',3,''),(114,'2014-11-03 04:11:52',1,18,'70','Megalight 140 T-Shirt Man  (Size: M)',3,''),(115,'2014-11-03 04:11:52',1,18,'69','Megalight 140 T-Shirt Man ',3,''),(116,'2014-11-03 04:11:52',1,18,'68','Megalight 140 Tanktop Woman  (Size: XL)',3,''),(117,'2014-11-03 04:11:52',1,18,'67','Megalight 140 Tanktop Woman  (Size: L)',3,''),(118,'2014-11-03 04:11:52',1,18,'66','Megalight 140 Tanktop Woman  (Size: M)',3,''),(119,'2014-11-03 04:11:52',1,18,'65','Megalight 140 Tanktop Woman  (Size: S)',3,''),(120,'2014-11-03 04:11:52',1,18,'64','Megalight 140 Tanktop Woman ',3,''),(121,'2014-11-03 04:11:52',1,18,'63','Megalight 140 Longshirt Woman  (Size: XL)',3,''),(122,'2014-11-03 04:11:52',1,18,'62','Megalight 140 Longshirt Woman  (Size: L)',3,''),(123,'2014-11-03 04:11:52',1,18,'61','Megalight 140 Longshirt Woman  (Size: M)',3,''),(124,'2014-11-03 04:11:52',1,18,'60','Megalight 140 Longshirt Woman  (Size: S)',3,''),(125,'2014-11-03 04:11:52',1,18,'59','Megalight 140 Longshirt Woman ',3,''),(126,'2014-11-03 04:11:52',1,18,'58','Megalight 140 T-Shirt Berry Woman  (Size: XL)',3,''),(127,'2014-11-03 04:11:52',1,18,'57','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(128,'2014-11-03 04:11:52',1,18,'56','Megalight 140 Longshirt Berry Woman  (Size: XL)',3,''),(129,'2014-11-03 04:11:52',1,18,'55','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(130,'2014-11-03 04:11:52',1,18,'54','Megalight 140 1 (Size: 2 Short Man /XL)',3,''),(131,'2014-11-03 04:11:52',1,18,'53','Megalight 140 1 (Size: 2 Short Man /L)',3,''),(132,'2014-11-03 04:11:52',1,18,'52','Megalight 140 1 (Size: 2 Short Man /M)',3,''),(133,'2014-11-03 04:11:52',1,18,'51','Megalight 140 1',3,''),(134,'2014-11-03 04:11:52',1,18,'50','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(135,'2014-11-03 04:11:52',1,18,'49','Megalight 140 Longshirt Berry Woman  (Size: M)',3,''),(136,'2014-11-03 04:11:52',1,18,'48','Megalight 140 Longshirt Berry Woman ',3,''),(137,'2014-11-03 04:11:52',1,18,'47','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(138,'2014-11-03 04:11:52',1,18,'46','Megalight 140 T-Shirt Berry Woman  (Size: M)',3,''),(139,'2014-11-03 04:11:52',1,18,'45','Megalight 140 T-Shirt Berry Woman ',3,''),(140,'2014-11-03 04:11:52',1,18,'44','Megalight 140 Longtight Berry Woman  (Size: L)',3,''),(141,'2014-11-03 04:11:52',1,18,'43','Megalight 140 Longtight Berry Woman  (Size: M)',3,''),(142,'2014-11-03 04:11:52',1,18,'42','Megalight 140 Longtight Berry Woman  (Size: S)',3,''),(143,'2014-11-03 04:11:52',1,18,'41','Megalight 140 Longtight Berry Woman ',3,''),(144,'2014-11-03 04:11:52',1,18,'40','Megalight 140 Singlet Berry Woman  (Size: L)',3,''),(145,'2014-11-03 04:11:52',1,18,'39','Megalight 140 Singlet Berry Woman  (Size: M)',3,''),(146,'2014-11-03 04:11:52',1,18,'38','Megalight 140 Singlet Berry Woman  (Size: S)',3,''),(147,'2014-11-03 04:11:52',1,18,'37','Megalight 140 Singlet Berry Woman ',3,''),(148,'2014-11-03 04:11:52',1,18,'36','Organic Bamboo T-Shirt Woman  (Size: XL)',3,''),(149,'2014-11-03 04:11:52',1,18,'35','Organic Bamboo Tanktop Woman  (Size: L)',3,''),(150,'2014-11-03 04:11:52',1,18,'34','Organic Bamboo Tanktop Woman  (Size: M)',3,''),(151,'2014-11-03 04:11:52',1,18,'33','Organic Bamboo Tanktop Woman ',3,''),(152,'2014-11-03 04:11:52',1,18,'32','Organic Bamboo T-Shirt Woman  (Size: L)',3,''),(153,'2014-11-03 04:11:52',1,18,'31','Organic Bamboo T-Shirt Woman  (Size: M)',3,''),(154,'2014-11-03 04:11:52',1,18,'30','Organic Bamboo T-Shirt Woman ',3,''),(155,'2014-11-03 04:11:52',1,18,'29','Mittens (Flap) Gloves  (Size: XL)',3,''),(156,'2014-11-03 04:11:52',1,18,'28','Mittens (Flap) Gloves  (Size: L)',3,''),(157,'2014-11-03 04:11:52',1,18,'27','Mittens (Flap) Gloves  (Size: S)',3,''),(158,'2014-11-03 04:11:52',1,18,'26','Mittens (Flap) Gloves  (Size: XS)',3,''),(159,'2014-11-03 04:11:52',1,18,'25','Mittens (Flap) Gloves ',3,''),(160,'2014-11-03 04:11:52',1,18,'24','Cycling Boxer Sewn Upholstery Woman  (Size: XL)',3,''),(161,'2014-11-03 04:11:52',1,18,'23','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(162,'2014-11-03 04:11:52',1,18,'22','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(163,'2014-11-03 04:11:52',1,18,'21','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(164,'2014-11-03 04:11:52',1,18,'20','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(165,'2014-11-03 04:11:52',1,18,'19','Cycling Boxer Sewn Upholstery Woman  (Size: S)',3,''),(166,'2014-11-03 04:11:52',1,18,'18','Cycling Boxer Sewn Upholstery Woman ',3,''),(167,'2014-11-03 04:11:52',1,18,'1','Makak Dress Shirt',3,''),(168,'2014-11-03 04:16:21',1,18,'152','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(169,'2014-11-03 04:16:21',1,18,'151','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(170,'2014-11-03 04:16:21',1,18,'150','Cycling Boxer Sewn Upholstery Woman  (Size: S)',3,''),(171,'2014-11-03 04:16:21',1,18,'149','Cycling Boxer Sewn Upholstery Woman ',3,''),(172,'2014-11-03 04:17:13',1,18,'153','Cycling Boxer Sewn Upholstery Woman ',3,''),(173,'2014-11-03 04:27:01',1,18,'154','Cycling Boxer Sewn Upholstery Woman ',3,''),(174,'2014-11-03 04:27:49',1,18,'155','Cycling Boxer Sewn Upholstery Woman ',3,''),(175,'2014-11-03 04:28:56',1,18,'156','Cycling Boxer Sewn Upholstery Woman ',3,''),(176,'2014-11-03 04:30:16',1,18,'157','Cycling Boxer Sewn Upholstery Woman ',3,''),(177,'2014-11-03 04:30:58',1,18,'158','Cycling Boxer Sewn Upholstery Woman ',3,''),(178,'2014-11-03 04:37:12',1,18,'159','Cycling Boxer Sewn Upholstery Woman ',3,''),(179,'2014-11-03 04:38:55',1,18,'160','Cycling Boxer Sewn Upholstery Woman ',3,''),(180,'2014-11-03 04:43:29',1,18,'161','Cycling Boxer Sewn Upholstery Woman ',3,''),(181,'2014-11-03 04:45:36',1,18,'162','Cycling Boxer Sewn Upholstery Woman ',3,''),(182,'2014-11-03 04:47:49',1,18,'163','Cycling Boxer Sewn Upholstery Woman ',3,''),(183,'2014-11-03 04:49:58',1,18,'164','Cycling Boxer Sewn Upholstery Woman ',3,''),(184,'2014-11-03 04:53:47',1,18,'165','Cycling Boxer Sewn Upholstery Woman ',3,''),(185,'2014-11-03 04:56:01',1,18,'166','Cycling Boxer Sewn Upholstery Woman ',3,''),(186,'2014-11-03 05:07:08',1,18,'297','Skiing Lite  (Size: 43-46)',3,''),(187,'2014-11-03 05:07:08',1,18,'296','Skiing Lite  (Size: 39-42)',3,''),(188,'2014-11-03 05:07:08',1,18,'295','Skiing Lite ',3,''),(189,'2014-11-03 05:07:08',1,18,'294','Skiing Nt P 100 Woman  (Size: 47-49)',3,''),(190,'2014-11-03 05:07:08',1,18,'293','Skiing Nt P 100 Woman  (Size: 39-42)',3,''),(191,'2014-11-03 05:07:08',1,18,'292','Skiing Nt P 100 Woman ',3,''),(192,'2014-11-03 05:07:08',1,18,'291','Ultralight 70 T-Shirt Woman  (Size: XL)',3,''),(193,'2014-11-03 05:07:08',1,18,'290','Ultralight 70 Panty Woman  (Size: L)',3,''),(194,'2014-11-03 05:07:08',1,18,'289','Ultralight 70 Panty Woman ',3,''),(195,'2014-11-03 05:07:08',1,18,'288','Ultralight 70 Tanktop Man  (Size: XL)',3,''),(196,'2014-11-03 05:07:08',1,18,'287','Ultralight 70 Tanktop Man  (Size: L)',3,''),(197,'2014-11-03 05:07:08',1,18,'286','Ultralight 70 Tanktop Man ',3,''),(198,'2014-11-03 05:07:08',1,18,'285','Ultralight 70 T-Shirt Woman  (Size: S)',3,''),(199,'2014-11-03 05:07:08',1,18,'284','Ultralight 70 T-Shirt Woman  (Size: M)',3,''),(200,'2014-11-03 05:07:08',1,18,'283','Ultralight 70 T-Shirt Woman  (Size: L)',3,''),(201,'2014-11-03 05:07:08',1,18,'282','Ultralight 70 T-Shirt Woman ',3,''),(202,'2014-11-03 05:07:08',1,18,'281','Running Mid Woman  (Size: 43-46)',3,''),(203,'2014-11-03 05:07:08',1,18,'280','Running Mid Woman  (Size: 39-42)',3,''),(204,'2014-11-03 05:07:08',1,18,'279','Running Mid Woman  (Size: 39-42)',3,''),(205,'2014-11-03 05:07:08',1,18,'278','Running Mid Woman  (Size: 35-38)',3,''),(206,'2014-11-03 05:07:08',1,18,'277','Running Mid Woman ',3,''),(207,'2014-11-03 05:07:08',1,18,'276','Running High Man  (Size: 47-49)',3,''),(208,'2014-11-03 05:07:08',1,18,'275','Running High Man  (Size: 43-46)',3,''),(209,'2014-11-03 05:07:08',1,18,'274','Running High Man  (Size: 39-42)',3,''),(210,'2014-11-03 05:07:08',1,18,'273','Running High Man ',3,''),(211,'2014-11-03 05:07:08',1,18,'272','Running Short Woman  (Size: 39-42)',3,''),(212,'2014-11-03 05:07:08',1,18,'271','Running Short Woman  (Size: 35-38)',3,''),(213,'2014-11-03 05:07:08',1,18,'270','Running Short Woman ',3,''),(214,'2014-11-03 05:07:08',1,18,'269','Trekking A 100  (Size: 47-49)',3,''),(215,'2014-11-03 05:07:08',1,18,'268','Trekking A 100  (Size: 43-46)',3,''),(216,'2014-11-03 05:07:08',1,18,'267','Trekking A 100  (Size: 39-42)',3,''),(217,'2014-11-03 05:07:08',1,18,'266','Trekking A 100  (Size: 35-38)',3,''),(218,'2014-11-03 05:07:08',1,18,'265','Trekking A 100 ',3,''),(219,'2014-11-03 05:07:08',1,18,'264','Sporting Allround 300  (Size: 47-49)',3,''),(220,'2014-11-03 05:07:08',1,18,'263','Sporting Allround 300  (Size: 39-42)',3,''),(221,'2014-11-03 05:07:08',1,18,'262','Sporting Allround 300 ',3,''),(222,'2014-11-03 05:07:08',1,18,'261','Merino Tec 240 Longtight Man  (Size: XL)',3,''),(223,'2014-11-03 05:07:08',1,18,'260','Merino Tec 240 Longtight Man  (Size: L)',3,''),(224,'2014-11-03 05:07:08',1,18,'259','Merino Tec 240 Longtight Man  (Size: M)',3,''),(225,'2014-11-03 05:07:08',1,18,'258','Merino Tec 240 Longtight Man ',3,''),(226,'2014-11-03 05:07:08',1,18,'257','Merino Tec 240 Longshirt Zipper Woman  (Size: L)',3,''),(227,'2014-11-03 05:07:08',1,18,'256','Merino Tec 240 Longshirt Zipper Woman  (Size: M)',3,''),(228,'2014-11-03 05:07:08',1,18,'255','Merino Tec 240 Longshirt Zipper Woman  (Size: S)',3,''),(229,'2014-11-03 05:07:08',1,18,'254','Merino Tec 240 Longshirt Zipper Woman ',3,''),(230,'2014-11-03 05:07:08',1,18,'253','Merino T-Shirt Man  (Size: L)',3,''),(231,'2014-11-03 05:07:08',1,18,'252','Merino T-Shirt Man ',3,''),(232,'2014-11-03 05:07:08',1,18,'251','Megalight 200 Longtight Man  (Size: XL)',3,''),(233,'2014-11-03 05:07:08',1,18,'250','Megalight 200 Longtight Man  (Size: L)',3,''),(234,'2014-11-03 05:07:08',1,18,'249','Megalight 200 Longtight Man  (Size: M)',3,''),(235,'2014-11-03 05:07:08',1,18,'248','Megalight 200 Longtight Man ',3,''),(236,'2014-11-03 05:07:08',1,18,'247','Megalight 200 Longshirt Man  (Size: XL)',3,''),(237,'2014-11-03 05:07:08',1,18,'246','Megalight 200 Longshirt Man  (Size: L)',3,''),(238,'2014-11-03 05:07:08',1,18,'245','Megalight 200 Longshirt Man ',3,''),(239,'2014-11-03 05:07:08',1,18,'244','Megalight 200 T-Shirt Man  (Size: XL)',3,''),(240,'2014-11-03 05:07:08',1,18,'243','Megalight 200 T-Shirt Man  (Size: L)',3,''),(241,'2014-11-03 05:07:08',1,18,'242','Megalight 200 T-Shirt Man ',3,''),(242,'2014-11-03 05:07:08',1,18,'241','Kids Megalight 140 Boxer Unisex  (Size: 152-164)',3,''),(243,'2014-11-03 05:07:08',1,18,'240','Kids Megalight 140 Boxer Unisex  (Size: 128-140)',3,''),(244,'2014-11-03 05:07:08',1,18,'239','Kids Megalight 140 Boxer Unisex  (Size: 104-116)',3,''),(245,'2014-11-03 05:07:08',1,18,'238','Kids Megalight 140 Boxer Unisex ',3,''),(246,'2014-11-03 05:07:08',1,18,'237','Kids Megalight 140 T-Shirt Unisex  (Size: 152-164)',3,''),(247,'2014-11-03 05:07:08',1,18,'236','Kids Megalight 140 T-Shirt Unisex  (Size: 128-140)',3,''),(248,'2014-11-03 05:07:08',1,18,'235','Kids Megalight 140 T-Shirt Unisex  (Size: 104-116)',3,''),(249,'2014-11-03 05:07:08',1,18,'234','Kids Megalight 140 T-Shirt Unisex ',3,''),(250,'2014-11-03 05:07:08',1,18,'233','Megalight 140 Boxer Man  (Size: XL)',3,''),(251,'2014-11-03 05:07:08',1,18,'232','Megalight 140 Boxer Man  (Size: L)',3,''),(252,'2014-11-03 05:07:08',1,18,'231','Megalight 140 Boxer Man  (Size: M)',3,''),(253,'2014-11-03 05:07:08',1,18,'230','Megalight 140 Boxer Man ',3,''),(254,'2014-11-03 05:07:08',1,18,'229','Megalight 140 3 (Size: 4 Tight Man /XL)',3,''),(255,'2014-11-03 05:07:08',1,18,'228','Megalight 140 3 (Size: 4 Tight Man /L)',3,''),(256,'2014-11-03 05:07:08',1,18,'227','Megalight 140 3 (Size: 4 Tight Man /M)',3,''),(257,'2014-11-03 05:07:08',1,18,'226','Megalight 140 3',3,''),(258,'2014-11-03 05:07:08',1,18,'225','Megalight 140 Longtight Man  (Size: XL)',3,''),(259,'2014-11-03 05:07:08',1,18,'224','Megalight 140 Longtight Man  (Size: L)',3,''),(260,'2014-11-03 05:07:08',1,18,'223','Megalight 140 Longtight Man  (Size: M)',3,''),(261,'2014-11-03 05:07:08',1,18,'222','Megalight 140 Longtight Man ',3,''),(262,'2014-11-03 05:07:08',1,18,'221','Megalight 140 T-Shirt Man  (Size: XL)',3,''),(263,'2014-11-03 05:07:08',1,18,'220','Megalight 140 T-Shirt Man  (Size: L)',3,''),(264,'2014-11-03 05:07:08',1,18,'219','Megalight 140 T-Shirt Man  (Size: M)',3,''),(265,'2014-11-03 05:07:08',1,18,'218','Megalight 140 T-Shirt Man ',3,''),(266,'2014-11-03 05:07:08',1,18,'217','Megalight 140 Tanktop Woman  (Size: XL)',3,''),(267,'2014-11-03 05:07:08',1,18,'216','Megalight 140 Tanktop Woman  (Size: L)',3,''),(268,'2014-11-03 05:07:08',1,18,'215','Megalight 140 Tanktop Woman  (Size: M)',3,''),(269,'2014-11-03 05:07:08',1,18,'214','Megalight 140 Tanktop Woman  (Size: S)',3,''),(270,'2014-11-03 05:07:08',1,18,'213','Megalight 140 Tanktop Woman ',3,''),(271,'2014-11-03 05:07:08',1,18,'212','Megalight 140 Longshirt Woman  (Size: XL)',3,''),(272,'2014-11-03 05:07:08',1,18,'211','Megalight 140 Longshirt Woman  (Size: L)',3,''),(273,'2014-11-03 05:07:08',1,18,'210','Megalight 140 Longshirt Woman  (Size: M)',3,''),(274,'2014-11-03 05:07:08',1,18,'209','Megalight 140 Longshirt Woman  (Size: S)',3,''),(275,'2014-11-03 05:07:08',1,18,'208','Megalight 140 Longshirt Woman ',3,''),(276,'2014-11-03 05:07:08',1,18,'207','Megalight 140 T-Shirt Berry Woman  (Size: XL)',3,''),(277,'2014-11-03 05:07:08',1,18,'206','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(278,'2014-11-03 05:07:08',1,18,'205','Megalight 140 Longshirt Berry Woman  (Size: XL)',3,''),(279,'2014-11-03 05:07:08',1,18,'204','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(280,'2014-11-03 05:07:08',1,18,'203','Megalight 140 1 (Size: 2 Short Man /XL)',3,''),(281,'2014-11-03 05:07:08',1,18,'202','Megalight 140 1 (Size: 2 Short Man /L)',3,''),(282,'2014-11-03 05:07:08',1,18,'201','Megalight 140 1 (Size: 2 Short Man /M)',3,''),(283,'2014-11-03 05:07:08',1,18,'200','Megalight 140 1',3,''),(284,'2014-11-03 05:07:08',1,18,'199','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(285,'2014-11-03 05:07:08',1,18,'198','Megalight 140 Longshirt Berry Woman  (Size: M)',3,''),(286,'2014-11-03 05:07:08',1,18,'197','Megalight 140 Longshirt Berry Woman ',3,''),(287,'2014-11-03 05:07:08',1,18,'196','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(288,'2014-11-03 05:07:08',1,18,'195','Megalight 140 T-Shirt Berry Woman  (Size: M)',3,''),(289,'2014-11-03 05:07:08',1,18,'194','Megalight 140 T-Shirt Berry Woman ',3,''),(290,'2014-11-03 05:07:08',1,18,'193','Megalight 140 Longtight Berry Woman  (Size: L)',3,''),(291,'2014-11-03 05:07:08',1,18,'192','Megalight 140 Longtight Berry Woman  (Size: M)',3,''),(292,'2014-11-03 05:07:08',1,18,'191','Megalight 140 Longtight Berry Woman  (Size: S)',3,''),(293,'2014-11-03 05:07:08',1,18,'190','Megalight 140 Longtight Berry Woman ',3,''),(294,'2014-11-03 05:07:08',1,18,'189','Megalight 140 Singlet Berry Woman  (Size: L)',3,''),(295,'2014-11-03 05:07:08',1,18,'188','Megalight 140 Singlet Berry Woman  (Size: M)',3,''),(296,'2014-11-03 05:07:08',1,18,'187','Megalight 140 Singlet Berry Woman  (Size: S)',3,''),(297,'2014-11-03 05:07:08',1,18,'186','Megalight 140 Singlet Berry Woman ',3,''),(298,'2014-11-03 05:07:08',1,18,'185','Organic Bamboo T-Shirt Woman  (Size: XL)',3,''),(299,'2014-11-03 05:07:08',1,18,'184','Organic Bamboo Tanktop Woman  (Size: L)',3,''),(300,'2014-11-03 05:07:08',1,18,'183','Organic Bamboo Tanktop Woman  (Size: M)',3,''),(301,'2014-11-03 05:07:08',1,18,'182','Organic Bamboo Tanktop Woman ',3,''),(302,'2014-11-03 05:07:08',1,18,'181','Organic Bamboo T-Shirt Woman  (Size: L)',3,''),(303,'2014-11-03 05:07:08',1,18,'180','Organic Bamboo T-Shirt Woman  (Size: M)',3,''),(304,'2014-11-03 05:07:08',1,18,'179','Organic Bamboo T-Shirt Woman ',3,''),(305,'2014-11-03 05:07:08',1,18,'178','Mittens (Flap) Gloves  (Size: XL)',3,''),(306,'2014-11-03 05:07:08',1,18,'177','Mittens (Flap) Gloves  (Size: L)',3,''),(307,'2014-11-03 05:07:08',1,18,'176','Mittens (Flap) Gloves  (Size: S)',3,''),(308,'2014-11-03 05:07:08',1,18,'175','Mittens (Flap) Gloves  (Size: XS)',3,''),(309,'2014-11-03 05:07:08',1,18,'174','Mittens (Flap) Gloves ',3,''),(310,'2014-11-03 05:07:08',1,18,'173','Cycling Boxer Sewn Upholstery Woman  (Size: XL)',3,''),(311,'2014-11-03 05:07:08',1,18,'172','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(312,'2014-11-03 05:07:08',1,18,'171','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(313,'2014-11-03 05:07:08',1,18,'170','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(314,'2014-11-03 05:07:08',1,18,'169','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(315,'2014-11-03 05:07:08',1,18,'168','Cycling Boxer Sewn Upholstery Woman  (Size: S)',3,''),(316,'2014-11-03 05:07:08',1,18,'167','Cycling Boxer Sewn Upholstery Woman ',3,''),(317,'2014-11-03 05:10:46',1,18,'428','Skiing Lite  (Size: 43-46)',3,''),(318,'2014-11-03 05:10:46',1,18,'427','Skiing Lite  (Size: 39-42)',3,''),(319,'2014-11-03 05:10:46',1,18,'426','Skiing Lite ',3,''),(320,'2014-11-03 05:10:46',1,18,'425','Skiing Nt P 100 Woman  (Size: 47-49)',3,''),(321,'2014-11-03 05:10:46',1,18,'424','Skiing Nt P 100 Woman  (Size: 39-42)',3,''),(322,'2014-11-03 05:10:46',1,18,'423','Skiing Nt P 100 Woman ',3,''),(323,'2014-11-03 05:10:46',1,18,'422','Ultralight 70 T-Shirt Woman  (Size: XL)',3,''),(324,'2014-11-03 05:10:46',1,18,'421','Ultralight 70 Panty Woman  (Size: L)',3,''),(325,'2014-11-03 05:10:46',1,18,'420','Ultralight 70 Panty Woman ',3,''),(326,'2014-11-03 05:10:46',1,18,'419','Ultralight 70 Tanktop Man  (Size: XL)',3,''),(327,'2014-11-03 05:10:46',1,18,'418','Ultralight 70 Tanktop Man  (Size: L)',3,''),(328,'2014-11-03 05:10:46',1,18,'417','Ultralight 70 Tanktop Man ',3,''),(329,'2014-11-03 05:10:46',1,18,'416','Ultralight 70 T-Shirt Woman  (Size: S)',3,''),(330,'2014-11-03 05:10:46',1,18,'415','Ultralight 70 T-Shirt Woman  (Size: M)',3,''),(331,'2014-11-03 05:10:46',1,18,'414','Ultralight 70 T-Shirt Woman  (Size: L)',3,''),(332,'2014-11-03 05:10:46',1,18,'413','Ultralight 70 T-Shirt Woman ',3,''),(333,'2014-11-03 05:10:46',1,18,'412','Running Mid Woman  (Size: 43-46)',3,''),(334,'2014-11-03 05:10:46',1,18,'411','Running Mid Woman  (Size: 39-42)',3,''),(335,'2014-11-03 05:10:46',1,18,'410','Running Mid Woman  (Size: 39-42)',3,''),(336,'2014-11-03 05:10:46',1,18,'409','Running Mid Woman  (Size: 35-38)',3,''),(337,'2014-11-03 05:10:46',1,18,'408','Running Mid Woman ',3,''),(338,'2014-11-03 05:10:46',1,18,'407','Running High Man  (Size: 47-49)',3,''),(339,'2014-11-03 05:10:46',1,18,'406','Running High Man  (Size: 43-46)',3,''),(340,'2014-11-03 05:10:46',1,18,'405','Running High Man  (Size: 39-42)',3,''),(341,'2014-11-03 05:10:46',1,18,'404','Running High Man ',3,''),(342,'2014-11-03 05:10:46',1,18,'403','Running Short Woman  (Size: 39-42)',3,''),(343,'2014-11-03 05:10:46',1,18,'402','Running Short Woman  (Size: 35-38)',3,''),(344,'2014-11-03 05:10:46',1,18,'401','Running Short Woman ',3,''),(345,'2014-11-03 05:10:46',1,18,'400','Trekking A 100  (Size: 47-49)',3,''),(346,'2014-11-03 05:10:46',1,18,'399','Trekking A 100  (Size: 43-46)',3,''),(347,'2014-11-03 05:10:46',1,18,'398','Trekking A 100  (Size: 39-42)',3,''),(348,'2014-11-03 05:10:46',1,18,'397','Trekking A 100  (Size: 35-38)',3,''),(349,'2014-11-03 05:10:46',1,18,'396','Trekking A 100 ',3,''),(350,'2014-11-03 05:10:46',1,18,'395','Sporting Allround 300  (Size: 47-49)',3,''),(351,'2014-11-03 05:10:46',1,18,'394','Sporting Allround 300  (Size: 39-42)',3,''),(352,'2014-11-03 05:10:46',1,18,'393','Sporting Allround 300 ',3,''),(353,'2014-11-03 05:10:46',1,18,'392','Merino Tec 240 Longtight Man  (Size: XL)',3,''),(354,'2014-11-03 05:10:46',1,18,'391','Merino Tec 240 Longtight Man  (Size: L)',3,''),(355,'2014-11-03 05:10:46',1,18,'390','Merino Tec 240 Longtight Man  (Size: M)',3,''),(356,'2014-11-03 05:10:46',1,18,'389','Merino Tec 240 Longtight Man ',3,''),(357,'2014-11-03 05:10:46',1,18,'388','Merino Tec 240 Longshirt Zipper Woman  (Size: L)',3,''),(358,'2014-11-03 05:10:46',1,18,'387','Merino Tec 240 Longshirt Zipper Woman  (Size: M)',3,''),(359,'2014-11-03 05:10:46',1,18,'386','Merino Tec 240 Longshirt Zipper Woman  (Size: S)',3,''),(360,'2014-11-03 05:10:46',1,18,'385','Merino Tec 240 Longshirt Zipper Woman ',3,''),(361,'2014-11-03 05:10:46',1,18,'384','Merino T-Shirt Man  (Size: L)',3,''),(362,'2014-11-03 05:10:46',1,18,'383','Merino T-Shirt Man ',3,''),(363,'2014-11-03 05:10:46',1,18,'382','Megalight 200 Longtight Man  (Size: XL)',3,''),(364,'2014-11-03 05:10:46',1,18,'381','Megalight 200 Longtight Man  (Size: L)',3,''),(365,'2014-11-03 05:10:46',1,18,'380','Megalight 200 Longtight Man  (Size: M)',3,''),(366,'2014-11-03 05:10:46',1,18,'379','Megalight 200 Longtight Man ',3,''),(367,'2014-11-03 05:10:47',1,18,'378','Megalight 200 Longshirt Man  (Size: XL)',3,''),(368,'2014-11-03 05:10:47',1,18,'377','Megalight 200 Longshirt Man  (Size: L)',3,''),(369,'2014-11-03 05:10:47',1,18,'376','Megalight 200 Longshirt Man ',3,''),(370,'2014-11-03 05:10:47',1,18,'375','Megalight 200 T-Shirt Man  (Size: XL)',3,''),(371,'2014-11-03 05:10:47',1,18,'374','Megalight 200 T-Shirt Man  (Size: L)',3,''),(372,'2014-11-03 05:10:47',1,18,'373','Megalight 200 T-Shirt Man ',3,''),(373,'2014-11-03 05:10:47',1,18,'372','Kids Megalight 140 Boxer Unisex  (Size: 152-164)',3,''),(374,'2014-11-03 05:10:47',1,18,'371','Kids Megalight 140 Boxer Unisex  (Size: 128-140)',3,''),(375,'2014-11-03 05:10:47',1,18,'370','Kids Megalight 140 Boxer Unisex  (Size: 104-116)',3,''),(376,'2014-11-03 05:10:47',1,18,'369','Kids Megalight 140 Boxer Unisex ',3,''),(377,'2014-11-03 05:10:47',1,18,'368','Kids Megalight 140 T-Shirt Unisex  (Size: 152-164)',3,''),(378,'2014-11-03 05:10:47',1,18,'367','Kids Megalight 140 T-Shirt Unisex  (Size: 128-140)',3,''),(379,'2014-11-03 05:10:47',1,18,'366','Kids Megalight 140 T-Shirt Unisex  (Size: 104-116)',3,''),(380,'2014-11-03 05:10:47',1,18,'365','Kids Megalight 140 T-Shirt Unisex ',3,''),(381,'2014-11-03 05:10:47',1,18,'364','Megalight 140 Boxer Man  (Size: XL)',3,''),(382,'2014-11-03 05:10:47',1,18,'363','Megalight 140 Boxer Man  (Size: L)',3,''),(383,'2014-11-03 05:10:47',1,18,'362','Megalight 140 Boxer Man  (Size: M)',3,''),(384,'2014-11-03 05:10:47',1,18,'361','Megalight 140 Boxer Man ',3,''),(385,'2014-11-03 05:10:47',1,18,'360','Megalight 140 3 (Size: 4 Tight Man /XL)',3,''),(386,'2014-11-03 05:10:47',1,18,'359','Megalight 140 3 (Size: 4 Tight Man /L)',3,''),(387,'2014-11-03 05:10:47',1,18,'358','Megalight 140 3 (Size: 4 Tight Man /M)',3,''),(388,'2014-11-03 05:10:47',1,18,'357','Megalight 140 3',3,''),(389,'2014-11-03 05:10:47',1,18,'356','Megalight 140 Longtight Man  (Size: XL)',3,''),(390,'2014-11-03 05:10:47',1,18,'355','Megalight 140 Longtight Man  (Size: L)',3,''),(391,'2014-11-03 05:10:47',1,18,'354','Megalight 140 Longtight Man  (Size: M)',3,''),(392,'2014-11-03 05:10:47',1,18,'353','Megalight 140 Longtight Man ',3,''),(393,'2014-11-03 05:10:47',1,18,'352','Megalight 140 T-Shirt Man  (Size: XL)',3,''),(394,'2014-11-03 05:10:47',1,18,'351','Megalight 140 T-Shirt Man  (Size: L)',3,''),(395,'2014-11-03 05:10:47',1,18,'350','Megalight 140 T-Shirt Man  (Size: M)',3,''),(396,'2014-11-03 05:10:47',1,18,'349','Megalight 140 T-Shirt Man ',3,''),(397,'2014-11-03 05:10:47',1,18,'348','Megalight 140 Tanktop Woman  (Size: XL)',3,''),(398,'2014-11-03 05:10:47',1,18,'347','Megalight 140 Tanktop Woman  (Size: L)',3,''),(399,'2014-11-03 05:10:47',1,18,'346','Megalight 140 Tanktop Woman  (Size: M)',3,''),(400,'2014-11-03 05:10:47',1,18,'345','Megalight 140 Tanktop Woman  (Size: S)',3,''),(401,'2014-11-03 05:10:47',1,18,'344','Megalight 140 Tanktop Woman ',3,''),(402,'2014-11-03 05:10:47',1,18,'343','Megalight 140 Longshirt Woman  (Size: XL)',3,''),(403,'2014-11-03 05:10:47',1,18,'342','Megalight 140 Longshirt Woman  (Size: L)',3,''),(404,'2014-11-03 05:10:47',1,18,'341','Megalight 140 Longshirt Woman  (Size: M)',3,''),(405,'2014-11-03 05:10:47',1,18,'340','Megalight 140 Longshirt Woman  (Size: S)',3,''),(406,'2014-11-03 05:10:47',1,18,'339','Megalight 140 Longshirt Woman ',3,''),(407,'2014-11-03 05:10:47',1,18,'338','Megalight 140 T-Shirt Berry Woman  (Size: XL)',3,''),(408,'2014-11-03 05:10:47',1,18,'337','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(409,'2014-11-03 05:10:47',1,18,'336','Megalight 140 Longshirt Berry Woman  (Size: XL)',3,''),(410,'2014-11-03 05:10:47',1,18,'335','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(411,'2014-11-03 05:10:47',1,18,'334','Megalight 140 1 (Size: 2 Short Man /XL)',3,''),(412,'2014-11-03 05:10:47',1,18,'333','Megalight 140 1 (Size: 2 Short Man /L)',3,''),(413,'2014-11-03 05:10:47',1,18,'332','Megalight 140 1 (Size: 2 Short Man /M)',3,''),(414,'2014-11-03 05:10:47',1,18,'331','Megalight 140 1',3,''),(415,'2014-11-03 05:10:47',1,18,'330','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(416,'2014-11-03 05:10:47',1,18,'329','Megalight 140 Longshirt Berry Woman  (Size: M)',3,''),(417,'2014-11-03 05:10:47',1,18,'328','Megalight 140 Longshirt Berry Woman ',3,''),(418,'2014-11-03 05:10:47',1,18,'327','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(419,'2014-11-03 05:10:47',1,18,'326','Megalight 140 T-Shirt Berry Woman  (Size: M)',3,''),(420,'2014-11-03 05:10:47',1,18,'325','Megalight 140 T-Shirt Berry Woman ',3,''),(421,'2014-11-03 05:10:47',1,18,'324','Megalight 140 Longtight Berry Woman  (Size: L)',3,''),(422,'2014-11-03 05:10:47',1,18,'323','Megalight 140 Longtight Berry Woman  (Size: M)',3,''),(423,'2014-11-03 05:10:47',1,18,'322','Megalight 140 Longtight Berry Woman  (Size: S)',3,''),(424,'2014-11-03 05:10:47',1,18,'321','Megalight 140 Longtight Berry Woman ',3,''),(425,'2014-11-03 05:10:47',1,18,'320','Megalight 140 Singlet Berry Woman  (Size: L)',3,''),(426,'2014-11-03 05:10:47',1,18,'319','Megalight 140 Singlet Berry Woman  (Size: M)',3,''),(427,'2014-11-03 05:10:47',1,18,'318','Megalight 140 Singlet Berry Woman  (Size: S)',3,''),(428,'2014-11-03 05:10:47',1,18,'317','Megalight 140 Singlet Berry Woman ',3,''),(429,'2014-11-03 05:10:47',1,18,'316','Organic Bamboo T-Shirt Woman  (Size: XL)',3,''),(430,'2014-11-03 05:10:47',1,18,'315','Organic Bamboo Tanktop Woman  (Size: L)',3,''),(431,'2014-11-03 05:10:47',1,18,'314','Organic Bamboo Tanktop Woman  (Size: M)',3,''),(432,'2014-11-03 05:10:47',1,18,'313','Organic Bamboo Tanktop Woman ',3,''),(433,'2014-11-03 05:10:47',1,18,'312','Organic Bamboo T-Shirt Woman  (Size: L)',3,''),(434,'2014-11-03 05:10:47',1,18,'311','Organic Bamboo T-Shirt Woman  (Size: M)',3,''),(435,'2014-11-03 05:10:47',1,18,'310','Organic Bamboo T-Shirt Woman ',3,''),(436,'2014-11-03 05:10:47',1,18,'309','Mittens (Flap) Gloves  (Size: XL)',3,''),(437,'2014-11-03 05:10:47',1,18,'308','Mittens (Flap) Gloves  (Size: L)',3,''),(438,'2014-11-03 05:10:47',1,18,'307','Mittens (Flap) Gloves  (Size: S)',3,''),(439,'2014-11-03 05:10:47',1,18,'306','Mittens (Flap) Gloves  (Size: XS)',3,''),(440,'2014-11-03 05:10:47',1,18,'305','Mittens (Flap) Gloves ',3,''),(441,'2014-11-03 05:10:47',1,18,'304','Cycling Boxer Sewn Upholstery Woman  (Size: XL)',3,''),(442,'2014-11-03 05:10:47',1,18,'303','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(443,'2014-11-03 05:10:47',1,18,'302','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(444,'2014-11-03 05:10:47',1,18,'301','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(445,'2014-11-03 05:10:47',1,18,'300','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(446,'2014-11-03 05:10:47',1,18,'299','Cycling Boxer Sewn Upholstery Woman  (Size: S)',3,''),(447,'2014-11-03 05:10:47',1,18,'298','Cycling Boxer Sewn Upholstery Woman ',3,''),(448,'2014-11-03 05:11:11',1,18,'429','Cycling Boxer Sewn Upholstery Woman ',3,''),(449,'2014-11-03 07:06:23',1,23,'705','Size: 43-46',3,''),(450,'2014-11-03 07:06:23',1,23,'704','Size: 39-42',3,''),(451,'2014-11-03 07:06:23',1,23,'703','Material: THERMOLITE 70% Polyamide 13% Cotton 15% Elastane 2%',3,''),(452,'2014-11-03 07:06:23',1,23,'702','Color: Yellow',3,''),(453,'2014-11-03 07:06:23',1,23,'701','Size: 47-49',3,''),(454,'2014-11-03 07:06:23',1,23,'700','Size: 39-42',3,''),(455,'2014-11-03 07:06:23',1,23,'699','Material: Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',3,''),(456,'2014-11-03 07:06:23',1,23,'698','Color: Mid Grey/Light Grey',3,''),(457,'2014-11-03 07:06:23',1,23,'697','Size: XL',3,''),(458,'2014-11-03 07:06:23',1,23,'696','Size: L',3,''),(459,'2014-11-03 07:06:23',1,23,'695','Material: Polypropylene 74% Polyamide 21% Elastane 3% Carbon 2%',3,''),(460,'2014-11-03 07:06:23',1,23,'694','Color: Deep Black',3,''),(461,'2014-11-03 07:06:23',1,23,'693','Size: XL',3,''),(462,'2014-11-03 07:06:23',1,23,'692','Size: L',3,''),(463,'2014-11-03 07:06:23',1,23,'691','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(464,'2014-11-03 07:06:23',1,23,'690','Color: Deep Black',3,''),(465,'2014-11-03 07:06:23',1,23,'689','Size: S',3,''),(466,'2014-11-03 07:06:23',1,23,'688','Size: M',3,''),(467,'2014-11-03 07:06:23',1,23,'687','Size: L',3,''),(468,'2014-11-03 07:06:23',1,23,'686','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(469,'2014-11-03 07:06:23',1,23,'685','Color: Deep Black',3,''),(470,'2014-11-03 07:06:23',1,23,'684','Size: 43-46',3,''),(471,'2014-11-03 07:06:23',1,23,'683','Size: 39-42',3,''),(472,'2014-11-03 07:06:23',1,23,'682','Size: 39-42',3,''),(473,'2014-11-03 07:06:23',1,23,'681','Size: 35-38',3,''),(474,'2014-11-03 07:06:23',1,23,'680','Material: Polypropylene 56% Polyamide 41% Elastane 3%',3,''),(475,'2014-11-03 07:06:23',1,23,'679','Color: Neon Orange/Pink',3,''),(476,'2014-11-03 07:06:23',1,23,'678','Size: 47-49',3,''),(477,'2014-11-03 07:06:23',1,23,'677','Size: 43-46',3,''),(478,'2014-11-03 07:06:23',1,23,'676','Size: 39-42',3,''),(479,'2014-11-03 07:06:23',1,23,'675','Material: Polyamide 65% Polyamide Microlon 23% Polyproplene 10% Elastane 2%',3,''),(480,'2014-11-03 07:06:23',1,23,'674','Color: Black/Light Grey',3,''),(481,'2014-11-03 07:06:23',1,23,'673','Size: 39-42',3,''),(482,'2014-11-03 07:06:23',1,23,'672','Size: 35-38',3,''),(483,'2014-11-03 07:06:23',1,23,'671','Material: Polyamide 65% Polyamide Microlon 20% Polyproyplene 13% Elastane 2%',3,''),(484,'2014-11-03 07:06:23',1,23,'670','Color: Black/Light Grey',3,''),(485,'2014-11-03 07:06:23',1,23,'669','Size: 47-49',3,''),(486,'2014-11-03 07:06:23',1,23,'668','Size: 43-46',3,''),(487,'2014-11-03 07:06:23',1,23,'667','Size: 39-42',3,''),(488,'2014-11-03 07:06:23',1,23,'666','Size: 35-38',3,''),(489,'2014-11-03 07:06:23',1,23,'665','Material: Polyamide 47% Polypropylene 26% Polyamide Microlon 25% Elastane 2%',3,''),(490,'2014-11-03 07:06:23',1,23,'664','Color: Black/Orange',3,''),(491,'2014-11-03 07:06:23',1,23,'663','Size: 47-49',3,''),(492,'2014-11-03 07:06:23',1,23,'662','Size: 39-42',3,''),(493,'2014-11-03 07:06:23',1,23,'661','Material: Polyester 54% Polyester Coolmax 30% Polyamide 14% Elastane 2%',3,''),(494,'2014-11-03 07:06:23',1,23,'660','Color: White',3,''),(495,'2014-11-03 07:06:23',1,23,'659','Size: XL',3,''),(496,'2014-11-03 07:06:23',1,23,'658','Size: L',3,''),(497,'2014-11-03 07:06:23',1,23,'657','Size: M',3,''),(498,'2014-11-03 07:06:23',1,23,'656','Color: Black',3,''),(499,'2014-11-03 07:06:23',1,23,'655','Size: L',3,''),(500,'2014-11-03 07:06:23',1,23,'654','Size: M',3,''),(501,'2014-11-03 07:06:23',1,23,'653','Size: S',3,''),(502,'2014-11-03 07:06:23',1,23,'652','Color: Black',3,''),(503,'2014-11-03 07:06:23',1,23,'651','Size: L',3,''),(504,'2014-11-03 07:06:23',1,23,'650','Material: Wool 76% Polypropylene 12% Polyamide 10% Elastane 2%',3,''),(505,'2014-11-03 07:06:23',1,23,'649','Color: Black',3,''),(506,'2014-11-03 07:06:23',1,23,'648','Size: XL',3,''),(507,'2014-11-03 07:06:23',1,23,'647','Size: L',3,''),(508,'2014-11-03 07:06:23',1,23,'646','Size: M',3,''),(509,'2014-11-03 07:06:23',1,23,'645','Material: Polyamide 88% Polyester 12%',3,''),(510,'2014-11-03 07:06:23',1,23,'644','Color: Black',3,''),(511,'2014-11-03 07:06:23',1,23,'643','Size: XL',3,''),(512,'2014-11-03 07:06:23',1,23,'642','Size: L',3,''),(513,'2014-11-03 07:06:23',1,23,'641','Material: Polyamide 88% Polyester 12%',3,''),(514,'2014-11-03 07:06:23',1,23,'640','Color: Black',3,''),(515,'2014-11-03 07:06:23',1,23,'639','Size: XL',3,''),(516,'2014-11-03 07:06:23',1,23,'638','Size: L',3,''),(517,'2014-11-03 07:06:23',1,23,'637','Material: Polyamide 88% Polyester 12%',3,''),(518,'2014-11-03 07:06:23',1,23,'636','Color: Black',3,''),(519,'2014-11-03 07:06:23',1,23,'635','Size: 152-164',3,''),(520,'2014-11-03 07:06:23',1,23,'634','Size: 128-140',3,''),(521,'2014-11-03 07:06:23',1,23,'633','Size: 104-116',3,''),(522,'2014-11-03 07:06:23',1,23,'632','Material: Polyamide 78% Polyester 22%',3,''),(523,'2014-11-03 07:06:23',1,23,'631','Color: Black ',3,''),(524,'2014-11-03 07:06:23',1,23,'630','Size: 152-164',3,''),(525,'2014-11-03 07:06:23',1,23,'629','Size: 128-140',3,''),(526,'2014-11-03 07:06:23',1,23,'628','Size: 104-116',3,''),(527,'2014-11-03 07:06:23',1,23,'627','Material: Polyamide 78% Polyester 22%',3,''),(528,'2014-11-03 07:06:23',1,23,'626','Color: Black ',3,''),(529,'2014-11-03 07:06:23',1,23,'625','Size: XL',3,''),(530,'2014-11-03 07:06:23',1,23,'624','Size: L',3,''),(531,'2014-11-03 07:06:23',1,23,'623','Size: M',3,''),(532,'2014-11-03 07:06:23',1,23,'622','Material: Polyamide 78% Polyester 22%',3,''),(533,'2014-11-03 07:06:23',1,23,'621','Color: Black',3,''),(534,'2014-11-03 07:06:23',1,23,'620','Size: 4 Tight Man /XL',3,''),(535,'2014-11-03 07:06:23',1,23,'619','Size: 4 Tight Man /L',3,''),(536,'2014-11-03 07:06:23',1,23,'618','Size: 4 Tight Man /M',3,''),(537,'2014-11-03 07:06:23',1,23,'617','Material: Polyamide 78% Polyester 22%',3,''),(538,'2014-11-03 07:06:23',1,23,'616','Color: Black',3,''),(539,'2014-11-03 07:06:23',1,23,'615','Size: XL',3,''),(540,'2014-11-03 07:06:23',1,23,'614','Size: L',3,''),(541,'2014-11-03 07:06:23',1,23,'613','Size: M',3,''),(542,'2014-11-03 07:06:23',1,23,'612','Material: Polyamide 78% Polyester 22%',3,''),(543,'2014-11-03 07:06:23',1,23,'611','Color: Black',3,''),(544,'2014-11-03 07:06:23',1,23,'610','Size: XL',3,''),(545,'2014-11-03 07:06:23',1,23,'609','Size: L',3,''),(546,'2014-11-03 07:06:23',1,23,'608','Size: M',3,''),(547,'2014-11-03 07:06:23',1,23,'607','Material: Polyamide 78% Polyester 22%',3,''),(548,'2014-11-03 07:06:23',1,23,'606','Color: Black',3,''),(549,'2014-11-03 07:06:23',1,23,'605','Size: XL',3,''),(550,'2014-11-03 07:06:23',1,23,'604','Size: L',3,''),(551,'2014-11-03 07:06:23',1,23,'603','Size: M',3,''),(552,'2014-11-03 07:06:23',1,23,'602','Size: S',3,''),(553,'2014-11-03 07:06:23',1,23,'601','Material: Polyamide 78% Polyester 22%',3,''),(554,'2014-11-03 07:06:23',1,23,'600','Color: Black',3,''),(555,'2014-11-03 07:06:23',1,23,'599','Size: XL',3,''),(556,'2014-11-03 07:06:23',1,23,'598','Size: L',3,''),(557,'2014-11-03 07:06:23',1,23,'597','Size: M',3,''),(558,'2014-11-03 07:06:23',1,23,'596','Size: S',3,''),(559,'2014-11-03 07:06:23',1,23,'595','Material: Polyamide 78% Polyester 22%',3,''),(560,'2014-11-03 07:06:23',1,23,'594','Color: Black',3,''),(561,'2014-11-03 07:06:23',1,23,'593','Size: XL',3,''),(562,'2014-11-03 07:06:23',1,23,'592','Size: L',3,''),(563,'2014-11-03 07:06:23',1,23,'591','Size: XL',3,''),(564,'2014-11-03 07:06:23',1,23,'590','Size: L',3,''),(565,'2014-11-03 07:06:23',1,23,'589','Size: 2 Short Man /XL',3,''),(566,'2014-11-03 07:06:23',1,23,'588','Size: 2 Short Man /L',3,''),(567,'2014-11-03 07:06:23',1,23,'587','Size: 2 Short Man /M',3,''),(568,'2014-11-03 07:06:23',1,23,'586','Material: Polyamide 72% Polyester 21% Elastane 7%',3,''),(569,'2014-11-03 07:06:23',1,23,'585','Color: Black',3,''),(570,'2014-11-03 07:06:23',1,23,'584','Size: L',3,''),(571,'2014-11-03 07:06:23',1,23,'583','Size: M',3,''),(572,'2014-11-03 07:06:23',1,23,'582','Material: Polyamide 78% Polyester 22%',3,''),(573,'2014-11-03 07:06:23',1,23,'581','Color: Black/Pink',3,''),(574,'2014-11-03 07:06:23',1,23,'580','Size: L',3,''),(575,'2014-11-03 07:06:23',1,23,'579','Size: M',3,''),(576,'2014-11-03 07:06:23',1,23,'578','Material: Polyamide 78% Polyester 22%',3,''),(577,'2014-11-03 07:06:23',1,23,'577','Color: Black/Pink',3,''),(578,'2014-11-03 07:06:23',1,23,'576','Size: L',3,''),(579,'2014-11-03 07:06:23',1,23,'575','Size: M',3,''),(580,'2014-11-03 07:06:23',1,23,'574','Size: S',3,''),(581,'2014-11-03 07:06:23',1,23,'573','Material: Polyamide 78% Polyester 22%',3,''),(582,'2014-11-03 07:06:23',1,23,'572','Color: Black/Pink',3,''),(583,'2014-11-03 07:06:23',1,23,'571','Size: L',3,''),(584,'2014-11-03 07:06:23',1,23,'570','Size: M',3,''),(585,'2014-11-03 07:06:23',1,23,'569','Size: S',3,''),(586,'2014-11-03 07:06:23',1,23,'568','Material: Polyamide 94% Elastane 6%',3,''),(587,'2014-11-03 07:06:23',1,23,'567','Color: Pink/Orange',3,''),(588,'2014-11-03 07:06:23',1,23,'566','Size: XL',3,''),(589,'2014-11-03 07:06:23',1,23,'565','Size: L',3,''),(590,'2014-11-03 07:06:23',1,23,'564','Size: M',3,''),(591,'2014-11-03 07:06:23',1,23,'563','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(592,'2014-11-03 07:06:23',1,23,'562','Color: Black',3,''),(593,'2014-11-03 07:06:23',1,23,'561','Size: L',3,''),(594,'2014-11-03 07:06:23',1,23,'560','Size: M',3,''),(595,'2014-11-03 07:06:23',1,23,'559','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(596,'2014-11-03 07:06:23',1,23,'558','Color: Black',3,''),(597,'2014-11-03 07:06:23',1,23,'557','Size: XL',3,''),(598,'2014-11-03 07:06:23',1,23,'556','Size: L',3,''),(599,'2014-11-03 07:06:23',1,23,'555','Size: S',3,''),(600,'2014-11-03 07:06:23',1,23,'554','Size: XS',3,''),(601,'2014-11-03 07:06:23',1,23,'553','Material: Polyester 100%',3,''),(602,'2014-11-03 07:06:23',1,23,'552','Color: Black',3,''),(603,'2014-11-03 07:06:23',1,23,'551','Size: XL',3,''),(604,'2014-11-03 07:06:23',1,23,'550','Size: L',3,''),(605,'2014-11-03 07:06:23',1,23,'549','Size: M',3,''),(606,'2014-11-03 07:06:23',1,23,'548','Size: L',3,''),(607,'2014-11-03 07:06:23',1,23,'547','Size: M',3,''),(608,'2014-11-03 07:06:23',1,23,'546','Size: S',3,''),(609,'2014-11-03 07:06:23',1,23,'545','Material: Polyamid 85% Polyester 15%',3,''),(610,'2014-11-03 07:06:23',1,23,'544','Color: Black',3,''),(611,'2014-11-03 07:07:01',1,18,'560','Skiing Lite  ()',3,''),(612,'2014-11-03 07:07:01',1,18,'559','Skiing Lite  ()',3,''),(613,'2014-11-03 07:07:01',1,18,'558','Skiing Lite ',3,''),(614,'2014-11-03 07:07:01',1,18,'557','Skiing Nt P 100 Woman  ()',3,''),(615,'2014-11-03 07:07:01',1,18,'556','Skiing Nt P 100 Woman  ()',3,''),(616,'2014-11-03 07:07:01',1,18,'555','Skiing Nt P 100 Woman ',3,''),(617,'2014-11-03 07:07:01',1,18,'554','Ultralight 70 T-Shirt Woman  ()',3,''),(618,'2014-11-03 07:07:01',1,18,'553','Ultralight 70 Panty Woman  ()',3,''),(619,'2014-11-03 07:07:01',1,18,'552','Ultralight 70 Panty Woman ',3,''),(620,'2014-11-03 07:07:01',1,18,'551','Ultralight 70 Tanktop Man  ()',3,''),(621,'2014-11-03 07:07:01',1,18,'550','Ultralight 70 Tanktop Man  ()',3,''),(622,'2014-11-03 07:07:01',1,18,'549','Ultralight 70 Tanktop Man ',3,''),(623,'2014-11-03 07:07:01',1,18,'548','Ultralight 70 T-Shirt Woman  ()',3,''),(624,'2014-11-03 07:07:01',1,18,'547','Ultralight 70 T-Shirt Woman  ()',3,''),(625,'2014-11-03 07:07:01',1,18,'546','Ultralight 70 T-Shirt Woman  ()',3,''),(626,'2014-11-03 07:07:01',1,18,'545','Ultralight 70 T-Shirt Woman ',3,''),(627,'2014-11-03 07:07:01',1,18,'544','Running Mid Woman  ()',3,''),(628,'2014-11-03 07:07:01',1,18,'543','Running Mid Woman  ()',3,''),(629,'2014-11-03 07:07:01',1,18,'542','Running Mid Woman  ()',3,''),(630,'2014-11-03 07:07:01',1,18,'541','Running Mid Woman  ()',3,''),(631,'2014-11-03 07:07:01',1,18,'540','Running Mid Woman ',3,''),(632,'2014-11-03 07:07:01',1,18,'539','Running High Man  ()',3,''),(633,'2014-11-03 07:07:01',1,18,'538','Running High Man  ()',3,''),(634,'2014-11-03 07:07:01',1,18,'537','Running High Man  ()',3,''),(635,'2014-11-03 07:07:01',1,18,'536','Running High Man ',3,''),(636,'2014-11-03 07:07:01',1,18,'535','Running Short Woman  ()',3,''),(637,'2014-11-03 07:07:01',1,18,'534','Running Short Woman  ()',3,''),(638,'2014-11-03 07:07:01',1,18,'533','Running Short Woman ',3,''),(639,'2014-11-03 07:07:01',1,18,'532','Trekking A 100  ()',3,''),(640,'2014-11-03 07:07:01',1,18,'531','Trekking A 100  ()',3,''),(641,'2014-11-03 07:07:01',1,18,'530','Trekking A 100  ()',3,''),(642,'2014-11-03 07:07:01',1,18,'529','Trekking A 100  ()',3,''),(643,'2014-11-03 07:07:01',1,18,'528','Trekking A 100 ',3,''),(644,'2014-11-03 07:07:01',1,18,'527','Sporting Allround 300  ()',3,''),(645,'2014-11-03 07:07:01',1,18,'526','Sporting Allround 300  ()',3,''),(646,'2014-11-03 07:07:01',1,18,'525','Sporting Allround 300 ',3,''),(647,'2014-11-03 07:07:01',1,18,'524','Merino Tec 240 Longtight Man  ()',3,''),(648,'2014-11-03 07:07:01',1,18,'523','Merino Tec 240 Longtight Man  ()',3,''),(649,'2014-11-03 07:07:01',1,18,'522','Merino Tec 240 Longtight Man  ()',3,''),(650,'2014-11-03 07:07:01',1,18,'521','Merino Tec 240 Longtight Man ',3,''),(651,'2014-11-03 07:07:01',1,18,'520','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(652,'2014-11-03 07:07:01',1,18,'519','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(653,'2014-11-03 07:07:01',1,18,'518','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(654,'2014-11-03 07:07:01',1,18,'517','Merino Tec 240 Longshirt Zipper Woman ',3,''),(655,'2014-11-03 07:07:01',1,18,'516','Merino T-Shirt Man  ()',3,''),(656,'2014-11-03 07:07:01',1,18,'515','Merino T-Shirt Man ',3,''),(657,'2014-11-03 07:07:01',1,18,'514','Megalight 200 Longtight Man  ()',3,''),(658,'2014-11-03 07:07:01',1,18,'513','Megalight 200 Longtight Man  ()',3,''),(659,'2014-11-03 07:07:01',1,18,'512','Megalight 200 Longtight Man  ()',3,''),(660,'2014-11-03 07:07:01',1,18,'511','Megalight 200 Longtight Man ',3,''),(661,'2014-11-03 07:07:01',1,18,'510','Megalight 200 Longshirt Man  ()',3,''),(662,'2014-11-03 07:07:01',1,18,'509','Megalight 200 Longshirt Man  ()',3,''),(663,'2014-11-03 07:07:01',1,18,'508','Megalight 200 Longshirt Man ',3,''),(664,'2014-11-03 07:07:01',1,18,'507','Megalight 200 T-Shirt Man  ()',3,''),(665,'2014-11-03 07:07:01',1,18,'506','Megalight 200 T-Shirt Man  ()',3,''),(666,'2014-11-03 07:07:01',1,18,'505','Megalight 200 T-Shirt Man ',3,''),(667,'2014-11-03 07:07:01',1,18,'504','Kids Megalight 140 Boxer Unisex  ()',3,''),(668,'2014-11-03 07:07:01',1,18,'503','Kids Megalight 140 Boxer Unisex  ()',3,''),(669,'2014-11-03 07:07:01',1,18,'502','Kids Megalight 140 Boxer Unisex  ()',3,''),(670,'2014-11-03 07:07:01',1,18,'501','Kids Megalight 140 Boxer Unisex ',3,''),(671,'2014-11-03 07:07:01',1,18,'500','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(672,'2014-11-03 07:07:01',1,18,'499','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(673,'2014-11-03 07:07:01',1,18,'498','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(674,'2014-11-03 07:07:01',1,18,'497','Kids Megalight 140 T-Shirt Unisex ',3,''),(675,'2014-11-03 07:07:01',1,18,'496','Megalight 140 Boxer Man  ()',3,''),(676,'2014-11-03 07:07:01',1,18,'495','Megalight 140 Boxer Man  ()',3,''),(677,'2014-11-03 07:07:01',1,18,'494','Megalight 140 Boxer Man  ()',3,''),(678,'2014-11-03 07:07:01',1,18,'493','Megalight 140 Boxer Man ',3,''),(679,'2014-11-03 07:07:01',1,18,'492','Megalight 140 3 ()',3,''),(680,'2014-11-03 07:07:01',1,18,'491','Megalight 140 3 ()',3,''),(681,'2014-11-03 07:07:01',1,18,'490','Megalight 140 3 ()',3,''),(682,'2014-11-03 07:07:01',1,18,'489','Megalight 140 3',3,''),(683,'2014-11-03 07:07:01',1,18,'488','Megalight 140 Longtight Man  ()',3,''),(684,'2014-11-03 07:07:01',1,18,'487','Megalight 140 Longtight Man  ()',3,''),(685,'2014-11-03 07:07:01',1,18,'486','Megalight 140 Longtight Man  ()',3,''),(686,'2014-11-03 07:07:01',1,18,'485','Megalight 140 Longtight Man ',3,''),(687,'2014-11-03 07:07:01',1,18,'484','Megalight 140 T-Shirt Man  ()',3,''),(688,'2014-11-03 07:07:01',1,18,'483','Megalight 140 T-Shirt Man  ()',3,''),(689,'2014-11-03 07:07:01',1,18,'482','Megalight 140 T-Shirt Man  ()',3,''),(690,'2014-11-03 07:07:01',1,18,'481','Megalight 140 T-Shirt Man ',3,''),(691,'2014-11-03 07:07:01',1,18,'480','Megalight 140 Tanktop Woman  ()',3,''),(692,'2014-11-03 07:07:01',1,18,'479','Megalight 140 Tanktop Woman  ()',3,''),(693,'2014-11-03 07:07:01',1,18,'478','Megalight 140 Tanktop Woman  ()',3,''),(694,'2014-11-03 07:07:01',1,18,'477','Megalight 140 Tanktop Woman  ()',3,''),(695,'2014-11-03 07:07:01',1,18,'476','Megalight 140 Tanktop Woman ',3,''),(696,'2014-11-03 07:07:01',1,18,'475','Megalight 140 Longshirt Woman  ()',3,''),(697,'2014-11-03 07:07:01',1,18,'474','Megalight 140 Longshirt Woman  ()',3,''),(698,'2014-11-03 07:07:01',1,18,'473','Megalight 140 Longshirt Woman  ()',3,''),(699,'2014-11-03 07:07:01',1,18,'472','Megalight 140 Longshirt Woman  ()',3,''),(700,'2014-11-03 07:07:01',1,18,'471','Megalight 140 Longshirt Woman ',3,''),(701,'2014-11-03 07:07:01',1,18,'470','Megalight 140 T-Shirt Berry Woman  ()',3,''),(702,'2014-11-03 07:07:01',1,18,'469','Megalight 140 T-Shirt Berry Woman  ()',3,''),(703,'2014-11-03 07:07:01',1,18,'468','Megalight 140 Longshirt Berry Woman  ()',3,''),(704,'2014-11-03 07:07:01',1,18,'467','Megalight 140 Longshirt Berry Woman  ()',3,''),(705,'2014-11-03 07:07:01',1,18,'466','Megalight 140 1 ()',3,''),(706,'2014-11-03 07:07:01',1,18,'465','Megalight 140 1 ()',3,''),(707,'2014-11-03 07:07:01',1,18,'464','Megalight 140 1 ()',3,''),(708,'2014-11-03 07:07:01',1,18,'463','Megalight 140 1',3,''),(709,'2014-11-03 07:07:01',1,18,'462','Megalight 140 Longshirt Berry Woman  ()',3,''),(710,'2014-11-03 07:07:01',1,18,'461','Megalight 140 Longshirt Berry Woman  ()',3,''),(711,'2014-11-03 07:07:01',1,18,'460','Megalight 140 Longshirt Berry Woman ',3,''),(712,'2014-11-03 07:07:01',1,18,'459','Megalight 140 T-Shirt Berry Woman  ()',3,''),(713,'2014-11-03 07:07:01',1,18,'458','Megalight 140 T-Shirt Berry Woman  ()',3,''),(714,'2014-11-03 07:07:01',1,18,'457','Megalight 140 T-Shirt Berry Woman ',3,''),(715,'2014-11-03 07:07:01',1,18,'456','Megalight 140 Longtight Berry Woman  ()',3,''),(716,'2014-11-03 07:07:01',1,18,'455','Megalight 140 Longtight Berry Woman  ()',3,''),(717,'2014-11-03 07:07:01',1,18,'454','Megalight 140 Longtight Berry Woman  ()',3,''),(718,'2014-11-03 07:07:01',1,18,'453','Megalight 140 Longtight Berry Woman ',3,''),(719,'2014-11-03 07:07:01',1,18,'452','Megalight 140 Singlet Berry Woman  ()',3,''),(720,'2014-11-03 07:07:01',1,18,'451','Megalight 140 Singlet Berry Woman  ()',3,''),(721,'2014-11-03 07:07:01',1,18,'450','Megalight 140 Singlet Berry Woman  ()',3,''),(722,'2014-11-03 07:07:01',1,18,'449','Megalight 140 Singlet Berry Woman ',3,''),(723,'2014-11-03 07:07:01',1,18,'448','Organic Bamboo T-Shirt Woman  ()',3,''),(724,'2014-11-03 07:07:01',1,18,'447','Organic Bamboo Tanktop Woman  ()',3,''),(725,'2014-11-03 07:07:01',1,18,'446','Organic Bamboo Tanktop Woman  ()',3,''),(726,'2014-11-03 07:07:01',1,18,'445','Organic Bamboo Tanktop Woman ',3,''),(727,'2014-11-03 07:07:01',1,18,'444','Organic Bamboo T-Shirt Woman  ()',3,''),(728,'2014-11-03 07:07:01',1,18,'443','Organic Bamboo T-Shirt Woman  ()',3,''),(729,'2014-11-03 07:07:01',1,18,'442','Organic Bamboo T-Shirt Woman ',3,''),(730,'2014-11-03 07:07:01',1,18,'441','Mittens (Flap) Gloves  ()',3,''),(731,'2014-11-03 07:07:01',1,18,'440','Mittens (Flap) Gloves  ()',3,''),(732,'2014-11-03 07:07:01',1,18,'439','Mittens (Flap) Gloves  ()',3,''),(733,'2014-11-03 07:07:01',1,18,'438','Mittens (Flap) Gloves  ()',3,''),(734,'2014-11-03 07:07:01',1,18,'437','Mittens (Flap) Gloves ',3,''),(735,'2014-11-03 07:07:01',1,18,'436','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(736,'2014-11-03 07:07:01',1,18,'435','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(737,'2014-11-03 07:07:01',1,18,'434','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(738,'2014-11-03 07:07:01',1,18,'433','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(739,'2014-11-03 07:07:01',1,18,'432','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(740,'2014-11-03 07:07:01',1,18,'431','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(741,'2014-11-03 07:07:01',1,18,'430','Cycling Boxer Sewn Upholstery Woman ',3,''),(742,'2014-11-03 07:39:10',1,23,'867','Size: 43-46',3,''),(743,'2014-11-03 07:39:10',1,23,'866','Size: 39-42',3,''),(744,'2014-11-03 07:39:10',1,23,'865','Material: THERMOLITE 70% Polyamide 13% Cotton 15% Elastane 2%',3,''),(745,'2014-11-03 07:39:10',1,23,'864','Color: Yellow',3,''),(746,'2014-11-03 07:39:10',1,23,'863','Size: 47-49',3,''),(747,'2014-11-03 07:39:10',1,23,'862','Size: 39-42',3,''),(748,'2014-11-03 07:39:10',1,23,'861','Material: Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',3,''),(749,'2014-11-03 07:39:10',1,23,'860','Color: Mid Grey/Light Grey',3,''),(750,'2014-11-03 07:39:10',1,23,'859','Size: XL',3,''),(751,'2014-11-03 07:39:10',1,23,'858','Size: L',3,''),(752,'2014-11-03 07:39:10',1,23,'857','Material: Polypropylene 74% Polyamide 21% Elastane 3% Carbon 2%',3,''),(753,'2014-11-03 07:39:10',1,23,'856','Color: Deep Black',3,''),(754,'2014-11-03 07:39:10',1,23,'855','Size: XL',3,''),(755,'2014-11-03 07:39:10',1,23,'854','Size: L',3,''),(756,'2014-11-03 07:39:10',1,23,'853','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(757,'2014-11-03 07:39:10',1,23,'852','Color: Deep Black',3,''),(758,'2014-11-03 07:39:10',1,23,'851','Size: S',3,''),(759,'2014-11-03 07:39:10',1,23,'850','Size: M',3,''),(760,'2014-11-03 07:39:10',1,23,'849','Size: L',3,''),(761,'2014-11-03 07:39:10',1,23,'848','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(762,'2014-11-03 07:39:10',1,23,'847','Color: Deep Black',3,''),(763,'2014-11-03 07:39:10',1,23,'846','Size: 43-46',3,''),(764,'2014-11-03 07:39:10',1,23,'845','Size: 39-42',3,''),(765,'2014-11-03 07:39:10',1,23,'844','Size: 39-42',3,''),(766,'2014-11-03 07:39:10',1,23,'843','Size: 35-38',3,''),(767,'2014-11-03 07:39:10',1,23,'842','Material: Polypropylene 56% Polyamide 41% Elastane 3%',3,''),(768,'2014-11-03 07:39:10',1,23,'841','Color: Neon Orange/Pink',3,''),(769,'2014-11-03 07:39:10',1,23,'840','Size: 47-49',3,''),(770,'2014-11-03 07:39:10',1,23,'839','Size: 43-46',3,''),(771,'2014-11-03 07:39:10',1,23,'838','Size: 39-42',3,''),(772,'2014-11-03 07:39:10',1,23,'837','Material: Polyamide 65% Polyamide Microlon 23% Polyproplene 10% Elastane 2%',3,''),(773,'2014-11-03 07:39:10',1,23,'836','Color: Black/Light Grey',3,''),(774,'2014-11-03 07:39:10',1,23,'835','Size: 39-42',3,''),(775,'2014-11-03 07:39:10',1,23,'834','Size: 35-38',3,''),(776,'2014-11-03 07:39:10',1,23,'833','Material: Polyamide 65% Polyamide Microlon 20% Polyproyplene 13% Elastane 2%',3,''),(777,'2014-11-03 07:39:10',1,23,'832','Color: Black/Light Grey',3,''),(778,'2014-11-03 07:39:10',1,23,'831','Size: 47-49',3,''),(779,'2014-11-03 07:39:10',1,23,'830','Size: 43-46',3,''),(780,'2014-11-03 07:39:10',1,23,'829','Size: 39-42',3,''),(781,'2014-11-03 07:39:10',1,23,'828','Size: 35-38',3,''),(782,'2014-11-03 07:39:10',1,23,'827','Material: Polyamide 47% Polypropylene 26% Polyamide Microlon 25% Elastane 2%',3,''),(783,'2014-11-03 07:39:10',1,23,'826','Color: Black/Orange',3,''),(784,'2014-11-03 07:39:10',1,23,'825','Size: 47-49',3,''),(785,'2014-11-03 07:39:10',1,23,'824','Size: 39-42',3,''),(786,'2014-11-03 07:39:10',1,23,'823','Material: Polyester 54% Polyester Coolmax 30% Polyamide 14% Elastane 2%',3,''),(787,'2014-11-03 07:39:10',1,23,'822','Color: White',3,''),(788,'2014-11-03 07:39:10',1,23,'821','Size: XL',3,''),(789,'2014-11-03 07:39:10',1,23,'820','Size: L',3,''),(790,'2014-11-03 07:39:10',1,23,'819','Size: M',3,''),(791,'2014-11-03 07:39:10',1,23,'818','Color: Black',3,''),(792,'2014-11-03 07:39:10',1,23,'817','Size: L',3,''),(793,'2014-11-03 07:39:10',1,23,'816','Size: M',3,''),(794,'2014-11-03 07:39:10',1,23,'815','Size: S',3,''),(795,'2014-11-03 07:39:10',1,23,'814','Color: Black',3,''),(796,'2014-11-03 07:39:10',1,23,'813','Size: L',3,''),(797,'2014-11-03 07:39:10',1,23,'812','Material: Wool 76% Polypropylene 12% Polyamide 10% Elastane 2%',3,''),(798,'2014-11-03 07:39:10',1,23,'811','Color: Black',3,''),(799,'2014-11-03 07:39:10',1,23,'810','Size: XL',3,''),(800,'2014-11-03 07:39:10',1,23,'809','Size: L',3,''),(801,'2014-11-03 07:39:10',1,23,'808','Size: M',3,''),(802,'2014-11-03 07:39:10',1,23,'807','Material: Polyamide 88% Polyester 12%',3,''),(803,'2014-11-03 07:39:10',1,23,'806','Color: Black',3,''),(804,'2014-11-03 07:39:10',1,23,'805','Size: XL',3,''),(805,'2014-11-03 07:39:10',1,23,'804','Size: L',3,''),(806,'2014-11-03 07:39:10',1,23,'803','Material: Polyamide 88% Polyester 12%',3,''),(807,'2014-11-03 07:39:10',1,23,'802','Color: Black',3,''),(808,'2014-11-03 07:39:10',1,23,'801','Size: XL',3,''),(809,'2014-11-03 07:39:10',1,23,'800','Size: L',3,''),(810,'2014-11-03 07:39:10',1,23,'799','Material: Polyamide 88% Polyester 12%',3,''),(811,'2014-11-03 07:39:10',1,23,'798','Color: Black',3,''),(812,'2014-11-03 07:39:10',1,23,'797','Size: 152-164',3,''),(813,'2014-11-03 07:39:10',1,23,'796','Size: 128-140',3,''),(814,'2014-11-03 07:39:10',1,23,'795','Size: 104-116',3,''),(815,'2014-11-03 07:39:10',1,23,'794','Material: Polyamide 78% Polyester 22%',3,''),(816,'2014-11-03 07:39:10',1,23,'793','Color: Black ',3,''),(817,'2014-11-03 07:39:10',1,23,'792','Size: 152-164',3,''),(818,'2014-11-03 07:39:10',1,23,'791','Size: 128-140',3,''),(819,'2014-11-03 07:39:10',1,23,'790','Size: 104-116',3,''),(820,'2014-11-03 07:39:10',1,23,'789','Material: Polyamide 78% Polyester 22%',3,''),(821,'2014-11-03 07:39:10',1,23,'788','Color: Black ',3,''),(822,'2014-11-03 07:39:10',1,23,'787','Size: XL',3,''),(823,'2014-11-03 07:39:10',1,23,'786','Size: L',3,''),(824,'2014-11-03 07:39:10',1,23,'785','Size: M',3,''),(825,'2014-11-03 07:39:10',1,23,'784','Material: Polyamide 78% Polyester 22%',3,''),(826,'2014-11-03 07:39:10',1,23,'783','Color: Black',3,''),(827,'2014-11-03 07:39:10',1,23,'782','Size: 4 Tight Man /XL',3,''),(828,'2014-11-03 07:39:10',1,23,'781','Size: 4 Tight Man /L',3,''),(829,'2014-11-03 07:39:10',1,23,'780','Size: 4 Tight Man /M',3,''),(830,'2014-11-03 07:39:10',1,23,'779','Material: Polyamide 78% Polyester 22%',3,''),(831,'2014-11-03 07:39:10',1,23,'778','Color: Black',3,''),(832,'2014-11-03 07:39:10',1,23,'777','Size: XL',3,''),(833,'2014-11-03 07:39:10',1,23,'776','Size: L',3,''),(834,'2014-11-03 07:39:10',1,23,'775','Size: M',3,''),(835,'2014-11-03 07:39:10',1,23,'774','Material: Polyamide 78% Polyester 22%',3,''),(836,'2014-11-03 07:39:10',1,23,'773','Color: Black',3,''),(837,'2014-11-03 07:39:10',1,23,'772','Size: XL',3,''),(838,'2014-11-03 07:39:10',1,23,'771','Size: L',3,''),(839,'2014-11-03 07:39:10',1,23,'770','Size: M',3,''),(840,'2014-11-03 07:39:10',1,23,'769','Material: Polyamide 78% Polyester 22%',3,''),(841,'2014-11-03 07:39:10',1,23,'768','Color: Black',3,''),(842,'2014-11-03 07:39:10',1,23,'767','Size: XL',3,''),(843,'2014-11-03 07:39:10',1,23,'766','Size: L',3,''),(844,'2014-11-03 07:39:10',1,23,'765','Size: M',3,''),(845,'2014-11-03 07:39:10',1,23,'764','Size: S',3,''),(846,'2014-11-03 07:39:10',1,23,'763','Material: Polyamide 78% Polyester 22%',3,''),(847,'2014-11-03 07:39:10',1,23,'762','Color: Black',3,''),(848,'2014-11-03 07:39:10',1,23,'761','Size: XL',3,''),(849,'2014-11-03 07:39:10',1,23,'760','Size: L',3,''),(850,'2014-11-03 07:39:10',1,23,'759','Size: M',3,''),(851,'2014-11-03 07:39:10',1,23,'758','Size: S',3,''),(852,'2014-11-03 07:39:10',1,23,'757','Material: Polyamide 78% Polyester 22%',3,''),(853,'2014-11-03 07:39:10',1,23,'756','Color: Black',3,''),(854,'2014-11-03 07:39:10',1,23,'755','Size: XL',3,''),(855,'2014-11-03 07:39:10',1,23,'754','Size: L',3,''),(856,'2014-11-03 07:39:10',1,23,'753','Size: XL',3,''),(857,'2014-11-03 07:39:10',1,23,'752','Size: L',3,''),(858,'2014-11-03 07:39:10',1,23,'751','Size: 2 Short Man /XL',3,''),(859,'2014-11-03 07:39:10',1,23,'750','Size: 2 Short Man /L',3,''),(860,'2014-11-03 07:39:10',1,23,'749','Size: 2 Short Man /M',3,''),(861,'2014-11-03 07:39:10',1,23,'748','Material: Polyamide 72% Polyester 21% Elastane 7%',3,''),(862,'2014-11-03 07:39:10',1,23,'747','Color: Black',3,''),(863,'2014-11-03 07:39:10',1,23,'746','Size: L',3,''),(864,'2014-11-03 07:39:10',1,23,'745','Size: M',3,''),(865,'2014-11-03 07:39:10',1,23,'744','Material: Polyamide 78% Polyester 22%',3,''),(866,'2014-11-03 07:39:10',1,23,'743','Color: Black/Pink',3,''),(867,'2014-11-03 07:39:10',1,23,'742','Size: L',3,''),(868,'2014-11-03 07:39:10',1,23,'741','Size: M',3,''),(869,'2014-11-03 07:39:10',1,23,'740','Material: Polyamide 78% Polyester 22%',3,''),(870,'2014-11-03 07:39:10',1,23,'739','Color: Black/Pink',3,''),(871,'2014-11-03 07:39:10',1,23,'738','Size: L',3,''),(872,'2014-11-03 07:39:10',1,23,'737','Size: M',3,''),(873,'2014-11-03 07:39:10',1,23,'736','Size: S',3,''),(874,'2014-11-03 07:39:10',1,23,'735','Material: Polyamide 78% Polyester 22%',3,''),(875,'2014-11-03 07:39:10',1,23,'734','Color: Black/Pink',3,''),(876,'2014-11-03 07:39:10',1,23,'733','Size: L',3,''),(877,'2014-11-03 07:39:10',1,23,'732','Size: M',3,''),(878,'2014-11-03 07:39:10',1,23,'731','Size: S',3,''),(879,'2014-11-03 07:39:10',1,23,'730','Material: Polyamide 94% Elastane 6%',3,''),(880,'2014-11-03 07:39:10',1,23,'729','Color: Pink/Orange',3,''),(881,'2014-11-03 07:39:10',1,23,'728','Size: XL',3,''),(882,'2014-11-03 07:39:10',1,23,'727','Size: L',3,''),(883,'2014-11-03 07:39:10',1,23,'726','Size: M',3,''),(884,'2014-11-03 07:39:10',1,23,'725','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(885,'2014-11-03 07:39:10',1,23,'724','Color: Black',3,''),(886,'2014-11-03 07:39:10',1,23,'723','Size: L',3,''),(887,'2014-11-03 07:39:10',1,23,'722','Size: M',3,''),(888,'2014-11-03 07:39:10',1,23,'721','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(889,'2014-11-03 07:39:10',1,23,'720','Color: Black',3,''),(890,'2014-11-03 07:39:10',1,23,'719','Size: XL',3,''),(891,'2014-11-03 07:39:10',1,23,'718','Size: L',3,''),(892,'2014-11-03 07:39:10',1,23,'717','Size: S',3,''),(893,'2014-11-03 07:39:10',1,23,'716','Size: XS',3,''),(894,'2014-11-03 07:39:10',1,23,'715','Material: Polyester 100%',3,''),(895,'2014-11-03 07:39:10',1,23,'714','Color: Black',3,''),(896,'2014-11-03 07:39:10',1,23,'713','Size: XL',3,''),(897,'2014-11-03 07:39:10',1,23,'712','Size: L',3,''),(898,'2014-11-03 07:39:10',1,23,'711','Size: M',3,''),(899,'2014-11-03 07:39:10',1,23,'710','Size: L',3,''),(900,'2014-11-03 07:39:10',1,23,'709','Size: M',3,''),(901,'2014-11-03 07:39:10',1,23,'708','Size: S',3,''),(902,'2014-11-03 07:39:10',1,23,'707','Material: Polyamid 85% Polyester 15%',3,''),(903,'2014-11-03 07:39:10',1,23,'706','Color: Black',3,''),(904,'2014-11-03 07:39:26',1,18,'691','Skiing Lite  ()',3,''),(905,'2014-11-03 07:39:26',1,18,'690','Skiing Lite  ()',3,''),(906,'2014-11-03 07:39:26',1,18,'689','Skiing Lite ',3,''),(907,'2014-11-03 07:39:26',1,18,'688','Skiing Nt P 100 Woman  ()',3,''),(908,'2014-11-03 07:39:26',1,18,'687','Skiing Nt P 100 Woman  ()',3,''),(909,'2014-11-03 07:39:26',1,18,'686','Skiing Nt P 100 Woman ',3,''),(910,'2014-11-03 07:39:26',1,18,'685','Ultralight 70 T-Shirt Woman  ()',3,''),(911,'2014-11-03 07:39:26',1,18,'684','Ultralight 70 Panty Woman  ()',3,''),(912,'2014-11-03 07:39:26',1,18,'683','Ultralight 70 Panty Woman ',3,''),(913,'2014-11-03 07:39:26',1,18,'682','Ultralight 70 Tanktop Man  ()',3,''),(914,'2014-11-03 07:39:26',1,18,'681','Ultralight 70 Tanktop Man  ()',3,''),(915,'2014-11-03 07:39:26',1,18,'680','Ultralight 70 Tanktop Man ',3,''),(916,'2014-11-03 07:39:26',1,18,'679','Ultralight 70 T-Shirt Woman  ()',3,''),(917,'2014-11-03 07:39:26',1,18,'678','Ultralight 70 T-Shirt Woman  ()',3,''),(918,'2014-11-03 07:39:26',1,18,'677','Ultralight 70 T-Shirt Woman  ()',3,''),(919,'2014-11-03 07:39:26',1,18,'676','Ultralight 70 T-Shirt Woman ',3,''),(920,'2014-11-03 07:39:26',1,18,'675','Running Mid Woman  ()',3,''),(921,'2014-11-03 07:39:26',1,18,'674','Running Mid Woman  ()',3,''),(922,'2014-11-03 07:39:26',1,18,'673','Running Mid Woman  ()',3,''),(923,'2014-11-03 07:39:26',1,18,'672','Running Mid Woman  ()',3,''),(924,'2014-11-03 07:39:26',1,18,'671','Running Mid Woman ',3,''),(925,'2014-11-03 07:39:26',1,18,'670','Running High Man  ()',3,''),(926,'2014-11-03 07:39:26',1,18,'669','Running High Man  ()',3,''),(927,'2014-11-03 07:39:26',1,18,'668','Running High Man  ()',3,''),(928,'2014-11-03 07:39:26',1,18,'667','Running High Man ',3,''),(929,'2014-11-03 07:39:26',1,18,'666','Running Short Woman  ()',3,''),(930,'2014-11-03 07:39:26',1,18,'665','Running Short Woman  ()',3,''),(931,'2014-11-03 07:39:26',1,18,'664','Running Short Woman ',3,''),(932,'2014-11-03 07:39:26',1,18,'663','Trekking A 100  ()',3,''),(933,'2014-11-03 07:39:26',1,18,'662','Trekking A 100  ()',3,''),(934,'2014-11-03 07:39:26',1,18,'661','Trekking A 100  ()',3,''),(935,'2014-11-03 07:39:26',1,18,'660','Trekking A 100  ()',3,''),(936,'2014-11-03 07:39:26',1,18,'659','Trekking A 100 ',3,''),(937,'2014-11-03 07:39:26',1,18,'658','Sporting Allround 300  ()',3,''),(938,'2014-11-03 07:39:26',1,18,'657','Sporting Allround 300  ()',3,''),(939,'2014-11-03 07:39:26',1,18,'656','Sporting Allround 300 ',3,''),(940,'2014-11-03 07:39:26',1,18,'655','Merino Tec 240 Longtight Man  ()',3,''),(941,'2014-11-03 07:39:26',1,18,'654','Merino Tec 240 Longtight Man  ()',3,''),(942,'2014-11-03 07:39:26',1,18,'653','Merino Tec 240 Longtight Man  ()',3,''),(943,'2014-11-03 07:39:26',1,18,'652','Merino Tec 240 Longtight Man ',3,''),(944,'2014-11-03 07:39:26',1,18,'651','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(945,'2014-11-03 07:39:26',1,18,'650','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(946,'2014-11-03 07:39:26',1,18,'649','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(947,'2014-11-03 07:39:26',1,18,'648','Merino Tec 240 Longshirt Zipper Woman ',3,''),(948,'2014-11-03 07:39:26',1,18,'647','Merino T-Shirt Man  ()',3,''),(949,'2014-11-03 07:39:26',1,18,'646','Merino T-Shirt Man ',3,''),(950,'2014-11-03 07:39:26',1,18,'645','Megalight 200 Longtight Man  ()',3,''),(951,'2014-11-03 07:39:26',1,18,'644','Megalight 200 Longtight Man  ()',3,''),(952,'2014-11-03 07:39:26',1,18,'643','Megalight 200 Longtight Man  ()',3,''),(953,'2014-11-03 07:39:26',1,18,'642','Megalight 200 Longtight Man ',3,''),(954,'2014-11-03 07:39:26',1,18,'641','Megalight 200 Longshirt Man  ()',3,''),(955,'2014-11-03 07:39:26',1,18,'640','Megalight 200 Longshirt Man  ()',3,''),(956,'2014-11-03 07:39:26',1,18,'639','Megalight 200 Longshirt Man ',3,''),(957,'2014-11-03 07:39:26',1,18,'638','Megalight 200 T-Shirt Man  ()',3,''),(958,'2014-11-03 07:39:26',1,18,'637','Megalight 200 T-Shirt Man  ()',3,''),(959,'2014-11-03 07:39:26',1,18,'636','Megalight 200 T-Shirt Man ',3,''),(960,'2014-11-03 07:39:26',1,18,'635','Kids Megalight 140 Boxer Unisex  ()',3,''),(961,'2014-11-03 07:39:26',1,18,'634','Kids Megalight 140 Boxer Unisex  ()',3,''),(962,'2014-11-03 07:39:26',1,18,'633','Kids Megalight 140 Boxer Unisex  ()',3,''),(963,'2014-11-03 07:39:26',1,18,'632','Kids Megalight 140 Boxer Unisex ',3,''),(964,'2014-11-03 07:39:26',1,18,'631','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(965,'2014-11-03 07:39:26',1,18,'630','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(966,'2014-11-03 07:39:26',1,18,'629','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(967,'2014-11-03 07:39:26',1,18,'628','Kids Megalight 140 T-Shirt Unisex ',3,''),(968,'2014-11-03 07:39:26',1,18,'627','Megalight 140 Boxer Man  ()',3,''),(969,'2014-11-03 07:39:26',1,18,'626','Megalight 140 Boxer Man  ()',3,''),(970,'2014-11-03 07:39:26',1,18,'625','Megalight 140 Boxer Man  ()',3,''),(971,'2014-11-03 07:39:26',1,18,'624','Megalight 140 Boxer Man ',3,''),(972,'2014-11-03 07:39:26',1,18,'623','Megalight 140 3 ()',3,''),(973,'2014-11-03 07:39:26',1,18,'622','Megalight 140 3 ()',3,''),(974,'2014-11-03 07:39:26',1,18,'621','Megalight 140 3 ()',3,''),(975,'2014-11-03 07:39:26',1,18,'620','Megalight 140 3',3,''),(976,'2014-11-03 07:39:26',1,18,'619','Megalight 140 Longtight Man  ()',3,''),(977,'2014-11-03 07:39:26',1,18,'618','Megalight 140 Longtight Man  ()',3,''),(978,'2014-11-03 07:39:26',1,18,'617','Megalight 140 Longtight Man  ()',3,''),(979,'2014-11-03 07:39:26',1,18,'616','Megalight 140 Longtight Man ',3,''),(980,'2014-11-03 07:39:26',1,18,'615','Megalight 140 T-Shirt Man  ()',3,''),(981,'2014-11-03 07:39:26',1,18,'614','Megalight 140 T-Shirt Man  ()',3,''),(982,'2014-11-03 07:39:26',1,18,'613','Megalight 140 T-Shirt Man  ()',3,''),(983,'2014-11-03 07:39:26',1,18,'612','Megalight 140 T-Shirt Man ',3,''),(984,'2014-11-03 07:39:26',1,18,'611','Megalight 140 Tanktop Woman  ()',3,''),(985,'2014-11-03 07:39:26',1,18,'610','Megalight 140 Tanktop Woman  ()',3,''),(986,'2014-11-03 07:39:26',1,18,'609','Megalight 140 Tanktop Woman  ()',3,''),(987,'2014-11-03 07:39:26',1,18,'608','Megalight 140 Tanktop Woman  ()',3,''),(988,'2014-11-03 07:39:26',1,18,'607','Megalight 140 Tanktop Woman ',3,''),(989,'2014-11-03 07:39:26',1,18,'606','Megalight 140 Longshirt Woman  ()',3,''),(990,'2014-11-03 07:39:26',1,18,'605','Megalight 140 Longshirt Woman  ()',3,''),(991,'2014-11-03 07:39:26',1,18,'604','Megalight 140 Longshirt Woman  ()',3,''),(992,'2014-11-03 07:39:26',1,18,'603','Megalight 140 Longshirt Woman  ()',3,''),(993,'2014-11-03 07:39:26',1,18,'602','Megalight 140 Longshirt Woman ',3,''),(994,'2014-11-03 07:39:26',1,18,'601','Megalight 140 T-Shirt Berry Woman  ()',3,''),(995,'2014-11-03 07:39:26',1,18,'600','Megalight 140 T-Shirt Berry Woman  ()',3,''),(996,'2014-11-03 07:39:26',1,18,'599','Megalight 140 Longshirt Berry Woman  ()',3,''),(997,'2014-11-03 07:39:26',1,18,'598','Megalight 140 Longshirt Berry Woman  ()',3,''),(998,'2014-11-03 07:39:26',1,18,'597','Megalight 140 1 ()',3,''),(999,'2014-11-03 07:39:26',1,18,'596','Megalight 140 1 ()',3,''),(1000,'2014-11-03 07:39:26',1,18,'595','Megalight 140 1 ()',3,''),(1001,'2014-11-03 07:39:26',1,18,'594','Megalight 140 1',3,''),(1002,'2014-11-03 07:39:26',1,18,'593','Megalight 140 Longshirt Berry Woman  ()',3,''),(1003,'2014-11-03 07:39:26',1,18,'592','Megalight 140 Longshirt Berry Woman  ()',3,''),(1004,'2014-11-03 07:39:26',1,18,'591','Megalight 140 Longshirt Berry Woman ',3,''),(1005,'2014-11-03 07:39:26',1,18,'590','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1006,'2014-11-03 07:39:26',1,18,'589','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1007,'2014-11-03 07:39:26',1,18,'588','Megalight 140 T-Shirt Berry Woman ',3,''),(1008,'2014-11-03 07:39:26',1,18,'587','Megalight 140 Longtight Berry Woman  ()',3,''),(1009,'2014-11-03 07:39:26',1,18,'586','Megalight 140 Longtight Berry Woman  ()',3,''),(1010,'2014-11-03 07:39:26',1,18,'585','Megalight 140 Longtight Berry Woman  ()',3,''),(1011,'2014-11-03 07:39:26',1,18,'584','Megalight 140 Longtight Berry Woman ',3,''),(1012,'2014-11-03 07:39:26',1,18,'583','Megalight 140 Singlet Berry Woman  ()',3,''),(1013,'2014-11-03 07:39:26',1,18,'582','Megalight 140 Singlet Berry Woman  ()',3,''),(1014,'2014-11-03 07:39:26',1,18,'581','Megalight 140 Singlet Berry Woman  ()',3,''),(1015,'2014-11-03 07:39:26',1,18,'580','Megalight 140 Singlet Berry Woman ',3,''),(1016,'2014-11-03 07:39:26',1,18,'579','Organic Bamboo T-Shirt Woman  ()',3,''),(1017,'2014-11-03 07:39:26',1,18,'578','Organic Bamboo Tanktop Woman  ()',3,''),(1018,'2014-11-03 07:39:26',1,18,'577','Organic Bamboo Tanktop Woman  ()',3,''),(1019,'2014-11-03 07:39:26',1,18,'576','Organic Bamboo Tanktop Woman ',3,''),(1020,'2014-11-03 07:39:26',1,18,'575','Organic Bamboo T-Shirt Woman  ()',3,''),(1021,'2014-11-03 07:39:26',1,18,'574','Organic Bamboo T-Shirt Woman  ()',3,''),(1022,'2014-11-03 07:39:26',1,18,'573','Organic Bamboo T-Shirt Woman ',3,''),(1023,'2014-11-03 07:39:26',1,18,'572','Mittens (Flap) Gloves  ()',3,''),(1024,'2014-11-03 07:39:26',1,18,'571','Mittens (Flap) Gloves  ()',3,''),(1025,'2014-11-03 07:39:26',1,18,'570','Mittens (Flap) Gloves  ()',3,''),(1026,'2014-11-03 07:39:26',1,18,'569','Mittens (Flap) Gloves  ()',3,''),(1027,'2014-11-03 07:39:26',1,18,'568','Mittens (Flap) Gloves ',3,''),(1028,'2014-11-03 07:39:26',1,18,'567','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1029,'2014-11-03 07:39:26',1,18,'566','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1030,'2014-11-03 07:39:26',1,18,'565','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1031,'2014-11-03 07:39:26',1,18,'564','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1032,'2014-11-03 07:39:26',1,18,'563','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1033,'2014-11-03 07:39:26',1,18,'562','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1034,'2014-11-03 07:39:26',1,18,'561','Cycling Boxer Sewn Upholstery Woman ',3,''),(1035,'2014-11-03 07:42:59',1,23,'1029','Size: 43-46',3,''),(1036,'2014-11-03 07:42:59',1,23,'1028','Size: 39-42',3,''),(1037,'2014-11-03 07:42:59',1,23,'1027','Material: THERMOLITE 70% Polyamide 13% Cotton 15% Elastane 2%',3,''),(1038,'2014-11-03 07:42:59',1,23,'1026','Color: Yellow',3,''),(1039,'2014-11-03 07:42:59',1,23,'1025','Size: 47-49',3,''),(1040,'2014-11-03 07:42:59',1,23,'1024','Size: 39-42',3,''),(1041,'2014-11-03 07:42:59',1,23,'1023','Material: Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',3,''),(1042,'2014-11-03 07:42:59',1,23,'1022','Color: Mid Grey/Light Grey',3,''),(1043,'2014-11-03 07:42:59',1,23,'1021','Size: XL',3,''),(1044,'2014-11-03 07:42:59',1,23,'1020','Size: L',3,''),(1045,'2014-11-03 07:42:59',1,23,'1019','Material: Polypropylene 74% Polyamide 21% Elastane 3% Carbon 2%',3,''),(1046,'2014-11-03 07:42:59',1,23,'1018','Color: Deep Black',3,''),(1047,'2014-11-03 07:42:59',1,23,'1017','Size: XL',3,''),(1048,'2014-11-03 07:42:59',1,23,'1016','Size: L',3,''),(1049,'2014-11-03 07:42:59',1,23,'1015','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1050,'2014-11-03 07:42:59',1,23,'1014','Color: Deep Black',3,''),(1051,'2014-11-03 07:42:59',1,23,'1013','Size: S',3,''),(1052,'2014-11-03 07:42:59',1,23,'1012','Size: M',3,''),(1053,'2014-11-03 07:42:59',1,23,'1011','Size: L',3,''),(1054,'2014-11-03 07:42:59',1,23,'1010','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1055,'2014-11-03 07:42:59',1,23,'1009','Color: Deep Black',3,''),(1056,'2014-11-03 07:42:59',1,23,'1008','Size: 43-46',3,''),(1057,'2014-11-03 07:42:59',1,23,'1007','Size: 39-42',3,''),(1058,'2014-11-03 07:42:59',1,23,'1006','Size: 39-42',3,''),(1059,'2014-11-03 07:42:59',1,23,'1005','Size: 35-38',3,''),(1060,'2014-11-03 07:42:59',1,23,'1004','Material: Polypropylene 56% Polyamide 41% Elastane 3%',3,''),(1061,'2014-11-03 07:42:59',1,23,'1003','Color: Neon Orange/Pink',3,''),(1062,'2014-11-03 07:42:59',1,23,'1002','Size: 47-49',3,''),(1063,'2014-11-03 07:42:59',1,23,'1001','Size: 43-46',3,''),(1064,'2014-11-03 07:42:59',1,23,'1000','Size: 39-42',3,''),(1065,'2014-11-03 07:42:59',1,23,'999','Material: Polyamide 65% Polyamide Microlon 23% Polyproplene 10% Elastane 2%',3,''),(1066,'2014-11-03 07:42:59',1,23,'998','Color: Black/Light Grey',3,''),(1067,'2014-11-03 07:42:59',1,23,'997','Size: 39-42',3,''),(1068,'2014-11-03 07:42:59',1,23,'996','Size: 35-38',3,''),(1069,'2014-11-03 07:42:59',1,23,'995','Material: Polyamide 65% Polyamide Microlon 20% Polyproyplene 13% Elastane 2%',3,''),(1070,'2014-11-03 07:42:59',1,23,'994','Color: Black/Light Grey',3,''),(1071,'2014-11-03 07:42:59',1,23,'993','Size: 47-49',3,''),(1072,'2014-11-03 07:42:59',1,23,'992','Size: 43-46',3,''),(1073,'2014-11-03 07:42:59',1,23,'991','Size: 39-42',3,''),(1074,'2014-11-03 07:42:59',1,23,'990','Size: 35-38',3,''),(1075,'2014-11-03 07:42:59',1,23,'989','Material: Polyamide 47% Polypropylene 26% Polyamide Microlon 25% Elastane 2%',3,''),(1076,'2014-11-03 07:42:59',1,23,'988','Color: Black/Orange',3,''),(1077,'2014-11-03 07:42:59',1,23,'987','Size: 47-49',3,''),(1078,'2014-11-03 07:42:59',1,23,'986','Size: 39-42',3,''),(1079,'2014-11-03 07:42:59',1,23,'985','Material: Polyester 54% Polyester Coolmax 30% Polyamide 14% Elastane 2%',3,''),(1080,'2014-11-03 07:42:59',1,23,'984','Color: White',3,''),(1081,'2014-11-03 07:42:59',1,23,'983','Size: XL',3,''),(1082,'2014-11-03 07:42:59',1,23,'982','Size: L',3,''),(1083,'2014-11-03 07:42:59',1,23,'981','Size: M',3,''),(1084,'2014-11-03 07:42:59',1,23,'980','Color: Black',3,''),(1085,'2014-11-03 07:42:59',1,23,'979','Size: L',3,''),(1086,'2014-11-03 07:42:59',1,23,'978','Size: M',3,''),(1087,'2014-11-03 07:42:59',1,23,'977','Size: S',3,''),(1088,'2014-11-03 07:42:59',1,23,'976','Color: Black',3,''),(1089,'2014-11-03 07:42:59',1,23,'975','Size: L',3,''),(1090,'2014-11-03 07:42:59',1,23,'974','Material: Wool 76% Polypropylene 12% Polyamide 10% Elastane 2%',3,''),(1091,'2014-11-03 07:42:59',1,23,'973','Color: Black',3,''),(1092,'2014-11-03 07:42:59',1,23,'972','Size: XL',3,''),(1093,'2014-11-03 07:42:59',1,23,'971','Size: L',3,''),(1094,'2014-11-03 07:42:59',1,23,'970','Size: M',3,''),(1095,'2014-11-03 07:42:59',1,23,'969','Material: Polyamide 88% Polyester 12%',3,''),(1096,'2014-11-03 07:42:59',1,23,'968','Color: Black',3,''),(1097,'2014-11-03 07:42:59',1,23,'967','Size: XL',3,''),(1098,'2014-11-03 07:42:59',1,23,'966','Size: L',3,''),(1099,'2014-11-03 07:42:59',1,23,'965','Material: Polyamide 88% Polyester 12%',3,''),(1100,'2014-11-03 07:42:59',1,23,'964','Color: Black',3,''),(1101,'2014-11-03 07:42:59',1,23,'963','Size: XL',3,''),(1102,'2014-11-03 07:42:59',1,23,'962','Size: L',3,''),(1103,'2014-11-03 07:42:59',1,23,'961','Material: Polyamide 88% Polyester 12%',3,''),(1104,'2014-11-03 07:42:59',1,23,'960','Color: Black',3,''),(1105,'2014-11-03 07:42:59',1,23,'959','Size: 152-164',3,''),(1106,'2014-11-03 07:42:59',1,23,'958','Size: 128-140',3,''),(1107,'2014-11-03 07:42:59',1,23,'957','Size: 104-116',3,''),(1108,'2014-11-03 07:42:59',1,23,'956','Material: Polyamide 78% Polyester 22%',3,''),(1109,'2014-11-03 07:42:59',1,23,'955','Color: Black ',3,''),(1110,'2014-11-03 07:42:59',1,23,'954','Size: 152-164',3,''),(1111,'2014-11-03 07:42:59',1,23,'953','Size: 128-140',3,''),(1112,'2014-11-03 07:42:59',1,23,'952','Size: 104-116',3,''),(1113,'2014-11-03 07:42:59',1,23,'951','Material: Polyamide 78% Polyester 22%',3,''),(1114,'2014-11-03 07:42:59',1,23,'950','Color: Black ',3,''),(1115,'2014-11-03 07:42:59',1,23,'949','Size: XL',3,''),(1116,'2014-11-03 07:42:59',1,23,'948','Size: L',3,''),(1117,'2014-11-03 07:42:59',1,23,'947','Size: M',3,''),(1118,'2014-11-03 07:42:59',1,23,'946','Material: Polyamide 78% Polyester 22%',3,''),(1119,'2014-11-03 07:42:59',1,23,'945','Color: Black',3,''),(1120,'2014-11-03 07:42:59',1,23,'944','Size: 4 Tight Man /XL',3,''),(1121,'2014-11-03 07:42:59',1,23,'943','Size: 4 Tight Man /L',3,''),(1122,'2014-11-03 07:42:59',1,23,'942','Size: 4 Tight Man /M',3,''),(1123,'2014-11-03 07:42:59',1,23,'941','Material: Polyamide 78% Polyester 22%',3,''),(1124,'2014-11-03 07:42:59',1,23,'940','Color: Black',3,''),(1125,'2014-11-03 07:42:59',1,23,'939','Size: XL',3,''),(1126,'2014-11-03 07:42:59',1,23,'938','Size: L',3,''),(1127,'2014-11-03 07:42:59',1,23,'937','Size: M',3,''),(1128,'2014-11-03 07:42:59',1,23,'936','Material: Polyamide 78% Polyester 22%',3,''),(1129,'2014-11-03 07:42:59',1,23,'935','Color: Black',3,''),(1130,'2014-11-03 07:42:59',1,23,'934','Size: XL',3,''),(1131,'2014-11-03 07:42:59',1,23,'933','Size: L',3,''),(1132,'2014-11-03 07:42:59',1,23,'932','Size: M',3,''),(1133,'2014-11-03 07:42:59',1,23,'931','Material: Polyamide 78% Polyester 22%',3,''),(1134,'2014-11-03 07:42:59',1,23,'930','Color: Black',3,''),(1135,'2014-11-03 07:42:59',1,23,'929','Size: XL',3,''),(1136,'2014-11-03 07:42:59',1,23,'928','Size: L',3,''),(1137,'2014-11-03 07:42:59',1,23,'927','Size: M',3,''),(1138,'2014-11-03 07:42:59',1,23,'926','Size: S',3,''),(1139,'2014-11-03 07:42:59',1,23,'925','Material: Polyamide 78% Polyester 22%',3,''),(1140,'2014-11-03 07:42:59',1,23,'924','Color: Black',3,''),(1141,'2014-11-03 07:42:59',1,23,'923','Size: XL',3,''),(1142,'2014-11-03 07:42:59',1,23,'922','Size: L',3,''),(1143,'2014-11-03 07:42:59',1,23,'921','Size: M',3,''),(1144,'2014-11-03 07:42:59',1,23,'920','Size: S',3,''),(1145,'2014-11-03 07:42:59',1,23,'919','Material: Polyamide 78% Polyester 22%',3,''),(1146,'2014-11-03 07:42:59',1,23,'918','Color: Black',3,''),(1147,'2014-11-03 07:42:59',1,23,'917','Size: XL',3,''),(1148,'2014-11-03 07:42:59',1,23,'916','Size: L',3,''),(1149,'2014-11-03 07:42:59',1,23,'915','Size: XL',3,''),(1150,'2014-11-03 07:42:59',1,23,'914','Size: L',3,''),(1151,'2014-11-03 07:42:59',1,23,'913','Size: 2 Short Man /XL',3,''),(1152,'2014-11-03 07:42:59',1,23,'912','Size: 2 Short Man /L',3,''),(1153,'2014-11-03 07:42:59',1,23,'911','Size: 2 Short Man /M',3,''),(1154,'2014-11-03 07:42:59',1,23,'910','Material: Polyamide 72% Polyester 21% Elastane 7%',3,''),(1155,'2014-11-03 07:42:59',1,23,'909','Color: Black',3,''),(1156,'2014-11-03 07:42:59',1,23,'908','Size: L',3,''),(1157,'2014-11-03 07:42:59',1,23,'907','Size: M',3,''),(1158,'2014-11-03 07:42:59',1,23,'906','Material: Polyamide 78% Polyester 22%',3,''),(1159,'2014-11-03 07:42:59',1,23,'905','Color: Black/Pink',3,''),(1160,'2014-11-03 07:42:59',1,23,'904','Size: L',3,''),(1161,'2014-11-03 07:42:59',1,23,'903','Size: M',3,''),(1162,'2014-11-03 07:42:59',1,23,'902','Material: Polyamide 78% Polyester 22%',3,''),(1163,'2014-11-03 07:42:59',1,23,'901','Color: Black/Pink',3,''),(1164,'2014-11-03 07:42:59',1,23,'900','Size: L',3,''),(1165,'2014-11-03 07:42:59',1,23,'899','Size: M',3,''),(1166,'2014-11-03 07:42:59',1,23,'898','Size: S',3,''),(1167,'2014-11-03 07:42:59',1,23,'897','Material: Polyamide 78% Polyester 22%',3,''),(1168,'2014-11-03 07:42:59',1,23,'896','Color: Black/Pink',3,''),(1169,'2014-11-03 07:42:59',1,23,'895','Size: L',3,''),(1170,'2014-11-03 07:42:59',1,23,'894','Size: M',3,''),(1171,'2014-11-03 07:42:59',1,23,'893','Size: S',3,''),(1172,'2014-11-03 07:42:59',1,23,'892','Material: Polyamide 94% Elastane 6%',3,''),(1173,'2014-11-03 07:42:59',1,23,'891','Color: Pink/Orange',3,''),(1174,'2014-11-03 07:42:59',1,23,'890','Size: XL',3,''),(1175,'2014-11-03 07:42:59',1,23,'889','Size: L',3,''),(1176,'2014-11-03 07:42:59',1,23,'888','Size: M',3,''),(1177,'2014-11-03 07:42:59',1,23,'887','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(1178,'2014-11-03 07:42:59',1,23,'886','Color: Black',3,''),(1179,'2014-11-03 07:42:59',1,23,'885','Size: L',3,''),(1180,'2014-11-03 07:42:59',1,23,'884','Size: M',3,''),(1181,'2014-11-03 07:42:59',1,23,'883','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(1182,'2014-11-03 07:42:59',1,23,'882','Color: Black',3,''),(1183,'2014-11-03 07:42:59',1,23,'881','Size: XL',3,''),(1184,'2014-11-03 07:42:59',1,23,'880','Size: L',3,''),(1185,'2014-11-03 07:42:59',1,23,'879','Size: S',3,''),(1186,'2014-11-03 07:42:59',1,23,'878','Size: XS',3,''),(1187,'2014-11-03 07:42:59',1,23,'877','Material: Polyester 100%',3,''),(1188,'2014-11-03 07:42:59',1,23,'876','Color: Black',3,''),(1189,'2014-11-03 07:42:59',1,23,'875','Size: XL',3,''),(1190,'2014-11-03 07:42:59',1,23,'874','Size: L',3,''),(1191,'2014-11-03 07:42:59',1,23,'873','Size: M',3,''),(1192,'2014-11-03 07:42:59',1,23,'872','Size: L',3,''),(1193,'2014-11-03 07:42:59',1,23,'871','Size: M',3,''),(1194,'2014-11-03 07:42:59',1,23,'870','Size: S',3,''),(1195,'2014-11-03 07:42:59',1,23,'869','Material: Polyamid 85% Polyester 15%',3,''),(1196,'2014-11-03 07:42:59',1,23,'868','Color: Black',3,''),(1197,'2014-11-03 07:43:16',1,18,'822','Skiing Lite  ()',3,''),(1198,'2014-11-03 07:43:16',1,18,'821','Skiing Lite  ()',3,''),(1199,'2014-11-03 07:43:16',1,18,'820','Skiing Lite ',3,''),(1200,'2014-11-03 07:43:16',1,18,'819','Skiing Nt P 100 Woman  ()',3,''),(1201,'2014-11-03 07:43:16',1,18,'818','Skiing Nt P 100 Woman  ()',3,''),(1202,'2014-11-03 07:43:16',1,18,'817','Skiing Nt P 100 Woman ',3,''),(1203,'2014-11-03 07:43:16',1,18,'816','Ultralight 70 T-Shirt Woman  ()',3,''),(1204,'2014-11-03 07:43:16',1,18,'815','Ultralight 70 Panty Woman  ()',3,''),(1205,'2014-11-03 07:43:16',1,18,'814','Ultralight 70 Panty Woman ',3,''),(1206,'2014-11-03 07:43:16',1,18,'813','Ultralight 70 Tanktop Man  ()',3,''),(1207,'2014-11-03 07:43:16',1,18,'812','Ultralight 70 Tanktop Man  ()',3,''),(1208,'2014-11-03 07:43:16',1,18,'811','Ultralight 70 Tanktop Man ',3,''),(1209,'2014-11-03 07:43:16',1,18,'810','Ultralight 70 T-Shirt Woman  ()',3,''),(1210,'2014-11-03 07:43:16',1,18,'809','Ultralight 70 T-Shirt Woman  ()',3,''),(1211,'2014-11-03 07:43:16',1,18,'808','Ultralight 70 T-Shirt Woman  ()',3,''),(1212,'2014-11-03 07:43:16',1,18,'807','Ultralight 70 T-Shirt Woman ',3,''),(1213,'2014-11-03 07:43:16',1,18,'806','Running Mid Woman  ()',3,''),(1214,'2014-11-03 07:43:16',1,18,'805','Running Mid Woman  ()',3,''),(1215,'2014-11-03 07:43:16',1,18,'804','Running Mid Woman  ()',3,''),(1216,'2014-11-03 07:43:16',1,18,'803','Running Mid Woman  ()',3,''),(1217,'2014-11-03 07:43:16',1,18,'802','Running Mid Woman ',3,''),(1218,'2014-11-03 07:43:16',1,18,'801','Running High Man  ()',3,''),(1219,'2014-11-03 07:43:16',1,18,'800','Running High Man  ()',3,''),(1220,'2014-11-03 07:43:16',1,18,'799','Running High Man  ()',3,''),(1221,'2014-11-03 07:43:16',1,18,'798','Running High Man ',3,''),(1222,'2014-11-03 07:43:16',1,18,'797','Running Short Woman  ()',3,''),(1223,'2014-11-03 07:43:16',1,18,'796','Running Short Woman  ()',3,''),(1224,'2014-11-03 07:43:16',1,18,'795','Running Short Woman ',3,''),(1225,'2014-11-03 07:43:16',1,18,'794','Trekking A 100  ()',3,''),(1226,'2014-11-03 07:43:16',1,18,'793','Trekking A 100  ()',3,''),(1227,'2014-11-03 07:43:16',1,18,'792','Trekking A 100  ()',3,''),(1228,'2014-11-03 07:43:16',1,18,'791','Trekking A 100  ()',3,''),(1229,'2014-11-03 07:43:16',1,18,'790','Trekking A 100 ',3,''),(1230,'2014-11-03 07:43:16',1,18,'789','Sporting Allround 300  ()',3,''),(1231,'2014-11-03 07:43:16',1,18,'788','Sporting Allround 300  ()',3,''),(1232,'2014-11-03 07:43:16',1,18,'787','Sporting Allround 300 ',3,''),(1233,'2014-11-03 07:43:16',1,18,'786','Merino Tec 240 Longtight Man  ()',3,''),(1234,'2014-11-03 07:43:16',1,18,'785','Merino Tec 240 Longtight Man  ()',3,''),(1235,'2014-11-03 07:43:16',1,18,'784','Merino Tec 240 Longtight Man  ()',3,''),(1236,'2014-11-03 07:43:16',1,18,'783','Merino Tec 240 Longtight Man ',3,''),(1237,'2014-11-03 07:43:16',1,18,'782','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(1238,'2014-11-03 07:43:16',1,18,'781','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(1239,'2014-11-03 07:43:16',1,18,'780','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(1240,'2014-11-03 07:43:16',1,18,'779','Merino Tec 240 Longshirt Zipper Woman ',3,''),(1241,'2014-11-03 07:43:16',1,18,'778','Merino T-Shirt Man  ()',3,''),(1242,'2014-11-03 07:43:16',1,18,'777','Merino T-Shirt Man ',3,''),(1243,'2014-11-03 07:43:16',1,18,'776','Megalight 200 Longtight Man  ()',3,''),(1244,'2014-11-03 07:43:16',1,18,'775','Megalight 200 Longtight Man  ()',3,''),(1245,'2014-11-03 07:43:16',1,18,'774','Megalight 200 Longtight Man  ()',3,''),(1246,'2014-11-03 07:43:16',1,18,'773','Megalight 200 Longtight Man ',3,''),(1247,'2014-11-03 07:43:16',1,18,'772','Megalight 200 Longshirt Man  ()',3,''),(1248,'2014-11-03 07:43:16',1,18,'771','Megalight 200 Longshirt Man  ()',3,''),(1249,'2014-11-03 07:43:16',1,18,'770','Megalight 200 Longshirt Man ',3,''),(1250,'2014-11-03 07:43:16',1,18,'769','Megalight 200 T-Shirt Man  ()',3,''),(1251,'2014-11-03 07:43:16',1,18,'768','Megalight 200 T-Shirt Man  ()',3,''),(1252,'2014-11-03 07:43:16',1,18,'767','Megalight 200 T-Shirt Man ',3,''),(1253,'2014-11-03 07:43:16',1,18,'766','Kids Megalight 140 Boxer Unisex  ()',3,''),(1254,'2014-11-03 07:43:16',1,18,'765','Kids Megalight 140 Boxer Unisex  ()',3,''),(1255,'2014-11-03 07:43:16',1,18,'764','Kids Megalight 140 Boxer Unisex  ()',3,''),(1256,'2014-11-03 07:43:16',1,18,'763','Kids Megalight 140 Boxer Unisex ',3,''),(1257,'2014-11-03 07:43:16',1,18,'762','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(1258,'2014-11-03 07:43:16',1,18,'761','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(1259,'2014-11-03 07:43:16',1,18,'760','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(1260,'2014-11-03 07:43:16',1,18,'759','Kids Megalight 140 T-Shirt Unisex ',3,''),(1261,'2014-11-03 07:43:16',1,18,'758','Megalight 140 Boxer Man  ()',3,''),(1262,'2014-11-03 07:43:16',1,18,'757','Megalight 140 Boxer Man  ()',3,''),(1263,'2014-11-03 07:43:16',1,18,'756','Megalight 140 Boxer Man  ()',3,''),(1264,'2014-11-03 07:43:16',1,18,'755','Megalight 140 Boxer Man ',3,''),(1265,'2014-11-03 07:43:16',1,18,'754','Megalight 140 3 ()',3,''),(1266,'2014-11-03 07:43:16',1,18,'753','Megalight 140 3 ()',3,''),(1267,'2014-11-03 07:43:16',1,18,'752','Megalight 140 3 ()',3,''),(1268,'2014-11-03 07:43:16',1,18,'751','Megalight 140 3',3,''),(1269,'2014-11-03 07:43:16',1,18,'750','Megalight 140 Longtight Man  ()',3,''),(1270,'2014-11-03 07:43:16',1,18,'749','Megalight 140 Longtight Man  ()',3,''),(1271,'2014-11-03 07:43:16',1,18,'748','Megalight 140 Longtight Man  ()',3,''),(1272,'2014-11-03 07:43:16',1,18,'747','Megalight 140 Longtight Man ',3,''),(1273,'2014-11-03 07:43:16',1,18,'746','Megalight 140 T-Shirt Man  ()',3,''),(1274,'2014-11-03 07:43:16',1,18,'745','Megalight 140 T-Shirt Man  ()',3,''),(1275,'2014-11-03 07:43:16',1,18,'744','Megalight 140 T-Shirt Man  ()',3,''),(1276,'2014-11-03 07:43:16',1,18,'743','Megalight 140 T-Shirt Man ',3,''),(1277,'2014-11-03 07:43:16',1,18,'742','Megalight 140 Tanktop Woman  ()',3,''),(1278,'2014-11-03 07:43:16',1,18,'741','Megalight 140 Tanktop Woman  ()',3,''),(1279,'2014-11-03 07:43:16',1,18,'740','Megalight 140 Tanktop Woman  ()',3,''),(1280,'2014-11-03 07:43:16',1,18,'739','Megalight 140 Tanktop Woman  ()',3,''),(1281,'2014-11-03 07:43:16',1,18,'738','Megalight 140 Tanktop Woman ',3,''),(1282,'2014-11-03 07:43:16',1,18,'737','Megalight 140 Longshirt Woman  ()',3,''),(1283,'2014-11-03 07:43:16',1,18,'736','Megalight 140 Longshirt Woman  ()',3,''),(1284,'2014-11-03 07:43:16',1,18,'735','Megalight 140 Longshirt Woman  ()',3,''),(1285,'2014-11-03 07:43:16',1,18,'734','Megalight 140 Longshirt Woman  ()',3,''),(1286,'2014-11-03 07:43:16',1,18,'733','Megalight 140 Longshirt Woman ',3,''),(1287,'2014-11-03 07:43:16',1,18,'732','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1288,'2014-11-03 07:43:16',1,18,'731','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1289,'2014-11-03 07:43:16',1,18,'730','Megalight 140 Longshirt Berry Woman  ()',3,''),(1290,'2014-11-03 07:43:16',1,18,'729','Megalight 140 Longshirt Berry Woman  ()',3,''),(1291,'2014-11-03 07:43:16',1,18,'728','Megalight 140 1 ()',3,''),(1292,'2014-11-03 07:43:16',1,18,'727','Megalight 140 1 ()',3,''),(1293,'2014-11-03 07:43:16',1,18,'726','Megalight 140 1 ()',3,''),(1294,'2014-11-03 07:43:16',1,18,'725','Megalight 140 1',3,''),(1295,'2014-11-03 07:43:16',1,18,'724','Megalight 140 Longshirt Berry Woman  ()',3,''),(1296,'2014-11-03 07:43:16',1,18,'723','Megalight 140 Longshirt Berry Woman  ()',3,''),(1297,'2014-11-03 07:43:16',1,18,'722','Megalight 140 Longshirt Berry Woman ',3,''),(1298,'2014-11-03 07:43:16',1,18,'721','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1299,'2014-11-03 07:43:16',1,18,'720','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1300,'2014-11-03 07:43:16',1,18,'719','Megalight 140 T-Shirt Berry Woman ',3,''),(1301,'2014-11-03 07:43:16',1,18,'718','Megalight 140 Longtight Berry Woman  ()',3,''),(1302,'2014-11-03 07:43:16',1,18,'717','Megalight 140 Longtight Berry Woman  ()',3,''),(1303,'2014-11-03 07:43:16',1,18,'716','Megalight 140 Longtight Berry Woman  ()',3,''),(1304,'2014-11-03 07:43:16',1,18,'715','Megalight 140 Longtight Berry Woman ',3,''),(1305,'2014-11-03 07:43:16',1,18,'714','Megalight 140 Singlet Berry Woman  ()',3,''),(1306,'2014-11-03 07:43:16',1,18,'713','Megalight 140 Singlet Berry Woman  ()',3,''),(1307,'2014-11-03 07:43:16',1,18,'712','Megalight 140 Singlet Berry Woman  ()',3,''),(1308,'2014-11-03 07:43:16',1,18,'711','Megalight 140 Singlet Berry Woman ',3,''),(1309,'2014-11-03 07:43:16',1,18,'710','Organic Bamboo T-Shirt Woman  ()',3,''),(1310,'2014-11-03 07:43:16',1,18,'709','Organic Bamboo Tanktop Woman  ()',3,''),(1311,'2014-11-03 07:43:16',1,18,'708','Organic Bamboo Tanktop Woman  ()',3,''),(1312,'2014-11-03 07:43:16',1,18,'707','Organic Bamboo Tanktop Woman ',3,''),(1313,'2014-11-03 07:43:16',1,18,'706','Organic Bamboo T-Shirt Woman  ()',3,''),(1314,'2014-11-03 07:43:16',1,18,'705','Organic Bamboo T-Shirt Woman  ()',3,''),(1315,'2014-11-03 07:43:16',1,18,'704','Organic Bamboo T-Shirt Woman ',3,''),(1316,'2014-11-03 07:43:16',1,18,'703','Mittens (Flap) Gloves  ()',3,''),(1317,'2014-11-03 07:43:16',1,18,'702','Mittens (Flap) Gloves  ()',3,''),(1318,'2014-11-03 07:43:16',1,18,'701','Mittens (Flap) Gloves  ()',3,''),(1319,'2014-11-03 07:43:16',1,18,'700','Mittens (Flap) Gloves  ()',3,''),(1320,'2014-11-03 07:43:16',1,18,'699','Mittens (Flap) Gloves ',3,''),(1321,'2014-11-03 07:43:16',1,18,'698','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1322,'2014-11-03 07:43:16',1,18,'697','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1323,'2014-11-03 07:43:16',1,18,'696','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1324,'2014-11-03 07:43:16',1,18,'695','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1325,'2014-11-03 07:43:16',1,18,'694','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1326,'2014-11-03 07:43:16',1,18,'693','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1327,'2014-11-03 07:43:16',1,18,'692','Cycling Boxer Sewn Upholstery Woman ',3,''),(1328,'2014-11-03 07:46:18',1,18,'953','Skiing Lite  (Size: 43-46)',3,''),(1329,'2014-11-03 07:46:18',1,18,'952','Skiing Lite  (Size: 39-42)',3,''),(1330,'2014-11-03 07:46:18',1,18,'951','Skiing Lite ',3,''),(1331,'2014-11-03 07:46:18',1,18,'950','Skiing Nt P 100 Woman  (Size: 47-49)',3,''),(1332,'2014-11-03 07:46:18',1,18,'949','Skiing Nt P 100 Woman  (Size: 39-42)',3,''),(1333,'2014-11-03 07:46:18',1,18,'948','Skiing Nt P 100 Woman ',3,''),(1334,'2014-11-03 07:46:18',1,18,'947','Ultralight 70 T-Shirt Woman  (Size: XL)',3,''),(1335,'2014-11-03 07:46:18',1,18,'946','Ultralight 70 Panty Woman  (Size: L)',3,''),(1336,'2014-11-03 07:46:18',1,18,'945','Ultralight 70 Panty Woman ',3,''),(1337,'2014-11-03 07:46:18',1,18,'944','Ultralight 70 Tanktop Man  (Size: XL)',3,''),(1338,'2014-11-03 07:46:18',1,18,'943','Ultralight 70 Tanktop Man  (Size: L)',3,''),(1339,'2014-11-03 07:46:18',1,18,'942','Ultralight 70 Tanktop Man ',3,''),(1340,'2014-11-03 07:46:18',1,18,'941','Ultralight 70 T-Shirt Woman  (Size: S)',3,''),(1341,'2014-11-03 07:46:18',1,18,'940','Ultralight 70 T-Shirt Woman  (Size: M)',3,''),(1342,'2014-11-03 07:46:18',1,18,'939','Ultralight 70 T-Shirt Woman  (Size: L)',3,''),(1343,'2014-11-03 07:46:18',1,18,'938','Ultralight 70 T-Shirt Woman ',3,''),(1344,'2014-11-03 07:46:18',1,18,'937','Running Mid Woman  (Size: 43-46)',3,''),(1345,'2014-11-03 07:46:18',1,18,'936','Running Mid Woman  (Size: 39-42)',3,''),(1346,'2014-11-03 07:46:18',1,18,'935','Running Mid Woman  (Size: 39-42)',3,''),(1347,'2014-11-03 07:46:18',1,18,'934','Running Mid Woman  (Size: 35-38)',3,''),(1348,'2014-11-03 07:46:18',1,18,'933','Running Mid Woman ',3,''),(1349,'2014-11-03 07:46:18',1,18,'932','Running High Man  (Size: 47-49)',3,''),(1350,'2014-11-03 07:46:18',1,18,'931','Running High Man  (Size: 43-46)',3,''),(1351,'2014-11-03 07:46:18',1,18,'930','Running High Man  (Size: 39-42)',3,''),(1352,'2014-11-03 07:46:18',1,18,'929','Running High Man ',3,''),(1353,'2014-11-03 07:46:18',1,18,'928','Running Short Woman  (Size: 39-42)',3,''),(1354,'2014-11-03 07:46:18',1,18,'927','Running Short Woman  (Size: 35-38)',3,''),(1355,'2014-11-03 07:46:18',1,18,'926','Running Short Woman ',3,''),(1356,'2014-11-03 07:46:18',1,18,'925','Trekking A 100  (Size: 47-49)',3,''),(1357,'2014-11-03 07:46:18',1,18,'924','Trekking A 100  (Size: 43-46)',3,''),(1358,'2014-11-03 07:46:18',1,18,'923','Trekking A 100  (Size: 39-42)',3,''),(1359,'2014-11-03 07:46:18',1,18,'922','Trekking A 100  (Size: 35-38)',3,''),(1360,'2014-11-03 07:46:18',1,18,'921','Trekking A 100 ',3,''),(1361,'2014-11-03 07:46:18',1,18,'920','Sporting Allround 300  (Size: 47-49)',3,''),(1362,'2014-11-03 07:46:18',1,18,'919','Sporting Allround 300  (Size: 39-42)',3,''),(1363,'2014-11-03 07:46:18',1,18,'918','Sporting Allround 300 ',3,''),(1364,'2014-11-03 07:46:18',1,18,'917','Merino Tec 240 Longtight Man  (Size: XL)',3,''),(1365,'2014-11-03 07:46:18',1,18,'916','Merino Tec 240 Longtight Man  (Size: L)',3,''),(1366,'2014-11-03 07:46:18',1,18,'915','Merino Tec 240 Longtight Man  (Size: M)',3,''),(1367,'2014-11-03 07:46:18',1,18,'914','Merino Tec 240 Longtight Man ',3,''),(1368,'2014-11-03 07:46:18',1,18,'913','Merino Tec 240 Longshirt Zipper Woman  (Size: L)',3,''),(1369,'2014-11-03 07:46:18',1,18,'912','Merino Tec 240 Longshirt Zipper Woman  (Size: M)',3,''),(1370,'2014-11-03 07:46:18',1,18,'911','Merino Tec 240 Longshirt Zipper Woman  (Size: S)',3,''),(1371,'2014-11-03 07:46:18',1,18,'910','Merino Tec 240 Longshirt Zipper Woman ',3,''),(1372,'2014-11-03 07:46:18',1,18,'909','Merino T-Shirt Man  (Size: L)',3,''),(1373,'2014-11-03 07:46:18',1,18,'908','Merino T-Shirt Man ',3,''),(1374,'2014-11-03 07:46:18',1,18,'907','Megalight 200 Longtight Man  (Size: XL)',3,''),(1375,'2014-11-03 07:46:18',1,18,'906','Megalight 200 Longtight Man  (Size: L)',3,''),(1376,'2014-11-03 07:46:18',1,18,'905','Megalight 200 Longtight Man  (Size: M)',3,''),(1377,'2014-11-03 07:46:18',1,18,'904','Megalight 200 Longtight Man ',3,''),(1378,'2014-11-03 07:46:18',1,18,'903','Megalight 200 Longshirt Man  (Size: XL)',3,''),(1379,'2014-11-03 07:46:18',1,18,'902','Megalight 200 Longshirt Man  (Size: L)',3,''),(1380,'2014-11-03 07:46:18',1,18,'901','Megalight 200 Longshirt Man ',3,''),(1381,'2014-11-03 07:46:18',1,18,'900','Megalight 200 T-Shirt Man  (Size: XL)',3,''),(1382,'2014-11-03 07:46:18',1,18,'899','Megalight 200 T-Shirt Man  (Size: L)',3,''),(1383,'2014-11-03 07:46:18',1,18,'898','Megalight 200 T-Shirt Man ',3,''),(1384,'2014-11-03 07:46:18',1,18,'897','Kids Megalight 140 Boxer Unisex  (Size: 152-164)',3,''),(1385,'2014-11-03 07:46:18',1,18,'896','Kids Megalight 140 Boxer Unisex  (Size: 128-140)',3,''),(1386,'2014-11-03 07:46:18',1,18,'895','Kids Megalight 140 Boxer Unisex  (Size: 104-116)',3,''),(1387,'2014-11-03 07:46:18',1,18,'894','Kids Megalight 140 Boxer Unisex ',3,''),(1388,'2014-11-03 07:46:18',1,18,'893','Kids Megalight 140 T-Shirt Unisex  (Size: 152-164)',3,''),(1389,'2014-11-03 07:46:18',1,18,'892','Kids Megalight 140 T-Shirt Unisex  (Size: 128-140)',3,''),(1390,'2014-11-03 07:46:18',1,18,'891','Kids Megalight 140 T-Shirt Unisex  (Size: 104-116)',3,''),(1391,'2014-11-03 07:46:18',1,18,'890','Kids Megalight 140 T-Shirt Unisex ',3,''),(1392,'2014-11-03 07:46:18',1,18,'889','Megalight 140 Boxer Man  (Size: XL)',3,''),(1393,'2014-11-03 07:46:18',1,18,'888','Megalight 140 Boxer Man  (Size: L)',3,''),(1394,'2014-11-03 07:46:18',1,18,'887','Megalight 140 Boxer Man  (Size: M)',3,''),(1395,'2014-11-03 07:46:18',1,18,'886','Megalight 140 Boxer Man ',3,''),(1396,'2014-11-03 07:46:18',1,18,'885','Megalight 140 3 (Size: 4 Tight Man /XL)',3,''),(1397,'2014-11-03 07:46:18',1,18,'884','Megalight 140 3 (Size: 4 Tight Man /L)',3,''),(1398,'2014-11-03 07:46:18',1,18,'883','Megalight 140 3 (Size: 4 Tight Man /M)',3,''),(1399,'2014-11-03 07:46:18',1,18,'882','Megalight 140 3',3,''),(1400,'2014-11-03 07:46:18',1,18,'881','Megalight 140 Longtight Man  (Size: XL)',3,''),(1401,'2014-11-03 07:46:18',1,18,'880','Megalight 140 Longtight Man  (Size: L)',3,''),(1402,'2014-11-03 07:46:18',1,18,'879','Megalight 140 Longtight Man  (Size: M)',3,''),(1403,'2014-11-03 07:46:18',1,18,'878','Megalight 140 Longtight Man ',3,''),(1404,'2014-11-03 07:46:18',1,18,'877','Megalight 140 T-Shirt Man  (Size: XL)',3,''),(1405,'2014-11-03 07:46:18',1,18,'876','Megalight 140 T-Shirt Man  (Size: L)',3,''),(1406,'2014-11-03 07:46:18',1,18,'875','Megalight 140 T-Shirt Man  (Size: M)',3,''),(1407,'2014-11-03 07:46:18',1,18,'874','Megalight 140 T-Shirt Man ',3,''),(1408,'2014-11-03 07:46:18',1,18,'873','Megalight 140 Tanktop Woman  (Size: XL)',3,''),(1409,'2014-11-03 07:46:18',1,18,'872','Megalight 140 Tanktop Woman  (Size: L)',3,''),(1410,'2014-11-03 07:46:18',1,18,'871','Megalight 140 Tanktop Woman  (Size: M)',3,''),(1411,'2014-11-03 07:46:18',1,18,'870','Megalight 140 Tanktop Woman  (Size: S)',3,''),(1412,'2014-11-03 07:46:18',1,18,'869','Megalight 140 Tanktop Woman ',3,''),(1413,'2014-11-03 07:46:18',1,18,'868','Megalight 140 Longshirt Woman  (Size: XL)',3,''),(1414,'2014-11-03 07:46:18',1,18,'867','Megalight 140 Longshirt Woman  (Size: L)',3,''),(1415,'2014-11-03 07:46:18',1,18,'866','Megalight 140 Longshirt Woman  (Size: M)',3,''),(1416,'2014-11-03 07:46:18',1,18,'865','Megalight 140 Longshirt Woman  (Size: S)',3,''),(1417,'2014-11-03 07:46:18',1,18,'864','Megalight 140 Longshirt Woman ',3,''),(1418,'2014-11-03 07:46:18',1,18,'863','Megalight 140 T-Shirt Berry Woman  (Size: XL)',3,''),(1419,'2014-11-03 07:46:18',1,18,'862','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(1420,'2014-11-03 07:46:18',1,18,'861','Megalight 140 Longshirt Berry Woman  (Size: XL)',3,''),(1421,'2014-11-03 07:46:18',1,18,'860','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(1422,'2014-11-03 07:46:18',1,18,'859','Megalight 140 1 (Size: 2 Short Man /XL)',3,''),(1423,'2014-11-03 07:46:18',1,18,'858','Megalight 140 1 (Size: 2 Short Man /L)',3,''),(1424,'2014-11-03 07:46:18',1,18,'857','Megalight 140 1 (Size: 2 Short Man /M)',3,''),(1425,'2014-11-03 07:46:18',1,18,'856','Megalight 140 1',3,''),(1426,'2014-11-03 07:46:18',1,18,'855','Megalight 140 Longshirt Berry Woman  (Size: L)',3,''),(1427,'2014-11-03 07:46:18',1,18,'854','Megalight 140 Longshirt Berry Woman  (Size: M)',3,''),(1428,'2014-11-03 07:46:18',1,18,'853','Megalight 140 Longshirt Berry Woman ',3,''),(1429,'2014-11-03 07:46:18',1,18,'852','Megalight 140 T-Shirt Berry Woman  (Size: L)',3,''),(1430,'2014-11-03 07:46:18',1,18,'851','Megalight 140 T-Shirt Berry Woman  (Size: M)',3,''),(1431,'2014-11-03 07:46:18',1,18,'850','Megalight 140 T-Shirt Berry Woman ',3,''),(1432,'2014-11-03 07:46:18',1,18,'849','Megalight 140 Longtight Berry Woman  (Size: L)',3,''),(1433,'2014-11-03 07:46:18',1,18,'848','Megalight 140 Longtight Berry Woman  (Size: M)',3,''),(1434,'2014-11-03 07:46:18',1,18,'847','Megalight 140 Longtight Berry Woman  (Size: S)',3,''),(1435,'2014-11-03 07:46:18',1,18,'846','Megalight 140 Longtight Berry Woman ',3,''),(1436,'2014-11-03 07:46:18',1,18,'845','Megalight 140 Singlet Berry Woman  (Size: L)',3,''),(1437,'2014-11-03 07:46:18',1,18,'844','Megalight 140 Singlet Berry Woman  (Size: M)',3,''),(1438,'2014-11-03 07:46:18',1,18,'843','Megalight 140 Singlet Berry Woman  (Size: S)',3,''),(1439,'2014-11-03 07:46:18',1,18,'842','Megalight 140 Singlet Berry Woman ',3,''),(1440,'2014-11-03 07:46:18',1,18,'841','Organic Bamboo T-Shirt Woman  (Size: XL)',3,''),(1441,'2014-11-03 07:46:18',1,18,'840','Organic Bamboo Tanktop Woman  (Size: L)',3,''),(1442,'2014-11-03 07:46:18',1,18,'839','Organic Bamboo Tanktop Woman  (Size: M)',3,''),(1443,'2014-11-03 07:46:18',1,18,'838','Organic Bamboo Tanktop Woman ',3,''),(1444,'2014-11-03 07:46:18',1,18,'837','Organic Bamboo T-Shirt Woman  (Size: L)',3,''),(1445,'2014-11-03 07:46:18',1,18,'836','Organic Bamboo T-Shirt Woman  (Size: M)',3,''),(1446,'2014-11-03 07:46:18',1,18,'835','Organic Bamboo T-Shirt Woman ',3,''),(1447,'2014-11-03 07:46:18',1,18,'834','Mittens (Flap) Gloves  (Size: XL)',3,''),(1448,'2014-11-03 07:46:18',1,18,'833','Mittens (Flap) Gloves  (Size: L)',3,''),(1449,'2014-11-03 07:46:18',1,18,'832','Mittens (Flap) Gloves  (Size: S)',3,''),(1450,'2014-11-03 07:46:18',1,18,'831','Mittens (Flap) Gloves  (Size: XS)',3,''),(1451,'2014-11-03 07:46:18',1,18,'830','Mittens (Flap) Gloves ',3,''),(1452,'2014-11-03 07:46:18',1,18,'829','Cycling Boxer Sewn Upholstery Woman  (Size: XL)',3,''),(1453,'2014-11-03 07:46:18',1,18,'828','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(1454,'2014-11-03 07:46:18',1,18,'827','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(1455,'2014-11-03 07:46:18',1,18,'826','Cycling Boxer Sewn Upholstery Woman  (Size: L)',3,''),(1456,'2014-11-03 07:46:18',1,18,'825','Cycling Boxer Sewn Upholstery Woman  (Size: M)',3,''),(1457,'2014-11-03 07:46:18',1,18,'824','Cycling Boxer Sewn Upholstery Woman  (Size: S)',3,''),(1458,'2014-11-03 07:46:18',1,18,'823','Cycling Boxer Sewn Upholstery Woman ',3,''),(1459,'2014-11-03 08:52:43',1,23,'1385','Color: Kindazimma - Fleece: Darkblue ',3,''),(1460,'2014-11-03 08:52:43',1,23,'1384','Size:  one size',3,''),(1461,'2014-11-03 08:52:43',1,23,'1383','Material: 100% Polyester',3,''),(1462,'2014-11-03 08:52:43',1,23,'1382','Color: Had Shards ',3,''),(1463,'2014-11-03 08:52:43',1,23,'1381','Color: Go Hard',3,''),(1464,'2014-11-03 08:52:43',1,23,'1380','Size:  one size',3,''),(1465,'2014-11-03 08:52:43',1,23,'1379','Material: 100%Polyester',3,''),(1466,'2014-11-03 08:52:43',1,23,'1378','Color: Any Available Style',3,''),(1467,'2014-11-03 08:52:43',1,23,'1377','Size:  one size',3,''),(1468,'2014-11-03 08:52:43',1,23,'1376','Material: 100% Polyester',3,''),(1469,'2014-11-03 08:52:43',1,23,'1375','Color: India Paisley Berry',3,''),(1470,'2014-11-03 08:52:43',1,23,'1374','Color: Woodcut Grey',3,''),(1471,'2014-11-03 08:52:43',1,23,'1373','Color: India Paisley Black ',3,''),(1472,'2014-11-03 08:52:43',1,23,'1372','Color: Grey',3,''),(1473,'2014-11-03 08:52:43',1,23,'1371','Color: Berry',3,''),(1474,'2014-11-03 08:52:43',1,23,'1370','Color: Sky',3,''),(1475,'2014-11-03 08:52:43',1,23,'1369','Size:  one size',3,''),(1476,'2014-11-03 08:52:43',1,23,'1368','Material: 100%Merino',3,''),(1477,'2014-11-03 08:52:43',1,23,'1367','Size: 43-46',3,''),(1478,'2014-11-03 08:52:43',1,23,'1366','Size: 39-42',3,''),(1479,'2014-11-03 08:52:43',1,23,'1365','Material: THERMOLITE 70% Polyamide 13% Cotton 15% Elastane 2%',3,''),(1480,'2014-11-03 08:52:43',1,23,'1364','Color: Yellow',3,''),(1481,'2014-11-03 08:52:43',1,23,'1363','Size: 47-49',3,''),(1482,'2014-11-03 08:52:43',1,23,'1362','Material: Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',3,''),(1483,'2014-11-03 08:52:43',1,23,'1361','Color: Mid Grey/Light Grey',3,''),(1484,'2014-11-03 08:52:43',1,23,'1360','Size: 39-42',3,''),(1485,'2014-11-03 08:52:43',1,23,'1359','Material: Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',3,''),(1486,'2014-11-03 08:52:43',1,23,'1358','Color: Mid Grey/Light Grey',3,''),(1487,'2014-11-03 08:52:43',1,23,'1357','Size: XL',3,''),(1488,'2014-11-03 08:52:43',1,23,'1356','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1489,'2014-11-03 08:52:43',1,23,'1355','Color: Deep Black',3,''),(1490,'2014-11-03 08:52:43',1,23,'1354','Size: L',3,''),(1491,'2014-11-03 08:52:43',1,23,'1353','Material: Polypropylene 74% Polyamide 21% Elastane 3% Carbon 2%',3,''),(1492,'2014-11-03 08:52:43',1,23,'1352','Color: Deep Black',3,''),(1493,'2014-11-03 08:52:43',1,23,'1351','Size: XL',3,''),(1494,'2014-11-03 08:52:43',1,23,'1350','Size: L',3,''),(1495,'2014-11-03 08:52:43',1,23,'1349','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1496,'2014-11-03 08:52:43',1,23,'1348','Color: Deep Black',3,''),(1497,'2014-11-03 08:52:43',1,23,'1347','Size: S',3,''),(1498,'2014-11-03 08:52:43',1,23,'1346','Size: M',3,''),(1499,'2014-11-03 08:52:43',1,23,'1345','Size: L',3,''),(1500,'2014-11-03 08:52:43',1,23,'1344','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1501,'2014-11-03 08:52:43',1,23,'1343','Color: Deep Black',3,''),(1502,'2014-11-03 08:52:43',1,23,'1342','Size: 43-46',3,''),(1503,'2014-11-03 08:52:43',1,23,'1341','Size: 39-42',3,''),(1504,'2014-11-03 08:52:43',1,23,'1340','Material: Polypropylene 56% Polyamide 41% Elastane 3%',3,''),(1505,'2014-11-03 08:52:43',1,23,'1339','Color: Neon Green/Yellow',3,''),(1506,'2014-11-03 08:52:43',1,23,'1338','Size: 39-42',3,''),(1507,'2014-11-03 08:52:43',1,23,'1337','Size: 35-38',3,''),(1508,'2014-11-03 08:52:43',1,23,'1336','Material: Polypropylene 56% Polyamide 41% Elastane 3%',3,''),(1509,'2014-11-03 08:52:43',1,23,'1335','Color: Neon Orange/Pink',3,''),(1510,'2014-11-03 08:52:43',1,23,'1334','Size: 47-49',3,''),(1511,'2014-11-03 08:52:43',1,23,'1333','Size: 43-46',3,''),(1512,'2014-11-03 08:52:43',1,23,'1332','Size: 39-42',3,''),(1513,'2014-11-03 08:52:43',1,23,'1331','Material: Polyamide 65% Polyamide Microlon 23% Polyproplene 10% Elastane 2%',3,''),(1514,'2014-11-03 08:52:43',1,23,'1330','Color: Black/Light Grey',3,''),(1515,'2014-11-03 08:52:43',1,23,'1329','Size: 39-42',3,''),(1516,'2014-11-03 08:52:43',1,23,'1328','Size: 35-38',3,''),(1517,'2014-11-03 08:52:43',1,23,'1327','Material: Polyamide 65% Polyamide Microlon 20% Polyproyplene 13% Elastane 2%',3,''),(1518,'2014-11-03 08:52:43',1,23,'1326','Color: Black/Light Grey',3,''),(1519,'2014-11-03 08:52:43',1,23,'1325','Size: 47-49',3,''),(1520,'2014-11-03 08:52:43',1,23,'1324','Size: 43-46',3,''),(1521,'2014-11-03 08:52:43',1,23,'1323','Size: 39-42',3,''),(1522,'2014-11-03 08:52:43',1,23,'1322','Size: 35-38',3,''),(1523,'2014-11-03 08:52:43',1,23,'1321','Material: Polyamide 47% Polypropylene 26% Polyamide Microlon 25% Elastane 2%',3,''),(1524,'2014-11-03 08:52:43',1,23,'1320','Color: Black/Orange',3,''),(1525,'2014-11-03 08:52:43',1,23,'1319','Size: 47-49',3,''),(1526,'2014-11-03 08:52:43',1,23,'1318','Size: 39-42',3,''),(1527,'2014-11-03 08:52:43',1,23,'1317','Material: Polyester 54% Polyester Coolmax 30% Polyamide 14% Elastane 2%',3,''),(1528,'2014-11-03 08:52:43',1,23,'1316','Color: White',3,''),(1529,'2014-11-03 08:52:43',1,23,'1315','Size: XL',3,''),(1530,'2014-11-03 08:52:43',1,23,'1314','Size: L',3,''),(1531,'2014-11-03 08:52:43',1,23,'1313','Size: M',3,''),(1532,'2014-11-03 08:52:43',1,23,'1312','Color: Black',3,''),(1533,'2014-11-03 08:52:43',1,23,'1311','Size: L',3,''),(1534,'2014-11-03 08:52:43',1,23,'1310','Size: M',3,''),(1535,'2014-11-03 08:52:43',1,23,'1309','Size: S',3,''),(1536,'2014-11-03 08:52:43',1,23,'1308','Color: Black',3,''),(1537,'2014-11-03 08:52:43',1,23,'1307','Size: L',3,''),(1538,'2014-11-03 08:52:43',1,23,'1306','Material: Wool 76% Polypropylene 12% Polyamide 10% Elastane 2%',3,''),(1539,'2014-11-03 08:52:43',1,23,'1305','Color: Black',3,''),(1540,'2014-11-03 08:52:43',1,23,'1304','Size: XL',3,''),(1541,'2014-11-03 08:52:43',1,23,'1303','Size: L',3,''),(1542,'2014-11-03 08:52:43',1,23,'1302','Size: M',3,''),(1543,'2014-11-03 08:52:43',1,23,'1301','Material: Polyamide 88% Polyester 12%',3,''),(1544,'2014-11-03 08:52:43',1,23,'1300','Color: Black',3,''),(1545,'2014-11-03 08:52:43',1,23,'1299','Size: XL',3,''),(1546,'2014-11-03 08:52:43',1,23,'1298','Size: L',3,''),(1547,'2014-11-03 08:52:43',1,23,'1297','Material: Polyamide 88% Polyester 12%',3,''),(1548,'2014-11-03 08:52:43',1,23,'1296','Color: Black',3,''),(1549,'2014-11-03 08:52:43',1,23,'1295','Size: XL',3,''),(1550,'2014-11-03 08:52:43',1,23,'1294','Size: L',3,''),(1551,'2014-11-03 08:52:43',1,23,'1293','Material: Polyamide 88% Polyester 12%',3,''),(1552,'2014-11-03 08:52:43',1,23,'1292','Color: Black',3,''),(1553,'2014-11-03 08:52:43',1,23,'1291','Size: 152-164',3,''),(1554,'2014-11-03 08:52:43',1,23,'1290','Size: 128-140',3,''),(1555,'2014-11-03 08:52:43',1,23,'1289','Size: 104-116',3,''),(1556,'2014-11-03 08:52:43',1,23,'1288','Material: Polyamide 78% Polyester 22%',3,''),(1557,'2014-11-03 08:52:43',1,23,'1287','Color: Black ',3,''),(1558,'2014-11-03 08:52:43',1,23,'1286','Size: 152-164',3,''),(1559,'2014-11-03 08:52:43',1,23,'1285','Size: 128-140',3,''),(1560,'2014-11-03 08:52:43',1,23,'1284','Size: 104-116',3,''),(1561,'2014-11-03 08:52:43',1,23,'1283','Material: Polyamide 78% Polyester 22%',3,''),(1562,'2014-11-03 08:52:43',1,23,'1282','Color: Black ',3,''),(1563,'2014-11-03 08:52:43',1,23,'1281','Size: XL',3,''),(1564,'2014-11-03 08:52:43',1,23,'1280','Size: L',3,''),(1565,'2014-11-03 08:52:43',1,23,'1279','Size: M',3,''),(1566,'2014-11-03 08:52:43',1,23,'1278','Material: Polyamide 78% Polyester 22%',3,''),(1567,'2014-11-03 08:52:43',1,23,'1277','Color: Black',3,''),(1568,'2014-11-03 08:52:43',1,23,'1276','Size: 4 Tight Man /XL',3,''),(1569,'2014-11-03 08:52:43',1,23,'1275','Size: 4 Tight Man /L',3,''),(1570,'2014-11-03 08:52:43',1,23,'1274','Size: 4 Tight Man /M',3,''),(1571,'2014-11-03 08:52:43',1,23,'1273','Material: Polyamide 78% Polyester 22%',3,''),(1572,'2014-11-03 08:52:43',1,23,'1272','Color: Black',3,''),(1573,'2014-11-03 08:52:43',1,23,'1271','Size: XL',3,''),(1574,'2014-11-03 08:52:43',1,23,'1270','Size: L',3,''),(1575,'2014-11-03 08:52:43',1,23,'1269','Size: M',3,''),(1576,'2014-11-03 08:52:43',1,23,'1268','Material: Polyamide 78% Polyester 22%',3,''),(1577,'2014-11-03 08:52:43',1,23,'1267','Color: Black',3,''),(1578,'2014-11-03 08:52:43',1,23,'1266','Size: XL',3,''),(1579,'2014-11-03 08:52:43',1,23,'1265','Size: L',3,''),(1580,'2014-11-03 08:52:43',1,23,'1264','Size: M',3,''),(1581,'2014-11-03 08:52:43',1,23,'1263','Material: Polyamide 78% Polyester 22%',3,''),(1582,'2014-11-03 08:52:43',1,23,'1262','Color: Black',3,''),(1583,'2014-11-03 08:52:43',1,23,'1261','Size: XL',3,''),(1584,'2014-11-03 08:52:43',1,23,'1260','Size: L',3,''),(1585,'2014-11-03 08:52:43',1,23,'1259','Size: M',3,''),(1586,'2014-11-03 08:52:43',1,23,'1258','Size: S',3,''),(1587,'2014-11-03 08:52:43',1,23,'1257','Material: Polyamide 78% Polyester 22%',3,''),(1588,'2014-11-03 08:52:43',1,23,'1256','Color: Black',3,''),(1589,'2014-11-03 08:52:43',1,23,'1255','Size: XL',3,''),(1590,'2014-11-03 08:52:43',1,23,'1254','Size: L',3,''),(1591,'2014-11-03 08:52:43',1,23,'1253','Size: M',3,''),(1592,'2014-11-03 08:52:43',1,23,'1252','Size: S',3,''),(1593,'2014-11-03 08:52:43',1,23,'1251','Material: Polyamide 78% Polyester 22%',3,''),(1594,'2014-11-03 08:52:43',1,23,'1250','Color: Black',3,''),(1595,'2014-11-03 08:52:43',1,23,'1249','Size: XL',3,''),(1596,'2014-11-03 08:52:43',1,23,'1248','Size: L',3,''),(1597,'2014-11-03 08:52:43',1,23,'1247','Material: Polyamide 78% Polyester 22%',3,''),(1598,'2014-11-03 08:52:43',1,23,'1246','Color: Black/Green',3,''),(1599,'2014-11-03 08:52:43',1,23,'1245','Size: XL',3,''),(1600,'2014-11-03 08:52:43',1,23,'1244','Size: L',3,''),(1601,'2014-11-03 08:52:43',1,23,'1243','Material: Polyamide 78% Polyester 22%',3,''),(1602,'2014-11-03 08:52:43',1,23,'1242','Color: Black/Green',3,''),(1603,'2014-11-03 08:52:43',1,23,'1241','Size: 2 Short Man /XL',3,''),(1604,'2014-11-03 08:52:43',1,23,'1240','Size: 2 Short Man /L',3,''),(1605,'2014-11-03 08:52:43',1,23,'1239','Size: 2 Short Man /M',3,''),(1606,'2014-11-03 08:52:43',1,23,'1238','Material: Polyamide 72% Polyester 21% Elastane 7%',3,''),(1607,'2014-11-03 08:52:43',1,23,'1237','Color: Black',3,''),(1608,'2014-11-03 08:52:43',1,23,'1236','Size: L',3,''),(1609,'2014-11-03 08:52:43',1,23,'1235','Size: M',3,''),(1610,'2014-11-03 08:52:43',1,23,'1234','Material: Polyamide 78% Polyester 22%',3,''),(1611,'2014-11-03 08:52:43',1,23,'1233','Color: Black/Pink',3,''),(1612,'2014-11-03 08:52:43',1,23,'1232','Size: L',3,''),(1613,'2014-11-03 08:52:43',1,23,'1231','Size: M',3,''),(1614,'2014-11-03 08:52:43',1,23,'1230','Material: Polyamide 78% Polyester 22%',3,''),(1615,'2014-11-03 08:52:43',1,23,'1229','Color: Black/Pink',3,''),(1616,'2014-11-03 08:52:43',1,23,'1228','Size: L',3,''),(1617,'2014-11-03 08:52:43',1,23,'1227','Size: M',3,''),(1618,'2014-11-03 08:52:43',1,23,'1226','Size: S',3,''),(1619,'2014-11-03 08:52:43',1,23,'1225','Material: Polyamide 78% Polyester 22%',3,''),(1620,'2014-11-03 08:52:43',1,23,'1224','Color: Black/Pink',3,''),(1621,'2014-11-03 08:52:43',1,23,'1223','Size: L',3,''),(1622,'2014-11-03 08:52:43',1,23,'1222','Size: M',3,''),(1623,'2014-11-03 08:52:43',1,23,'1221','Size: S',3,''),(1624,'2014-11-03 08:52:43',1,23,'1220','Material: Polyamide 94% Elastane 6%',3,''),(1625,'2014-11-03 08:52:43',1,23,'1219','Color: Pink/Orange',3,''),(1626,'2014-11-03 08:52:43',1,23,'1218','Size: XL',3,''),(1627,'2014-11-03 08:52:43',1,23,'1217','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(1628,'2014-11-03 08:52:43',1,23,'1216','Color: Black',3,''),(1629,'2014-11-03 08:52:43',1,23,'1215','Size: L',3,''),(1630,'2014-11-03 08:52:43',1,23,'1214','Size: M',3,''),(1631,'2014-11-03 08:52:43',1,23,'1213','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(1632,'2014-11-03 08:52:43',1,23,'1212','Color: Black',3,''),(1633,'2014-11-03 08:52:43',1,23,'1211','Size: L',3,''),(1634,'2014-11-03 08:52:43',1,23,'1210','Size: M',3,''),(1635,'2014-11-03 08:52:43',1,23,'1209','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(1636,'2014-11-03 08:52:43',1,23,'1208','Color: Black',3,''),(1637,'2014-11-03 08:52:43',1,23,'1207','Size: XL',3,''),(1638,'2014-11-03 08:52:43',1,23,'1206','Size: L',3,''),(1639,'2014-11-03 08:52:43',1,23,'1205','Size: S',3,''),(1640,'2014-11-03 08:52:43',1,23,'1204','Size: XS',3,''),(1641,'2014-11-03 08:52:43',1,23,'1203','Material: Polyester 100%',3,''),(1642,'2014-11-03 08:52:43',1,23,'1202','Color: Black',3,''),(1643,'2014-11-03 08:52:43',1,23,'1201','Size: XL',3,''),(1644,'2014-11-03 08:52:43',1,23,'1200','Size: L',3,''),(1645,'2014-11-03 08:52:43',1,23,'1199','Size: M',3,''),(1646,'2014-11-03 08:52:43',1,23,'1198','Material: Polyamid 85% Polyester 15%',3,''),(1647,'2014-11-03 08:52:43',1,23,'1197','Color: Black',3,''),(1648,'2014-11-03 08:52:43',1,23,'1196','Size: L',3,''),(1649,'2014-11-03 08:52:43',1,23,'1195','Size: M',3,''),(1650,'2014-11-03 08:52:43',1,23,'1194','Size: S',3,''),(1651,'2014-11-03 08:52:43',1,23,'1193','Material: Polyamid 85% Polyester 15%',3,''),(1652,'2014-11-03 08:52:43',1,23,'1192','Color: Black',3,''),(1653,'2014-11-03 08:55:22',1,18,'1105','Had Neckwarmer Fleece Kids  ()',3,''),(1654,'2014-11-03 08:55:22',1,18,'1104','Had Neckwarmer Fleece Kids ',3,''),(1655,'2014-11-03 08:55:22',1,18,'1103','Had Junior  ()',3,''),(1656,'2014-11-03 08:55:22',1,18,'1102','Had Junior  ()',3,''),(1657,'2014-11-03 08:55:22',1,18,'1101','Had Junior ',3,''),(1658,'2014-11-03 08:55:22',1,18,'1100','Had Neckwarmer Fleece  ()',3,''),(1659,'2014-11-03 08:55:22',1,18,'1099','Had Neckwarmer Fleece ',3,''),(1660,'2014-11-03 08:55:22',1,18,'1098','Had Merino  ()',3,''),(1661,'2014-11-03 08:55:22',1,18,'1097','Had Merino  ()',3,''),(1662,'2014-11-03 08:55:22',1,18,'1096','Had Merino  ()',3,''),(1663,'2014-11-03 08:55:22',1,18,'1095','Had Merino  ()',3,''),(1664,'2014-11-03 08:55:22',1,18,'1094','Had Merino  ()',3,''),(1665,'2014-11-03 08:55:22',1,18,'1093','Had Merino  ()',3,''),(1666,'2014-11-03 08:55:22',1,18,'1092','Had Merino ',3,''),(1667,'2014-11-03 08:55:22',1,18,'1091','Skiing Lite  ()',3,''),(1668,'2014-11-03 08:55:22',1,18,'1090','Skiing Lite  ()',3,''),(1669,'2014-11-03 08:55:22',1,18,'1089','Skiing Lite ',3,''),(1670,'2014-11-03 08:55:22',1,18,'1088','Skiing Nt P 100 Man  ()',3,''),(1671,'2014-11-03 08:55:22',1,18,'1087','Skiing Nt P 100 Man ',3,''),(1672,'2014-11-03 08:55:22',1,18,'1086','Skiing Nt P 100 Woman  ()',3,''),(1673,'2014-11-03 08:55:22',1,18,'1085','Skiing Nt P 100 Woman ',3,''),(1674,'2014-11-03 08:55:22',1,18,'1084','Ultralight 70 T-Shirt Man  ()',3,''),(1675,'2014-11-03 08:55:22',1,18,'1083','Ultralight 70 T-Shirt Man ',3,''),(1676,'2014-11-03 08:55:22',1,18,'1082','Ultralight 70 Panty Woman  ()',3,''),(1677,'2014-11-03 08:55:22',1,18,'1081','Ultralight 70 Panty Woman ',3,''),(1678,'2014-11-03 08:55:22',1,18,'1080','Ultralight 70 Tanktop Man  ()',3,''),(1679,'2014-11-03 08:55:22',1,18,'1079','Ultralight 70 Tanktop Man  ()',3,''),(1680,'2014-11-03 08:55:22',1,18,'1078','Ultralight 70 Tanktop Man ',3,''),(1681,'2014-11-03 08:55:22',1,18,'1077','Ultralight 70 T-Shirt Woman  ()',3,''),(1682,'2014-11-03 08:55:22',1,18,'1076','Ultralight 70 T-Shirt Woman  ()',3,''),(1683,'2014-11-03 08:55:22',1,18,'1075','Ultralight 70 T-Shirt Woman  ()',3,''),(1684,'2014-11-03 08:55:22',1,18,'1074','Ultralight 70 T-Shirt Woman ',3,''),(1685,'2014-11-03 08:55:22',1,18,'1073','Running Mid Man  ()',3,''),(1686,'2014-11-03 08:55:22',1,18,'1072','Running Mid Man  ()',3,''),(1687,'2014-11-03 08:55:22',1,18,'1071','Running Mid Man ',3,''),(1688,'2014-11-03 08:55:22',1,18,'1070','Running Mid Woman  ()',3,''),(1689,'2014-11-03 08:55:22',1,18,'1069','Running Mid Woman  ()',3,''),(1690,'2014-11-03 08:55:22',1,18,'1068','Running Mid Woman ',3,''),(1691,'2014-11-03 08:55:22',1,18,'1067','Running High Man  ()',3,''),(1692,'2014-11-03 08:55:22',1,18,'1066','Running High Man  ()',3,''),(1693,'2014-11-03 08:55:22',1,18,'1065','Running High Man  ()',3,''),(1694,'2014-11-03 08:55:22',1,18,'1064','Running High Man ',3,''),(1695,'2014-11-03 08:55:22',1,18,'1063','Running Short Woman  ()',3,''),(1696,'2014-11-03 08:55:22',1,18,'1062','Running Short Woman  ()',3,''),(1697,'2014-11-03 08:55:22',1,18,'1061','Running Short Woman ',3,''),(1698,'2014-11-03 08:55:22',1,18,'1060','Trekking A 100  ()',3,''),(1699,'2014-11-03 08:55:22',1,18,'1059','Trekking A 100  ()',3,''),(1700,'2014-11-03 08:55:22',1,18,'1058','Trekking A 100  ()',3,''),(1701,'2014-11-03 08:55:22',1,18,'1057','Trekking A 100  ()',3,''),(1702,'2014-11-03 08:55:22',1,18,'1056','Trekking A 100 ',3,''),(1703,'2014-11-03 08:55:22',1,18,'1055','Sporting Allround 300  ()',3,''),(1704,'2014-11-03 08:55:22',1,18,'1054','Sporting Allround 300  ()',3,''),(1705,'2014-11-03 08:55:22',1,18,'1053','Sporting Allround 300 ',3,''),(1706,'2014-11-03 08:55:22',1,18,'1052','Merino Tec 240 Longtight Man  ()',3,''),(1707,'2014-11-03 08:55:22',1,18,'1051','Merino Tec 240 Longtight Man  ()',3,''),(1708,'2014-11-03 08:55:22',1,18,'1050','Merino Tec 240 Longtight Man  ()',3,''),(1709,'2014-11-03 08:55:22',1,18,'1049','Merino Tec 240 Longtight Man ',3,''),(1710,'2014-11-03 08:55:22',1,18,'1048','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(1711,'2014-11-03 08:55:22',1,18,'1047','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(1712,'2014-11-03 08:55:22',1,18,'1046','Merino Tec 240 Longshirt Zipper Woman  ()',3,''),(1713,'2014-11-03 08:55:22',1,18,'1045','Merino Tec 240 Longshirt Zipper Woman ',3,''),(1714,'2014-11-03 08:55:22',1,18,'1044','Merino T-Shirt Man  ()',3,''),(1715,'2014-11-03 08:55:22',1,18,'1043','Merino T-Shirt Man ',3,''),(1716,'2014-11-03 08:55:22',1,18,'1042','Megalight 200 Longtight Man  ()',3,''),(1717,'2014-11-03 08:55:22',1,18,'1041','Megalight 200 Longtight Man  ()',3,''),(1718,'2014-11-03 08:55:22',1,18,'1040','Megalight 200 Longtight Man  ()',3,''),(1719,'2014-11-03 08:55:22',1,18,'1039','Megalight 200 Longtight Man ',3,''),(1720,'2014-11-03 08:55:22',1,18,'1038','Megalight 200 Longshirt Man  ()',3,''),(1721,'2014-11-03 08:55:22',1,18,'1037','Megalight 200 Longshirt Man  ()',3,''),(1722,'2014-11-03 08:55:22',1,18,'1036','Megalight 200 Longshirt Man ',3,''),(1723,'2014-11-03 08:55:22',1,18,'1035','Megalight 200 T-Shirt Man  ()',3,''),(1724,'2014-11-03 08:55:22',1,18,'1034','Megalight 200 T-Shirt Man  ()',3,''),(1725,'2014-11-03 08:55:22',1,18,'1033','Megalight 200 T-Shirt Man ',3,''),(1726,'2014-11-03 08:55:22',1,18,'1032','Kids Megalight 140 Boxer Unisex  ()',3,''),(1727,'2014-11-03 08:55:22',1,18,'1031','Kids Megalight 140 Boxer Unisex  ()',3,''),(1728,'2014-11-03 08:55:22',1,18,'1030','Kids Megalight 140 Boxer Unisex  ()',3,''),(1729,'2014-11-03 08:55:22',1,18,'1029','Kids Megalight 140 Boxer Unisex ',3,''),(1730,'2014-11-03 08:55:22',1,18,'1028','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(1731,'2014-11-03 08:55:22',1,18,'1027','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(1732,'2014-11-03 08:55:22',1,18,'1026','Kids Megalight 140 T-Shirt Unisex  ()',3,''),(1733,'2014-11-03 08:55:22',1,18,'1025','Kids Megalight 140 T-Shirt Unisex ',3,''),(1734,'2014-11-03 08:55:22',1,18,'1024','Megalight 140 Boxer Man  ()',3,''),(1735,'2014-11-03 08:55:22',1,18,'1023','Megalight 140 Boxer Man  ()',3,''),(1736,'2014-11-03 08:55:22',1,18,'1022','Megalight 140 Boxer Man  ()',3,''),(1737,'2014-11-03 08:55:22',1,18,'1021','Megalight 140 Boxer Man ',3,''),(1738,'2014-11-03 08:55:22',1,18,'1020','Megalight 140 3 ()',3,''),(1739,'2014-11-03 08:55:22',1,18,'1019','Megalight 140 3 ()',3,''),(1740,'2014-11-03 08:55:22',1,18,'1018','Megalight 140 3 ()',3,''),(1741,'2014-11-03 08:55:22',1,18,'1017','Megalight 140 3',3,''),(1742,'2014-11-03 08:55:22',1,18,'1016','Megalight 140 Longtight Man  ()',3,''),(1743,'2014-11-03 08:55:22',1,18,'1015','Megalight 140 Longtight Man  ()',3,''),(1744,'2014-11-03 08:55:22',1,18,'1014','Megalight 140 Longtight Man  ()',3,''),(1745,'2014-11-03 08:55:22',1,18,'1013','Megalight 140 Longtight Man ',3,''),(1746,'2014-11-03 08:55:22',1,18,'1012','Megalight 140 T-Shirt Man  ()',3,''),(1747,'2014-11-03 08:55:22',1,18,'1011','Megalight 140 T-Shirt Man  ()',3,''),(1748,'2014-11-03 08:55:22',1,18,'1010','Megalight 140 T-Shirt Man  ()',3,''),(1749,'2014-11-03 08:55:22',1,18,'1009','Megalight 140 T-Shirt Man ',3,''),(1750,'2014-11-03 08:55:22',1,18,'1008','Megalight 140 Tanktop Woman  ()',3,''),(1751,'2014-11-03 08:55:22',1,18,'1007','Megalight 140 Tanktop Woman  ()',3,''),(1752,'2014-11-03 08:55:22',1,18,'1006','Megalight 140 Tanktop Woman  ()',3,''),(1753,'2014-11-03 08:55:22',1,18,'1005','Megalight 140 Tanktop Woman  ()',3,''),(1754,'2014-11-03 08:55:22',1,18,'1004','Megalight 140 Tanktop Woman ',3,''),(1755,'2014-11-03 08:55:22',1,18,'1003','Megalight 140 Longshirt Woman  ()',3,''),(1756,'2014-11-03 08:55:22',1,18,'1002','Megalight 140 Longshirt Woman  ()',3,''),(1757,'2014-11-03 08:55:22',1,18,'1001','Megalight 140 Longshirt Woman  ()',3,''),(1758,'2014-11-03 08:55:22',1,18,'1000','Megalight 140 Longshirt Woman  ()',3,''),(1759,'2014-11-03 08:55:22',1,18,'999','Megalight 140 Longshirt Woman ',3,''),(1760,'2014-11-03 08:55:22',1,18,'998','Megalight 140 T-Shirt Lime Man  ()',3,''),(1761,'2014-11-03 08:55:22',1,18,'997','Megalight 140 T-Shirt Lime Man  ()',3,''),(1762,'2014-11-03 08:55:22',1,18,'996','Megalight 140 T-Shirt Lime Man ',3,''),(1763,'2014-11-03 08:55:22',1,18,'995','Megalight 140 Longshirt Lime Man  ()',3,''),(1764,'2014-11-03 08:55:22',1,18,'994','Megalight 140 Longshirt Lime Man  ()',3,''),(1765,'2014-11-03 08:55:22',1,18,'993','Megalight 140 Longshirt Lime Man ',3,''),(1766,'2014-11-03 08:55:22',1,18,'992','Megalight 140 1 ()',3,''),(1767,'2014-11-03 08:55:22',1,18,'991','Megalight 140 1 ()',3,''),(1768,'2014-11-03 08:55:22',1,18,'990','Megalight 140 1 ()',3,''),(1769,'2014-11-03 08:55:22',1,18,'989','Megalight 140 1',3,''),(1770,'2014-11-03 08:55:22',1,18,'988','Megalight 140 Longshirt Berry Woman  ()',3,''),(1771,'2014-11-03 08:55:22',1,18,'987','Megalight 140 Longshirt Berry Woman  ()',3,''),(1772,'2014-11-03 08:55:22',1,18,'986','Megalight 140 Longshirt Berry Woman ',3,''),(1773,'2014-11-03 08:55:22',1,18,'985','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1774,'2014-11-03 08:55:22',1,18,'984','Megalight 140 T-Shirt Berry Woman  ()',3,''),(1775,'2014-11-03 08:55:22',1,18,'983','Megalight 140 T-Shirt Berry Woman ',3,''),(1776,'2014-11-03 08:55:22',1,18,'982','Megalight 140 Longtight Berry Woman  ()',3,''),(1777,'2014-11-03 08:55:22',1,18,'981','Megalight 140 Longtight Berry Woman  ()',3,''),(1778,'2014-11-03 08:55:22',1,18,'980','Megalight 140 Longtight Berry Woman  ()',3,''),(1779,'2014-11-03 08:55:22',1,18,'979','Megalight 140 Longtight Berry Woman ',3,''),(1780,'2014-11-03 08:55:22',1,18,'978','Megalight 140 Singlet Berry Woman  ()',3,''),(1781,'2014-11-03 08:55:22',1,18,'977','Megalight 140 Singlet Berry Woman  ()',3,''),(1782,'2014-11-03 08:55:22',1,18,'976','Megalight 140 Singlet Berry Woman  ()',3,''),(1783,'2014-11-03 08:55:22',1,18,'975','Megalight 140 Singlet Berry Woman ',3,''),(1784,'2014-11-03 08:55:22',1,18,'974','Organic Bamboo T-Shirt Man  ()',3,''),(1785,'2014-11-03 08:55:22',1,18,'973','Organic Bamboo T-Shirt Man ',3,''),(1786,'2014-11-03 08:55:22',1,18,'972','Organic Bamboo Tanktop Woman  ()',3,''),(1787,'2014-11-03 08:55:22',1,18,'971','Organic Bamboo Tanktop Woman  ()',3,''),(1788,'2014-11-03 08:55:22',1,18,'970','Organic Bamboo Tanktop Woman ',3,''),(1789,'2014-11-03 08:55:22',1,18,'969','Organic Bamboo T-Shirt Woman  ()',3,''),(1790,'2014-11-03 08:55:22',1,18,'968','Organic Bamboo T-Shirt Woman  ()',3,''),(1791,'2014-11-03 08:55:22',1,18,'967','Organic Bamboo T-Shirt Woman ',3,''),(1792,'2014-11-03 08:55:22',1,18,'966','Mittens (Flap) Gloves  ()',3,''),(1793,'2014-11-03 08:55:22',1,18,'965','Mittens (Flap) Gloves  ()',3,''),(1794,'2014-11-03 08:55:22',1,18,'964','Mittens (Flap) Gloves  ()',3,''),(1795,'2014-11-03 08:55:22',1,18,'963','Mittens (Flap) Gloves  ()',3,''),(1796,'2014-11-03 08:55:22',1,18,'962','Mittens (Flap) Gloves ',3,''),(1797,'2014-11-03 08:55:22',1,18,'961','Cycling Boxer Sewn Upholstery Man  ()',3,''),(1798,'2014-11-03 08:55:22',1,18,'960','Cycling Boxer Sewn Upholstery Man  ()',3,''),(1799,'2014-11-03 08:55:22',1,18,'959','Cycling Boxer Sewn Upholstery Man  ()',3,''),(1800,'2014-11-03 08:55:22',1,18,'958','Cycling Boxer Sewn Upholstery Man ',3,''),(1801,'2014-11-03 08:55:22',1,18,'957','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1802,'2014-11-03 08:55:22',1,18,'956','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1803,'2014-11-03 08:55:22',1,18,'955','Cycling Boxer Sewn Upholstery Woman  ()',3,''),(1804,'2014-11-03 08:55:22',1,18,'954','Cycling Boxer Sewn Upholstery Woman ',3,''),(1805,'2014-11-03 10:11:17',1,23,'1680','Color: Stripe Beige Blue - Fleece: Grey',3,''),(1806,'2014-11-03 10:11:17',1,23,'1679','Size:  one size',3,''),(1807,'2014-11-03 10:11:17',1,23,'1678','Material: 100%Polyester',3,''),(1808,'2014-11-03 10:11:17',1,23,'1677','Color: Eskimo - Fleece: Darkblue',3,''),(1809,'2014-11-03 10:11:17',1,23,'1676','Color: Giraffe ',3,''),(1810,'2014-11-03 10:11:17',1,23,'1675','Color: TräCker ',3,''),(1811,'2014-11-03 10:11:17',1,23,'1674','Color: Bugz Blue',3,''),(1812,'2014-11-03 10:11:17',1,23,'1673','Size:  one size',3,''),(1813,'2014-11-03 10:11:17',1,23,'1672','Material: 100%Polyester',3,''),(1814,'2014-11-03 10:11:17',1,23,'1671','Color: Drift - Fleece: Red ',3,''),(1815,'2014-11-03 10:11:17',1,23,'1670','Color: Go Hard Reflective - Jm',3,''),(1816,'2014-11-03 10:11:17',1,23,'1669','Size: one size',3,''),(1817,'2014-11-03 10:11:17',1,23,'1668','Material: 100%Polyester',3,''),(1818,'2014-11-03 10:11:17',1,23,'1667','Color: Water Colour Pink - Fleece: Fluffy Black',3,''),(1819,'2014-11-03 10:11:17',1,23,'1666','Color: Skal Deer Black - Fleece: Black',3,''),(1820,'2014-11-03 10:11:17',1,23,'1665','Color: Red - Fleece: Black',3,''),(1821,'2014-11-03 10:11:17',1,23,'1664','Color: Sky - Fleece: Black',3,''),(1822,'2014-11-03 10:11:17',1,23,'1663','Color: Black Eyes - Fleece: Black',3,''),(1823,'2014-11-03 10:11:17',1,23,'1662','Size:  one size',3,''),(1824,'2014-11-03 10:11:17',1,23,'1661','Material: 100%Polyester',3,''),(1825,'2014-11-03 10:11:17',1,23,'1660','Color: Rb Confetti Mint - Fleece: Black',3,''),(1826,'2014-11-03 10:11:17',1,23,'1659','Color: Dot Grass - Fleece: Black',3,''),(1827,'2014-11-03 10:11:17',1,23,'1658','Color: Neon Green - Fleece: Black ',3,''),(1828,'2014-11-03 10:11:17',1,23,'1657','Color: Arabesk - Fleece: Camel',3,''),(1829,'2014-11-03 10:11:17',1,23,'1656','Color: Chico - Fleece: Camel',3,''),(1830,'2014-11-03 10:11:17',1,23,'1655','Color: Marvin - Fleece: Black ',3,''),(1831,'2014-11-03 10:11:17',1,23,'1654','Color: Babylon - Fleece: Black',3,''),(1832,'2014-11-03 10:11:17',1,23,'1653','Color: Peer - Fleece: Camel',3,''),(1833,'2014-11-03 10:11:17',1,23,'1652','Color: Fading Pink - Fleece: Lightblue',3,''),(1834,'2014-11-03 10:11:17',1,23,'1651','Size:  one size',3,''),(1835,'2014-11-03 10:11:17',1,23,'1650','Material: 100%Polyester',3,''),(1836,'2014-11-03 10:11:17',1,23,'1649','Color: Black Eyes',3,''),(1837,'2014-11-03 10:11:17',1,23,'1648','Size:  one size',3,''),(1838,'2014-11-03 10:11:17',1,23,'1647','Material: 100% Polyester',3,''),(1839,'2014-11-03 10:11:17',1,23,'1646','Color: Seabase ',3,''),(1840,'2014-11-03 10:11:17',1,23,'1645','Size: one size',3,''),(1841,'2014-11-03 10:11:17',1,23,'1644','Material: 100% Polyester',3,''),(1842,'2014-11-03 10:11:17',1,23,'1643','Color: Kaleidoscope Layers',3,''),(1843,'2014-11-03 10:11:17',1,23,'1642','Size: one size',3,''),(1844,'2014-11-03 10:11:17',1,23,'1641','Material: 100% Polyester',3,''),(1845,'2014-11-03 10:11:17',1,23,'1640','Color: Gulf Stream ',3,''),(1846,'2014-11-03 10:11:17',1,23,'1639','Color: Mt. Everest',3,''),(1847,'2014-11-03 10:11:17',1,23,'1638','Size:  one size',3,''),(1848,'2014-11-03 10:11:17',1,23,'1637','Material: 100% Primaloft',3,''),(1849,'2014-11-03 10:11:17',1,23,'1636','Color: Woodcut Sky',3,''),(1850,'2014-11-03 10:11:17',1,23,'1635','Color: Black',3,''),(1851,'2014-11-03 10:11:17',1,23,'1634','Color: Coolmax Temple ',3,''),(1852,'2014-11-03 10:11:17',1,23,'1633','Color: Coolmax Sunset ',3,''),(1853,'2014-11-03 10:11:17',1,23,'1632','Color: Coolmax Black Eyes Reflective',3,''),(1854,'2014-11-03 10:11:17',1,23,'1631','Size: one size',3,''),(1855,'2014-11-03 10:11:17',1,23,'1630','Material: 100% Polyester',3,''),(1856,'2014-11-03 10:11:17',1,23,'1629','Color: Tricolo - Bm',3,''),(1857,'2014-11-03 10:11:17',1,23,'1628','Color: Falcon Eye - Bm',3,''),(1858,'2014-11-03 10:11:17',1,23,'1627','Color: Black Eyes Reflective- Bm ',3,''),(1859,'2014-11-03 10:11:17',1,23,'1626','Size: one size',3,''),(1860,'2014-11-03 10:11:17',1,23,'1625','Material: 100% Coolmax',3,''),(1861,'2014-11-03 10:11:17',1,23,'1624','Color: Single Karo Mint',3,''),(1862,'2014-11-03 10:11:17',1,23,'1623','Color: Sepp',3,''),(1863,'2014-11-03 10:11:17',1,23,'1622','Color: Heidi',3,''),(1864,'2014-11-03 10:11:17',1,23,'1621','Color: Buds ',3,''),(1865,'2014-11-03 10:11:17',1,23,'1620','Color: Arborg ',3,''),(1866,'2014-11-03 10:11:17',1,23,'1619','Color: Nautilus ',3,''),(1867,'2014-11-03 10:11:17',1,23,'1618','Color: Nimmaland ',3,''),(1868,'2014-11-03 10:11:17',1,23,'1617','Color: Pinions ',3,''),(1869,'2014-11-03 10:11:17',1,23,'1616','Color: The Mexican',3,''),(1870,'2014-11-03 10:11:17',1,23,'1615','Color: Pirate',3,''),(1871,'2014-11-03 10:11:17',1,23,'1614','Color: Chains ',3,''),(1872,'2014-11-03 10:11:17',1,23,'1613','Color: Rusties',3,''),(1873,'2014-11-03 10:11:17',1,23,'1612','Color: Moto Tears Red',3,''),(1874,'2014-11-03 10:11:17',1,23,'1611','Color: Chinese Dragon Blue',3,''),(1875,'2014-11-03 10:11:17',1,23,'1610','Color: Identity Black',3,''),(1876,'2014-11-03 10:11:17',1,23,'1609','Color: Moto Tears Black',3,''),(1877,'2014-11-03 10:11:17',1,23,'1608','Color: Crazy Flowers Cloud',3,''),(1878,'2014-11-03 10:11:17',1,23,'1607','Color: Comb Black',3,''),(1879,'2014-11-03 10:11:17',1,23,'1606','Color: Fox Flower Black',3,''),(1880,'2014-11-03 10:11:17',1,23,'1605','Color: Crazy Flowers Berry',3,''),(1881,'2014-11-03 10:11:17',1,23,'1604','Color: Woodcut Blanc ',3,''),(1882,'2014-11-03 10:11:17',1,23,'1603','Color: Urban Camouflage',3,''),(1883,'2014-11-03 10:11:17',1,23,'1602','Color: Lines Longway Lilac',3,''),(1884,'2014-11-03 10:11:17',1,23,'1601','Color: Mosaik Atari Black',3,''),(1885,'2014-11-03 10:11:17',1,23,'1600','Color: Dragon Pink',3,''),(1886,'2014-11-03 10:11:17',1,23,'1599','Color: Smoke',3,''),(1887,'2014-11-03 10:11:17',1,23,'1598','Color: Lost Blue',3,''),(1888,'2014-11-03 10:11:17',1,23,'1597','Color: Water Colour Black ',3,''),(1889,'2014-11-03 10:11:17',1,23,'1596','Color: Nebula',3,''),(1890,'2014-11-03 10:11:17',1,23,'1595','Color: Mali ',3,''),(1891,'2014-11-03 10:11:17',1,23,'1594','Color: Water Colour Pink ',3,''),(1892,'2014-11-03 10:11:17',1,23,'1593','Color: Twister ',3,''),(1893,'2014-11-03 10:11:17',1,23,'1592','Color: Grey',3,''),(1894,'2014-11-03 10:11:17',1,23,'1591','Color: Berry ',3,''),(1895,'2014-11-03 10:11:17',1,23,'1590','Color: Grass',3,''),(1896,'2014-11-03 10:11:17',1,23,'1589','Color: White',3,''),(1897,'2014-11-03 10:11:17',1,23,'1588','Size:  one size',3,''),(1898,'2014-11-03 10:11:17',1,23,'1587','Material: 100%Polyester',3,''),(1899,'2014-11-03 10:11:17',1,23,'1586','Color: Patrick Seabase ',3,''),(1900,'2014-11-03 10:11:17',1,23,'1585','Color: Ml-Barrel King',3,''),(1901,'2014-11-03 10:11:17',1,23,'1584','Color: Japo',3,''),(1902,'2014-11-03 10:11:17',1,23,'1583','Color: Howdy - Um',3,''),(1903,'2014-11-03 10:11:17',1,23,'1582','Color: Mountain\'S Calling - Om',3,''),(1904,'2014-11-03 10:11:17',1,23,'1581','Color: Badaboom - Junior - Jm',3,''),(1905,'2014-11-03 10:11:17',1,23,'1580','Color: Bear - Bm',3,''),(1906,'2014-11-03 10:11:17',1,23,'1579','Color: Kindazimma - Fleece: Darkblue ',3,''),(1907,'2014-11-03 10:11:17',1,23,'1578','Size:  one size',3,''),(1908,'2014-11-03 10:11:17',1,23,'1577','Material: 100% Polyester',3,''),(1909,'2014-11-03 10:11:17',1,23,'1576','Color: Had Shards ',3,''),(1910,'2014-11-03 10:11:17',1,23,'1575','Color: Go Hard',3,''),(1911,'2014-11-03 10:11:17',1,23,'1574','Size:  one size',3,''),(1912,'2014-11-03 10:11:17',1,23,'1573','Material: 100%Polyester',3,''),(1913,'2014-11-03 10:11:17',1,23,'1572','Color: Any Available Style',3,''),(1914,'2014-11-03 10:11:17',1,23,'1571','Size:  one size',3,''),(1915,'2014-11-03 10:11:17',1,23,'1570','Material: 100% Polyester',3,''),(1916,'2014-11-03 10:11:17',1,23,'1569','Color: India Paisley Berry',3,''),(1917,'2014-11-03 10:11:17',1,23,'1568','Color: Woodcut Grey',3,''),(1918,'2014-11-03 10:11:17',1,23,'1567','Color: India Paisley Black ',3,''),(1919,'2014-11-03 10:11:17',1,23,'1566','Color: Grey',3,''),(1920,'2014-11-03 10:11:17',1,23,'1565','Color: Berry',3,''),(1921,'2014-11-03 10:11:17',1,23,'1564','Color: Sky',3,''),(1922,'2014-11-03 10:11:17',1,23,'1563','Size:  one size',3,''),(1923,'2014-11-03 10:11:17',1,23,'1562','Material: 100%Merino',3,''),(1924,'2014-11-03 10:11:17',1,23,'1561','Size: 43-46',3,''),(1925,'2014-11-03 10:11:17',1,23,'1560','Size: 39-42',3,''),(1926,'2014-11-03 10:11:17',1,23,'1559','Material: THERMOLITE 70% Polyamide 13% Cotton 15% Elastane 2%',3,''),(1927,'2014-11-03 10:11:17',1,23,'1558','Color: Yellow',3,''),(1928,'2014-11-03 10:11:17',1,23,'1557','Size: 47-49',3,''),(1929,'2014-11-03 10:11:17',1,23,'1556','Material: Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',3,''),(1930,'2014-11-03 10:11:17',1,23,'1555','Color: Mid Grey/Light Grey',3,''),(1931,'2014-11-03 10:11:17',1,23,'1554','Size: 39-42',3,''),(1932,'2014-11-03 10:11:17',1,23,'1553','Material: Polyamide 33% Wool 30% Polyacryl 30% Polyamide Cordura 5% Elastane 2%',3,''),(1933,'2014-11-03 10:11:17',1,23,'1552','Color: Mid Grey/Light Grey',3,''),(1934,'2014-11-03 10:11:17',1,23,'1551','Size: XL',3,''),(1935,'2014-11-03 10:11:17',1,23,'1550','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1936,'2014-11-03 10:11:17',1,23,'1549','Color: Deep Black',3,''),(1937,'2014-11-03 10:11:17',1,23,'1548','Size: L',3,''),(1938,'2014-11-03 10:11:17',1,23,'1547','Material: Polypropylene 74% Polyamide 21% Elastane 3% Carbon 2%',3,''),(1939,'2014-11-03 10:11:17',1,23,'1546','Color: Deep Black',3,''),(1940,'2014-11-03 10:11:17',1,23,'1545','Size: XL',3,''),(1941,'2014-11-03 10:11:17',1,23,'1544','Size: L',3,''),(1942,'2014-11-03 10:11:17',1,23,'1543','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1943,'2014-11-03 10:11:17',1,23,'1542','Color: Deep Black',3,''),(1944,'2014-11-03 10:11:17',1,23,'1541','Size: S',3,''),(1945,'2014-11-03 10:11:17',1,23,'1540','Size: M',3,''),(1946,'2014-11-03 10:11:17',1,23,'1539','Size: L',3,''),(1947,'2014-11-03 10:11:17',1,23,'1538','Material: Polypropylene 76% Polyamide 22% Carbon 2%',3,''),(1948,'2014-11-03 10:11:17',1,23,'1537','Color: Deep Black',3,''),(1949,'2014-11-03 10:11:17',1,23,'1536','Size: 43-46',3,''),(1950,'2014-11-03 10:11:17',1,23,'1535','Size: 39-42',3,''),(1951,'2014-11-03 10:11:17',1,23,'1534','Material: Polypropylene 56% Polyamide 41% Elastane 3%',3,''),(1952,'2014-11-03 10:11:17',1,23,'1533','Color: Neon Green/Yellow',3,''),(1953,'2014-11-03 10:11:17',1,23,'1532','Size: 39-42',3,''),(1954,'2014-11-03 10:11:17',1,23,'1531','Size: 35-38',3,''),(1955,'2014-11-03 10:11:17',1,23,'1530','Material: Polypropylene 56% Polyamide 41% Elastane 3%',3,''),(1956,'2014-11-03 10:11:17',1,23,'1529','Color: Neon Orange/Pink',3,''),(1957,'2014-11-03 10:11:17',1,23,'1528','Size: 47-49',3,''),(1958,'2014-11-03 10:11:17',1,23,'1527','Size: 43-46',3,''),(1959,'2014-11-03 10:11:17',1,23,'1526','Size: 39-42',3,''),(1960,'2014-11-03 10:11:17',1,23,'1525','Material: Polyamide 65% Polyamide Microlon 23% Polyproplene 10% Elastane 2%',3,''),(1961,'2014-11-03 10:11:17',1,23,'1524','Color: Black/Light Grey',3,''),(1962,'2014-11-03 10:11:17',1,23,'1523','Size: 39-42',3,''),(1963,'2014-11-03 10:11:17',1,23,'1522','Size: 35-38',3,''),(1964,'2014-11-03 10:11:17',1,23,'1521','Material: Polyamide 65% Polyamide Microlon 20% Polyproyplene 13% Elastane 2%',3,''),(1965,'2014-11-03 10:11:17',1,23,'1520','Color: Black/Light Grey',3,''),(1966,'2014-11-03 10:11:17',1,23,'1519','Size: 47-49',3,''),(1967,'2014-11-03 10:11:17',1,23,'1518','Size: 43-46',3,''),(1968,'2014-11-03 10:11:17',1,23,'1517','Size: 39-42',3,''),(1969,'2014-11-03 10:11:17',1,23,'1516','Size: 35-38',3,''),(1970,'2014-11-03 10:11:17',1,23,'1515','Material: Polyamide 47% Polypropylene 26% Polyamide Microlon 25% Elastane 2%',3,''),(1971,'2014-11-03 10:11:17',1,23,'1514','Color: Black/Orange',3,''),(1972,'2014-11-03 10:11:17',1,23,'1513','Size: 47-49',3,''),(1973,'2014-11-03 10:11:17',1,23,'1512','Size: 39-42',3,''),(1974,'2014-11-03 10:11:17',1,23,'1511','Material: Polyester 54% Polyester Coolmax 30% Polyamide 14% Elastane 2%',3,''),(1975,'2014-11-03 10:11:17',1,23,'1510','Color: White',3,''),(1976,'2014-11-03 10:11:17',1,23,'1509','Size: XL',3,''),(1977,'2014-11-03 10:11:17',1,23,'1508','Size: L',3,''),(1978,'2014-11-03 10:11:17',1,23,'1507','Size: M',3,''),(1979,'2014-11-03 10:11:17',1,23,'1506','Color: Black',3,''),(1980,'2014-11-03 10:11:17',1,23,'1505','Size: L',3,''),(1981,'2014-11-03 10:11:17',1,23,'1504','Size: M',3,''),(1982,'2014-11-03 10:11:17',1,23,'1503','Size: S',3,''),(1983,'2014-11-03 10:11:17',1,23,'1502','Color: Black',3,''),(1984,'2014-11-03 10:11:17',1,23,'1501','Size: L',3,''),(1985,'2014-11-03 10:11:17',1,23,'1500','Material: Wool 76% Polypropylene 12% Polyamide 10% Elastane 2%',3,''),(1986,'2014-11-03 10:11:17',1,23,'1499','Color: Black',3,''),(1987,'2014-11-03 10:11:17',1,23,'1498','Size: XL',3,''),(1988,'2014-11-03 10:11:17',1,23,'1497','Size: L',3,''),(1989,'2014-11-03 10:11:17',1,23,'1496','Size: M',3,''),(1990,'2014-11-03 10:11:17',1,23,'1495','Material: Polyamide 88% Polyester 12%',3,''),(1991,'2014-11-03 10:11:17',1,23,'1494','Color: Black',3,''),(1992,'2014-11-03 10:11:17',1,23,'1493','Size: XL',3,''),(1993,'2014-11-03 10:11:17',1,23,'1492','Size: L',3,''),(1994,'2014-11-03 10:11:17',1,23,'1491','Material: Polyamide 88% Polyester 12%',3,''),(1995,'2014-11-03 10:11:17',1,23,'1490','Color: Black',3,''),(1996,'2014-11-03 10:11:17',1,23,'1489','Size: XL',3,''),(1997,'2014-11-03 10:11:17',1,23,'1488','Size: L',3,''),(1998,'2014-11-03 10:11:17',1,23,'1487','Material: Polyamide 88% Polyester 12%',3,''),(1999,'2014-11-03 10:11:17',1,23,'1486','Color: Black',3,''),(2000,'2014-11-03 10:11:17',1,23,'1485','Size: 152-164',3,''),(2001,'2014-11-03 10:11:17',1,23,'1484','Size: 128-140',3,''),(2002,'2014-11-03 10:11:17',1,23,'1483','Size: 104-116',3,''),(2003,'2014-11-03 10:11:17',1,23,'1482','Material: Polyamide 78% Polyester 22%',3,''),(2004,'2014-11-03 10:11:17',1,23,'1481','Color: Black ',3,''),(2005,'2014-11-03 10:11:17',1,23,'1480','Size: 152-164',3,''),(2006,'2014-11-03 10:11:17',1,23,'1479','Size: 128-140',3,''),(2007,'2014-11-03 10:11:17',1,23,'1478','Size: 104-116',3,''),(2008,'2014-11-03 10:11:17',1,23,'1477','Material: Polyamide 78% Polyester 22%',3,''),(2009,'2014-11-03 10:11:17',1,23,'1476','Color: Black ',3,''),(2010,'2014-11-03 10:11:17',1,23,'1475','Size: XL',3,''),(2011,'2014-11-03 10:11:17',1,23,'1474','Size: L',3,''),(2012,'2014-11-03 10:11:17',1,23,'1473','Size: M',3,''),(2013,'2014-11-03 10:11:17',1,23,'1472','Material: Polyamide 78% Polyester 22%',3,''),(2014,'2014-11-03 10:11:17',1,23,'1471','Color: Black',3,''),(2015,'2014-11-03 10:11:17',1,23,'1470','Size: 4 Tight Man /XL',3,''),(2016,'2014-11-03 10:11:17',1,23,'1469','Size: 4 Tight Man /L',3,''),(2017,'2014-11-03 10:11:17',1,23,'1468','Size: 4 Tight Man /M',3,''),(2018,'2014-11-03 10:11:17',1,23,'1467','Material: Polyamide 78% Polyester 22%',3,''),(2019,'2014-11-03 10:11:17',1,23,'1466','Color: Black',3,''),(2020,'2014-11-03 10:11:17',1,23,'1465','Size: XL',3,''),(2021,'2014-11-03 10:11:17',1,23,'1464','Size: L',3,''),(2022,'2014-11-03 10:11:17',1,23,'1463','Size: M',3,''),(2023,'2014-11-03 10:11:17',1,23,'1462','Material: Polyamide 78% Polyester 22%',3,''),(2024,'2014-11-03 10:11:17',1,23,'1461','Color: Black',3,''),(2025,'2014-11-03 10:11:17',1,23,'1460','Size: XL',3,''),(2026,'2014-11-03 10:11:17',1,23,'1459','Size: L',3,''),(2027,'2014-11-03 10:11:17',1,23,'1458','Size: M',3,''),(2028,'2014-11-03 10:11:17',1,23,'1457','Material: Polyamide 78% Polyester 22%',3,''),(2029,'2014-11-03 10:11:17',1,23,'1456','Color: Black',3,''),(2030,'2014-11-03 10:11:17',1,23,'1455','Size: XL',3,''),(2031,'2014-11-03 10:11:17',1,23,'1454','Size: L',3,''),(2032,'2014-11-03 10:11:17',1,23,'1453','Size: M',3,''),(2033,'2014-11-03 10:11:17',1,23,'1452','Size: S',3,''),(2034,'2014-11-03 10:11:17',1,23,'1451','Material: Polyamide 78% Polyester 22%',3,''),(2035,'2014-11-03 10:11:17',1,23,'1450','Color: Black',3,''),(2036,'2014-11-03 10:11:17',1,23,'1449','Size: XL',3,''),(2037,'2014-11-03 10:11:17',1,23,'1448','Size: L',3,''),(2038,'2014-11-03 10:11:17',1,23,'1447','Size: M',3,''),(2039,'2014-11-03 10:11:17',1,23,'1446','Size: S',3,''),(2040,'2014-11-03 10:11:17',1,23,'1445','Material: Polyamide 78% Polyester 22%',3,''),(2041,'2014-11-03 10:11:17',1,23,'1444','Color: Black',3,''),(2042,'2014-11-03 10:11:17',1,23,'1443','Size: XL',3,''),(2043,'2014-11-03 10:11:17',1,23,'1442','Size: L',3,''),(2044,'2014-11-03 10:11:17',1,23,'1441','Material: Polyamide 78% Polyester 22%',3,''),(2045,'2014-11-03 10:11:17',1,23,'1440','Color: Black/Green',3,''),(2046,'2014-11-03 10:11:17',1,23,'1439','Size: XL',3,''),(2047,'2014-11-03 10:11:17',1,23,'1438','Size: L',3,''),(2048,'2014-11-03 10:11:17',1,23,'1437','Material: Polyamide 78% Polyester 22%',3,''),(2049,'2014-11-03 10:11:17',1,23,'1436','Color: Black/Green',3,''),(2050,'2014-11-03 10:11:17',1,23,'1435','Size: 2 Short Man /XL',3,''),(2051,'2014-11-03 10:11:17',1,23,'1434','Size: 2 Short Man /L',3,''),(2052,'2014-11-03 10:11:17',1,23,'1433','Size: 2 Short Man /M',3,''),(2053,'2014-11-03 10:11:17',1,23,'1432','Material: Polyamide 72% Polyester 21% Elastane 7%',3,''),(2054,'2014-11-03 10:11:17',1,23,'1431','Color: Black',3,''),(2055,'2014-11-03 10:11:17',1,23,'1430','Size: L',3,''),(2056,'2014-11-03 10:11:17',1,23,'1429','Size: M',3,''),(2057,'2014-11-03 10:11:17',1,23,'1428','Material: Polyamide 78% Polyester 22%',3,''),(2058,'2014-11-03 10:11:17',1,23,'1427','Color: Black/Pink',3,''),(2059,'2014-11-03 10:11:17',1,23,'1426','Size: L',3,''),(2060,'2014-11-03 10:11:17',1,23,'1425','Size: M',3,''),(2061,'2014-11-03 10:11:17',1,23,'1424','Material: Polyamide 78% Polyester 22%',3,''),(2062,'2014-11-03 10:11:17',1,23,'1423','Color: Black/Pink',3,''),(2063,'2014-11-03 10:11:17',1,23,'1422','Size: L',3,''),(2064,'2014-11-03 10:11:17',1,23,'1421','Size: M',3,''),(2065,'2014-11-03 10:11:17',1,23,'1420','Size: S',3,''),(2066,'2014-11-03 10:11:17',1,23,'1419','Material: Polyamide 78% Polyester 22%',3,''),(2067,'2014-11-03 10:11:17',1,23,'1418','Color: Black/Pink',3,''),(2068,'2014-11-03 10:11:17',1,23,'1417','Size: L',3,''),(2069,'2014-11-03 10:11:17',1,23,'1416','Size: M',3,''),(2070,'2014-11-03 10:11:17',1,23,'1415','Size: S',3,''),(2071,'2014-11-03 10:11:17',1,23,'1414','Material: Polyamide 94% Elastane 6%',3,''),(2072,'2014-11-03 10:11:17',1,23,'1413','Color: Pink/Orange',3,''),(2073,'2014-11-03 10:11:17',1,23,'1412','Size: XL',3,''),(2074,'2014-11-03 10:11:17',1,23,'1411','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(2075,'2014-11-03 10:11:17',1,23,'1410','Color: Black',3,''),(2076,'2014-11-03 10:11:17',1,23,'1409','Size: L',3,''),(2077,'2014-11-03 10:11:17',1,23,'1408','Size: M',3,''),(2078,'2014-11-03 10:11:17',1,23,'1407','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(2079,'2014-11-03 10:11:17',1,23,'1406','Color: Black',3,''),(2080,'2014-11-03 10:11:17',1,23,'1405','Size: L',3,''),(2081,'2014-11-03 10:11:17',1,23,'1404','Size: M',3,''),(2082,'2014-11-03 10:11:17',1,23,'1403','Material: Bamboo 81% Polyamide 15% Elastane 4%',3,''),(2083,'2014-11-03 10:11:17',1,23,'1402','Color: Black',3,''),(2084,'2014-11-03 10:11:17',1,23,'1401','Size: XL',3,''),(2085,'2014-11-03 10:11:17',1,23,'1400','Size: L',3,''),(2086,'2014-11-03 10:11:17',1,23,'1399','Size: S',3,''),(2087,'2014-11-03 10:11:17',1,23,'1398','Size: XS',3,''),(2088,'2014-11-03 10:11:17',1,23,'1397','Material: Polyester 100%',3,''),(2089,'2014-11-03 10:11:17',1,23,'1396','Color: Black',3,''),(2090,'2014-11-03 10:11:17',1,23,'1395','Size: XL',3,''),(2091,'2014-11-03 10:11:17',1,23,'1394','Size: L',3,''),(2092,'2014-11-03 10:11:17',1,23,'1393','Size: M',3,''),(2093,'2014-11-03 10:11:17',1,23,'1392','Material: Polyamid 85% Polyester 15%',3,''),(2094,'2014-11-03 10:11:17',1,23,'1391','Color: Black',3,''),(2095,'2014-11-03 10:11:17',1,23,'1390','Size: L',3,''),(2096,'2014-11-03 10:11:17',1,23,'1389','Size: M',3,''),(2097,'2014-11-03 10:11:17',1,23,'1388','Size: S',3,''),(2098,'2014-11-03 10:11:17',1,23,'1387','Material: Polyamid 85% Polyester 15%',3,''),(2099,'2014-11-03 10:11:17',1,23,'1386','Color: Black',3,''),(2100,'2014-11-03 10:11:32',1,22,'2','Color',3,''),(2101,'2014-11-03 10:11:32',1,22,'3','Material',3,''),(2102,'2014-11-03 10:11:32',1,22,'1','Size',3,''),(2103,'2014-11-03 10:11:47',1,17,'5','Rock Climbing',3,''),(2104,'2014-11-03 10:11:47',1,17,'4','Skiing',3,''),(2105,'2014-11-03 10:11:47',1,17,'3','Trekking',3,''),(2106,'2014-11-03 10:11:47',1,17,'2','Running',3,''),(2107,'2014-11-03 10:11:47',1,17,'1','Cycling',3,''),(2108,'2014-11-03 10:12:05',1,16,'6','Makak',3,''),(2109,'2014-11-03 10:12:05',1,16,'5','H.A.D.',3,''),(2110,'2014-11-03 10:12:05',1,16,'4','F-Lite',3,''),(2111,'2014-11-03 10:12:05',1,16,'3','Charko',3,''),(2112,'2014-11-03 10:12:05',1,16,'2','Bourge-de-Peage',3,''),(2113,'2014-11-03 10:12:05',1,16,'1','8BPlus',3,''),(2114,'2014-11-03 10:12:25',1,19,'1','Clothing',3,''),(2115,'2014-11-03 10:12:47',1,20,'1','Clothing',3,''),(2116,'2014-11-03 10:12:47',1,20,'19','Clothing > Kid\'s Clothing',3,''),(2117,'2014-11-03 10:12:47',1,20,'63','Clothing > Kid\'s Clothing > Accessories',3,''),(2118,'2014-11-03 10:12:47',1,20,'22','Clothing > Kid\'s Clothing > Boy\'s Jackets & Coats',3,''),(2119,'2014-11-03 10:12:47',1,20,'21','Clothing > Kid\'s Clothing > Boy\'s Pants & Shorts',3,''),(2120,'2014-11-03 10:12:47',1,20,'20','Clothing > Kid\'s Clothing > Boy\'s Shirts',3,''),(2121,'2014-11-03 10:12:47',1,20,'65','Clothing > Kid\'s Clothing > Boy\'s Shirts > Longshirt',3,''),(2122,'2014-11-03 10:12:47',1,20,'64','Clothing > Kid\'s Clothing > Boy\'s Shirts > T-Shirt',3,''),(2123,'2014-11-03 10:12:47',1,20,'66','Clothing > Kid\'s Clothing > Boy\'s Shirts > Tanktop',3,''),(2124,'2014-11-03 10:12:47',1,20,'23','Clothing > Kid\'s Clothing > Boy\'s Swimwear',3,''),(2125,'2014-11-03 10:12:47',1,20,'70','Clothing > Kid\'s Clothing > Girl\'s Dresses & Skirts',3,''),(2126,'2014-11-03 10:12:47',1,20,'26','Clothing > Kid\'s Clothing > Girl\'s Jackets & Coats',3,''),(2127,'2014-11-03 10:12:47',1,20,'25','Clothing > Kid\'s Clothing > Girl\'s Pants & Shorts',3,''),(2128,'2014-11-03 10:12:47',1,20,'24','Clothing > Kid\'s Clothing > Girl\'s Shirts',3,''),(2129,'2014-11-03 10:12:47',1,20,'68','Clothing > Kid\'s Clothing > Girl\'s Shirts > Longshirt',3,''),(2130,'2014-11-03 10:12:47',1,20,'67','Clothing > Kid\'s Clothing > Girl\'s Shirts > T-Shirt',3,''),(2131,'2014-11-03 10:12:47',1,20,'69','Clothing > Kid\'s Clothing > Girl\'s Shirts > Tanktop',3,''),(2132,'2014-11-03 10:12:47',1,20,'27','Clothing > Kid\'s Clothing > Girl\'s Swimwear',3,''),(2133,'2014-11-03 10:12:47',1,20,'2','Clothing > Men\'s Clothing',3,''),(2134,'2014-11-03 10:12:47',1,20,'55','Clothing > Men\'s Clothing > Accessories',3,''),(2135,'2014-11-03 10:12:47',1,20,'8','Clothing > Men\'s Clothing > Base Layer',3,''),(2136,'2014-11-03 10:12:47',1,20,'6','Clothing > Men\'s Clothing > Jackets & Coats',3,''),(2137,'2014-11-03 10:12:47',1,20,'5','Clothing > Men\'s Clothing > Pants',3,''),(2138,'2014-11-03 10:12:47',1,20,'3','Clothing > Men\'s Clothing > Shirts',3,''),(2139,'2014-11-03 10:12:47',1,20,'57','Clothing > Men\'s Clothing > Shirts > Longshirt',3,''),(2140,'2014-11-03 10:12:47',1,20,'56','Clothing > Men\'s Clothing > Shirts > T-Shirt',3,''),(2141,'2014-11-03 10:12:47',1,20,'58','Clothing > Men\'s Clothing > Shirts > Tanktop',3,''),(2142,'2014-11-03 10:12:47',1,20,'4','Clothing > Men\'s Clothing > Shorts',3,''),(2143,'2014-11-03 10:12:47',1,20,'9','Clothing > Men\'s Clothing > Sweathirts',3,''),(2144,'2014-11-03 10:12:47',1,20,'7','Clothing > Men\'s Clothing > Swimwear',3,''),(2145,'2014-11-03 10:12:47',1,20,'10','Clothing > Women\'s Clothing',3,''),(2146,'2014-11-03 10:12:47',1,20,'59','Clothing > Women\'s Clothing > Accessories',3,''),(2147,'2014-11-03 10:12:47',1,20,'16','Clothing > Women\'s Clothing > Base Layer',3,''),(2148,'2014-11-03 10:12:47',1,20,'18','Clothing > Women\'s Clothing > Dresses & Skirts',3,''),(2149,'2014-11-03 10:12:47',1,20,'14','Clothing > Women\'s Clothing > Jackets & Coats',3,''),(2150,'2014-11-03 10:12:47',1,20,'13','Clothing > Women\'s Clothing > Pants',3,''),(2151,'2014-11-03 10:12:47',1,20,'11','Clothing > Women\'s Clothing > Shirts & Tops',3,''),(2152,'2014-11-03 10:12:47',1,20,'61','Clothing > Women\'s Clothing > Shirts & Tops > Longshirt',3,''),(2153,'2014-11-03 10:12:47',1,20,'60','Clothing > Women\'s Clothing > Shirts & Tops > T-Shirt',3,''),(2154,'2014-11-03 10:12:47',1,20,'62','Clothing > Women\'s Clothing > Shirts & Tops > Tanktop',3,''),(2155,'2014-11-03 10:12:47',1,20,'12','Clothing > Women\'s Clothing > Shorts',3,''),(2156,'2014-11-03 10:12:47',1,20,'17','Clothing > Women\'s Clothing > Sweathirts',3,''),(2157,'2014-11-03 10:12:47',1,20,'15','Clothing > Women\'s Clothing > Swimsuits',3,''),(2158,'2014-11-03 10:12:47',1,20,'28','Shoes',3,''),(2159,'2014-11-03 10:12:47',1,20,'39','Shoes > Kid\'s Footwear',3,''),(2160,'2014-11-03 10:12:47',1,20,'41','Shoes > Kid\'s Footwear > Kid\'s Boots',3,''),(2161,'2014-11-03 10:12:47',1,20,'40','Shoes > Kid\'s Footwear > Kid\'s Shoes',3,''),(2162,'2014-11-03 10:12:47',1,20,'42','Shoes > Kid\'s Footwear > Kid\'s Socks',3,''),(2163,'2014-11-03 10:12:47',1,20,'29','Shoes > Men\'s Footwear',3,''),(2164,'2014-11-03 10:12:47',1,20,'32','Shoes > Men\'s Footwear > Boots',3,''),(2165,'2014-11-03 10:12:47',1,20,'30','Shoes > Men\'s Footwear > Sandals',3,''),(2166,'2014-11-03 10:12:47',1,20,'31','Shoes > Men\'s Footwear > Shoes',3,''),(2167,'2014-11-03 10:12:47',1,20,'33','Shoes > Men\'s Footwear > Socks',3,''),(2168,'2014-11-03 10:12:47',1,20,'34','Shoes > Women\'s Footwear',3,''),(2169,'2014-11-03 10:12:47',1,20,'37','Shoes > Women\'s Footwear > Boots',3,''),(2170,'2014-11-03 10:12:47',1,20,'35','Shoes > Women\'s Footwear > Sandals',3,''),(2171,'2014-11-03 10:12:47',1,20,'36','Shoes > Women\'s Footwear > Shoes',3,''),(2172,'2014-11-03 10:12:47',1,20,'38','Shoes > Women\'s Footwear > Socks',3,''),(2173,'2014-11-03 10:12:47',1,20,'43','Sports & Outdoors',3,''),(2174,'2014-11-03 10:12:47',1,20,'44','Sports & Outdoors > Outdoor Gear',3,''),(2175,'2014-11-03 10:12:47',1,20,'48','Sports & Outdoors > Outdoor Gear > Binoculars & Camera',3,''),(2176,'2014-11-03 10:12:47',1,20,'45','Sports & Outdoors > Outdoor Gear > Camping & Hiking',3,''),(2177,'2014-11-03 10:12:47',1,20,'47','Sports & Outdoors > Outdoor Gear > Climbing Gear',3,''),(2178,'2014-11-03 10:12:47',1,20,'46','Sports & Outdoors > Outdoor Gear > Hunting',3,''),(2179,'2014-11-03 10:12:47',1,20,'49','Sports & Outdoors > Sporting Goods',3,''),(2180,'2014-11-03 10:12:47',1,20,'51','Sports & Outdoors > Sporting Goods > Golf',3,''),(2181,'2014-11-03 10:12:47',1,20,'50','Sports & Outdoors > Sporting Goods > Running & Fitness',3,''),(2182,'2014-11-03 10:12:47',1,20,'52','Sports & Outdoors > Sporting Goods > Ski',3,''),(2183,'2014-11-03 10:12:47',1,20,'54','Sports & Outdoors > Sporting Goods > Tennis',3,''),(2184,'2014-11-03 10:12:47',1,20,'53','Sports & Outdoors > Sporting Goods > Water Sports',3,'');
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
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'flat page','flatpages','flatpage'),(9,'migration history','south','migrationhistory'),(10,'kv store','thumbnail','kvstore'),(11,'Email','customer','email'),(12,'Communication event type','customer','communicationeventtype'),(13,'notification','customer','notification'),(14,'product alert','customer','productalert'),(15,'Product Recommendation','catalogue','productrecommendation'),(16,'product brand','catalogue','productbrand'),(17,'product activity','catalogue','productactivity'),(18,'Product','catalogue','product'),(19,'Product Class','catalogue','productclass'),(20,'Category','catalogue','category'),(21,'Product Category','catalogue','productcategory'),(22,'Product Attribute','catalogue','productattribute'),(23,'Product Attribute Value','catalogue','productattributevalue'),(24,'Attribute Option Group','catalogue','attributeoptiongroup'),(25,'Attribute Option','catalogue','attributeoption'),(26,'Attribute Entity','catalogue','attributeentity'),(27,'Attribute Entity Type','catalogue','attributeentitytype'),(28,'Option','catalogue','option'),(29,'Product Image','catalogue','productimage'),(30,'Product record','analytics','productrecord'),(31,'User record','analytics','userrecord'),(32,'User product view','analytics','userproductview'),(33,'User search query','analytics','usersearch'),(34,'User address','address','useraddress'),(35,'Country','address','country'),(36,'Order and Item Charge','shipping','orderanditemcharges'),(37,'Weight-based Shipping Method','shipping','weightbased'),(38,'Weight Band','shipping','weightband'),(39,'Product review','reviews','productreview'),(40,'Vote','reviews','vote'),(41,'Fulfillment partner','partner','partner'),(42,'Partner address','partner','partneraddress'),(43,'Stock record','partner','stockrecord'),(44,'Stock Alert','partner','stockalert'),(45,'Payment Event Quantity','order','paymenteventquantity'),(46,'Shipping Event Quantity','order','shippingeventquantity'),(47,'Order','order','order'),(48,'Order Note','order','ordernote'),(49,'Communication Event','order','communicationevent'),(50,'Shipping address','order','shippingaddress'),(51,'Billing address','order','billingaddress'),(52,'Order Line','order','line'),(53,'Line Price','order','lineprice'),(54,'Line Attribute','order','lineattribute'),(55,'Shipping Event','order','shippingevent'),(56,'Shipping Event Type','order','shippingeventtype'),(57,'Payment Event','order','paymentevent'),(58,'Payment Event Type','order','paymenteventtype'),(59,'Order Discount','order','orderdiscount'),(60,'Conditional offer','offer','conditionaloffer'),(61,'Condition','offer','condition'),(62,'Benefit','offer','benefit'),(63,'Range','offer','range'),(64,'range product','offer','rangeproduct'),(65,'Fixed price shipping benefit','offer','shippingfixedpricebenefit'),(66,'Coverage Condition','offer','coveragecondition'),(67,'Count Condition','offer','countcondition'),(68,'Value Condition','offer','valuecondition'),(69,'Multibuy discount benefit','offer','multibuydiscountbenefit'),(70,'Shipping percentage discount benefit','offer','shippingpercentagediscountbenefit'),(71,'Absolute discount benefit','offer','absolutediscountbenefit'),(72,'shipping benefit','offer','shippingbenefit'),(73,'Shipping absolute discount benefit','offer','shippingabsolutediscountbenefit'),(74,'Percentage discount benefit','offer','percentagediscountbenefit'),(75,'Fixed price benefit','offer','fixedpricebenefit'),(76,'Voucher','voucher','voucher'),(77,'Voucher Application','voucher','voucherapplication'),(78,'Basket','basket','basket'),(79,'Basket line','basket','line'),(80,'Line attribute','basket','lineattribute'),(81,'Transaction','payment','transaction'),(82,'Source','payment','source'),(83,'Source Type','payment','sourcetype'),(84,'Bankcard','payment','bankcard'),(85,'Page Promotion','promotions','pagepromotion'),(86,'Keyword Promotion','promotions','keywordpromotion'),(87,'Raw HTML','promotions','rawhtml'),(88,'Image','promotions','image'),(89,'Multi Image','promotions','multiimage'),(90,'Single Product','promotions','singleproduct'),(91,'Hand Picked Product List','promotions','handpickedproductlist'),(92,'Ordered Product','promotions','orderedproduct'),(93,'Automatic Product List','promotions','automaticproductlist'),(94,'Ordered Product List','promotions','orderedproductlist'),(95,'Tabbed Block','promotions','tabbedblock'),(96,'Wish List','wishlists','wishlist'),(97,'Wish list line','wishlists','line'),(98,'Range Product Uploaded File','ranges','rangeproductfileupload');
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
  KEY `django_flatpage_c379dc61` (`url`)
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
  KEY `django_flatpage_sites_872c4601` (`flatpage_id`),
  KEY `django_flatpage_sites_99732b5c` (`site_id`),
  CONSTRAINT `flatpage_id_refs_id_83cd0023` FOREIGN KEY (`flatpage_id`) REFERENCES `django_flatpage` (`id`),
  CONSTRAINT `site_id_refs_id_2df951cb` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
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
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3a0i3lb7nmdp1gfejxj5ecot5hgfkcin','MGEyMDM2NWI2N2VkMjA4MWY4YWI1MDM1NWZiMzM3NzVhNWIxY2E0Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6Im9zY2FyLmFwcHMuY3VzdG9tZXIuYXV0aF9iYWNrZW5kcy5FbWFpbGJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoxfQ==','2014-11-12 22:16:13'),('gg995esqfhp73f06xdmjviqj5smje9d5','MGEyMDM2NWI2N2VkMjA4MWY4YWI1MDM1NWZiMzM3NzVhNWIxY2E0Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6Im9zY2FyLmFwcHMuY3VzdG9tZXIuYXV0aF9iYWNrZW5kcy5FbWFpbGJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoxfQ==','2014-11-12 18:26:31'),('ls53wkg0p8m3zlbsujtlm9493vjw9t4u','MGEyMDM2NWI2N2VkMjA4MWY4YWI1MDM1NWZiMzM3NzVhNWIxY2E0Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6Im9zY2FyLmFwcHMuY3VzdG9tZXIuYXV0aF9iYWNrZW5kcy5FbWFpbGJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoxfQ==','2014-11-12 01:53:41'),('ucajnjss0dbrd9a49wrdoobp2f4xq1up','MGEyMDM2NWI2N2VkMjA4MWY4YWI1MDM1NWZiMzM3NzVhNWIxY2E0Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6Im9zY2FyLmFwcHMuY3VzdG9tZXIuYXV0aF9iYWNrZW5kcy5FbWFpbGJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoxfQ==','2014-11-16 15:03:42');
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
  `range_id` int(11) DEFAULT NULL,
  `type` varchar(128) NOT NULL,
  `value` decimal(12,2) DEFAULT NULL,
  `max_affected_items` int(10) unsigned DEFAULT NULL,
  `proxy_class` varchar(255),
  PRIMARY KEY (`id`),
  UNIQUE KEY `proxy_class` (`proxy_class`),
  KEY `offer_benefit_f352812e` (`range_id`),
  CONSTRAINT `range_id_refs_id_f2d72a7b` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
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
  `range_id` int(11),
  `type` varchar(128) NOT NULL,
  `value` decimal(12,2),
  `proxy_class` varchar(255),
  PRIMARY KEY (`id`),
  UNIQUE KEY `proxy_class` (`proxy_class`),
  KEY `offer_condition_f352812e` (`range_id`),
  CONSTRAINT `range_id_refs_id_b29dd3dd` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
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
  `description` longtext NOT NULL,
  `offer_type` varchar(128) NOT NULL,
  `condition_id` int(11) NOT NULL,
  `benefit_id` int(11) NOT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `total_discount` decimal(12,2) NOT NULL,
  `date_created` datetime NOT NULL,
  `redirect_url` varchar(200) NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `slug` varchar(128) NOT NULL,
  `max_basket_applications` int(10) unsigned DEFAULT NULL,
  `max_global_applications` int(10) unsigned,
  `num_applications` int(10) unsigned NOT NULL,
  `max_user_applications` int(10) unsigned,
  `max_discount` decimal(12,2),
  `status` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offer_conditionaloffer_name_3c29ac426cd12ce3_uniq` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `offer_conditionaloffer_65c4fb1e` (`condition_id`),
  KEY `offer_conditionaloffer_0bd1fbee` (`benefit_id`),
  CONSTRAINT `benefit_id_refs_id_ceef232a` FOREIGN KEY (`benefit_id`) REFERENCES `offer_benefit` (`id`),
  CONSTRAINT `condition_id_refs_id_add008f5` FOREIGN KEY (`condition_id`) REFERENCES `offer_condition` (`id`)
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
  `includes_all_products` tinyint(1) NOT NULL,
  `date_created` datetime NOT NULL,
  `proxy_class` varchar(255),
  `slug` varchar(128),
  `is_public` tinyint(1) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `offer_range_proxy_class_7b62e7b2541da6a2_uniq` (`proxy_class`),
  UNIQUE KEY `slug` (`slug`)
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
  UNIQUE KEY `offer_range_classes_range_id_bdcb6b196150337_uniq` (`range_id`,`productclass_id`),
  KEY `offer_range_classes_f352812e` (`range_id`),
  KEY `offer_range_classes_791d7bd9` (`productclass_id`),
  CONSTRAINT `productclass_id_refs_id_e86345b2` FOREIGN KEY (`productclass_id`) REFERENCES `catalogue_productclass` (`id`),
  CONSTRAINT `range_id_refs_id_9d92569c` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
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
  UNIQUE KEY `offer_range_excluded_products_range_id_517164c1e1e8929f_uniq` (`range_id`,`product_id`),
  KEY `offer_range_excluded_products_f352812e` (`range_id`),
  KEY `offer_range_excluded_products_7f1b40ad` (`product_id`),
  CONSTRAINT `product_id_refs_id_91aa8b72` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `range_id_refs_id_10d89d0e` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
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
  UNIQUE KEY `offer_range_included_categories_range_id_1e886d89e69b6665_uniq` (`range_id`,`category_id`),
  KEY `offer_range_included_categories_f352812e` (`range_id`),
  KEY `offer_range_included_categories_6f33f001` (`category_id`),
  CONSTRAINT `category_id_refs_id_2a0f26e3` FOREIGN KEY (`category_id`) REFERENCES `catalogue_category` (`id`),
  CONSTRAINT `range_id_refs_id_134d028b` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
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
  `range_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `display_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offer_range_included_products_range_id_5653de41c69b5815_uniq` (`range_id`,`product_id`),
  KEY `offer_range_included_products_f352812e` (`range_id`),
  KEY `offer_range_included_products_7f1b40ad` (`product_id`),
  CONSTRAINT `product_id_refs_id_e167190e` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `range_id_refs_id_1034ad34` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`)
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
  `country_id` varchar(2) NOT NULL,
  `search_text` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_billingaddress_d860be3c` (`country_id`),
  CONSTRAINT `country_id_refs_iso_3166_1_a2_09851b6f` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
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
  `order_id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_communicationevent_68d25c7a` (`order_id`),
  KEY `order_communicationevent_3120f0b2` (`event_type_id`),
  CONSTRAINT `event_type_id_refs_id_ac6e0330` FOREIGN KEY (`event_type_id`) REFERENCES `customer_communicationeventtype` (`id`),
  CONSTRAINT `order_id_refs_id_61d12ee4` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`)
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
  `order_id` int(11) NOT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `partner_name` varchar(128) NOT NULL,
  `partner_sku` varchar(128) NOT NULL,
  `title` varchar(255) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `line_price_incl_tax` decimal(12,2) NOT NULL,
  `line_price_excl_tax` decimal(12,2) NOT NULL,
  `line_price_before_discounts_incl_tax` decimal(12,2) NOT NULL,
  `line_price_before_discounts_excl_tax` decimal(12,2) NOT NULL,
  `unit_cost_price` decimal(12,2) DEFAULT NULL,
  `unit_price_incl_tax` decimal(12,2) DEFAULT NULL,
  `unit_price_excl_tax` decimal(12,2) DEFAULT NULL,
  `unit_retail_price` decimal(12,2) DEFAULT NULL,
  `partner_line_reference` varchar(128) NOT NULL,
  `partner_line_notes` longtext NOT NULL,
  `status` varchar(255) NOT NULL,
  `est_dispatch_date` date DEFAULT NULL,
  `upc` varchar(128),
  `stockrecord_id` int(11),
  PRIMARY KEY (`id`),
  KEY `order_line_68d25c7a` (`order_id`),
  KEY `order_line_42b53b76` (`partner_id`),
  KEY `order_line_7f1b40ad` (`product_id`),
  KEY `order_line_e4e4faf8` (`stockrecord_id`),
  CONSTRAINT `order_id_refs_id_7cf8e7a8` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `partner_id_refs_id_2c67d9e2` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`),
  CONSTRAINT `product_id_refs_id_348f4827` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `stockrecord_id_refs_id_7fffcad1` FOREIGN KEY (`stockrecord_id`) REFERENCES `partner_stockrecord` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_line`
--

LOCK TABLES `order_line` WRITE;
/*!40000 ALTER TABLE `order_line` DISABLE KEYS */;
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
  `line_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `type` varchar(128) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_lineattribute_dc784296` (`line_id`),
  KEY `order_lineattribute_9c74a4f3` (`option_id`),
  CONSTRAINT `line_id_refs_id_9351d677` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `option_id_refs_id_5bd0ce5e` FOREIGN KEY (`option_id`) REFERENCES `catalogue_option` (`id`)
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
  `order_id` int(11) NOT NULL,
  `line_id` int(11) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `price_incl_tax` decimal(12,2) NOT NULL,
  `price_excl_tax` decimal(12,2) NOT NULL,
  `shipping_incl_tax` decimal(12,2) NOT NULL,
  `shipping_excl_tax` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_lineprice_68d25c7a` (`order_id`),
  KEY `order_lineprice_dc784296` (`line_id`),
  CONSTRAINT `line_id_refs_id_0a00c490` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `order_id_refs_id_bf9eea40` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_lineprice`
--

LOCK TABLES `order_lineprice` WRITE;
/*!40000 ALTER TABLE `order_lineprice` DISABLE KEYS */;
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
  `site_id` int(11),
  `user_id` int(11),
  `billing_address_id` int(11),
  `total_incl_tax` decimal(12,2) NOT NULL,
  `total_excl_tax` decimal(12,2) NOT NULL,
  `shipping_incl_tax` decimal(12,2) NOT NULL,
  `shipping_excl_tax` decimal(12,2) NOT NULL,
  `shipping_address_id` int(11),
  `shipping_method` varchar(128) NOT NULL,
  `status` varchar(100) NOT NULL,
  `date_placed` datetime NOT NULL,
  `guest_email` varchar(75) NOT NULL,
  `currency` varchar(12) NOT NULL,
  `shipping_code` varchar(128) NOT NULL,
  `basket_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_order_d4e7917a` (`number`),
  KEY `order_order_99732b5c` (`site_id`),
  KEY `order_order_6340c63c` (`user_id`),
  KEY `order_order_6bc022d9` (`billing_address_id`),
  KEY `order_order_9d06984a` (`shipping_address_id`),
  KEY `order_order_b8718875` (`date_placed`),
  KEY `order_order_eb2f6cfd` (`basket_id`),
  CONSTRAINT `billing_address_id_refs_id_eaceddb1` FOREIGN KEY (`billing_address_id`) REFERENCES `order_billingaddress` (`id`),
  CONSTRAINT `shipping_address_id_refs_id_bafff5c5` FOREIGN KEY (`shipping_address_id`) REFERENCES `order_shippingaddress` (`id`),
  CONSTRAINT `site_id_refs_id_5cb82ab8` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `user_id_refs_id_1c12d2d3` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_order`
--

LOCK TABLES `order_order` WRITE;
/*!40000 ALTER TABLE `order_order` DISABLE KEYS */;
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
  `order_id` int(11) NOT NULL,
  `offer_id` int(10) unsigned DEFAULT NULL,
  `voucher_id` int(10) unsigned DEFAULT NULL,
  `voucher_code` varchar(128) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `offer_name` varchar(128) NOT NULL,
  `frequency` int(10) unsigned,
  `category` varchar(64) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_orderdiscount_68d25c7a` (`order_id`),
  KEY `order_orderdiscount_c512db6a` (`voucher_code`),
  KEY `order_orderdiscount_e81052d9` (`offer_name`),
  CONSTRAINT `order_id_refs_id_eb6490ac` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`)
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
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `note_type` varchar(128) NOT NULL,
  `message` longtext NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_ordernote_68d25c7a` (`order_id`),
  KEY `order_ordernote_6340c63c` (`user_id`),
  CONSTRAINT `order_id_refs_id_ba34b637` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `user_id_refs_id_805fa316` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  `order_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `reference` varchar(128) NOT NULL,
  `shipping_event_id` int(11),
  PRIMARY KEY (`id`),
  KEY `order_paymentevent_68d25c7a` (`order_id`),
  KEY `order_paymentevent_3120f0b2` (`event_type_id`),
  KEY `order_paymentevent_6f3c67bb` (`shipping_event_id`),
  CONSTRAINT `event_type_id_refs_id_f58bfdbc` FOREIGN KEY (`event_type_id`) REFERENCES `order_paymenteventtype` (`id`),
  CONSTRAINT `order_id_refs_id_1dd7333e` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `shipping_event_id_refs_id_9935d141` FOREIGN KEY (`shipping_event_id`) REFERENCES `order_shippingevent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_paymentevent`
--

LOCK TABLES `order_paymentevent` WRITE;
/*!40000 ALTER TABLE `order_paymentevent` DISABLE KEYS */;
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
  `event_id` int(11) NOT NULL,
  `line_id` int(11) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_paymenteventquantity_a41e20fe` (`event_id`),
  KEY `order_paymenteventquantity_dc784296` (`line_id`),
  CONSTRAINT `event_id_refs_id_551749e0` FOREIGN KEY (`event_id`) REFERENCES `order_paymentevent` (`id`),
  CONSTRAINT `line_id_refs_id_acc73059` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_paymenteventquantity`
--

LOCK TABLES `order_paymenteventquantity` WRITE;
/*!40000 ALTER TABLE `order_paymenteventquantity` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_paymenteventtype`
--

LOCK TABLES `order_paymenteventtype` WRITE;
/*!40000 ALTER TABLE `order_paymenteventtype` DISABLE KEYS */;
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
  `country_id` varchar(2) NOT NULL,
  `search_text` varchar(1000) NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `notes` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_shippingaddress_d860be3c` (`country_id`),
  CONSTRAINT `country_id_refs_iso_3166_1_a2_d987c6b2` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_shippingaddress`
--

LOCK TABLES `order_shippingaddress` WRITE;
/*!40000 ALTER TABLE `order_shippingaddress` DISABLE KEYS */;
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
  `order_id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `notes` longtext NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_shippingevent_68d25c7a` (`order_id`),
  KEY `order_shippingevent_3120f0b2` (`event_type_id`),
  CONSTRAINT `event_type_id_refs_id_7610d2c2` FOREIGN KEY (`event_type_id`) REFERENCES `order_shippingeventtype` (`id`),
  CONSTRAINT `order_id_refs_id_c1ea2109` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`)
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
  `event_id` int(11) NOT NULL,
  `line_id` int(11) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_shippingeventquantity_a41e20fe` (`event_id`),
  KEY `order_shippingeventquantity_dc784296` (`line_id`),
  CONSTRAINT `event_id_refs_id_617e3002` FOREIGN KEY (`event_id`) REFERENCES `order_shippingevent` (`id`),
  CONSTRAINT `line_id_refs_id_a19cc7bf` FOREIGN KEY (`line_id`) REFERENCES `order_line` (`id`)
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
  `name` varchar(128) NOT NULL,
  `code` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partner_partner_code_6d336eee39c91508_uniq` (`code`),
  KEY `partner_partner_09bb5fb3` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_partner`
--

LOCK TABLES `partner_partner` WRITE;
/*!40000 ALTER TABLE `partner_partner` DISABLE KEYS */;
INSERT INTO `partner_partner` VALUES (1,'Reno Warehouse','reno-warehouse');
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
  UNIQUE KEY `partner_partner_users_partner_id_bd29f702075850b_uniq` (`partner_id`,`user_id`),
  KEY `partner_partner_users_42b53b76` (`partner_id`),
  KEY `partner_partner_users_6340c63c` (`user_id`),
  CONSTRAINT `partner_id_refs_id_30a5b550` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`),
  CONSTRAINT `user_id_refs_id_09ff534c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  `country_id` varchar(2) NOT NULL,
  `search_text` varchar(1000) NOT NULL,
  `partner_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_partneraddress_d860be3c` (`country_id`),
  KEY `partner_partneraddress_42b53b76` (`partner_id`),
  CONSTRAINT `country_id_refs_iso_3166_1_a2_35298bfb` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`),
  CONSTRAINT `partner_id_refs_id_2f090d7e` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`)
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
  `stockrecord_id` int(11) NOT NULL,
  `threshold` int(10) unsigned NOT NULL,
  `status` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_closed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_abstractstockalert_e4e4faf8` (`stockrecord_id`),
  CONSTRAINT `stockrecord_id_refs_id_8944c281` FOREIGN KEY (`stockrecord_id`) REFERENCES `partner_stockrecord` (`id`)
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
  `product_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `partner_sku` varchar(128) NOT NULL,
  `price_currency` varchar(12) NOT NULL,
  `price_excl_tax` decimal(12,2) DEFAULT NULL,
  `price_retail` decimal(12,2) DEFAULT NULL,
  `cost_price` decimal(12,2) DEFAULT NULL,
  `num_in_stock` int(10) unsigned,
  `num_allocated` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `low_stock_threshold` int(10) unsigned,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partner_stockrecord_partner_id_4faf51cd0ce15682_uniq` (`partner_id`,`partner_sku`),
  KEY `partner_stockrecord_42b53b76` (`partner_id`),
  KEY `partner_stockrecord_68d861dd` (`date_updated`),
  KEY `product_id_refs_id_cacb631d` (`product_id`),
  CONSTRAINT `partner_id_refs_id_b2723ddb` FOREIGN KEY (`partner_id`) REFERENCES `partner_partner` (`id`),
  CONSTRAINT `product_id_refs_id_cacb631d` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1176 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_stockrecord`
--

LOCK TABLES `partner_stockrecord` WRITE;
/*!40000 ALTER TABLE `partner_stockrecord` DISABLE KEYS */;
INSERT INTO `partner_stockrecord` VALUES (991,1348,1,'20-1008-7-1-0002','USD',38.94,38.94,12.94,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(992,1349,1,'20-1008-7-2-0002','USD',38.94,38.94,12.94,0,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(993,1350,1,'20-1008-7-3-0002','USD',38.94,38.94,12.94,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(994,1352,1,'20-1008-8-1-0002','USD',38.94,38.94,12.94,0,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(995,1353,1,'20-1008-8-2-0002','USD',38.94,38.94,12.94,0,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(996,1354,1,'20-1008-8-3-0002','USD',38.94,38.94,12.94,0,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(997,1356,1,'39-6023-0-1-0002','USD',19.44,19.44,5.92,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(998,1357,1,'39-6023-0-2-0002','USD',19.44,19.44,5.92,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(999,1358,1,'39-6023-0-4-0002','USD',19.44,19.44,5.92,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(1000,1359,1,'39-6023-0-5-0002','USD',19.44,19.44,5.92,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(1001,1361,1,'12-1800-7-2-0002','USD',51.94,51.94,16.84,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(1002,1362,1,'12-1800-7-3-0002','USD',51.94,51.94,16.84,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(1003,1364,1,'13-1802-7-2-0002','USD',45.44,45.44,14.24,1,NULL,'2014-11-03 10:16:00','2014-11-03 10:16:00',NULL),(1004,1365,1,'13-1802-7-3-0002','USD',45.44,45.44,14.24,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1005,1367,1,'12-1800-8-3-0002','USD',51.94,51.94,16.84,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1006,1369,1,'13-1072-7-1-0229','USD',51.94,51.94,16.51,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1007,1370,1,'13-1072-7-2-0229','USD',51.94,51.94,16.51,2,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1008,1371,1,'13-1072-7-3-0229','USD',51.94,51.94,16.51,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1009,1373,1,'14-1073-7-1-0227','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1010,1374,1,'14-1073-7-2-0227','USD',45.44,45.44,12.70,2,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1011,1375,1,'14-1073-7-3-0227','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1012,1377,1,'12-1079-7-2-0227','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1013,1378,1,'12-1079-7-3-0227','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1014,1380,1,'15-1070-7-2-0227','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1015,1381,1,'15-1070-7-3-0227','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1016,1383,1,'19-1076-8-1-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1017,1384,1,'19-1076-8-2-0002','USD',38.94,38.94,10.88,2,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1018,1385,1,'19-1076-8-3-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1019,1387,1,'15-1070-8-2-0017','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1020,1388,1,'15-1070-8-3-0017','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:01','2014-11-03 10:16:01',NULL),(1021,1390,1,'12-1079-8-2-0017','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1022,1391,1,'12-1079-8-3-0017','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1023,1393,1,'15-1060-7-1-0002','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1024,1394,1,'15-1060-7-2-0002','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1025,1395,1,'15-1060-7-3-0002','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1026,1396,1,'15-1060-7-4-0002','USD',51.94,51.94,14.98,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1027,1398,1,'13-1061-7-1-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1028,1399,1,'13-1061-7-2-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1029,1400,1,'13-1061-7-3-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1030,1401,1,'13-1061-7-4-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1031,1403,1,'12-1059-8-1-0002','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1032,1404,1,'12-1059-8-2-0002','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1033,1405,1,'12-1059-8-3-0002','USD',45.44,45.44,12.70,2,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1034,1407,1,'14-1053-8-1-0002','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1035,1408,1,'14-1053-8-2-0002','USD',45.44,45.44,12.70,2,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1036,1409,1,'14-1053-8-3-0002','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1037,1411,1,'16-1054-8-1-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1038,1412,1,'16-1054-8-2-0002','USD',38.94,38.94,10.88,2,NULL,'2014-11-03 10:16:02','2014-11-03 10:16:02',NULL),(1039,1413,1,'16-1054-8-3-0002','USD',38.94,38.94,10.88,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1040,1415,1,'11-1056-8-1-0002','USD',23.34,23.34,6.83,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1041,1416,1,'11-1056-8-2-0002','USD',23.34,23.34,6.83,2,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1042,1417,1,'11-1056-8-3-0002','USD',23.34,23.34,6.83,2,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1043,1419,1,'12-1000-9-1-0002','USD',12.94,12.94,4.29,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1044,1420,1,'12-1000-9-2-0002','USD',12.94,12.94,4.29,2,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1045,1421,1,'12-1000-9-3-0002','USD',12.94,12.94,4.29,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1046,1423,1,'11-1007-9-1-0002','USD',6.44,6.44,1.81,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1047,1424,1,'11-1007-9-2-0002','USD',6.44,6.44,1.81,2,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1048,1425,1,'11-1007-9-3-0002','USD',6.44,6.44,1.81,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1049,1427,1,'12-1250-8-2-0002','USD',51.94,51.94,16.34,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1050,1428,1,'12-1250-8-3-0002','USD',51.94,51.94,16.34,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1051,1430,1,'15-1251-8-2-0002','USD',64.94,64.94,18.16,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1052,1431,1,'15-1251-8-3-0002','USD',64.94,64.94,18.16,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1053,1433,1,'14-1253-8-1-0002','USD',51.94,51.94,14.52,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1054,1434,1,'14-1253-8-2-0002','USD',51.94,51.94,14.52,2,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1055,1435,1,'14-1253-8-3-0002','USD',51.94,51.94,14.52,1,NULL,'2014-11-03 10:16:03','2014-11-03 10:16:03',NULL),(1056,1437,1,'12-1417-8-2-0002','USD',77.94,77.94,24.25,0,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1057,1439,1,'15-2201-7-1-0002','USD',116.94,116.94,34.45,0,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1058,1440,1,'15-2201-7-2-0002','USD',116.94,116.94,34.45,0,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1059,1441,1,'15-2201-7-3-0002','USD',116.94,116.94,34.45,0,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1060,1443,1,'14-2202-8-1-0002','USD',84.44,84.44,25.70,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1061,1444,1,'14-2202-8-2-0002','USD',84.44,84.44,25.70,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1062,1445,1,'14-2202-8-3-0002','USD',84.44,84.44,25.70,2,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1063,1447,1,'28-4810-0-2-0001','USD',10.34,10.34,3.91,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1064,1448,1,'28-4810-0-4-0001','USD',10.34,10.34,3.91,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1065,1450,1,'23-4622-0-1-0193','USD',18.14,18.14,5.36,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1066,1451,1,'23-4622-0-2-0193','USD',18.14,18.14,5.36,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1067,1452,1,'23-4622-0-3-0198','USD',18.14,18.14,5.36,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1068,1453,1,'23-4622-0-4-0198','USD',18.14,18.14,5.36,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1069,1455,1,'21-4010-7-1-0184','USD',12.94,12.94,3.60,2,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1070,1456,1,'21-4010-7-2-0184','USD',12.94,12.94,3.60,2,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1071,1458,1,'21-4012-8-2-0184','USD',18.14,18.14,5.10,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1072,1459,1,'21-4012-8-3-0184','USD',18.14,18.14,5.10,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1073,1460,1,'21-4012-8-4-0184','USD',18.14,18.14,5.10,1,NULL,'2014-11-03 10:16:04','2014-11-03 10:16:04',NULL),(1074,1462,1,'21-4020-7-1-0233','USD',15.54,15.54,4.33,0,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1075,1463,1,'21-4020-7-2-0233','USD',15.54,15.54,4.33,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1076,1465,1,'21-4020-8-2-0232','USD',15.54,15.54,4.33,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1077,1466,1,'21-4020-8-3-0232','USD',15.54,15.54,4.33,0,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1078,1468,1,'12-2110-7-3-0002','USD',51.94,51.94,15.43,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1079,1469,1,'12-2110-7-2-0002','USD',51.94,51.94,15.43,2,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1080,1470,1,'12-2110-7-1-0002','USD',51.94,51.94,15.43,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1081,1472,1,'13-2112-8-2-0002','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1082,1473,1,'13-2112-8-3-0002','USD',45.44,45.44,12.70,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1083,1475,1,'11-2111-7-3-0002','USD',25.94,25.94,7.70,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1084,1477,1,'12-2110-8-3-0002','USD',51.94,51.94,15.43,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1085,1479,1,'27-4711-7-2-0202','USD',25.94,25.94,8.45,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1086,1481,1,'27-4711-8-4-0202','USD',25.94,25.94,8.45,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1087,1483,1,'27-4724-0-2-0071','USD',12.94,12.94,4.29,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1088,1484,1,'27-4724-0-3-0071','USD',12.94,12.94,4.29,1,NULL,'2014-11-03 10:16:05','2014-11-03 10:16:05',NULL),(1089,1486,1,'HA460-0006','USD',25.94,25.94,10.88,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1090,1487,1,'HA460-0015','USD',25.94,25.94,10.88,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1091,1488,1,'HA460-0018','USD',25.94,25.94,10.88,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1092,1489,1,'HA460-0442','USD',25.94,25.94,10.88,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:08',NULL),(1093,1490,1,'HA460-0443','USD',25.94,25.94,10.88,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1094,1491,1,'HA460-0445','USD',25.94,25.94,10.88,32,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1095,1493,1,'HA620-0XXX','USD',22.04,22.04,6.79,16,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1096,1495,1,'HA110-0285','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1097,1496,1,'HA110-0390','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1098,1498,1,'HA621-0224','USD',22.04,22.04,6.79,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1099,1499,1,'HA110-0477','USD',19.44,19.44,6.33,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1100,1500,1,'HA110-0475','USD',19.44,19.44,6.33,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1101,1501,1,'HA110-0470','USD',19.44,19.44,6.33,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1102,1502,1,'HA110-0472','USD',19.44,19.44,6.33,0,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1103,1503,1,'HA110-0219','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1104,1504,1,'HA110-0220','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1105,1505,1,'HA110-0252','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1106,1507,1,'HA100-0001','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1107,1508,1,'HA100-0004','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:06','2014-11-03 10:16:06',NULL),(1108,1509,1,'HA100-0015','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1109,1510,1,'HA100-0018','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1110,1511,1,'HA110-0415','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1111,1512,1,'HA110-0436','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1112,1513,1,'HA110-0419','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1113,1514,1,'HA110-0425','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1114,1515,1,'HA110-0438','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1115,1516,1,'HA110-0346','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1116,1517,1,'HA110-0349','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1117,1518,1,'HA110-0413','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1118,1519,1,'HA110-0143','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1119,1520,1,'HA110-0133','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1120,1521,1,'HA110-0158','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1121,1522,1,'HA110-0169','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1122,1523,1,'HA110-0154','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1123,1524,1,'HA110-0162','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1124,1525,1,'HA110-0234','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1125,1526,1,'HA110-0155','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1126,1527,1,'HA110-0264','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1127,1528,1,'HA110-0258','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1128,1529,1,'HA110-0242','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1129,1530,1,'HA110-0317','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1130,1531,1,'HA110-0385','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1131,1532,1,'HA110-0387','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:07','2014-11-03 10:16:07',NULL),(1132,1533,1,'HA110-0171','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1133,1534,1,'HA110-0362','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1134,1535,1,'HA110-0388','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1135,1536,1,'HA110-0400','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1136,1537,1,'HA110-0410','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1137,1538,1,'HA110-0406','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1138,1539,1,'HA110-0407','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1139,1540,1,'HA110-0271 ','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1140,1541,1,'HA110-0275','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1141,1542,1,'HA110-0135','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1142,1544,1,'HA450-0002','USD',20.74,20.74,6.57,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1143,1545,1,'HA450-0465','USD',20.74,20.74,6.57,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1144,1546,1,'HA450-0466','USD',20.74,20.74,6.57,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1145,1548,1,'HA651-0002','USD',12.94,12.94,4.23,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1146,1549,1,'HA651-0463','USD',12.94,12.94,4.23,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1147,1550,1,'HA651-0464','USD',12.94,12.94,4.23,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1148,1551,1,'HA460-0002','USD',25.94,25.94,10.88,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1149,1552,1,'HA460-0444','USD',25.94,25.94,10.88,0,NULL,'2014-11-03 10:16:08','2014-11-03 10:16:08',NULL),(1150,1554,1,'HA660-0377','USD',22.04,22.04,8.19,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1151,1555,1,'HA660-0452','USD',22.04,22.04,8.19,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1152,1557,1,'HA640-0122','USD',19.44,19.44,5.42,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1153,1559,1,'HA630-0252','USD',12.94,12.94,4.29,0,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1154,1561,1,'HA610-0002','USD',31.14,31.14,10.88,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1155,1563,1,'HA210-0347','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1156,1564,1,'HA210-0432','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1157,1565,1,'HA210-0416','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1158,1566,1,'HA210-0418','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1159,1567,1,'HA210-0411','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1160,1568,1,'HA210-0405','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1161,1569,1,'HA200-0029','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1162,1570,1,'HA210-0125','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1163,1571,1,'HA210-0147','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1164,1573,1,'HA200-0002','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1165,1574,1,'HA200-0006','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1166,1575,1,'HA200-0020','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1167,1576,1,'HA620-0233','USD',22.04,22.04,6.79,0,NULL,'2014-11-03 10:16:09','2014-11-03 10:16:09',NULL),(1168,1577,1,'HA620-0436','USD',22.04,22.04,6.79,0,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL),(1169,1579,1,'HA410-0489','USD',22.04,22.04,6.79,0,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL),(1170,1580,1,'HA210-0368','USD',31.14,31.14,9.97,8,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL),(1171,1582,1,'HA120-0371','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL),(1172,1583,1,'HA120-0392','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL),(1173,1584,1,'HA120-0202','USD',19.44,19.44,6.33,8,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL),(1174,1585,1,'HA621-0328','USD',22.04,22.04,6.79,0,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL),(1175,1587,1,'HA220-0298','USD',28.54,28.54,9.97,8,NULL,'2014-11-03 10:16:10','2014-11-03 10:16:10',NULL);
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
  `user_id` int(11) NOT NULL,
  `card_type` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(32) NOT NULL,
  `expiry_date` date NOT NULL,
  `partner_reference` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_bankcard_6340c63c` (`user_id`),
  CONSTRAINT `user_id_refs_id_d2b3ce08` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  `order_id` int(11) NOT NULL,
  `source_type_id` int(11) NOT NULL,
  `currency` varchar(12) NOT NULL,
  `amount_allocated` decimal(12,2) NOT NULL,
  `amount_debited` decimal(12,2) NOT NULL,
  `amount_refunded` decimal(12,2) NOT NULL,
  `reference` varchar(128) NOT NULL,
  `label` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_source_68d25c7a` (`order_id`),
  KEY `payment_source_0d33bb08` (`source_type_id`),
  CONSTRAINT `order_id_refs_id_0d2a193c` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `source_type_id_refs_id_0de56b57` FOREIGN KEY (`source_type_id`) REFERENCES `payment_sourcetype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_source`
--

LOCK TABLES `payment_source` WRITE;
/*!40000 ALTER TABLE `payment_source` DISABLE KEYS */;
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
  UNIQUE KEY `payment_sourcetype_code_671cc20b19f39586_uniq` (`code`),
  KEY `payment_sourcetype_09bb5fb3` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_sourcetype`
--

LOCK TABLES `payment_sourcetype` WRITE;
/*!40000 ALTER TABLE `payment_sourcetype` DISABLE KEYS */;
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
  `source_id` int(11) NOT NULL,
  `txn_type` varchar(128) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `reference` varchar(128) NOT NULL,
  `status` varchar(128) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_transaction_a34b03a6` (`source_id`),
  CONSTRAINT `source_id_refs_id_0d561a17` FOREIGN KEY (`source_id`) REFERENCES `payment_source` (`id`)
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
  `content_type_id` int(11) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `position` varchar(100) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `clicks` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `keyword` varchar(200) NOT NULL,
  `filter` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_keywordpromotion_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_33ef7929` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
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
  UNIQUE KEY `promotions_multiimage_image_multiimage_id_69609fd2c3956508_uniq` (`multiimage_id`,`image_id`),
  KEY `promotions_multiimage_images_28dc460e` (`multiimage_id`),
  KEY `promotions_multiimage_images_06df7330` (`image_id`),
  CONSTRAINT `image_id_refs_id_878154ca` FOREIGN KEY (`image_id`) REFERENCES `promotions_image` (`id`),
  CONSTRAINT `multiimage_id_refs_id_de51e414` FOREIGN KEY (`multiimage_id`) REFERENCES `promotions_multiimage` (`id`)
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
  `list_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_orderedproduct_c142dac4` (`list_id`),
  KEY `promotions_orderedproduct_7f1b40ad` (`product_id`),
  CONSTRAINT `list_id_refs_id_2f36089b` FOREIGN KEY (`list_id`) REFERENCES `promotions_handpickedproductlist` (`id`),
  CONSTRAINT `product_id_refs_id_1ef7c218` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
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
  `tabbed_block_id` int(11) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  PRIMARY KEY (`handpickedproductlist_ptr_id`),
  KEY `promotions_orderedproductlist_b67dfdaf` (`tabbed_block_id`),
  CONSTRAINT `handpickedproductlist_ptr_id_refs_id_fa5555e6` FOREIGN KEY (`handpickedproductlist_ptr_id`) REFERENCES `promotions_handpickedproductlist` (`id`),
  CONSTRAINT `tabbed_block_id_refs_id_10d18257` FOREIGN KEY (`tabbed_block_id`) REFERENCES `promotions_tabbedblock` (`id`)
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
  `content_type_id` int(11) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `position` varchar(100) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `clicks` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `page_url` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_pagepromotion_37ef4eb4` (`content_type_id`),
  KEY `promotions_pagepromotion_6046a735` (`page_url`),
  CONSTRAINT `content_type_id_refs_id_9eaf3a32` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
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
  `product_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_singleproduct_7f1b40ad` (`product_id`),
  CONSTRAINT `product_id_refs_id_1f165cab` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`)
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
-- Table structure for table `ranges_rangeproductfileupload`
--

DROP TABLE IF EXISTS `ranges_rangeproductfileupload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ranges_rangeproductfileupload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `range_id` int(11) NOT NULL,
  `filepath` varchar(255) NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `uploaded_by_id` int(11) NOT NULL,
  `date_uploaded` datetime NOT NULL,
  `status` varchar(32) NOT NULL,
  `error_message` varchar(255) NOT NULL,
  `date_processed` datetime DEFAULT NULL,
  `num_new_skus` int(10) unsigned DEFAULT NULL,
  `num_unknown_skus` int(10) unsigned DEFAULT NULL,
  `num_duplicate_skus` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ranges_rangeproductfileupload_f352812e` (`range_id`),
  KEY `ranges_rangeproductfileupload_e49b2481` (`uploaded_by_id`),
  CONSTRAINT `range_id_refs_id_27d10bdf` FOREIGN KEY (`range_id`) REFERENCES `offer_range` (`id`),
  CONSTRAINT `uploaded_by_id_refs_id_9e4537d1` FOREIGN KEY (`uploaded_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranges_rangeproductfileupload`
--

LOCK TABLES `ranges_rangeproductfileupload` WRITE;
/*!40000 ALTER TABLE `ranges_rangeproductfileupload` DISABLE KEYS */;
/*!40000 ALTER TABLE `ranges_rangeproductfileupload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_productreview`
--

DROP TABLE IF EXISTS `reviews_productreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews_productreview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `score` smallint(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(75) NOT NULL,
  `homepage` varchar(200) NOT NULL,
  `status` smallint(6) NOT NULL,
  `total_votes` int(11) NOT NULL,
  `delta_votes` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reviews_productreview_product_id_2dbdd3287f68dc33_uniq` (`product_id`,`user_id`),
  KEY `reviews_productreview_7f1b40ad` (`product_id`),
  KEY `reviews_productreview_6340c63c` (`user_id`),
  KEY `reviews_productreview_0d9e9d06` (`delta_votes`),
  CONSTRAINT `product_id_refs_id_81f67cf5` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `user_id_refs_id_c75d68da` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  `review_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `delta` smallint(6) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reviews_vote_user_id_75acca213178559b_uniq` (`user_id`,`review_id`),
  KEY `reviews_vote_a0363c29` (`review_id`),
  KEY `reviews_vote_6340c63c` (`user_id`),
  CONSTRAINT `review_id_refs_id_ac77cb5c` FOREIGN KEY (`review_id`) REFERENCES `reviews_productreview` (`id`),
  CONSTRAINT `user_id_refs_id_39e86292` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  UNIQUE KEY `shipping_orderanditemcharges_name_13c2642f48875fce_uniq` (`name`),
  KEY `shipping_orderanditemcharges_09bb5fb3` (`code`)
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
  UNIQUE KEY `shipping_orderandi_orderanditemcharges_id_3f857cb2380dca46_uniq` (`orderanditemcharges_id`,`country_id`),
  KEY `shipping_orderanditemcharges_countries_b61e1cea` (`orderanditemcharges_id`),
  KEY `shipping_orderanditemcharges_countries_d860be3c` (`country_id`),
  CONSTRAINT `country_id_refs_iso_3166_1_a2_a01c8bad` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`),
  CONSTRAINT `orderanditemcharges_id_refs_id_47b0171d` FOREIGN KEY (`orderanditemcharges_id`) REFERENCES `shipping_orderanditemcharges` (`id`)
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
  `upper_limit` double NOT NULL,
  `charge` decimal(12,2) NOT NULL,
  `method_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_weightband_357939b5` (`method_id`),
  CONSTRAINT `method_id_refs_id_28f186c2` FOREIGN KEY (`method_id`) REFERENCES `shipping_weightbased` (`id`)
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
  `upper_charge` decimal(12,2) DEFAULT NULL,
  `default_weight` decimal(12,2) NOT NULL,
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
  UNIQUE KEY `shipping_weightbased_count_weightbased_id_2d48b23bd516c826_uniq` (`weightbased_id`,`country_id`),
  KEY `shipping_weightbased_countries_fffb3eeb` (`weightbased_id`),
  KEY `shipping_weightbased_countries_d860be3c` (`country_id`),
  CONSTRAINT `country_id_refs_iso_3166_1_a2_15f8c1fc` FOREIGN KEY (`country_id`) REFERENCES `address_country` (`iso_3166_1_a2`),
  CONSTRAINT `weightbased_id_refs_id_6e278d4d` FOREIGN KEY (`weightbased_id`) REFERENCES `shipping_weightbased` (`id`)
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
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'customer','0001_initial','2014-10-29 01:51:53'),(2,'catalogue','0001_initial','2014-10-29 01:51:56'),(3,'analytics','0001_initial','2014-10-29 01:51:57'),(4,'checkout','0001_initial','2014-10-29 01:51:57'),(5,'address','0001_initial','2014-10-29 01:51:58'),(6,'address','0002_auto__chg_field_useraddress_postcode','2014-10-29 01:51:58'),(7,'address','0003_auto__add_field_country_display_order','2014-10-29 01:51:58'),(8,'address','0004_convert_is_highlighted','2014-10-29 01:51:58'),(9,'address','0005_auto__del_field_country_is_highlighted','2014-10-29 01:51:58'),(10,'address','0006_auto__add_unique_useraddress_hash_user','2014-10-29 01:51:58'),(11,'address','0007_auto__chg_field_useraddress_postcode','2014-10-29 01:51:58'),(12,'address','0008_auto__chg_field_useraddress_phone_number','2014-10-29 01:51:59'),(13,'address','0009_no_null_in_charfields','2014-10-29 01:51:59'),(14,'address','0010_auto__chg_field_useraddress_first_name__chg_field_useraddress_title__c','2014-10-29 01:51:59'),(15,'shipping','0001_initial','2014-10-29 01:51:59'),(16,'shipping','0002_auto__del_orderanditemlevelchargemethod__add_orderanditemcharges__add_','2014-10-29 01:51:59'),(17,'shipping','0003_auto__add_weightbased__chg_field_orderanditemcharges_code__add_unique_','2014-10-29 01:51:59'),(18,'shipping','0004_auto__add_field_weightbased_default_weight','2014-10-29 01:52:00'),(19,'shipping','0005_auto','2014-10-29 01:52:00'),(20,'shipping','0006_auto__chg_field_orderanditemcharges_code__chg_field_weightbased_code','2014-10-29 01:52:00'),(21,'reviews','0001_initial','2014-10-29 01:52:00'),(22,'reviews','0002_no_null_in_charfields','2014-10-29 01:52:00'),(23,'reviews','0003_auto__chg_field_productreview_name__chg_field_productreview_homepage__','2014-10-29 01:52:01'),(24,'partner','0001_initial','2014-10-29 01:52:01'),(25,'partner','0002_auto__add_stockalert__add_abstractstockalert__add_field_stockrecord_lo','2014-10-29 01:52:01'),(26,'partner','0003_auto__add_unique_stockrecord_partner_partner_sku','2014-10-29 01:52:01'),(27,'partner','0004_auto__add_field_partner_code','2014-10-29 01:52:02'),(28,'partner','0005_populate_slugs','2014-10-29 01:52:02'),(29,'partner','0006_auto__add_unique_partner_code','2014-10-29 01:52:02'),(30,'partner','0007_auto__chg_field_partner_name__del_unique_partner_name','2014-10-29 01:52:02'),(31,'partner','0008_auto__del_abstractstockalert__del_field_stockalert_abstractstockalert_','2014-10-29 01:52:02'),(32,'partner','0009_auto__add_partneraddress','2014-10-29 01:52:02'),(33,'partner','0010_auto__chg_field_stockrecord_product__del_unique_stockrecord_product','2014-10-29 01:52:02'),(34,'partner','0011_auto__chg_field_partner_code','2014-10-29 01:52:02'),(35,'partner','0012_no_null_in_charfields','2014-10-29 01:52:02'),(36,'partner','0013_auto__chg_field_partneraddress_first_name__chg_field_partneraddress_ti','2014-10-29 01:52:03'),(37,'order','0001_initial','2014-10-29 01:52:05'),(38,'offer','0001_initial','2014-10-29 01:52:05'),(39,'voucher','0001_initial','2014-10-29 01:52:06'),(40,'basket','0001_initial','2014-10-29 01:52:06'),(41,'basket','0002_auto__add_field_line_price_incl_tax','2014-10-29 01:52:06'),(42,'basket','0003_auto__add_field_line_price_excl_tax','2014-10-29 01:52:06'),(43,'basket','0004_auto__add_field_line_stockrecord','2014-10-29 01:52:07'),(44,'basket','0005_auto__add_field_line_price_currency','2014-10-29 01:52:07'),(45,'payment','0001_initial','2014-10-29 01:52:08'),(46,'payment','0002_auto__chg_field_source_reference__chg_field_source_label__chg_field_tr','2014-10-29 01:52:08'),(47,'payment','0003_auto__chg_field_sourcetype_code__add_unique_sourcetype_code','2014-10-29 01:52:08'),(48,'offer','0002_auto__add_unique_conditionaloffer_name','2014-10-29 01:52:08'),(49,'offer','0003_auto__add_field_conditionaloffer_num_orders','2014-10-29 01:52:08'),(50,'offer','0004_auto__add_field_conditionaloffer_slug','2014-10-29 01:52:09'),(51,'offer','0005_auto__add_field_range_date_created','2014-10-29 01:52:09'),(52,'offer','0006_auto__add_field_conditionaloffer_max_applications','2014-10-29 01:52:09'),(53,'offer','0007_auto__add_field_conditionaloffer_max_global_applications','2014-10-29 01:52:09'),(54,'offer','0008_auto__add_field_conditionaloffer_num_applications','2014-10-29 01:52:09'),(55,'offer','0009_auto__del_field_conditionaloffer_max_applications__add_field_condition','2014-10-29 01:52:09'),(56,'offer','0010_auto__add_field_conditionaloffer_max_user_applications','2014-10-29 01:52:09'),(57,'offer','0011_auto__add_field_range_proxy_class','2014-10-29 01:52:09'),(58,'offer','0012_auto__add_field_condition_proxy_class__chg_field_condition_range__chg_','2014-10-29 01:52:10'),(59,'offer','0013_auto__add_unique_range_proxy_class','2014-10-29 01:52:10'),(60,'offer','0014_consolidate_offer_changes','2014-10-29 01:52:10'),(61,'offer','0015_auto__add_field_conditionaloffer_max_discount','2014-10-29 01:52:10'),(62,'offer','0016_auto__add_field_conditionaloffer_status','2014-10-29 01:52:10'),(63,'offer','0017_auto__chg_field_conditionaloffer_end_date__chg_field_conditionaloffer_','2014-10-29 01:52:10'),(64,'offer','0018_auto__del_field_conditionaloffer_end_date__del_field_conditionaloffer_','2014-10-29 01:52:10'),(65,'offer','0019_auto__del_shippingbenefit__add_field_benefit_proxy_class__chg_field_be','2014-10-29 01:52:10'),(66,'offer','0020_remove_null_descriptions','2014-10-29 01:52:10'),(67,'offer','0021_auto__chg_field_benefit_type__chg_field_conditionaloffer_description','2014-10-29 01:52:10'),(68,'offer','0022_auto__add_field_range_slug','2014-10-29 01:52:11'),(69,'offer','0023_slugify_range_names','2014-10-29 01:52:11'),(70,'offer','0024_auto__add_field_range_is_public','2014-10-29 01:52:11'),(71,'offer','0025_auto__add_field_range_description','2014-10-29 01:52:11'),(72,'offer','0026_auto__add_field_conditionaloffer_applies_to_tax_exclusive_prices','2014-10-29 01:52:11'),(73,'offer','0027_add_rangeproduct','2014-10-29 01:52:11'),(74,'offer','0028_auto__del_field_conditionaloffer_applies_to_tax_exclusive_prices','2014-10-29 01:52:11'),(75,'offer','0029_auto__chg_field_conditionaloffer_slug','2014-10-29 01:52:11'),(76,'offer','0030_no_null_in_charfields','2014-10-29 01:52:11'),(77,'offer','0031_auto__chg_field_condition_type','2014-10-29 01:52:12'),(78,'offer','0032_auto__chg_field_benefit_proxy_class__chg_field_condition_proxy_class__','2014-10-29 01:52:12'),(79,'order','0002_auto__add_field_order_guest_email','2014-10-29 01:52:12'),(80,'order','0003_auto__del_field_ordernote_date__add_field_ordernote_date_created__add_','2014-10-29 01:52:12'),(81,'order','0004_auto__add_field_line_upc','2014-10-29 01:52:12'),(82,'order','0005_auto__add_field_orderdiscount_offer_name','2014-10-29 01:52:13'),(83,'order','0006_update_offer_name_field','2014-10-29 01:52:13'),(84,'order','0007_auto__add_field_orderdiscount_frequency','2014-10-29 01:52:13'),(85,'order','0008_auto__add_field_orderdiscount_category','2014-10-29 01:52:13'),(86,'order','0009_auto__add_field_orderdiscount_message','2014-10-29 01:52:13'),(87,'order','0010_auto__chg_field_billingaddress_postcode__chg_field_shippingaddress_pos','2014-10-29 01:52:13'),(88,'order','0011_auto__del_field_paymentevent_date__add_field_paymentevent_date_created','2014-10-29 01:52:14'),(89,'order','0012_auto__add_field_paymentevent_reference','2014-10-29 01:52:14'),(90,'order','0013_auto__add_field_paymentevent_shipping_event','2014-10-29 01:52:14'),(91,'order','0014_auto__chg_field_billingaddress_postcode__chg_field_shippingaddress_pos','2014-10-29 01:52:14'),(92,'order','0015_auto__del_field_shippingeventtype_is_required__del_field_shippingevent','2014-10-29 01:52:14'),(93,'order','0016_auto__add_field_order_currency__add_field_line_stockrecord','2014-10-29 01:52:15'),(94,'order','0017_auto__add_field_order_shipping_code','2014-10-29 01:52:15'),(95,'order','0018_auto__chg_field_shippingaddress_phone_number','2014-10-29 01:52:15'),(96,'order','0019_auto__chg_field_order_billing_address__chg_field_order_user__chg_field','2014-10-29 01:52:15'),(97,'order','0020_auto__add_field_order_basket_alt','2014-10-29 01:52:15'),(98,'order','0021_convert_basket_ids','2014-10-29 01:52:16'),(99,'order','0022_auto__del_field_order_basket_id','2014-10-29 01:52:16'),(100,'order','0023_rename_basket_field','2014-10-29 01:52:16'),(101,'order','0024_auto__chg_field_order_site','2014-10-29 01:52:16'),(102,'order','0025_auto__chg_field_shippingeventtype_code__chg_field_paymenteventtype_cod','2014-10-29 01:52:17'),(103,'order','0026_auto__chg_field_line_partner_name','2014-10-29 01:52:17'),(104,'order','0027_no_null_in_charfields','2014-10-29 01:52:17'),(105,'order','0028_auto__chg_field_line_partner_name__chg_field_line_status__chg_field_li','2014-10-29 01:52:18'),(106,'promotions','0001_initial','2014-10-29 01:52:20'),(107,'promotions','0002_auto__chg_field_keywordpromotion_filter__chg_field_image_link_url__chg','2014-10-29 01:52:20'),(108,'promotions','0003_auto__chg_field_image_image','2014-10-29 01:52:21'),(109,'promotions','0004_no_null_in_charfields','2014-10-29 01:52:21'),(110,'promotions','0005_auto__chg_field_automaticproductlist_link_url__chg_field_handpickedpro','2014-10-29 01:52:21'),(111,'voucher','0002_auto__chg_field_voucher_end_date__chg_field_voucher_start_date','2014-10-29 01:52:21'),(112,'voucher','0003_auto__del_field_voucher_end_date__del_field_voucher_start_date__add_fi','2014-10-29 01:52:21'),(113,'wishlists','0001_initial','2014-10-29 01:52:22'),(114,'catalogue','0002_auto__add_field_product_status__add_field_category_description__add_fi','2014-10-29 01:52:22'),(115,'catalogue','0003_auto__add_unique_product_upc__chg_field_productcontributor_role','2014-10-29 01:52:23'),(116,'catalogue','0004_auto__chg_field_productattributevalue_value_boolean','2014-10-29 01:52:23'),(117,'catalogue','0005_auto__chg_field_productattributevalue_value_boolean__add_field_product','2014-10-29 01:52:23'),(118,'catalogue','0006_auto__add_field_product_is_discountable','2014-10-29 01:52:23'),(119,'catalogue','0007_auto__add_field_productclass_requires_shipping__add_field_productclass','2014-10-29 01:52:23'),(120,'catalogue','0008_auto__add_unique_option_code','2014-10-29 01:52:23'),(121,'catalogue','0009_auto__add_field_product_rating','2014-10-29 01:52:23'),(122,'catalogue','0010_call_update_product_ratings','2014-10-29 01:52:23'),(123,'catalogue','0011_auto__chg_field_productimage_original__chg_field_category_image','2014-10-29 01:52:23'),(124,'catalogue','0012_auto__chg_field_productattributevalue_value_boolean','2014-10-29 01:52:23'),(125,'catalogue','0013_add_file_attributes','2014-10-29 01:52:23'),(126,'catalogue','0014_auto__del_field_productcategory_is_canonical','2014-10-29 01:52:24'),(127,'catalogue','0015_auto__chg_field_product_upc','2014-10-29 01:52:24'),(128,'catalogue','0016_customer','2014-10-29 01:52:24'),(129,'catalogue','0017_auto__del_contributor__del_productcontributor__del_contributorrole__de','2014-10-29 01:52:24'),(130,'catalogue','0018_auto__chg_field_product_product_class','2014-10-29 01:52:24'),(131,'catalogue','0019_no_null_in_charfields','2014-10-29 01:52:24'),(132,'catalogue','0020_auto__chg_field_productattributevalue_value_text__chg_field_productatt','2014-10-29 01:52:24'),(133,'ranges','0001_initial','2014-10-29 01:52:25'),(134,'ranges','0002_auto__chg_field_rangeproductfileupload_error_message','2014-10-29 01:52:25'),(135,'customer','0002_auto__add_notification','2014-10-29 01:52:26'),(136,'customer','0003_auto__add_productalert','2014-10-29 01:52:26'),(137,'customer','0004_auto__chg_field_communicationeventtype_email_subject_template','2014-10-29 01:52:26'),(138,'customer','0005_auto__chg_field_communicationeventtype_sms_template','2014-10-29 01:52:26'),(139,'customer','0006_auto__chg_field_communicationeventtype_code__add_unique_communicatione','2014-10-29 01:52:26'),(140,'customer','0007_no_null_in_charfields','2014-10-29 01:52:26'),(141,'customer','0008_auto__chg_field_productalert_email__chg_field_productalert_key__chg_fi','2014-10-29 01:52:27'),(142,'customer','0009_auto__chg_field_communicationeventtype_code','2014-10-29 01:52:27'),(143,'catalogue','0021_auto__add_productbrand__add_productactivity__add_field_product_brand__','2014-10-29 02:07:57'),(144,'catalogue','0022_auto__add_field_productbrand_slug__add_field_productactivity_slug','2014-10-29 18:43:21');
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
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
INSERT INTO `thumbnail_kvstore` VALUES ('sorl-thumbnail||image||333d9bc5d06398a67bb04eb910e0936c','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"image_not_found.jpg\", \"size\": [400, 300]}'),('sorl-thumbnail||image||9850cbedc8ea2a9f42019c1c53dcdb54','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ee/2b/ee2b9524f9c8130ccaf73ad60340a29e.jpg\", \"size\": [207, 155]}'),('sorl-thumbnail||image||c3eb66564c059718f5b99c3ad3e7e1e4','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/71/6b/716bd17622237f14699de92d6aebe271.jpg\", \"size\": [100, 75]}'),('sorl-thumbnail||image||e24990ea17cd67f5755751ae74bb3b91','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/af/81/af810d03215c71933dbb76476ec4eac3.jpg\", \"size\": [400, 300]}'),('sorl-thumbnail||thumbnails||333d9bc5d06398a67bb04eb910e0936c','[\"c3eb66564c059718f5b99c3ad3e7e1e4\", \"e24990ea17cd67f5755751ae74bb3b91\", \"9850cbedc8ea2a9f42019c1c53dcdb54\"]');
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
  `num_basket_additions` int(10) unsigned NOT NULL,
  `num_orders` int(10) unsigned NOT NULL,
  `total_discount` decimal(12,2) NOT NULL,
  `date_created` date NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
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
  UNIQUE KEY `voucher_voucher_offers_voucher_id_7a0c4a351389083e_uniq` (`voucher_id`,`conditionaloffer_id`),
  KEY `voucher_voucher_offers_57a58267` (`voucher_id`),
  KEY `voucher_voucher_offers_5df34e4f` (`conditionaloffer_id`),
  CONSTRAINT `conditionaloffer_id_refs_id_70af47be` FOREIGN KEY (`conditionaloffer_id`) REFERENCES `offer_conditionaloffer` (`id`),
  CONSTRAINT `voucher_id_refs_id_15302f99` FOREIGN KEY (`voucher_id`) REFERENCES `voucher_voucher` (`id`)
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
  `voucher_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `date_created` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_voucherapplication_57a58267` (`voucher_id`),
  KEY `voucher_voucherapplication_6340c63c` (`user_id`),
  KEY `voucher_voucherapplication_68d25c7a` (`order_id`),
  CONSTRAINT `order_id_refs_id_6e5c8698` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`),
  CONSTRAINT `user_id_refs_id_e1c199ae` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `voucher_id_refs_id_4919ac74` FOREIGN KEY (`voucher_id`) REFERENCES `voucher_voucher` (`id`)
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
  `wishlist_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wishlists_line_wishlist_id_53bbce7b453dfacc_uniq` (`wishlist_id`,`product_id`),
  KEY `wishlists_line_7f9501f4` (`wishlist_id`),
  KEY `wishlists_line_7f1b40ad` (`product_id`),
  CONSTRAINT `product_id_refs_id_a0c2dc87` FOREIGN KEY (`product_id`) REFERENCES `catalogue_product` (`id`),
  CONSTRAINT `wishlist_id_refs_id_8c2e4882` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlists_wishlist` (`id`)
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
  `owner_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `key` varchar(6) NOT NULL,
  `visibility` varchar(20) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `wishlists_wishlist_cb902d83` (`owner_id`),
  CONSTRAINT `owner_id_refs_id_180477a5` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
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

-- Dump completed on 2014-11-03  2:20:04
