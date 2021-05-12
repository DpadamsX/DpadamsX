﻿-- Create a function to accept an array of rows formatted as sterilizer_log_v1 for UPSERT into sterilizer_log.DROP FUNCTION IF EXISTS types_plus.insert_sterilizer_log_v1 (types_plus.sterilizer_log_v1[]);CREATE OR REPLACE FUNCTION types_plus.insert_sterilizer_log_v1 (data_in types_plus.sterilizer_log_v1[])  RETURNS intAS $BODY$-- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO sterilizer_log (			id,			data_file_id,			log_type,			summary_json,			log_xml)        SELECT			rows_in.id,			rows_in.data_file_id,			rows_in.log_type,			rows_in.summary_json,			rows_in.log_xml        FROM unnest(data_in) as rows_in        ON CONFLICT(id) DO UPDATE SET			data_file_id = EXCLUDED.data_file_id,			log_type = EXCLUDED.log_type,			summary_json = EXCLUDED.summary_json,			log_xml = EXCLUDED.log_xml        returning 1 as row_counter)    select sum(row_counter)::integer from inserted_rows;$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.insert_sterilizer_log_v1(types_plus.sterilizer_log_v1[]) OWNER TO user_bender;