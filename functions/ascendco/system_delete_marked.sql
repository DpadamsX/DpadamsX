CREATE OR REPLACE FUNCTION ascendco.system_delete_marked()
RETURNS table(
    schema text,
    table_name text,
    count int)
    
AS $BODY$
BEGIN
RETURN QUERY
   select 'ascendco','analytic_productivity', deleted_count from table_delete_marked('ascendco.analytic_productivity') union all
   select 'ascendco','analytic_sterilizer_load', deleted_count from table_delete_marked('ascendco.analytic_sterilizer_load') union all
   select 'ascendco','analytic_sterilizer_loadinv', deleted_count from table_delete_marked('ascendco.analytic_sterilizer_loadinv') union all
   select 'ascendco','item_type', deleted_count from table_delete_marked('ascendco.item_type') union all
   select 'ascendco','specialty', deleted_count from table_delete_marked('ascendco.specialty') union all
   select 'ascendco','sterilize_method', deleted_count from table_delete_marked('ascendco.sterilize_method');
END;
$BODY$
	 LANGUAGE plpgsql;


COMMENT ON FUNCTION ascendco.system_delete_marked() IS '
/* 
This code is built in IceBerg by PgBuild_ClearDeletedRecords. 
It reads the pgIOMap definitions to see which table(s) have
auto-delete enabled. Do *not* update this method by hand!
Use PgBuild_ClearDeletedRecords on Dev to change the rules.
After that, push the code to the Postgres database. 
The point here is to define the rules in Dev and enforce
them universally on Postgres. See:
https://ascendco.atlassian.net/wiki/spaces/SON/pages/767459342/Deleting+Records+on+Postgres
*/
';

ALTER FUNCTION ascendco.system_delete_marked() 
	OWNER TO user_bender;
