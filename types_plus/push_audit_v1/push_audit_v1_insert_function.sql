﻿-- Create a function to accept an array of rows formatted as push_audit_v1 for UPSERT into push_audit.DROP FUNCTION IF EXISTS types_plus.insert_push_audit_v1 (types_plus.push_audit_v1[]);CREATE OR REPLACE FUNCTION types_plus.insert_push_audit_v1 (    data_in  types_plus.push_audit_v1[])  RETURNS intAS $BODY$-- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.WITHinserted_rows AS (        INSERT INTO dba.push_audit (            data_file_id,			duration_seconds,			records_count,			target_id, -- int4 link to dba.push_target, PG-side.			version_number,			start_local_dts,			end_local_dts,			end_utc_dts,			error_occurred,			client_user_name,			push_method_name,			error_text)        SELECT			rows_in.data_file_id,			rows_in.duration_seconds,			rows_in.records_count,			push_target_add_if_missing (			     rows_in.schema_name,			     rows_in.target_name,			     rows_in.unique_path,			     rows_in.target_type),			rows_in.version_number,			rows_in.start_local_dts,			rows_in.end_local_dts,			rows_in.end_utc_dts,			rows_in.error_occurred,			rows_in.client_user_name,			rows_in.push_method_name,			rows_in.error_text        FROM unnest(data_in) as rows_in        RETURNING 1 as row_counter)    select sum(row_counter)::integer from inserted_rows;$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.insert_push_audit_v1(types_plus.push_audit_v1[])	OWNER TO user_bender;