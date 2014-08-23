DROP PROCEDURE IF EXISTS MZ_spMONEYi;

DELIMITER //

CREATE PROCEDURE MZ_spMONEYi(
	inout MONEYID varchar(36),
	in USERID varchar(36),
	in GROUPID varchar(36),	
	in ITEMCOSTNAME varchar(255),
	in VDATE datetime,
	in MONEY decimal(16,2),
	in APPID varchar(36),	
	out ERR varchar(255)
)
BEGIN

declare msg varchar(255);
declare count int;

/*
declare ITEMCOSTID varchar(36); 
select "" into ITEMCOSTID;
*/

# Start control parameters
select "" into ERR;

if TRIM(IFNULL(USERID, "")) = "" then 
	select concat(ERR, "$Error: into MZ_MONEYi, USERID is null or empty") into ERR;	
end if;

/* 
# Campo non obbligatorio
if TRIM(IFNULL(GROUPID, "")) = "" then 
	select concat(ERR, "$Error GROUPID is null or empty") into ERR;	
end if;
*/

if TRIM(IFNULL(ITEMCOSTNAME, "")) = "" then 
	select concat(ERR, "$nError: into MZ_MONEYi, ITEMCOSTNAME is null or empty") into ERR;	
end if;

if TRIM(IFNULL(APPID, "")) = "" then 
	select concat(ERR, "$Error: into MZ_MONEYi, APPID is null or empty") into ERR;	
end if;

if VDATE is null then
	select concat(ERR, "$Error: into MZ_MONEYi, VDATE is null or empty") into ERR;	
end if;

if trim(MONEY) is null then	
	select concat(ERR, "$Error: into MZ_MONEYi, MONEY is null or empty") into ERR;	
end if;
# End control parameters

if MZ_Debug() then	
	select "before call MZ_spITEMCOSTi" into msg;	
	select concat(msg, "\n@ITEMCOSTNAME:= ", ITEMCOSTNAME) into msg;
	select concat(msg, "\n@APPID:= ", APPID) into msg;
	select concat(msg, "\n@VDATE:= ", VDATE) into msg;
	call MZ_spMZ_LOGi ("MZ_MONEYi", msg, null, "i", APPID);
end if;

select "" into @ITEMCOSTID;

# Start insert ITEMCOST
call MZ_spITEMCOSTi(
	 @ITEMCOSTID
	,ITEMCOSTNAME
	,APPID 
	,VDATE 
	,@ERRITEMCOST 
);

if (select MZ_Debug()) then
	select "After call MZ_spITEMCOSTi is ok" into msg;
	select concat(msg, "\n@ITEMCOSTID:= ", @ITEMCOSTID) into msg;	
	select concat(msg, "\n@ERR1:= ", @ERRITEMCOST) into msg;
	call MZ_spMZ_LOGi ("\nMZ_MONEYi", msg, null, "i", APPID);
end if;
# End insert ITEMCOST

if MZ_Debug() then	
	call MZ_spMZ_LOGi ("MZ_MONEYi", "Before controllo esistenza record", null, "i", APPID);
end if;

select count(*) into count
from MZ_MONEY m
where m.USERID = USERID
  and m.ITEMCOSTID = @ITEMCOSTID
  and (m.GROUPID is null or m.GROUPID = GROUPID)
  and m.VDATE = VDATE
  and m.MONEY = MONEY;

if MZ_Debug() then	
	select "After controllo esistenza record is ok" into msg;
	select concat(msg, "\n@COUNT:= ", count) into msg;	
	call MZ_spMZ_LOGi ("MZ_MONEYi", msg, null, "i", APPID);
end if;

if count = 0 then
	if MZ_Debug() then		
		call MZ_spMZ_LOGi ("MZ_MONEYi", "Before insert MZ_MONEY", null, "i", APPID);
	end if;

	#select * from MZ_MONEY;
	select UUID() into MONEYID;
	insert into MZ_MONEY value (
		 MONEYID
		,USERID
		,GROUPID
		,@ITEMCOSTID
		,VDATE
		,now()
		,null
		,null
		,MONEY
		,"MZ_spMONEYi"
		,APPID
	);

	if MZ_Debug() then	
		call MZ_spMZ_LOGi ("MZ_MONEYi", "After insert MZ_MONEY is ok", null, "i", APPID);
	end if;
else
	select concat(ERR, "\nError: key duplicate") into ERR;
end if;

# Start format output messagge error
if ERR != "" then 
	select MZ_showERR(concat(ERR, @ERRITEMCOST)) into ERR;
end if;
# End format output messagge error

END; //
DELIMITER //