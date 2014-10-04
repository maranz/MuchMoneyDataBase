/*
 * Tabella del menu
 */ 
DROP TABLE IF EXISTS MZ_MENU;

CREATE TABLE `MZ_MENU` (
  `MENUID` varchar(36) NOT NULL,
  `ORDERID` int NOT NULL,
  `TITLE` varchar(255) NOT NULL,    
  `SUBTITLE` varchar(255) NOT NULL,    
  `IMG` varchar(25) NOT NULL,    
  `SELECTOR` varchar(25) NOT NULL,
  `PARAMS` varchar(25) NULL,
  `TYPE` varchar(25) NOT NULL,    
  `IDATA` datetime NOT NULL,
  `UDATE` datetime DEFAULT NULL,
  `CDATE` datetime DEFAULT NULL,
  `DINI` datetime DEFAULT NULL,
  `DFIN` datetime DEFAULT NULL,
  `USERAPP` varchar(45) DEFAULT NULL,
  `APPID` varchar(36) NOT NULL,
  `PROJECTID` varchar(36)  NULL,
  PRIMARY KEY (`MENUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
