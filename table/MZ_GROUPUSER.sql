/*
 * Tabella legame Gruppi utentei
 */ 
DROP TABLE IF EXISTS MZ_GROUPUSER;

CREATE TABLE `MZ_GROUPUSER` (
  `GROUPUSERID` varchar(36) NOT NULL,
  `GROUPID` varchar(36) NOT NULL,
  `USERID` varchar(36) NOT NULL,
  `IDATA` datetime NOT NULL,
  `UDATE` datetime DEFAULT NULL,
  `CDATE` datetime DEFAULT NULL,
  `DINI` datetime DEFAULT NULL,
  `DFIN` datetime DEFAULT NULL,
  `USERAPP` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`GROUPUSERID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;