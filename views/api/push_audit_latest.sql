DROP VIEW IF EXISTS api.push_audit_latest;

CREATE OR REPLACE VIEW api.push_audit_latest AS

WITH latest_push AS (
SELECT DISTINCT ON (unique_path,data_file_id)
        server.server_name_ AS server_name,
        target.unique_path,
        minutes_old (audit.inserted_utc_dts) as minutes_old,
        audit.records_count,
        audit.duration_seconds,

		target.schema_name,
        target.target_name,
        target.target_type,

        audit.start_local_dts,
        audit.end_local_dts,
        audit.end_utc_dts,
        audit.inserted_utc_dts,
        now() - audit.inserted_utc_dts AS age,
        audit.client_user_name,
        audit.inserted_by,
        audit.version_number,
        audit.error_occurred,
        audit.push_method_name,
        audit.error_text

     FROM push_audit       audit
LEFT JOIN dba.push_target  target on target.id = audit.target_id
LEFT JOIN data_file_info   server on server.id = audit.data_file_id

ORDER BY unique_path,
		 data_file_id,
		 end_utc_dts desc
)

-- Wrapped the search in a CTE above as DISTINCT ON has special requirements for the ORDER BY.
-- Now, we can grab the final results and sort them the way we prefer.

select *
  from latest_push
order by server_name, unique_path;

COMMENT ON VIEW api.push_audit_latest IS
'DISTINCT ON with a sort is a Postgres extension and, dang, it is awesome. In standard SQL, a GROUP BY works fine, until you want a value FROM one of the ungrouped columns. Which row out of the group is used for the column? It is random. There are lots of solutions to this but, for straightforward cases, nothing is AS simple AS the Postgres DISTINCT ON. The secret sauce here is the order by! Without that, you get a random row value. Random within the group, but is that random enough.';

ALTER VIEW api.push_audit_latest
    OWNER TO user_change_structure;

------------------------------------------------
-- Register view
------------------------------------------------
CALL view_register ('api','push_audit_latest','Displays the age of the last push by each server to each target. Good for spotting stragglers.','RDS push_audit_latest');
