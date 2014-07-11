DROP PROCEDURE IF EXISTS MZ_spUSERSl;

DELIMITER //
CREATE PROCEDURE MZ_spUSERSl (in APPID varchar(36))
BEGIN
	
	select u.USERID,
	       u.USER	   
	from MZ_USERS u
	inner join MZ_APPUSER a on
		a.APPID = APPID
	and a.USERID = u.USERID;	
		
	
END; //
DELIMITER // 
