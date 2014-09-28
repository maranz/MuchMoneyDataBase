DROP PROCEDURE IF EXISTS MZ_spMONEYDl_project;

DELIMITER //
CREATE PROCEDURE MZ_spMONEYDl_project (		
		 in YEAR int
		,in USERID varchar(36)
		,in PROJECTID varchar(36)
	    ,in APPID varchar(36)
)
BEGIN	
	SET @YEAR = IFNULL(YEAR, 1900); 
	SET @USERID = TRIM(IFNULL(USERID, "")); 
	SET @PROJECTID = TRIM(IFNULL(PROJECTID, ""));
	SET @APPID = TRIM(IFNULL(APPID, ""));
	
    SET @QRY = concat("select M.MONEYID
	,YEAR( M.VDATE ) YEAR
	,MONTH( M.VDATE ) MONTH
	,MZ_GETNAMEMONTH( MONTH( M.VDATE ) ) NAMEMONTH
	,DAY( M.VDATE ) DAY
	,M.VDATE
	,M.USERID
	,U.USER
	,U.AVATAR
	,M.PROJECTID
	,IFNULL( P.NAME, 'Private' ) PROJECTNAME
	,M.ITEMCOSTID
	,C.NAME ITEMCOSTNAME
	,C.CTYPE 
	,M.MONEY
	from MZ_MONEY M 
	inner join MZ_USERS U on 
		U.CDATE is null
		and U.USERID = M.USERID
	left join MZ_PROJECT P on
		P.CDATE is null
		and P.PROJECTID = M.PROJECTID 
	inner join MZ_ITEMCOST C ON
		C.CDATE is null
		and C.ITEMCOSTID = M.ITEMCOSTID 
	where M.CDATE is NULL
	and M.APPID = ?
	and YEAR( M.VDATE ) = ?
	{0}
	{1}
	ORDER BY M.VDATE DESC, U.USER");
	
	if @USERID != "" then	
		SET @QRY = replace(@QRY, "{0}", " and M.USERID = ? ");
	else
		SET @QRY = replace(@QRY, "{0}", " ");
	end if;

	if @PROJECTID != "" then	
		SET @QRY = replace(@QRY, "{1}", " and M.PROJECTID = ? ");
	else
		SET @QRY = replace(@QRY, "{1}", " ");
	end if;

	#select @QRY;

	PREPARE stmt FROM @QRY; 

	case 
	  	when @USERID != "" and @PROJECTID != "" then 			
	  		EXECUTE stmt USING @APPID, @YEAR, @USERID, @PROJECTID;	
		when @USERID = "" and @PROJECTID != "" then 
			EXECUTE stmt USING @APPID, @YEAR, @PROJECTID;
	  	when @USERID != "" and @PROJECTID = "" then 
	  		EXECUTE stmt USING @APPID, @YEAR, @USERID;							
	  	else 
	  		EXECUTE stmt USING @APPID, @YEAR;	  	
	end case;

	DEALLOCATE PREPARE stmt;
	
END; //
DELIMITER //