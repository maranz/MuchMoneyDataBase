DROP PROCEDURE IF EXISTS MZ_spITEMCOSTIl;

DELIMITER //
CREATE PROCEDURE MZ_spITEMCOSTIl (
		in NAME varchar(255)
	   ,in APPID varchar(36)
	   ,in VDATE datetime
	   ,in CTYPE varchar(1)	
	   ,in USERID varchar(36)
	   ,in PROJECTID varchar(36)
)
BEGIN
	/*
	 * Implementare la gestione della data di validità 
	*/		
	SET @NAME = TRIM(IFNULL(NAME, ""));
	SET @APPID = TRIM(IFNULL(APPID, ""));
	SET @CTYPE = TRIM(IFNULL(CTYPE, ""));	
	SET @USERID = TRIM(IFNULL(USERID, ""));
	SET @PROJECTID = TRIM(IFNULL(PROJECTID, ""));
	
	SET @QRY = concat("select c.ITEMCOSTID, c.NAME
from MZ_ITEMCOST c
inner join MZ_ITEMCOSTUSER uc
on uc.cdate is null 
{0}
and uc.ITEMCOSTID = c.ITEMCOSTID
where c.cdate is null 
and c.APPID = ? 
and c.CTYPE = ? 
{1}
order by c.NAME");
	
	if @NAME != "" then	
		SET @QRY = replace(@QRY, "{1}", " and c.NAME = ? ");
	else
		SET @QRY = replace(@QRY, "{1}", " ");
	end if;

	if @PROJECTID != "" then
		SET @QRY = replace(@QRY, "{0}"," and uc.PROJECTID = ? ");
	elseif @USERID != "" then
		SET @QRY = replace(@QRY, "{0}"," and uc.USERID = ? ");
	else
		SET @QRY = replace(@QRY, "{0}", " ");
	end if;
	
	#select @QRY;

	PREPARE stmt FROM @QRY; 

	case 
	  	when @NAME != "" and @PROJECTID != "" then 
	  		EXECUTE stmt USING @PROJECTID, @APPID, @CTYPE, @NAME;	
		when @NAME = "" and @PROJECTID != "" then 
			EXECUTE stmt USING @PROJECTID, @APPID, @CTYPE;
	  	when @NAME != "" and @USERID != "" then 
	  		EXECUTE stmt USING @USERID, @APPID, @CTYPE, @NAME;
		when @NAME = "" and @USERID != "" then 
			EXECUTE stmt USING @USERID, @APPID, @CTYPE;
	  	when @NAME != "" then 
	  		EXECUTE stmt USING @APPID, @CTYPE, @NAME;
	  	else 
	  		EXECUTE stmt USING @APPID, @CTYPE;	  	
	end case;

	DEALLOCATE PREPARE stmt;

END; //
DELIMITER //


