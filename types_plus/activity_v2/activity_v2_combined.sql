﻿-- Create a view onto activity formatted as activity_v2.-- If activity changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_activity_v2.DROP VIEW IF EXISTS types_plus.activity_v2 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.activity_v2 AS select id,        facility_id,        facility_activities_id,        web_user_id,        last_updated_by_data_file_id,        updated_dts,        created_dts,        done_dts,        start_dts,        duration_seconds,        marked_for_deletion,        other_desc,        created_by,        updated_by   from activity;ALTER TABLE types_plus.activity_v2    OWNER TO user_change_structure;-- Create a casting function to convert activity rows into the compound type format activity_v2.-- If activity changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.activity_to_v2 (activity_in activity)  RETURNS activity_v2AS $BODY$                   SELECT			activity_in.id,			activity_in.facility_id,			activity_in.facility_activities_id,			activity_in.web_user_id,			activity_in.last_updated_by_data_file_id,			activity_in.updated_dts,			activity_in.created_dts,			activity_in.done_dts,			activity_in.start_dts,			activity_in.duration_seconds,			activity_in.marked_for_deletion,			activity_in.other_desc,			activity_in.created_by,			activity_in.updated_by               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.activity_to_v2 (activity_in activity)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert activity rows into the activity_v2 compound type format using the following syntax:-- select activity::activity_v2 from activityDROP CAST IF EXISTS (activity as activity_v2);CREATE CAST (activity as activity_v2) WITH FUNCTION types_plus.activity_to_v2(activity);-- Create a function to accept an array of rows formatted as activity_v2 for UPSERT into activity.DROP FUNCTION IF EXISTS types_plus.insert_activity_v2 (types_plus.activity_v2[]);  CREATE OR REPLACE FUNCTION types_plus.insert_activity_v2 (data_in types_plus.activity_v2[])  RETURNS intAS $BODY$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO activity (			id,			facility_id,			facility_activities_id,			web_user_id,			last_updated_by_data_file_id,			updated_dts,			created_dts,			done_dts,			start_dts,			duration_seconds,			marked_for_deletion,			other_desc,			created_by,			updated_by)                  SELECT			rows_in.id,			rows_in.facility_id,			rows_in.facility_activities_id,			rows_in.web_user_id,			rows_in.last_updated_by_data_file_id,			rows_in.updated_dts,			rows_in.created_dts,			rows_in.done_dts,			rows_in.start_dts,			rows_in.duration_seconds,			rows_in.marked_for_deletion,			rows_in.other_desc,			rows_in.created_by,			rows_in.updated_by                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			facility_id = EXCLUDED.facility_id,			facility_activities_id = EXCLUDED.facility_activities_id,			web_user_id = EXCLUDED.web_user_id,			last_updated_by_data_file_id = EXCLUDED.last_updated_by_data_file_id,			updated_dts = EXCLUDED.updated_dts,			created_dts = EXCLUDED.created_dts,			done_dts = EXCLUDED.done_dts,			start_dts = EXCLUDED.start_dts,			duration_seconds = EXCLUDED.duration_seconds,			marked_for_deletion = EXCLUDED.marked_for_deletion,			other_desc = EXCLUDED.other_desc,			created_by = EXCLUDED.created_by,			updated_by = EXCLUDED.updated_by          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.insert_activity_v2(types_plus.activity_v2[])	OWNER TO user_bender;