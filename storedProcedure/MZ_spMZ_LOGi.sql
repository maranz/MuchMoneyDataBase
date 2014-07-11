DROP PROCEDURE IF EXISTS MZ_spMZ_LOGi;

DELIMITER //
CREATE PROCEDURE MZ_spMZ_LOGi(
	 in `FUNCTION` varchar(36)
    ,in `MESSAGE` varchar(255)
	,in `STACK` varchar(255)
	,in `TYPE` varchar(2)
	,in `USERAPP` varchar(45)
)
BEGIN

insert into MZ_LOG values (
	 UUID()
	,`FUNCTION`
	,`MESSAGE`
	,`STACK`
	,`TYPE`
	,now()
	,`USERAPP`
);

END; //
DELIMITER ;