DROP FUNCTION IF EXISTS MZ_Debug;

DELIMITER //

CREATE FUNCTION `MZ_Debug` ()
RETURNS boolean
BEGIN
	declare isDebug varchar(255);

	select `VALUE` into isDebug 
	from MZ_CONFIG 
	where lower(trim(`KEY`)) = "debug";
	
	if TRIM(IFNULL(isDebug, "")) = "true" then
		RETURN true;
	else
		RETURN false;
	end if;

END; //
DELIMITER ;