CREATE DATABASE  IF NOT EXISTS `kempexercise` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `kempexercise`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: kempexercise
-- ------------------------------------------------------
-- Server version	8.0.11

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
-- Table structure for table `cluster_table`
--

DROP TABLE IF EXISTS `cluster_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cluster_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'List of clusters',
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cluster_table`
--

LOCK TABLES `cluster_table` WRITE;
/*!40000 ALTER TABLE `cluster_table` DISABLE KEYS */;
INSERT INTO `cluster_table` VALUES (Null,'clare'),(Null,'limerick'),(Null,'kerry');
/*!40000 ALTER TABLE `cluster_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_table`
--

DROP TABLE IF EXISTS `server_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipAddress` varchar(45) NOT NULL,
  `clusterId` int(11) DEFAULT NULL COMMENT 'Server details\nEach server can belong to one cluster. ',
  `name` varchar(45) DEFAULT NULL COMMENT 'nickname of server',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_table`
--

LOCK TABLES `server_table` WRITE;
/*!40000 ALTER TABLE `server_table` DISABLE KEYS */;
INSERT INTO `server_table` VALUES (1,'192.123.45.3',1,'shannon'),(2,'192.123.45.4',1,'newmarket'),(3,'192.123.45.5',2,'parteen');
/*!40000 ALTER TABLE `server_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_access_table`
--

DROP TABLE IF EXISTS `service_access_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_access_table` (
  `userId` int(11) NOT NULL,
  `serverId` varchar(45) NOT NULL,
  `dateStamp` datetime NOT NULL,
  `success` tinyint(4) NOT NULL COMMENT 'User was successful or not in accessing this server\n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_access_table`
--

LOCK TABLES `service_access_table` WRITE;
/*!40000 ALTER TABLE `service_access_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_access_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_server_table`
--

DROP TABLE IF EXISTS `user_server_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_server_table` (
  `userId` int(11) NOT NULL,
  `serverId` int(11) NOT NULL COMMENT 'A user can have access to multiple servers'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_server_table`
--

LOCK TABLES `user_server_table` WRITE;
/*!40000 ALTER TABLE `user_server_table` DISABLE KEYS */;
INSERT INTO `user_server_table` VALUES (1,1),(1,2),(1,3);
/*!40000 ALTER TABLE `user_server_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_table`
--

DROP TABLE IF EXISTS `user_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'user name and password',
  `userName` varchar(45) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_table`
--
--
-- Create some initial data
truncate table user_table;
INSERT INTO user_table (userName, password) VALUES
    ('Kemp',('limerick')),
    ('Analog', ('clare'));
select * from user_table;

SELECT id FROM user_table 
WHERE userName = 'Analog'
AND password = ('clare');

truncate table cluster_table;
INSERT INTO cluster_table (name) VALUES
    ('galway'),('limerick'),('kerry');
select * from cluster_table;

truncate table server_table;
INSERT INTO server_table (id, ipAddress, clusterId, name) VALUES
    (NULL, '192.123.45.3', 1,'shannon' ),(NULL, '192.123.45.4', 1,'newmarket'),(NULL, '192.123.45.5', 2,'parteen');
select * from server_table;




truncate table service_access_table;
INSERT INTO service_access_table (userId, serverId, dateStamp, success) VALUES
    (1, 1,CURRENT_TIMESTAMP, 1),(1, 1,CURRENT_TIMESTAMP, 0),(1, 1,CURRENT_TIMESTAMP, 1);
select * from service_access_table;


truncate table user_server_table;
INSERT INTO user_server_table  (userId, serverId) VALUES
    (1,1),(1,2),(1,3);
select * from user_server_table;
LOCK TABLES `user_table` WRITE;
/*!40000 ALTER TABLE `user_table` DISABLE KEYS */;

/*!40000 ALTER TABLE `user_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-10 13:31:06
