DROP PROCEDURE IF EXISTS MZ_spTMPYEARSl;

DELIMITER //
CREATE PROCEDURE MZ_spTMPYEARSl (		
		 in YEAR int	    
)
BEGIN
	
	DROP TEMPORARY TABLE IF EXISTS tmpYEARS;	
	CREATE TEMPORARY TABLE tmpYEARS(
			YEAR int
			,M int
			,MONTH varchar ( 10 )
			,START date
			,END date
	);
	
	SET @startMonth = "";
	select `VALUE` into @startMonth from MZ_CONFIG where USERID is null and `KEY` = 'startmonth';

	SET @endMonth = "";
	select `VALUE` into @endMonth from MZ_CONFIG where USERID is null and `KEY` = 'endmonth';

	insert into tmpYEARS value (YEAR, 1, 'GENNAIO', CONCAT(CAST(YEAR AS CHAR(4)) , '-01-', CAST(@startMonth AS CHAR(2)))
										 	      , CONCAT(CAST(YEAR AS CHAR(10)) , '-02-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 2, 'FEBBRAIO', CONCAT(CAST(YEAR AS CHAR(4)) , '-02-', CAST(@startMonth AS CHAR(2)))
 											    , CONCAT(CAST(YEAR AS CHAR(10)) , '-03-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 3, 'MARZO', CONCAT(CAST(YEAR AS CHAR(4)) , '-03-', CAST(@startMonth AS CHAR(2)))
										 	    , CONCAT(CAST(YEAR AS CHAR(10)) , '-04-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 4, 'APRILE', CONCAT(CAST(YEAR AS CHAR(4)) , '-04-', CAST(@startMonth AS CHAR(2)))
  										         , CONCAT(CAST(YEAR AS CHAR(10)) , '-05-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 5, 'MAGGIO', CONCAT(CAST(YEAR AS CHAR(4)) , '-05-', CAST(@startMonth AS CHAR(2)))
											     , CONCAT(CAST(YEAR AS CHAR(10)) , '-06-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 6, 'GIUGNO', CONCAT(CAST(YEAR AS CHAR(4)) , '-06-', CAST(@startMonth AS CHAR(2)))
											     , CONCAT(CAST(YEAR AS CHAR(10)) , '-07-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 7,' LUGLIO', CONCAT(CAST(YEAR AS CHAR(4)) , '-07-', CAST(@startMonth AS CHAR(2)))
											     , CONCAT(CAST(YEAR AS CHAR(10)) , '-08-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 8, 'AGOSTO', CONCAT(CAST(YEAR AS CHAR(4)) , '-08-', CAST(@startMonth AS CHAR(2)))
											     , CONCAT(CAST(YEAR AS CHAR(10)) , '-09-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 9, 'SETTEMBRE', CONCAT(CAST(YEAR AS CHAR(4)) , '-09-', CAST(@startMonth AS CHAR(2)))
											        , CONCAT(CAST(YEAR AS CHAR(10)) , '-10-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 10, 'OTTOBRE', CONCAT(CAST(YEAR AS CHAR(4)) , '-10-', CAST(@startMonth AS CHAR(2)))
											       , CONCAT(CAST(YEAR AS CHAR(10)) , '-11-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 11, 'NOVEMBRE', CONCAT(CAST(YEAR AS CHAR(4)) , '-11-', CAST(@startMonth AS CHAR(2)))
											        , CONCAT(CAST(YEAR AS CHAR(10)) , '-12-', CAST(@endMonth AS CHAR(2))));

	insert into tmpYEARS value (YEAR, 12, 'DICEMBRE', CONCAT(CAST(YEAR AS CHAR(4)) , '-12-', CAST(@startMonth AS CHAR(2)))
											        , CONCAT(CAST(YEAR + 1 AS CHAR(10)) , '-01-', CAST(@endMonth AS CHAR(2))));
	-- select * from tmpYEARS;
END; //
DELIMITER //