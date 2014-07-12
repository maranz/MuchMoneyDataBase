/*
 * Tabella dei soldi in entrata
*/
DROP TABLE IF EXISTS MZ_MONEYOUT;

CREATE TABLE `MZ_MONEYOUT` (
  `MONEYID` varchar(36) NOT NULL,
  `USERID` varchar(36) NOT NULL,
  `GROUPID` varchar(36) DEFAULT NULL,
  `ITEMCOSTID` varchar(38) NOT NULL,
  `VDATE` datetime NOT NULL,
  `IDATA` datetime NOT NULL,
  `UDATE` datetime DEFAULT NULL,
  `CDATE` datetime DEFAULT NULL,
  `MONEY` decimal(16,2) NOT NULL DEFAULT '0.00',
  `USERAPP` varchar(45) DEFAULT NULL,
  `APPID` varchar(36) NOT NULL,
  PRIMARY KEY (`MONEYID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;