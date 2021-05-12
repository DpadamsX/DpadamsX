﻿-- Create a function to accept an array of rows formatted as web_user_v2 for UPSERT into web_user.DROP FUNCTION IF EXISTS types_plus.insert_web_user_v2 (types_plus.web_user_v2[]);  CREATE OR REPLACE FUNCTION types_plus.insert_web_user_v2 (data_in types_plus.web_user_v2[])  RETURNS intAS $BODY$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO web_user (			id,			data_file_id,			hsys_id,			is_sonar_ascendco_support,			marked_for_deletion,			name_first,			role_,			username,			name_full,			name_last)                  SELECT			rows_in.id,			rows_in.data_file_id,			rows_in.hsys_id,			rows_in.is_sonar_ascendco_support,			rows_in.marked_for_deletion,			rows_in.name_first,			rows_in.role_,			rows_in.username,			rows_in.name_full,			rows_in.name_last                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			data_file_id = EXCLUDED.data_file_id,			hsys_id = EXCLUDED.hsys_id,			is_sonar_ascendco_support = EXCLUDED.is_sonar_ascendco_support,			marked_for_deletion = EXCLUDED.marked_for_deletion,			name_first = EXCLUDED.name_first,			role_ = EXCLUDED.role_,			username = EXCLUDED.username,			name_full = EXCLUDED.name_full,			name_last = EXCLUDED.name_last          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.insert_web_user_v2(types_plus.web_user_v2[])	OWNER TO user_bender;