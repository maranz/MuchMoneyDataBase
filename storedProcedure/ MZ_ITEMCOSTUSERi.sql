drop procedure if exists MZ_ITEMCOSTUSERi;

DELIMITER //
CREATE PROCEDURE MZ_ITEMCOSTUSERi(
	in ITEMCOSTID varchar(36),
	in USERID varchar(36),
    in PROJECTID varchar(36), 
	in APPID varchar(36),
	in VDATE datetime, #data da utilizzare con DINI e DFIN, al momento predisposta la chiamata ma non utilizzata
	out ERR varchar(255)
)		
BEGIN

DECLARE FIND INT DEFAULT -1;	
DECLARE ITEMCOSTUSERID varchar(36);
	
#Start control parameters
select "" into ERR;

if TRIM(IFNULL(ITEMCOSTID, "")) = "" then 	
	select concat(ERR, "$Error ITEMCOSTID is null or empty") into ERR;	
end if;

if TRIM(IFNULL(USERID, "")) = "" then 
	select concat(ERR, "$Error USERID is null or empty") into ERR;	
end if;

if TRIM(IFNULL(PROJECTID, "")) = "" then 
	select concat(ERR, "$Error PROJECTID is null or empty") into ERR;	
end if;

if TRIM(IFNULL(APPID, "")) = "" then 
	select concat(ERR, "$Error APPID is null or empty") into ERR;	
end if;
# End control parameters

if ERR = "" then			
	select COUNT( * ) into FIND 
	from MZ_ITEMCOSTUSER c
	where c.ITEMCOSTID = ITEMCOSTID 
		AND c.USERID = USERID
		AND c.PROJECTID = PROJECTID
		AND c.APPID = APPID;

	/*
	   TODO: da gestire l'inserimento di una voce trovata ma non valida nel VDATE in linea
	   se il caso si presenta ritornare un errore...
	*/
	#Se non trovo ITEMCOSTUSERID inserisco la voce e mi ricavo ITEMCOSTID
	if FIND = 0 then						
		#select "DEBUG: before insert";
		select UUID() into ITEMCOSTUSERID;
		insert into MZ_ITEMCOSTUSER
		value (
		 ITEMCOSTUSERID #ITEMCOSTUSERID
		,ITEMCOSTID #ITEMCOSTID
		,USERID #USERID
		,PROJECTID #PROJECTID
		,NOW() #IDATE
		,NULL #UDATE
		,NULL #CDATE
		,NULL #DINI
		,NULL #DFIN
		,"MZ_ITEMCOSTUSERi"
		,APPID #USERAPP
		);
		#select "DEBUG: after insert";
	end if;
end if;

#Start format output messagge error
if ERR != "" then 	
	select MZ_showERR(ERR) into ERR;
end if;
# End format output messagge error

END; //
DELIMITER //