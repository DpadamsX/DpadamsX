CREATE OR REPLACE FUNCTION ascendco.rcl_get_record_id (rcl_id uuid)	RETURNS pg_catalog.uuidAS $BODY$SELECT record_id  FROM record_changes_log WHERE id = $1;$BODY$	LANGUAGE sql VOLATILE	COST 100;ALTER FUNCTION ascendco.rcl_get_record_id (uuid)	OWNER TO user_bender;