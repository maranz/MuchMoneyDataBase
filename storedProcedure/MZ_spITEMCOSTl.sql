DROP PROCEDURE IF EXISTS MZ_spITEMCOSTIl;

DELIMITER //
CREATE PROCEDURE MZ_spITEMCOSTIl (
		in NAME varchar(255)
	   ,in APPID varchar(36)
	   ,in VDATE datetime							 
)
BEGIN
	/*
	 * Implementare la gestione della data di validità 
	*/		
	SET @QRY = concat("select ITEMCOSTID, NAME from MZ_ITEMCOST where cdate is null and APPID = '", TRIM(IFNULL(APPID, "")) , "'");
	if TRIM(IFNULL(NAME, "")) != "" then	
		SET @QRY = concat(@QRY, " and NAME = '" , NAME, "'");
	end if;
	SET @QRY = concat(@QRY, " order by NAME");
	PREPARE stmt FROM @QRY; 
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

END; //
DELIMITER // 
