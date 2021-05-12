CREATE OR REPLACE VIEW api.push_log_latest AS

SELECT DISTINCT ON (ib_table_name,data_file_id)
	    *,
        NOW() AS dts,
        minutes_old(push_dts) AS push_log_minutes_old

    FROM push_log_plus

ORDER BY ib_table_name,
		 data_file_id,
		 push_dts desc;

COMMENT ON VIEW api.push_log_latest IS
'DISTINCT ON with a sort is a Postgres extension and, dang, it is awesome. In standard SQL, a GROUP BY works fine, until you want a value FROM one of the ungrouped columns. Which row out of the group is used for the column? It is random. There are lots of solutions to this but, for straightforward cases, nothing is AS simple AS the Postgres DISTINCT ON. The secret sauce here is the order by! Without that, you get a random row value. Random within the group, but is that random enough.';

ALTER VIEW api.push_log_latest
    OWNER TO user_change_structure;

------------------------------------------------
-- Register view
------------------------------------------------
CALL view_register ('api','push_log_latest','Displays the age of the last push by each server to each table. Good for spotting stragglers.','RDS push_log_latest');
