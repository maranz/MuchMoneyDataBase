/*
 * Tabella dei Voci di costo
 */ 
DROP TABLE IF EXISTS MZ_ITEMCOST;

CREATE TABLE `MZ_ITEMCOST` (
  `ITEMCOSTID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,    
  `IDATA` datetime NOT NULL,
  `UDATE` datetime DEFAULT NULL,
  `CDATE` datetime DEFAULT NULL,
  `DINI` datetime DEFAULT NULL,
  `DFIN` datetime DEFAULT NULL,
  `USERAPP` varchar(45) DEFAULT NULL,
  `APPID` varchar(36) NOT NULL,
  PRIMARY KEY (`ITEMCOSTID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;