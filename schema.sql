DROP TABLE IF EXISTS `anotherEntity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anotherEntity` (
  `anotherEntityID` int(11) NOT NULL AUTO_INCREMENT,
  `textHasLabelID` int(11) NOT NULL,
  `anotherEntity` text NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`anotherEntityID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `username` varchar(255) NOT NULL,
  `authority` varchar(50) NOT NULL,
  UNIQUE KEY `ix_auth_username` (`username`,`authority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidate` (
  `candidateID` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(250) NOT NULL,
  `label` varchar(250) NOT NULL,
  `abstract` text NOT NULL,
  PRIMARY KEY (`candidateID`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=44664 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `haslabel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `haslabel` (
  `textID` int(11) NOT NULL,
  `labelID` int(11) NOT NULL,
  PRIMARY KEY (`labelID`,`textID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `label` (
  `labelID` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(250) NOT NULL,
  PRIMARY KEY (`labelID`),
  UNIQUE KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=22215 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `labelHasCandidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labelHasCandidate` (
  `labelID` int(11) NOT NULL,
  `candidateID` int(11) NOT NULL,
  PRIMARY KEY (`labelID`,`candidateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `notIdentifiedNE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notIdentifiedNE` (
  `nine_id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(250) NOT NULL,
  `textID` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`nine_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(255) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text` (
  `textID` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`textID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `textHasLabel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `textHasLabel` (
  `textHasLabelID` int(11) NOT NULL AUTO_INCREMENT,
  `textID` int(11) NOT NULL,
  `labelID` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`textHasLabelID`)
) ENGINE=InnoDB AUTO_INCREMENT=93128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(255) NOT NULL,
  `password` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `voting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voting` (
  `votingID` int(11) NOT NULL AUTO_INCREMENT,
  `textHasLabelID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `candidateID` int(11) NOT NULL,
  PRIMARY KEY (`votingID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `userSawText`;
CREATE TABLE `userSawText` (
  `textID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`textID`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP VIEW IF EXISTS `textsHavingCandidates`;
CREATE VIEW `textsHavingCandidates` AS (
select distinct `textHasLabel`.`textID` AS `textID`
from (`textHasLabel` join `labelHasCandidate`)
where (`textHasLabel`.`labelID` = `labelHasCandidate`.`labelID`)
group by `textHasLabel`.`textID`,`labelHasCandidate`.`labelID`
having (count(`labelHasCandidate`.`candidateID`) > 0)) ;
