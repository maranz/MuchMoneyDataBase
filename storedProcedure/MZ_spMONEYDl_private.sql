DROP PROCEDURE IF EXISTS MZ_spMONEYDl_private;

DELIMITER //
CREATE PROCEDURE MZ_spMONEYDl_private (		
		 in YEAR int
		,in USERID varchar(36)		
	    ,in APPID varchar(36)
)
BEGIN	
	SET @YEAR = IFNULL(YEAR, 1900); 
	SET @USERID = TRIM(IFNULL(USERID, "")); 	
	SET @APPID = TRIM(IFNULL(APPID, ""));
	
    SET @QRY = concat("select M.MONEYID
	,YEAR( M.VDATE ) YEAR
	,MONTH( M.VDATE ) MONTH
	,DAY( M.VDATE ) MONTH
	,M.VDATE
	,M.USERID
	,U.USER
	,U.AVATAR
	,null PROJECTID
	,'Private' PROJECTNAME
	,M.ITEMCOSTID
	,C.NAME ITEMCOSTNAME
	,C.CTYPE 
	,M.MONEY
	from MZ_MONEY M 
	inner join MZ_USERS U on 
		U.CDATE is null
		and U.USERID = M.USERID	
	inner join MZ_ITEMCOST C ON
		C.CDATE is null
		and C.ITEMCOSTID = M.ITEMCOSTID 
	where M.CDATE is NULL
	and M.APPID = ?
	and YEAR( M.VDATE ) = ?
	and (M.PROJECTID is null or M.PROJECTID = '')
	{0}	
	ORDER BY M.VDATE DESC, U.USER");
	
	if @USERID != "" then	
		SET @QRY = replace(@QRY, "{0}", " and M.USERID = ? ");
	else
		SET @QRY = replace(@QRY, "{0}", " ");
	end if;

	#select @QRY;

	PREPARE stmt FROM @QRY; 

	case 
	  	when @USERID != "" then 			
	  		EXECUTE stmt USING @APPID, @YEAR, @USERID;			
	  	else 
	  		EXECUTE stmt USING @APPID, @YEAR;	  	
	end case;

	DEALLOCATE PREPARE stmt;
	
END; //
DELIMITER //
