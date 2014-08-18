DROP PROCEDURE IF EXISTS MZ_spITEMCOSTIl;

DELIMITER //
CREATE PROCEDURE MZ_spITEMCOSTIl (
		in NAME varchar(255)
	   ,in APPID varchar(36)
	   ,in VDATE datetime
	   ,in CTYPE varchar(1)							 
)
BEGIN
	/*
	 * Implementare la gestione della data di validità 
	*/		
	SET @NAME = TRIM(IFNULL(NAME, ""));
	SET @APPID = TRIM(IFNULL(APPID, ""));
	SET @CTYPE = TRIM(IFNULL(CTYPE, ""));
	
	SET @QRY = concat("select ITEMCOSTID, NAME from MZ_ITEMCOST where cdate is null and APPID = ? and CTYPE = ? ");
	if @NAME != "" then	
		SET @QRY = concat(@QRY, " and NAME = ?");
	end if;
	SET @QRY = concat(@QRY, " order by NAME");
	PREPARE stmt FROM @QRY; 

	if @NAME != "" then	
		EXECUTE stmt USING @APPID, @CTYPE, @NAME;
	else
		EXECUTE stmt USING @APPID, @CTYPE;
	end if;
	
	DEALLOCATE PREPARE stmt;

END; //
DELIMITER //

