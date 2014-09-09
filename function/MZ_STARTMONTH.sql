DROP FUNCTION IF EXISTS MZ_STARTMONTH;

DELIMITER //

CREATE FUNCTION MZ_STARTMONTH()
RETURNS int
BEGIN
	declare val int;

	select VALUE into val
	from MZ_CONFIG 
	where CDATE is null
	and USERID is null
	and lower(trim(`KEY`)) = "startmonth"
	LIMIT 1;
	
	if TRIM(IFNULL(val, "")) = "" then
		RETURN 0;
	else
		RETURN val;
	end if;

END; //
DELIMITER ;