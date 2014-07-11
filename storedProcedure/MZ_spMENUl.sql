DROP PROCEDURE IF EXISTS MZ_spMENUl;

DELIMITER //
CREATE PROCEDURE MZ_spMENUl (in APPID varchar(36))
BEGIN
	
	select m.MENUID
		 , m.ORDERID
		 , m.TITLE
		 , m.SUBTITLE
		 , m.IMG, m.SELECTOR
		 , m.PARAMS
		 , m.TYPE
		 , m.OWNERID
	from MZ_MENU m
	where TYPE = 'startmenu'
	and m.APPID = APPID
	order by m.ORDERID;		
	
END; //
DELIMITER // 