/*
 * Tabella Gruppi
 */ 
DROP TABLE IF EXISTS MZ_GROUP;

CREATE TABLE `MZ_GROUP` (
  `GROUPID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,    
  `IDATA` datetime NOT NULL,
  `UDATE` datetime DEFAULT NULL,
  `CDATE` datetime DEFAULT NULL,
  `DINI` datetime DEFAULT NULL,
  `DFIN` datetime DEFAULT NULL,
  `USERAPP` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`GROUPID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


