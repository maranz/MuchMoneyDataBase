/*
 * Tabella d'appoggio per l'importazione dei csv dei fogli single user
 */ 
DROP TABLE IF EXISTS MZ_IMPTABLE;

CREATE TABLE `MZ_IMPTABLE` (  
  `USER` varchar(45) NULL,
  `ITEMCOST` varchar(255) NULL,    
  `MONEY` decimal(16,2) NOT NULL DEFAULT '0.00',
  `VDATE` datetime DEFAULT NULL,
  `IDATE` datetime DEFAULT NULL,  
  `USERAPP` varchar(45) DEFAULT NULL,
  `SHEET` varchar(45) NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;