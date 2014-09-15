DROP PROCEDURE IF EXISTS MZ_spPROJECTl;

DELIMITER //
CREATE PROCEDURE MZ_spPROJECTl (		
		in USERID varchar(36)
	   ,in APPID varchar(36)
)
BEGIN
	
	select 'all'
	,'Tutti i progetti'
	union all
	select p.projectid
	,p.NAME 
	from MZ_PROJECT p
	inner join MZ_PROJECTUSER u on	
			u.CDATE is null
		and u.APPID = APPID
		and u.USERID = USERID
		and u.projectid = p.projectid
	where p.cdate is null
		and p.APPID = APPID
	union all
	select 'pers'
	,'Personale';
	
	
END; //
DELIMITER //