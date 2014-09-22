DROP PROCEDURE IF EXISTS MZ_spMONEYl;

DELIMITER //
CREATE PROCEDURE MZ_spMONEYl (		
		 in YEAR int
		,in USERID varchar(36)
		,in PROJECTID varchar(36)
	    ,in APPID varchar(36)
)
BEGIN	
	declare MAXM int; 

	call MZ_spYERASl ( YEAR );
	-- SELECT * FROM tmpYEARS;
	
	DROP TEMPORARY TABLE IF EXISTS tmpMONEY;	
	CREATE TEMPORARY TABLE tmpMONEY(
			YEAR int
			,M int
			,MONTH varchar ( 10 )
			,USERID varchar(36)
			,USER varchar(45)			
			,AVATAR varchar(50)	
			,MONEYIN decimal(16,2)
			,MONEYOUT decimal(16,2)
	);	

	 IF PROJECTID is not null THEN 
		CASE PROJECTID  
		  WHEN 'all' THEN 
			call MZ_spMONEYl_all (YEAR, APPID);
			
			SELECT MAX(M) - 1 INTO MAXM FROM tmpMONEY;			

			select YEAR, M, MONTH, USERID, USER, AVATAR, sum( MONEYIN ) MONEYIN, sum( MONEYOUT ) MONEYOUT, sum( MONEYIN ) - sum( MONEYOUT ) DELTA
			,CASE
				WHEN sum( MONEYIN ) <= 0 THEN 0
				WHEN (sum( MONEYOUT ) <= 0 OR sum( MONEYIN ) > sum( MONEYOUT )) THEN 100
				ELSE ROUND( (sum( MONEYOUT ) * 100) / sum( MONEYIN ), 0 )
			 END PMONEYIN
			,CASE 
				WHEN sum( MONEYOUT ) <= 0 THEN 0				
				WHEN (sum( MONEYIN ) <= 0 OR sum( MONEYOUT ) > sum( MONEYIN )) THEN 100
				ELSE ROUND( (sum( MONEYIN ) * 100) / sum( MONEYOUT ), 0 )
			 END PMONEYOUT
			,CASE M				
				WHEN MAXM THEN 1
				ELSE 0
			 END COLLAPSED
			from tmpMONEY
			GROUP BY YEAR, M, MONTH, USERID, USER, AVATAR
			order by M desc, USER;

		WHEN 'private' THEN 
			call MZ_spMONEYl_private (YEAR, APPID);
			
			SELECT MAX(M) - 1 INTO MAXM FROM tmpMONEY;	
			
			select YEAR, M, MONTH, USERID, USER,  AVATAR, null MONEYIN, sum( MONEYOUT ) MONEYOUT, null DELTA, null PMONEYIN , null PMONEYOUT
			,CASE M				
				WHEN MAXM THEN 1
				ELSE 0
			 END COLLAPSED
			from tmpMONEY
			GROUP BY YEAR, M, MONTH, USERID, USER,  AVATAR
			order by M desc, USER;			
	    ELSE  
			call MZ_spMONEYl_project (YEAR, PROJECTID, APPID);	    

			SELECT MAX(M) - 1 INTO MAXM FROM tmpMONEY;				

			select YEAR, M, MONTH, USERID, USER,  AVATAR, null MONEYIN, sum( MONEYOUT ) MONEYOUT, null DELTA, null PMONEYIN , null PMONEYOUT
			,CASE M				
				WHEN MAXM THEN 1
				ELSE 0
			END COLLAPSED
			from tmpMONEY
			GROUP BY YEAR, M, MONTH, USERID, USER
			order by M desc, USER;
		END CASE;
	END IF;

	
END; //
DELIMITER //