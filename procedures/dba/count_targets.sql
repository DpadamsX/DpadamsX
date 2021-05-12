DROP PROCEDURE IF EXISTS dba.count_targets;CREATE PROCEDURE dba.count_targets ()AS $BODY$/*Capture daily row counts for targets of interest by hsys and target into dba.target_count:ascendco.analytic_productivityascendco.analytic_scanascendco.analytic_sterilizer_loadinvascendco.analytic_sterilizer_loadNote: This is a stored PROCEDURE, not a FUNCTION. CALL count_targets(), not SELECT count_targets().*/WITHraw_counts AS (---------------------------------------------------- ascendco.analytic_productivity--------------------------------------------------   select hsys_id,          count(*)                             as records_count,          'ascendco'                           as schema_name,          'analytic_productivity'              as target_name      from ascendco.analytic_productivity  group by 1 union all---------------------------------------------------- ascendco.analytic_scan--------------------------------------------------    select hsys_id,           count(*)                            as records_count,          'ascendco'                           as schema_name,          'analytic_scan'                      as target_name      from ascendco.analytic_scan  group by 1 union all---------------------------------------------------- ascendco.ascendco.analytic_sterilizer_loadinv--------------------------------------------------    select hsys_id,           count(*)                            as records_count,          'ascendco'                           as schema_name,          'analytic_sterilizer_loadinv'        as target_name      from ascendco.analytic_sterilizer_loadinv  group by 1 union all---------------------------------------------------- ascendco.ascendco.analytic_sterilizer_load---------------------------------------------------- ascendco.analytic_sterilizer_load doesn't have hsys_id. D'oh!-- Look it up through facility_id, which is present.    select facility.hsys_id,           count(*)                            as records_count,           'ascendco'                          as schema_name,           'analytic_sterilizer_load'          as target_name       from ascendco.analytic_sterilizer_load left join facility on facility.id = analytic_sterilizer_load.facility_id  group by 1),---------------------------------------------------- Clear out bogus results--------------------------------------------------cleaned_counts AS (    select *     from raw_counts    where hsys_id IS NOT NULL      and hsys_id <> '00000000-0000-0000-0000-000000000000')---------------------------------------------------- Put it all together-------------------------------------------------- INSERT INTO dba.target_count (               hsys_id,               qualified_name,               records_count,               count_date,               count_dts)        SELECT hsys_id,               concat (schema_name, '.', target_name),               records_count,               current_date,               now()         FROM cleaned_counts  ON CONFLICT ON CONSTRAINT target_count_pk  DO UPDATE SET               records_count = EXCLUDED.records_count,               count_date    = EXCLUDED.count_date,               count_dts     = EXCLUDED.count_dts;$BODY$    LANGUAGE SQL;COMMENT ON PROCEDURE dba.count_targets IS 'Capture daily row counts for targets of interest by hsys and target into dba.target_count.Note: This is a stored PROCEDURE, not a FUNCTION. CALL count_targets(), not SELECT count_targets().';ALTER PROCEDURE dba.count_targets ()   OWNER TO user_bender;