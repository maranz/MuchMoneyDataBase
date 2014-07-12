/*
 * Tabella dei Voci di costo
*/
DROP TABLE IF EXISTS MZ_LOG;

CREATE TABLE `MZ_LOG` (
  `LOGID` varchar(36) NOT NULL,
  `FUNCTION` varchar(36) NOT NULL,
  `MESSAGE` varchar(255) NOT NULL,    
  `STACK` varchar(255) NULL,
  `TYPE` varchar(2) NOT NULL,
  `IDATA` datetime NOT NULL,
  `USERAPP` varchar(45) NOT NULL,  
  PRIMARY KEY (`LOGID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;