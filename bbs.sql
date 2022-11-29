
# MySQL-Front 5.0  (Build 1.0)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: localhost    Database: bbs
# ------------------------------------------------------
# Server version 5.0.67-community-nt

#
# Table structure for table replyinfo
#

DROP TABLE IF EXISTS `replyinfo`;
CREATE TABLE `replyinfo` (
                             `rId` int(11) NOT NULL auto_increment,
                             `rTId` int(11) NOT NULL default '0',
                             `rSId` int(11) NOT NULL default '0',
                             `rUId` int(11) NOT NULL default '0',
                             `rTopic` varchar(20) default '',
                             `rContents` text NOT NULL,
                             `rPublishTime` datetime ,
                             `rModifyTime` datetime default NULL,
                             PRIMARY KEY  (`rId`),
                             KEY `FK_rUId` (`rUId`),
                             KEY `FK_rSId` (`rSId`),
                             KEY `FK_rTId` (`rTId`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
INSERT INTO `replyinfo` VALUES (77,69,71,7,'写得不错，赞一个！','写得不错，赞一个！','2009-12-01 09:27:30',NULL);
INSERT INTO `replyinfo` VALUES (78,69,71,7,'写得不错，赞一个！','写得不错，赞一个！','2009-12-01 09:35:50',NULL);

#
# Table structure for table sectioninfo
#

DROP TABLE IF EXISTS `sectioninfo`;
CREATE TABLE `sectioninfo` (
                               `sId` int(11) NOT NULL auto_increment,
                               `sName` varchar(20) NOT NULL default '',
                               `sTopicCount` int(11) NOT NULL default '0',
                               `sMasterId` int(11) default '0',
                               `sParentId` int(11) NOT NULL default '0',
                               PRIMARY KEY  (`sId`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
INSERT INTO `sectioninfo` VALUES (70,'职场生涯',0,1,0);
INSERT INTO `sectioninfo` VALUES (71,'轻松职场',4,1,77);
INSERT INTO `sectioninfo` VALUES (73,'职场文化',1,1,70);
INSERT INTO `sectioninfo` VALUES (74,'提升充电',1,1,70);
INSERT INTO `sectioninfo` VALUES (75,'财富人生',1,1,70);
INSERT INTO `sectioninfo` VALUES (77,'商务综合',0,1,0);
INSERT INTO `sectioninfo` VALUES (78,'诚信社区',1,1,77);
INSERT INTO `sectioninfo` VALUES (79,'寻求合作',1,1,77);
INSERT INTO `sectioninfo` VALUES (80,'商海沉浮',1,1,77);
INSERT INTO `sectioninfo` VALUES (81,'电子商务',1,1,77);

#
# Table structure for table topicinfo
#

DROP TABLE IF EXISTS `topicinfo`;
CREATE TABLE `topicinfo` (
                             `tId` int(11) NOT NULL auto_increment,
                             `tSId` int(11) NOT NULL default '0',
                             `tUId` int(11) NOT NULL default '0',
                             `tTopic` varchar(20) NOT NULL default '',
                             `tContents` text NOT NULL,
                             `tReplyCount` int(11) NOT NULL default '0',
                             `tClickCount` int(11) NOT NULL default '0',
                             `tPublishTime` datetime,
                             `tModifyTime` datetime default NULL,
                             PRIMARY KEY  (`tId`),
                             KEY `FK_tUId` (`tUId`),
                             KEY `FK_tSId` (`tSId`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
INSERT INTO `topicinfo` VALUES (55,73,1,'Test','Test',0,0,'2009-11-30 15:59:44',NULL);
INSERT INTO `topicinfo` VALUES (56,74,1,'Test','Test',0,0,'2009-11-30 15:59:57',NULL);
INSERT INTO `topicinfo` VALUES (57,75,1,'Test','Test',0,0,'2009-11-30 16:00:05',NULL);
INSERT INTO `topicinfo` VALUES (59,78,1,'Test','Test',0,0,'2009-11-30 16:00:19',NULL);
INSERT INTO `topicinfo` VALUES (60,79,1,'Test','Test',0,0,'2009-11-30 16:00:24',NULL);
INSERT INTO `topicinfo` VALUES (61,80,1,'Test','Test',0,0,'2009-11-30 16:00:37',NULL);
INSERT INTO `topicinfo` VALUES (62,81,1,'Test','Test',0,0,'2009-11-30 16:00:43',NULL);
INSERT INTO `topicinfo` VALUES (68,71,1,'很高兴，能跟大家交流！！','很高兴，能跟大家交流！！',0,0,'2009-11-30 17:01:18',NULL);
INSERT INTO `topicinfo` VALUES (69,71,1,'如何为员工创造发展空间','当我们是一名员工的时候，我们渴望从工作中获得知识，渴望获得企业的认可。我们除了每月领取自己的工资，最希望得到的，是职业生涯发展的空间和动力。<br><br>　　1.新员工入职培训。<br><br>　　新员工入职培训是非常重要的环节，尤其是对于应届毕业的学生。学生从学校走入社会第一次接触“公司”，什么是公司。走出职业生涯的第一步，甚至还不知道什么是职业生涯。而新员工入职培训，则应该为他们讲解公司的价值观、文化、理念，告诉他们职业生涯是什么样的。<br><br>　　2.深度参与项目的机会。<br><br>　　很多时候新员工的潜能是很大的，但是要看你能给他多大的施展空间。如果不给他们足够的发展空间，大家都还没有机会深度介入到项目当中，又谈何来的成长与发展?因此，不要以“还不行”，“没经验”这样理由拒绝他们对项目中“高难度”工作的好奇心，打开一扇门，你会发现大家其实都能做得很好!<br><br>　　3.专业技能的培训。<br><br>　　在新员工入职后一年左右的时间，我们应该已经能够清楚地看到每一个人的优势及短板，做这大限度发挥优势的同时，也不要忘记为他们提供专业技能提升的机会——培训。市场上很多培训并不昂贵，4000~5000元的培训可能还不及他们一个月的工资，但是给他们一周的时间去学习，将使他们有机会迈上新的台阶。<br><br>　　4.自由发展的空间。<br><br>　　很多企业都讲以人为本，其实以人为本最简单的一个体现就是能够尊重员工的个人发展意愿，这种意愿包括职业方向、技术深度、广度等等。很多时候新员工在工作中会遇到不懂得东西，他们会自己去查，自己去学，他们有自己的思维，也会产生自己的兴趣。企业不应该是扮演索取员工剩余价值的机器，而是应该作为一个社会责任的承担者，引导他们、推动他们的职业生涯不断发展。<br>',2,0,'2009-11-30 17:03:53',NULL);

#
# Table structure for table userinfo
#

DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
                            `uId` int(11) NOT NULL auto_increment,
                            `uName` varchar(10) NOT NULL default '',
                            `uPassWord` varchar(20) NOT NULL default '',
                            `uSex` tinyint(1) NOT NULL default '0',
                            `uFace` varchar(7) NOT NULL default '',
                            `uRegTime` datetime ,
                            `uType` int(11) NOT NULL default '0',
                            `uActive` boolean default '1',
                            PRIMARY KEY  (`uId`),
                            UNIQUE KEY `UQ_uName` (`uName`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
INSERT INTO `userinfo` VALUES (1,'admin','admin',1,'1.gif','2009-01-11 22:17:48',2,1);
INSERT INTO `userinfo` VALUES (7,'test','test',1,'2.gif','2009-11-30 14:52:58',2,1);
INSERT INTO `userinfo` VALUES (8,'javaweb','javaweb',0,'2.gif','2010-01-29 10:34:37',0,1);

#
#  Foreign keys for table replyinfo
#

ALTER TABLE `replyinfo`
    ADD CONSTRAINT `FK_rUId` FOREIGN KEY (`rUId`) REFERENCES `userinfo` (`uId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ADD CONSTRAINT `FK_rSId` FOREIGN KEY (`rSId`) REFERENCES `sectioninfo` (`sId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ADD CONSTRAINT `FK_rTId` FOREIGN KEY (`rTId`) REFERENCES `topicinfo` (`tId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

#
#  Foreign keys for table topicinfo
#

ALTER TABLE `topicinfo`
    ADD CONSTRAINT `FK_tUId` FOREIGN KEY (`tUId`) REFERENCES `userinfo` (`uId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ADD CONSTRAINT `FK_tSId` FOREIGN KEY (`tSId`) REFERENCES `sectioninfo` (`sId`) ON DELETE NO ACTION ON UPDATE NO ACTION;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
