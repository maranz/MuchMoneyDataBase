DROP PROCEDURE IF EXISTS MZ_spYEARSl;

DELIMITER //
CREATE PROCEDURE MZ_spYEARSl (		
	    in APPID varchar(36)
)
BEGIN
	SET @ANNO = YEAR( now() );

	select YEARS
	from (

		select @ANNO as YEARS

		union all

		select YEAR( VDATE ) as YEARS
		from MZ_MONEY
		where CDATE is null
		and APPID = APPID
		and VDATE is not null		
		and YEAR( VDATE ) < @ANNO
		group by YEAR( VDATE )
		
	) as v
	order by YEARS desc;
	
END; //
DELIMITER //