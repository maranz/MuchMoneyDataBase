DROP PROCEDURE IF EXISTS MZ_spUSERSc;

DELIMITER //
CREATE PROCEDURE MZ_spUSERSc (
			in USERID varchar(36),
			in APPID varchar(36)
)
BEGIN
	
	select count(*) as count
	from MZ_USERS u 
	inner join MZ_APPUSER a on 
	    a.appid = APPID
	where u.USERID = USERID             
	and u.USERID = a.USERID;		
	
END; //
DELIMITER // 