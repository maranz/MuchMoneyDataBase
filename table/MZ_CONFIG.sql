/*
 * Tabella CONFIG
*/
DROP TABLE IF EXISTS MZ_CONFIG;

CREATE TABLE `MZ_CONFIG` (
  `CONFIGID` varchar(36) NOT NULL,
  `KEY` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,    
  `IDATA` datetime NOT NULL,
  `UDATE` datetime DEFAULT NULL,
  `CDATE` datetime DEFAULT NULL,
  `USERAPP` varchar(45) DEFAULT NULL,
  `VERSION`  varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CONFIGID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;