drop procedure if exists MZ_spITEMCOSTi;

DELIMITER //
CREATE PROCEDURE MZ_spITEMCOSTi(
	inout ITEMCOSTID varchar(36),
	in NAME varchar(255), 
	in APPID varchar(36),
	in VDATE datetime, #data da utilizzare con DINI e DFIN, al momento predisposta la chiamata ma non utilizzata
	in CTYPE varchar(1),
	in USERID varchar(36),
    in PROJECTID varchar(36),
	out ERR varchar(255)
)
BEGIN

#Start control parameters
select "" into ERR;

if TRIM(IFNULL(NAME, "")) = "" then 	
	select concat(ERR, "$Error NAME is null or empty") into ERR;	
end if;

if TRIM(IFNULL(APPID, "")) = "" then 
	select concat(ERR, "$Error APPID is null or empty") into ERR;	
end if;

if TRIM(IFNULL(CTYPE, "")) = "" then 
	select concat(ERR, "$Error CTYPE is null or empty") into ERR;	
end if;

if TRIM(IFNULL(USERID, "")) = "" then 
	select concat(ERR, "$Error USERID is null or empty") into ERR;	
end if;

/*
if TRIM(IFNULL(PROJECTID, "")) = "" then 
	select concat(ERR, "$Error PROJECTID is null or empty") into ERR;	
end if;
*/
# End control parameters

if ERR = "" then
	if TRIM(IFNULL(ITEMCOSTID , "")) = "" then		
		select c.ITEMCOSTID	into ITEMCOSTID 
		from MZ_ITEMCOST c
		where lower(trim(c.NAME)) = lower(trim(NAME))
		  and c.APPID = APPID
		  and c.CTYPE = CTYPE
		limit 1;	  

		/*
		   TODO: da gestire l'inserimento di una voce trovata ma non valida nel VDATE in linea
		   se il caso si presenta ritornare un errore...
		*/
		#Se non trovo ITEMCOSTID inserisco la voce e mi ricavo ITEMCOSTID
		if TRIM(IFNULL(ITEMCOSTID , "")) = "" then						
			#select "DEBUG: before insert";
			select UUID() into ITEMCOSTID;
			insert into MZ_ITEMCOST			
			values (
				ITEMCOSTID #ITEMCOSTID
				,NAME #NAME
				,now() #IDATA
				,null #UDATE
				,null #CDATE
				,null #DINI
				,null #DFIN
				,"MZ_spITEMCOSTi" #USERAPP
				,APPID #APPID
				,CTYPE #CTYPE
			);
			
			call MZ_ITEMCOSTUSERi(
				 ITEMCOSTID,
				 USERID,
		    	 PROJECTID, 
				 APPID,
				 VDATE,
			     @ERRITEMCOSTUSER
			);
			select concat(ERR, @ERRITEMCOSTUSER) into ERR;	
			#select "DEBUG: after insert";
		#else
			#select concat ("DEBUG: ", ITEMCOSTID);
		end if;
	else
		select concat(ERR, "$TODO: da implementare ...") into ERR;	
	end if;
end if;

#Start format output messagge error
if ERR != "" then 	
	select MZ_showERR(ERR) into ERR;	
end if;
# End format output messagge error

END; //
DELIMITER //