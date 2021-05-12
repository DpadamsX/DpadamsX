﻿-- Create a function to accept an array of rows formatted as activity_v1 for UPSERT into activity.DROP FUNCTION IF EXISTS types_plus.insert_activity_v1 (types_plus.activity_v1[]);  CREATE OR REPLACE FUNCTION types_plus.insert_activity_v1 (data_in types_plus.activity_v1[])  RETURNS intAS $BODY$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO activity (			id,			facility_id,			facility_activities_id,			web_user_id,			other_desc,			start_dts,			done_dts,			last_updated_by_data_file_id,			created_by,			created_dts,			updated_by,			updated_dts,			duration_seconds)                  SELECT			rows_in.id,			rows_in.facility_id,			rows_in.facility_activities_id,			rows_in.web_user_id,			rows_in.other_desc,			rows_in.start_dts,			rows_in.done_dts,			rows_in.last_updated_by_data_file_id,			rows_in.created_by,			rows_in.created_dts,			rows_in.updated_by,			rows_in.updated_dts,			rows_in.duration_seconds                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			facility_id = EXCLUDED.facility_id,			facility_activities_id = EXCLUDED.facility_activities_id,			web_user_id = EXCLUDED.web_user_id,			other_desc = EXCLUDED.other_desc,			start_dts = EXCLUDED.start_dts,			done_dts = EXCLUDED.done_dts,			last_updated_by_data_file_id = EXCLUDED.last_updated_by_data_file_id,			created_by = EXCLUDED.created_by,			created_dts = EXCLUDED.created_dts,			updated_by = EXCLUDED.updated_by,			updated_dts = EXCLUDED.updated_dts,			duration_seconds = EXCLUDED.duration_seconds          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.insert_activity_v1(types_plus.activity_v1[])	OWNER TO user_bender;