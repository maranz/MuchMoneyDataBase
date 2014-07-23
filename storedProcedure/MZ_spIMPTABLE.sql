DROP PROCEDURE IF EXISTS MZ_spIMPTABLE;

DELIMITER //
CREATE PROCEDURE MZ_spIMPTABLE ()
BEGIN
	/*
		Tabella di log
	*/
	CREATE TEMPORARY TABLE tmpLog ( log VARCHAR(255) NOT NULL);	

	/*
		Inserimento voci di  costo
	*/
	insert into tmpLog
	select CONCAT('Inserimento voci di  costo ok ', count(*))
	from (
		select imp.ITEMCOST
		from MZ_IMPTABLE as imp
		where not exists (
			select name 
			from MZ_ITEMCOST as c
			where upper(trim(imp.ITEMCOST)) <> upper(trim(c.NAME))
		)
		group by imp.ITEMCOST
	) as v;

    insert into MZ_ITEMCOST
	select UUID() as ITEMCOSTID
	,upper(trim(imp.ITEMCOST)) as NAME
	,NOW() as IDATA
	,null as UDATE
	,null as CDATE
	,null as DINI 
	,null as DFIN
	,'MZ_spIMPTABLE' as USERAPP 
	,'b4b6dff6-eef3-11e3-9555-001a92630969' as APPID
	from MZ_IMPTABLE as imp
	where not exists (
		select name 
		from MZ_ITEMCOST as c
		where upper(trim(imp.ITEMCOST)) <> upper(trim(c.NAME))
	)
	group by imp.ITEMCOST;


	/*
		Inserimento spese
	*/

	insert into tmpLog 
	select CONCAT('Numero di movimenti da importare ', count(*))
	from MZ_IMPTABLE;

	insert into tmpLog 
	select CONCAT('Numero di movimenti cancellati ', count(*))
	from MZ_MONEY_OUT
	where USERAPP = 'MZ_spIMPTABLE'
	and year(VDATE) in (
		select year(VDATE)
		from MZ_IMPTABLE
		group by year(VDATE)
	);	

	delete from MZ_MONEY_OUT
	where USERAPP = 'MZ_spIMPTABLE'
	and year(VDATE) in (
		select year(VDATE)
		from MZ_IMPTABLE
		group by year(VDATE)
	);
	
	insert into MZ_MONEY_OUT
	select UUID() as MONEYID
	,u.USERID AS USERID
	,g.GROUPID as GROUPID
	,c.ITEMCOSTID AS ITEMCOSTID
	,imp.VDATE AS VDATE
	,Now() as IDATA
	,null as UDATE
	,null as CDATE
	,imp.MONEY as MONEY
	,'MZ_spIMPTABLE' AS USERAPP
    ,'b4b6dff6-eef3-11e3-9555-001a92630969' as APPID	
	from MZ_IMPTABLE as imp
	inner join MZ_USERS as u on upper(trim(u.USER)) = upper(trim(imp.USER))
	inner join MZ_ITEMCOST as c on upper(trim(c.NAME)) = upper(trim(imp.ITEMCOST))
	left join MZ_GROUP as g on upper(trim(g.NAME)) = upper(trim(imp.sheet));

	insert into tmpLog 
	select CONCAT('Numero di movimenti importati ', count(*))
	from MZ_IMPTABLE as imp
	inner join MZ_USERS as u on upper(trim(u.USER)) = upper(trim(imp.USER))
	inner join MZ_ITEMCOST as c on upper(trim(c.NAME)) = upper(trim(imp.ITEMCOST));
	
	select * from tmpLog;
	drop table tmpLog;	

END; //
DELIMITER //