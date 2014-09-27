DROP PROCEDURE IF EXISTS MZ_spMONEYDl;

DELIMITER //
CREATE PROCEDURE MZ_spMONEYDl (		
		 in YEAR int
		,in USERID varchar(36)
		,in PROJECTID varchar(36)
	    ,in APPID varchar(36)
)
BEGIN	
	
	if PROJECTID = "PRIVATE" then
		call MZ_spMONEYDl_private ( YEAR, USERID, APPID );
	else
		call MZ_spMONEYDl_project ( YEAR, USERID, PROJECTID, APPID );
	end if;

END; //
DELIMITER //